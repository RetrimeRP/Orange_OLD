include("shared.lua")

local colorType
function ENT:Draw()
    if GetConVar("ret_points_show_borders"):GetString() == "0" then return end
    local w,h = self:GetCollisionBounds()
    self:DrawShadow(false)
    colorType = VIZIT_SCRIPTS.GetGroupColor(LocalPlayer())
    render.DrawWireframeBox(self:GetPos(), self:GetAngles(), w,h,colorType, true)
end