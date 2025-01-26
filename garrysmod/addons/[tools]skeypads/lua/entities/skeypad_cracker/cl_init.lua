
include("shared.lua")

function ENT:Initialize()

end

local screenPos = Vector(2.1, .65, 4.12)
local screenAngles = Angle(0, 270, 0)

local circleMat = Material("skeypads/circle.png", "noclamp smooth")

function ENT:Draw()
    self:DrawModel()

    cam.Start3D2D(self:LocalToWorld(screenPos), self:LocalToWorldAngles(screenAngles), 0.004)
        local circleSize = 130
        local circleSpacing = 60
        local circleX = -(circleSize * 3 + circleSpacing * 2) / 2

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(circleMat)

        for i = 0, 2 do
            surface.DrawTexturedRect(circleX + i * (circleSize + circleSpacing), 120 + math.sin((CurTime() + i * .2) * 4) * 25, circleSize, circleSize)
        end
    cam.End3D2D()
end

