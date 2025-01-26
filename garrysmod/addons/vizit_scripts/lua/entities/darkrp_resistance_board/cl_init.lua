include("shared.lua")
CreateFont("Board@Montserrat Bold@896")
CreateFont("boardPoints@Montserrat Bold@196")
local t1 = {
	"Восточная часть ЗС",
	"Западная часть ЗС",
	"Выход в город"
}
include("shared.lua")

local t1 = {
	"сасем",
	"сасем 2",
	"сасем 3"
}


function ENT:Draw()
	local offsetY = 850
	self:DrawModel()

	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 65536 then return end

	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetUp(), 360)
	ang:RotateAroundAxis(self:GetRight(), 180)
	ang:RotateAroundAxis(self:GetForward(), 90)
	
	local min, max = self:GetModelBounds()
	local center = self:GetPos() + (min + max) * 0.5
	local offset = Vector(-0.5, 0, max.z + 10)
	local pos = center + offset

	cam.Start3D2D(pos, ang, 0.02)
		draw.SimpleText("Наши точки", "Board", 0, 700, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	
		for _, text in ipairs(t1) do
			draw.SimpleText(text, "Board", 0, offsetY, Color(175, 21, 21), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			offsetY = offsetY + 210
		end
	cam.End3D2D()
end
