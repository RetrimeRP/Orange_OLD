ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.AutomaticFrameAdvance = true
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Smuggler Resistance"
ENT.Author = "cvrsjz"

function ENT:SetAutomaticFrameAdvance(bUsingAnim)

	self.AutomaticFrameAdvance = bUsingAnim

end

function ENT:Think()

	if SERVER then
		if self.SequenceID == nil then
			self.SequenceID = self:LookupSequence("pose_standing_02")
		end

		self:ResetSequence(self.SequenceID)
	end

	self:NextThink(CurTime() + 3)
	return true

end