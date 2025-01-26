/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80

function ENT:Initialize()
	ztm.Trashburner.Initialize(self)
end

function ENT:Draw()
	self:DrawModel()
	ztm.Trashburner.Draw(self)
end

function ENT:Think()
	ztm.Trashburner.Think(self)
	self:SetNextClientThink(CurTime())

	return true
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

function ENT:UpdateVisuals()
	ztm.Trashburner.UpdateVisuals(self)
end

function ENT:Remove()
	ztm.Trashburner.Remove(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
