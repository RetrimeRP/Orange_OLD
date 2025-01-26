ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Bandits Supplies"
ENT.Author = "VALERY"
ENT.Contact = "https://steamcommunity.com/id/valery/"

function ENT:SetupDataTables()

	self:NetworkVar("Int", 0, "CaptureStatus")

end