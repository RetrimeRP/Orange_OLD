include("shared.lua")

local c000 = Color(0, 0, 0)
local c255255255 = Color(255, 255, 255)
local c1657343 = Color(165, 73, 43)
local c25510251 = Color(255, 102, 51)

local status = 0

function ENT:DrawCustom3D2D()

	local pos = self:LocalToWorld(Vector(0, 0, 65))

	local ang = LocalPlayer():GetAngles()
	ang:RotateAroundAxis(ang:Right(), 90)
	ang:RotateAroundAxis(ang:Up(), -90)

	local capturestatus = self:GetCaptureStatus()

	cam.Start3D2D(pos, ang, 0.15)
		draw.SimpleText("Припасы", "font_40sb", 0, 0, c000, 1, 1)
		draw.SimpleText("Припасы", "font_40b", 0, 0, c255255255, 1, 1)

		if capturestatus < 1 then
			draw.SimpleText("Сопротивление может их захватить", "font_24s", 0, 30, c000, 1, 1)
			draw.SimpleText("Сопротивление может их захватить", "font_24r", 0, 30, c255255255, 1, 1)
		else
			status = Lerp(FrameTime() * 6, status, capturestatus)

			draw.RoundedBox(0, -80, 30, 160, 5, c1657343)
			draw.RoundedBox(0, -80, 30, 160 * (status / 24), 5, c25510251)
		end
	cam.End3D2D()

end