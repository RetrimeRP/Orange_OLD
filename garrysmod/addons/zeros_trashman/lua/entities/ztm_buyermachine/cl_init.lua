/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	if ztm.Buyermachine then
		ztm.Buyermachine.Initialize(self)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

function ENT:DrawTranslucent()
	self:Draw()
end

function ENT:Draw()
	self:DrawModel()
	if ztm.Buyermachine then
		ztm.Buyermachine.Draw(self)
	end
end

function ENT:Think()
	if ztm.Buyermachine then
		ztm.Buyermachine.Think(self)
	end
	self:SetNextClientThink(CurTime())

	return true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

function ENT:OnRemove()
	if ztm.Buyermachine then
		ztm.Buyermachine.OnRemove(self)
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398
