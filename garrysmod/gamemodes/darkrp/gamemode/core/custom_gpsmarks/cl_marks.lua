local marks = {}

local draw_DrawText = draw.DrawText

local c000 = Color(0, 0, 0)
local c230230230 = Color(230, 230, 230)
local c255255255 = Color(255, 255, 255)

local icons = {
	types = {
		[1] = Material("materials/retrime_orange/gpsmarks/capture.png"),
		[2] = Material("materials/retrime_orange/gpsmarks/gps.png"),
		[3] = Material("materials/retrime_orange/gpsmarks/alert.png"),
		[4] = Material("materials/retrime_orange/gpsmarks/alert.png")
	},
	counts = {
		[1] = Material("materials/retrime_orange/gpsmarks/1.png"),
		[2] = Material("materials/retrime_orange/gpsmarks/2.png"),
		[3] = Material("materials/retrime_orange/gpsmarks/3.png"),
		[4] = Material("materials/retrime_orange/gpsmarks/4.png"),
		[5] = Material("materials/retrime_orange/gpsmarks/5.png"),
		[6] = Material("materials/retrime_orange/gpsmarks/6.png"),
		[7] = Material("materials/retrime_orange/gpsmarks/7.png"),
		[8] = Material("materials/retrime_orange/gpsmarks/8.png"),
		[9] = Material("materials/retrime_orange/gpsmarks/9.png")
	}
}

--[[------------------------------------------------------------

	DeathMark

------------------------------------------------------------]]--
local function DeathMark(type, length, text, id, vector)
	local exists = false

	for k, v in pairs(marks) do
		if v.type ~= 3 or v.vector:DistToSqr(vector) > 262144 then continue end

		-- vector
		v.vector = vector

		if v.count then
			-- count, counticon
			v.count = v.count + 1
			v.counticon = (v.count < 10 and icons.counts[v.count]) or icons.counts[1]

			-- lifetime
			if v.lifetime < 4 then
				v.lifetime = v.lifetime + 1

				-- timer
				local name = "" .. k

				if timer.Exists(name) then
					timer.Remove(name)
				end

				timer.Create(name, length, 1, function()
					RemoveMark(k)
				end)
			end
		else
			-- newtext
			local newtext = DarkRP.textWrap("Потеря биосигналов", "font_18r", 100)

			-- width, height
			surface.SetFont("font_18r")
			local width, height = surface.GetTextSize(newtext)

			-- height, text
			v.height = height
			v.text = newtext

			-- count, counticon
			v.count = 2
			v.counticon = icons.counts[v.count] or icons.counts[2]

			-- lifetime
			v.lifetime = 1
		end

		-- exists
		exists = true
		break
	end

	if not exists then
		-- icon
		local icon = icons.types[type] or icons.types[3]

		-- newtext
		local newtext = DarkRP.textWrap(text, "font_18r", 100)

		-- width, height
		surface.SetFont("font_18r")
		local width, height = surface.GetTextSize(newtext)

		-- mark
		local mark = {
			type = type,
			vector = vector,
			height = height,
			text = newtext,
			icon = icon
		}

		marks[id] = mark

		-- timer
		local name = "" .. id

		if timer.Exists(name) then
			timer.Remove(name)
		end

		timer.Create(name, length, 1, function()
			RemoveMark(id)
		end)
	end
end

--[[------------------------------------------------------------

	CreateMark, RemoveMark, ClearMarks, GetMarks

------------------------------------------------------------]]--
function CreateMark(type, length, text, id, vector)
	-- type
	if type == 3 then
		DeathMark(type, length, text, id, vector)
		return
	end

	-- icon
	local icon = icons.types[type] or icons.types[3]

	-- newtext
	local newtext = DarkRP.textWrap(text, "font_18r", 100)

	-- width, height
	surface.SetFont("font_18r")
	local width, height = surface.GetTextSize(newtext)

	-- mark
	local mark = {
		type = type,
		vector = vector,
		height = height,
		text = newtext,
		icon = icon
	}

	marks[id] = mark

	-- timer
	local name = id

	if timer.Exists(name) then
		timer.Remove(name)
	end

	timer.Create(name, length, 1, function()
		RemoveMark(id)
	end)
end

function RemoveMark(id)
	local name = id

	if timer.Exists(name) then
		timer.Remove(name)
	end

	if marks[id] then
		marks[id] = nil
	end
end

function ClearMarks()
	for id in pairs(marks) do
		RemoveMark(id)
	end
end

function GetMarks()
	return marks
end

--[[------------------------------------------------------------

	CreateMark, RemoveMark, ClearMarks

------------------------------------------------------------]]--
net.Receive("CreateMark", function()
	CreateMark(net.ReadUInt(2), net.ReadUInt(8), net.ReadString(), net.ReadString(), net.ReadVector())
end)

net.Receive("RemoveMark", function()
	RemoveMark(net.ReadString())
end)

hook.Add("OnPlayerChangedTeam", "ClearMarks", function(ply)
	ClearMarks()
end)

--[[------------------------------------------------------------

	HUDPaint

------------------------------------------------------------]]--
hook.Add("HUDPaint", "Marks", function()
	local pos = LocalPlayer():GetPos()

	for k, v in pairs(marks) do
		if v.vector:DistToSqr(pos) < 65536 then
			RemoveMark(k)
			continue
		end

		-- screen_x, screen_y
		local screen = v.vector:ToScreen()
		local screen_x = screen.x
		local screen_y = screen.y

		-- height
		local height = screen_y - (36 + v.height)

		-- draw
		draw_DrawText(v.text, "font_18s", screen_x, height, c000, 1, 1)
		draw_DrawText(v.text, "font_18r", screen_x, height, c230230230, 1, 1)
		draw.Icon(screen_x - 16, screen_y - 32, 32, 32, c255255255, v.icon)

		-- counticon
		if v.counticon then
			draw.Icon(screen_x - 16, screen_y - 32, 32, 32, c255255255, v.counticon)
		end
	end
end)