/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.AutomaticFrameAdvance = true
ENT.Model = "models/zerochain/props_trashman/ztm_buyermachine.mdl"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "Buyermachine"
ENT.Category = "Zeros Trashman"
ENT.RenderGroup = RENDERGROUP_BOTH
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsInserting")
    self:NetworkVar("Float", 0, "Money")
    self:NetworkVar("Int", 0, "BlockType")
    self:NetworkVar("Entity", 0, "MoneyEnt")
    self:NetworkVar("Int", 1, "PriceModify")
    if (SERVER) then
        self:SetIsInserting(false)
        self:SetMoney(0)
        self:SetBlockType(1)
        self:SetPriceModify(100)
    end
end


function ENT:OnPayoutButton(ply)
    local trace = ply:GetEyeTrace()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

    local lp = self:WorldToLocal(trace.HitPos)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

    if lp.x > -13 and lp.x < 13 and lp.y < 10 and lp.y > 9 and lp.z > 79 and lp.z < 85.3 then
        return true
    else
        return false
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786
