ENT.Base = "base_anim"
ENT.Type = "ai"
ENT.AutomaticFrameAdvance = true
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "CWU Delivery Sell"

function ENT:Think()

	if SERVER then
		if self.SequenceID == nil then
			self.SequenceID = self:LookupSequence("pose_standing_0" .. math.random(1, 4))
		end

		self:ResetSequence(self.SequenceID)
	end

	self:NextThink(CurTime() + 3)
	return true

end