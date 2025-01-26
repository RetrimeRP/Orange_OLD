/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	ztm.Recycler.Initialize(self)
end

function ENT:Draw()
	self:DrawModel()
	ztm.Recycler.Draw(self)
end

function ENT:Think()
	ztm.Recycler.Think(self)
	self:SetNextClientThink(CurTime())
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

	return true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

function ENT:UpdateVisuals()
	ztm.Recycler.UpdateVisuals(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

function ENT:OnRemove()
	ztm.Recycler.OnRemove(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786
