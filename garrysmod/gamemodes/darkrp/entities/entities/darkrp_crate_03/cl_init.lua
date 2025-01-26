include("shared.lua")

local c000 = Color(0, 0, 0)
local c255255255 = Color(255, 255, 255)

function ENT:DrawCustom3D2D()
	local pos = self:LocalToWorld(Vector(0, 0, 80))

	local ang = LocalPlayer():GetAngles()
	ang:RotateAroundAxis(ang:Right(), 90)
	ang:RotateAroundAxis(ang:Up(), -90)

	local cratecharge = self:GetCrateCharge()

	cam.Start3D2D(pos, ang, 0.15)
		draw.SimpleText("Еда", "font_32sb", 0, 0, c000, 1, 1)
		draw.SimpleText("Еда", "font_32b", 0, 0, c255255255, 1, 1)

		draw.SimpleText("Осталось " .. cratecharge, "font_22s", 0, 30, c000, 1, 1)
		draw.SimpleText("Осталось " .. cratecharge, "font_22r", 0, 30, c255255255, 1, 1)
	cam.End3D2D()
end