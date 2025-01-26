/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

include("shared.lua")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

function ENT:Initialize()
	ztm.Trash.Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

function ENT:Draw()
	self:DrawModel()
	ztm.Trash.Draw(self)
end

function ENT:OnRemove()
	ztm.Trash.OnRemove(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786
