include("shared.lua")

local c000 = Color(0, 0, 0)
local c255255255 = Color(255, 255, 255)

function ENT:DrawCustom3D2D()
	local pos = self:LocalToWorld(Vector(0, 0, 160))

	local ang = LocalPlayer():GetAngles()
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)

	cam.Start3D2D(pos, ang, 0.12)
		draw.SimpleText("Святая рождественская ёлка", "font_40sb", 0, 0, c000, 1, 1)
		draw.SimpleText("Святая рождественская ёлка", "font_40b", 0, 0, c255255255, 1, 1)

		draw.SimpleText("Игрушки: " .. self:GetIgrushki() .. " из 20000", "font_24s", 0, 30, c000, 1, 1)
		draw.SimpleText("Игрушки: " .. self:GetIgrushki() .. " из 20000", "font_24r", 0, 30, c255255255, 1, 1)
	cam.End3D2D()
end