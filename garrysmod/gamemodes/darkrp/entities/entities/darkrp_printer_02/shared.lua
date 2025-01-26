ENT.Base = "darkrp_printer"
ENT.Type = "anim"
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Token Printer 02"
ENT.Author = "VALERY"
ENT.Contact = "https://steamcommunity.com/id/valery/"

function ENT:InitializeVariables()

	self.model = "models/props_c17/consolebox01a.mdl"
	self.color = Color(30, 30, 30)
	self.max = 3750
	self.print = 750
	self.damage = 100

end