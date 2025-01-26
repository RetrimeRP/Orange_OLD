ENT.Base = "darkrp_printer"
ENT.Type = "anim"
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Token Printer 01"
ENT.Author = "VALERY"
ENT.Contact = "https://steamcommunity.com/id/valery/"

function ENT:InitializeVariables()

	self.model = "models/props_c17/consolebox03a.mdl"
	self.color = Color(30, 30, 30)
	self.max = 1250
	self.print = 250
	self.damage = 50

end