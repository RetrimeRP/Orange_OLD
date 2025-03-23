AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_BBOX)
    self:SetTrigger(true)
    self:DrawShadow(false)
    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
    self.playersInZone = {}
    timer.Create("UpdateFactionCounts_" .. self:EntIndex(), 2, 0, function()
        if IsValid(self) then
            self:UpdateFactionCounts()
        else
            timer.Remove("UpdateFactionCounts_" .. self:EntIndex())
        end
    end)
end

local function isValidPlayer(ent)
    return IsValid(ent) and ent:IsPlayer() and ent:AllowCapture()
end
function ENT:getPoint()
    return self.point
end
function ENT:StartTouch(ent)
    if not isValidPlayer(ent) then return end
    self.playersInZone[ent] = true
end

function ENT:EndTouch(ent)
    if not isValidPlayer(ent) then return end
    self.playersInZone[ent] = nil
end

function ENT:UpdateFactionCounts()
    local point = self:getPoint()
    if not point then return end
    point.factions = {}
    for ent in pairs(self.playersInZone) do
        local playerFaction = ent:ReturnFaction()
        if playerFaction then
            point.factions[playerFaction] = point.factions[playerFaction] or {}
            point.factions[playerFaction][ent] = true
        end
    end
    local maxCount = 0
    local dominantFaction = "Никем"
    for faction, players in pairs(point.factions) do
        local count = table.Count(players)
        if count > maxCount then
            maxCount = count
            dominantFaction = faction
        end
    end
    -- PrintTable(point.factions)
    point.dominationFaction = dominantFaction
    point:SetWhoWin(dominantFaction)
    -- print("Сейчас побеждает:", dominantFaction)
end