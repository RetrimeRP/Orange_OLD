ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Bandits Crate"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "CrateCharge")
end