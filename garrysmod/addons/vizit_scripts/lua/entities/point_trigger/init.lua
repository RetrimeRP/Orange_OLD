AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
    -- self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_BBOX)
    -- self:SetCollisionBounds(-sizeTrigger,sizeTrigger)
    self:SetTrigger(true)
    self:DrawShadow(false)
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)

end
function ENT:StartTouch(ent)
    if not IsValid(ent) or not ent:IsPlayer() then return end
    if not ent:AllowCapture() then return end
    local point = self:getPoint()
    if not point then return end

    if not point.captureAmount then
        point.captureAmount = VIZIT_SCRIPTS.CaptureAmount or 0
    end


    if not point.players then
        point.players = {}
    end

    if point.players[ent] then return end

    point.players[ent] = true
    point.captureAmount = math.max(point.captureAmount - 1, 0)

    point:SetCaptureRequired(tonumber(point.captureAmount))
end

function ENT:EndTouch(ent)
    if not IsValid(ent) or not ent:IsPlayer() then return end

    local point = self:getPoint()
    if not point then return end

    if not point.players or not point.players[ent] then return end
    point.players[ent] = nil
    point.captureAmount = point.captureAmount + 1

    point:SetCaptureRequired(tonumber(point.captureAmount))
end
