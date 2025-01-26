/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.AutomaticFrameAdvance = true
ENT.Model = "models/zerochain/props_trashman/ztm_trashburner.mdl"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.PrintName = "Trashburner"
ENT.Category = "Zeros Trashman"
ENT.RenderGroup = RENDERGROUP_OPAQUE

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Trash")
    self:NetworkVar("Bool", 1, "IsBurning")
    self:NetworkVar("Bool", 0, "IsClosed")
    self:NetworkVar("Float", 0, "StartTime")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

    if (SERVER) then
        self:SetTrash(0)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

        self:SetIsClosed(false)
        self:SetIsBurning(false)
        self:SetStartTime(-1)
    end
end

function ENT:OnCloseButton(ply)
    local trace = ply:GetEyeTrace()

    local lp = self:WorldToLocal(trace.HitPos)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

    if lp.x > -40 and lp.x < -38 and lp.y < 10.5 and lp.y > 0 and lp.z > 52 and lp.z < 60 then
        return true
    else
        return false
    end
end

function ENT:OnStartButton(ply)
    local trace = ply:GetEyeTrace()

    local lp = self:WorldToLocal(trace.HitPos)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

    if lp.x > -40 and lp.x < -38 and lp.y < -0.6 and lp.y > -11 and lp.z > 52 and lp.z < 60 then
        return true
    else
        return false
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e
