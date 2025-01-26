local cameraX = CreateClientConVar("ret_cl_thirdperson_x", "100", true, false, "", 40, 120)
local cameraY = CreateClientConVar("ret_cl_thirdperson_y", "0", true, false, "", -40, 40)
local cameraZ = CreateClientConVar("ret_cl_thirdperson_z", "15", true, false, "", -15, 15)

local enabled = false
local distance = 0
local freeCamera = nil

local traceData = {
	start = nil,
	endpos = nil,
	filter = function(entity) return not entity:IsPlayer() end,
	mask = MASK_SHOT_HULL,
	mins = Vector(-10, -10, -10),
	maxs = Vector(10, 10, 10)
}

local view = {
	origin = nil,
	angles = nil,
	fov = 90,
	drawviewer = true
}

--[[------------------------------------------------------------
	Check
------------------------------------------------------------]]--
local function CheckThirdPerson(client)
	if not enabled then
		return false
	end

	if client:Health() < 1 then
		return false
	end

	if client:GetObserverMode() ~= OBS_MODE_NONE then
		return false
	end

	if client:InVehicle() then
		return false
	end

	local entity = client:GetViewEntity()

	if IsValid(entity) and entity:GetClass() == "gmod_cameraprop" then
		return false
	end

	if timer.Exists("FSpectatePosUpdate") then
		return false
	end

	return true
end

--[[------------------------------------------------------------
	View
------------------------------------------------------------]]--
local function ThirdPerson(client, pos, ang, fov, znear, zfar)
	local check = CheckThirdPerson(client)

	if check or distance > 0 then
		if check then
			distance = math.min(distance + (1 - distance) * FrameTime() * 9, 1)

			if distance > .99 then
				distance = 1
			end
		else
			distance = math.max(distance - distance * FrameTime() * 9, 0)

			if distance < .01 then
				distance = 0
			end
		end

		pos = pos + (freeCamera:Forward() * distance * (-math.Clamp(cameraX:GetInt(), 40, 120))) + (freeCamera:Right() * distance * (math.Clamp(cameraY:GetInt(), -40, 40))) + (freeCamera:Up() * distance * (math.Clamp(cameraZ:GetInt(), -15, 15)))

		traceData.start = client:GetShootPos()
		traceData.endpos = pos

		local traceHull = util.TraceHull(traceData)

		if traceHull.Hit then
			pos = traceHull.HitPos + (client:GetShootPos() - traceHull.HitPos):GetNormal() * 10
		end

		view.origin = pos
		view.angles = freeCamera
		view.drawviewer = true
		return view
	else
		if view and view.drawviewer then
			view.drawviewer = false
			return view
		end
	end
end

hook.Add("CalcView", "retrime.ThirdPerson", ThirdPerson)

--[[------------------------------------------------------------
	Mouse
------------------------------------------------------------]]--
local function ThirdPersonMouse(command, x, y, ang)
	local client = LocalPlayer()

	if CheckThirdPerson(client) and client:KeyDown(IN_WALK) then
		if not freeCamera then
			freeCamera = client:EyeAngles()
		end

		freeCamera.p = math.Clamp(math.NormalizeAngle(freeCamera.p + y / 50), -90, 90)
		freeCamera.y = math.NormalizeAngle(freeCamera.y - x / 50)
		return true
	else
		freeCamera = client:EyeAngles()
	end
end

hook.Add("InputMouseApply", "retrime.ThirdPerson", ThirdPersonMouse)

--[[------------------------------------------------------------
	Toggle
------------------------------------------------------------]]--
function ToggleThirdPerson()
	enabled = not enabled
end

--[[------------------------------------------------------------
	Command
------------------------------------------------------------]]--
concommand.Add("thirdperson_toggle", function()
	enabled = not enabled
end)