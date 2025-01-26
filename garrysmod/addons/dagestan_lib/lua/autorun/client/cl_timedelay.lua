local bool, text, float, start, text2
local i, next_dot, lerp = 0, CurTime() + 0.5

net.Receive("Un.Actions", function(len)
	bool = net.ReadBool() or false
	text = net.ReadString() or nil
	text2 = string.len(text) or 0
	float = net.ReadFloat() - CurTime() or 0
	start = CurTime() or 0
	lerp = 0
end)


hook.Add("HUDPaint", "Un.Actions", function()
	if bool == true then
		if float then
			local float = math.ceil((100 / float) * (float - ((start + float) - CurTime())))
			local new_float = 600 * float / 100
			if new_float > 0 and new_float < 600 then
				lerp = Lerp(FrameTime() * 10, lerp or 0, new_float)
				local w, h = ScrW() * 0.5, ScrH() * 0.5
				draw.RoundedBox(0, w - 304, h + 17, 600, 42, Color(0, 0, 0, 180))
				draw.RoundedBox(0, w - 300, h + 20, 592, 36, Color(12, 12, 12, 180))
				draw.RoundedBox(0, w - 300, h + 20, lerp, 36, Color(255 * float / 100, 25, 25, 255))

				if text then
					if next_dot <= CurTime() then
						if i < 3 then
							i = i + 1
							text = text.. "."
						else
							i = 0
							text = text:sub(1, text2)
						end
						next_dot = CurTime() + 0.5
					end
					draw.SimpleText(text, "ui.30", w, h, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
		end
	end
end)


local Marks = Marks or {}
net.Receive("Un.Marks", function(len)
	local data = net.ReadTable()
	if data.bool == false then
		for k, v in ipairs(Marks) do
			if v.id == data.id then
				table.remove(Marks, k)
			end
		end
		return
	end
	table.insert(Marks, data)
	if data.sounds then
		surface.PlaySound(data.sounds)
	end
end)

local unit = 26
local function NiceDist(vec1, vec2, str)

	if not isvector(vec1) or not isvector(vec2) then return end

	local str = str and " " .. str or " м."
	local pos = math.sqrt(vec1:DistToSqr(vec2))
	local nice_pos = math.floor(pos / unit)

	return nice_pos .. str

end

local text, icon, pos
hook.Add("HUDPaint", "Un.Marks", function()
	if not Marks or #Marks < 0 then return end

	local ply = LocalPlayer()

	for _, v in ipairs(Marks) do

		text = v.text
		icon = Material("icon16/"..v.icon..".png")

		if isvector(v.pos) then
			pos = v.pos
		elseif IsValid(v.pos) and (isentity(v.pos) or v.pos:IsPlayer()) then
			pos = v.pos:GetPos()
		end

		local dist = v.dist
		local nice_dist = NiceDist(ply:GetPos(), pos)

		if pos and ply:GetPos():DistToSqr(pos) < (dist * dist) and ply:Alive() then
			position = pos:ToScreen()
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(icon)
			surface.DrawTexturedRect(position.x, position.y, 16, 16)
			draw.SimpleTextOutlined(text, "ui.30", position.x + 5, position.y - 25, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
			draw.SimpleTextOutlined("Расстояние: ".. nice_dist , "ui.30", position.x + 5, position.y - 10, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0))
		end
	end
end)

local next_think = CurTime() + 1
hook.Add("Think", "Un.Marks", function()
	if next_think >= CurTime() then return end
	if Marks and #Marks > 0 then
		for k, v in ipairs(Marks) do
			if v.time and v.time >= CurTime() then continue end
			table.remove(Marks, k)
		end
	end
	next_think = CurTime() + 1
end)