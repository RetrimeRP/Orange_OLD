/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:SpawnFunction(ply, tr)
	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	local ent = ents.Create(self.ClassName)
	ent:SetPos(SpawnPos)
	ent:Spawn()
	ent:Activate()

	return ent
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

function ENT:Initialize()
	ztm.Trash.Initialize(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
