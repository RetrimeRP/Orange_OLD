ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Christmas"

function ENT:SetupDataTables()
    self:NetworkVar("Float", 0, "Igrushki")
end