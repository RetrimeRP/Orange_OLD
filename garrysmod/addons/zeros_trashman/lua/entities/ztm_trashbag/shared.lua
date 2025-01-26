/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Model = "models/zerochain/props_trashman/ztm_trashbag.mdl"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "Trashbag"
ENT.Category = "Zeros Trashman"
ENT.RenderGroup = RENDERGROUP_BOTH
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Trash")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

    if (SERVER) then
        self:SetTrash(100)
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8
