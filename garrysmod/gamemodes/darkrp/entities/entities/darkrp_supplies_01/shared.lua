ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Resistance Supplies"

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "CaptureStatus")
end