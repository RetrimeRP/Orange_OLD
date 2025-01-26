ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.Category = "Retrime"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.PrintName = "Printer Base"
ENT.Author = "VALERY"
ENT.Contact = "https://steamcommunity.com/id/valery/"

function ENT:SetupDataTables()

	self:NetworkVar("Int", 0, "Printed")
	self:NetworkVar("Entity", 0, "owning_ent")

end

function ENT:InitializeVariables()
end