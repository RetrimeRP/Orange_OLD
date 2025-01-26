local draw_SimpleText = draw.SimpleText
local draw_DrawText = draw.DrawText

local c255255255 = Color(255, 255, 255)
local c000 = Color(0, 0, 0)

local groupcolors = {}
groupcolors["Альянс"] = Color(51, 204, 204)
groupcolors["Сопротивление"] = Color(75, 75, 75)
groupcolors["Гражданский Союз Рабочих"] = Color(204, 204, 153)

local doorcache = {}
local trace = {}
local offset = Angle(0, 90, 90)

--[[------------------------------------------------------------

	Doors

------------------------------------------------------------]]--
timer.Create("DarkRP_RefreshDoorCache", 1, 0, function()

	local client = LocalPlayer()

	if not IsValid(client) then return end

	local doorcount = 0
	doorcache = {}

	for k, v in ipairs(ents.FindInSphere(client:GetPos(), 300)) do
		if not IsValid(v) or not v:isDoor() or not v:isKeysOwnable() then continue end

		doorcount = doorcount + 1
		doorcache[doorcount] = v
	end

end)

hook.Add("PostDrawTranslucentRenderables", "DarkRP_Doors", function()

	for k, v in ipairs(doorcache) do
		if not v:IsValid() then continue end

		local client = LocalPlayer()

		local pos = v:LocalToWorld(v:OBBCenter())
		pos.z = pos.z + 17.5

		trace.start = client:GetPos() + client:OBBCenter()
		trace.endpos = pos
		trace.filter = client

		local tr = util.TraceLine(trace)

		if tr.Entity ~= v then continue end
		if pos:DistToSqr(tr.HitPos) > 65 then continue end

		local owned = v:isKeysOwned()
		local owner = v:getDoorOwner()
		local title = v:getKeysTitle()
		local coowners = v:getKeysCoOwners() or {}
		local group = v:getKeysDoorGroup() or {}
		local disallowed = v:getKeysNonOwnable()

		cam.Start3D2D(tr.HitPos + tr.HitNormal, tr.HitNormal:Angle() + offset, .15)
			if owned then
				-- title
				draw_SimpleText(title or "Владелец", "font_40sb", 0, 0, c000, 1, 1)
				draw_SimpleText(title or "Владелец", "font_40b", 0, 0, c255255255, 1, 1)

				-- nick
				local nick = owner:Nick()

				draw_SimpleText(nick, "font_32sb", 0, 40, c000, 1, 1)
				draw_SimpleText(nick, "font_32b", 0, 40, c255255255, 1, 1)

				-- coowners
				local count = 1

				for key, val in pairs(coowners) do
					local ply = Player(key)

					if not IsValid(ply) then continue end

					local coownernick = ply:Nick()

					draw_SimpleText(coownernick, "font_32sb", 0, 40 + (count * 32), c000, 1, 1)
					draw_SimpleText(coownernick, "font_32b", 0, 40 + (count * 32), c255255255, 1, 1)

					count = count + 1
				end
			elseif group and #group > 0 then
				-- title
				draw_SimpleText(title or "Организация", "font_40sb", 0, 0, c000, 1, 1)
				draw_SimpleText(title or "Организация", "font_40b", 0, 0, c255255255, 1, 1)

				-- group
				local name = group:gsub(" ", "\n")
				local color = groupcolors[group] or c255255255

				draw_DrawText(name, "font_32sb", 0, 40, c000, 1, 1)
				draw_DrawText(name, "font_32b", 0, 40, color, 1, 1)
			elseif not disallowed and not owned then
				-- title
				draw_SimpleText("Свободно", "font_40sb", 0, 0, c000, 1, 1)
				draw_SimpleText("Свободно", "font_40b", 0, 0, c255255255, 1, 1)

				-- purchase
				draw_SimpleText("F2 для покупки", "font_32sb", 0, 40, c000, 1, 1)
				draw_SimpleText("F2 для покупки", "font_32b", 0, 40, c255255255, 1, 1)
			end
		cam.End3D2D()
	end

end)