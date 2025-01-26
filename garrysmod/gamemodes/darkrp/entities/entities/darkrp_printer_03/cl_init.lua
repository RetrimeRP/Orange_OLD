include("shared.lua")

local c19669105 = Color(196, 69, 105)
local c150150150 = Color(150, 150, 150)
local c1083858 = Color(108, 38, 58)

function ENT:Initialize()

	self:InitializeVariables()

end

function ENT:Draw()

	self:DrawModel()

	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 65536 then return end

	local owner = (IsValid(self:Getowning_ent()) and self:Getowning_ent():Name()) or "Неизвестен"
	local printed = self:GetPrinted()
	local max = self.max
	local print = self.print
	local progress = math.min(142 * (printed / max), 142)

	local pos = self:LocalToWorld(Vector(0, 0, 11))

	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 90)

	cam.Start3D2D(pos, ang, 0.075)
		draw.SimpleText("Большой принтер", "font_32b", 0, -2, c19669105, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		draw.SimpleText("Владелец: " .. owner, "font_22r", 0, 2, c150150150, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	cam.End3D2D()

	local pos2 = self:LocalToWorld(Vector(16.2, -3.2, 7.6))

	local ang2 = self:GetAngles()
	ang2:RotateAroundAxis(ang2:Right(), 270)
	ang2:RotateAroundAxis(ang2:Up(), 90)

	cam.Start3D2D(pos2, ang2, 0.05)
		draw.SimpleText(DarkRP.formatMoney(printed), "font_48b", -110, 60, c19669105, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		draw.SimpleText(DarkRP.formatMoney(print) .. "/мин", "font_22r", -110, 60, c150150150, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		draw.RoundedBox(0, 19, 25, 142, 26, c1083858)
		draw.RoundedBox(0, 19, 25, progress, 26, c19669105)
		draw.SimpleText("макс. " .. DarkRP.formatMoney(max), "font_22r", 90, 60, c150150150, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	cam.End3D2D()

end