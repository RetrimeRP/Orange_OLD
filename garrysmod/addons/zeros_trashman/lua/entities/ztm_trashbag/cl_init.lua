/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

include("shared.lua")

function ENT:Initialize()
	ztm.Trashbag.Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

function ENT:Draw()
	self:DrawModel()
	ztm.Trashbag.Draw(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80

function ENT:OnRemove()
	ztm.Trashbag.OnRemove(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e
