ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.Category = "Retrime"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.PrintName = "Corpse"

if SERVER then return end

function ENT:Initialize()

    self:DrawShadow(false) -- ИЗМЕНЕНО 04.07.2022

end