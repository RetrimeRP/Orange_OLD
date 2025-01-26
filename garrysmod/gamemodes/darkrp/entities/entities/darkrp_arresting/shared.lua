ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.AutomaticFrameAdvance = true
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Combine Arrest"
ENT.Author = "VALERY"
ENT.Contact = "https://steamcommunity.com/id/valery/"

function ENT:SetAutomaticFrameAdvance(bUsingAnim)

	self.AutomaticFrameAdvance = bUsingAnim

end

function ENT:Think()

	if self.Sequence == nil then return end

	if SERVER then
		if self.SequenceID == nil then
			self.SequenceID = self:LookupSequence(self.Sequence)
		end

		self:ResetSequence(self.SequenceID)
	end

	self:NextThink(CurTime() + 3)
	return true

end