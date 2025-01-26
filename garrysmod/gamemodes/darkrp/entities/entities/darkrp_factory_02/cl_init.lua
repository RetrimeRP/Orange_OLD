include("shared.lua")

local c303030 = Color(30, 30, 30)
local c255255255 = Color(255, 255, 255)

function ENT:DrawCustom3D2D()
	local pos = self:LocalToWorld(Vector(25, 0, 30))

	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Right(), 270)
	ang:RotateAroundAxis(ang:Up(), -90)

	cam.Start3D2D(pos, ang, 0.11)
		draw.RoundedBox(4, -175, -20, 350, 40, c303030)
		draw.SimpleText("РАЗДАТЧИК ВОДЫ", "font_32b", 0, 0, c255255255, 1, 1)
	cam.End3D2D()
end