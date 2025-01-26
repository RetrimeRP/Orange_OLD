local c200200200200 = Color(200, 200, 200, 200)
local c255255255 = Color(255, 255, 255)

local ghosting = {
	["gmod_cameraprop"] = true
}

local whitelist = {
	["prop_physics"] = true,
	["gmod_cameraprop"] = true
}

--[[------------------------------------------------------------

	GhostProp

------------------------------------------------------------]]--
local function MakeGhostProp(ent)
	if ent.PropGhosted then return end

	-- PropGhosted
	ent.PropGhosted = true

	-- PropCollision
	if not ent.PropCollision then
		ent.PropCollision = ent:GetCollisionGroup()
		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end

	-- PropRender
	if not ent.PropRender then
		ent.PropRender = ent:GetRenderMode()
		ent:SetRenderMode(RENDERMODE_TRANSALPHA)
	end

	ent:DrawShadow(false)
	ent:SetColor(c200200200200)
end

local function UndoGhostProp(ent)
	if not ent.PropGhosted then return end

	-- PropGhosted
	ent.PropGhosted = nil

	-- PropCollision
	if ent.PropCollision then
		ent:SetCollisionGroup(ent.PropCollision)
		ent.PropCollision = nil
	end

	-- PropRender
	if ent.PropRender then
		ent:SetRenderMode(ent.PropRender)
		ent.PropRender = nil
	end

	ent:DrawShadow(true)
	ent:SetColor(c255255255)
end

local function FreezeProp(ent)
	local phys = ent:GetPhysicsObject()

	if IsValid(phys) then
		if not phys:IsAsleep() then
			phys:Sleep()
		end

		if phys:IsMotionEnabled() then
			phys:EnableMotion(false)
		end
	end
end

--[[------------------------------------------------------------

	Ghosting

------------------------------------------------------------]]--
hook.Add("PlayerSpawnedProp", "retrime.Ghosting", function(ply, mdl, ent)
	MakeGhostProp(ent)
	FreezeProp(ent)
end)

hook.Add("OnEntityCreated", "retrime.Ghosting", function(ent)
	if ghosting[ent:GetClass()] then
		MakeGhostProp(ent)
		FreezeProp(ent)
	end
end)

hook.Add("OnPhysgunPickup", "retrime.Ghosting", function(ply, ent)
	if whitelist[ent:GetClass()] then
		MakeGhostProp(ent)
	end
end)

hook.Add("PhysgunDrop", "retrime.Ghosting", function(ply, ent)
	if whitelist[ent:GetClass()] then
		UndoGhostProp(ent)
		FreezeProp(ent)
	end
end)

--[[------------------------------------------------------------

	CanTool

------------------------------------------------------------]]--
local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
hook.Add("CanTool", "retrime.Ghosting", function(ply, tr, tool)
	local ent = tr.Entity

	if IsValid(ent) and whitelist[ent:GetClass()] and ent.PropGhosted then
		notify(ply, 0, 3, "Сначала вы должны разфризить этот проп")
		return false
	end
end)