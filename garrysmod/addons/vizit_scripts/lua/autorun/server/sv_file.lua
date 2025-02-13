    local ents = ents
local table = table
local timer = timer
local sql = sql
local ipairs = ipairs
local Vector = Vector
local Angle = Angle
local FindMetaTable = FindMetaTable
local strSp = string.Split
local unp = unpack
local entMeta = FindMetaTable("Entity")
local pointMap = pointMap or {}
local notify

local function findEntityByName(name)
    return pointMap[name]
end
hook.Add("DarkRPFinishedLoading","JustCheck",function()
    notify = DarkRP.notify
end)

hook.Add("PlayerDisconnected","chequeRemove",function(ply)
    -- if not ply.cheques then return end
    -- for _, k in ipairs(ply.cheques) do
    --     k:Remove()
    -- end
    for _, ent in ents.Iterator() do
        if ent.factions and ent.factions[ply:ReturnFaction()] then
            ent.factions[playerFaction][ent] = nil 
        end
    end
end)

function entMeta:AddSecondaryPoint(secondaryPoint)
    table.insert(self.secondaryPoints, secondaryPoint)
    -- self.secondaryPoints[#secondaryPoints + 1] = secondaryPoint
end

function entMeta:InitializePoint(data)
    self.uniqueName = data.unique_name
    self.mainPoint = (data.main_point == "NULL") and nil or data.main_point
    self.pos = strSp(data.pos, ",")
    self.entityPos = strSp(data.entity_pos, ",")
    self.entityAngle = strSp(data.entity_angle, ",")
    self.sizeTriggerW = strSp(data.sizeW, ",")
    self.sizeTriggerH = strSp(data.sizeH, ",")
    self.tableName = data.table_name
    self.capturedBy = nil
    self.captureProgress = 0
    self.isBandits = tonumber(data.isBandit)
    print(self.isBandits)
    if self.isBandits and self.isBandits ~= 1 then
        self.isBandits = nil
        print("ЭТА ТОЧКА  НЕ БАНДИТСКАЯ ЙОУ" .. self.uniqueName)
    end
    self.secondaryPoints = {}
    if self.mainPoint == "NULL" then
        self.mainPoint = nil
    end
    if self.mainPoint then
        self.isSecondary = true
    end
    return true
end

-- PrintTable(findEntityByName("mainpoint").secondaryPoints)

function entMeta:SpawnPoint()
    self:Spawn()
    self:SetPos(Vector(unp(self.entityPos)))
    self:SetAngles(Angle(unp(self.entityAngle)))
    -- print("НАЧАЛИ")
    -- print(string.format("ЭТА ИМЯ ЭНТИТИ И ЕГО self.isSeconday: %s %s",self.uniqueName,self.isSecondary))
    if self.isSecondary  then
        timer.Simple(0.3,function()
            local ent = findEntityByName(self.mainPoint)
            ent:AddSecondaryPoint(self)
            print("[INFO] ЭТА ДОП ТОЧКА ДААА!!1" .. self.uniqueName)
            PrintTable(ent.secondaryPoints)
        end)
    end

    
    local trigger = ents.Create("point_trigger")
    trigger:Spawn()
    trigger:SetPos(Vector(unp(self.pos)))

    timer.Simple(0.1, function()
        trigger:SetCollisionBounds(Vector(unp(self.sizeTriggerW)), Vector(unp(self.sizeTriggerH)))
    end)

    trigger:SetModel("models/props_c17/furnitureStove001a.mdl")
    trigger.point = self
end


function entMeta:AreAllSecondaryCaptured(ply)
    for _, secondary in ipairs(self.secondaryPoints) do
        print(ply:ReturnFaction())
        print(secondary:GetWhoCapture())
        if secondary:GetWhoCapture() ~= ply:ReturnFaction() then
            return false
        end
    end
    return true
end
function entMeta:StartCapture(ply)
    if not self:GetAllowCapture(ply) then
        return
    end
end

function entMeta:AlreadyCaptured(ply)
    if self:GetWhoCapture() == ply:ReturnFaction() then
        notify(ply, 1, 2, "Точка уже ваша!")
        return true
    end
end

function entMeta:SetCooldown(time)
    local index = self:EntIndex()
    local stringIndex = "CheckTime_" .. index
    self:SetCanCapture(false)
    timer.Create(stringIndex,time,1,function()
        self:SetCanCapture(true)
    end)
end

function entMeta:GetAllowCapture(ply)
    local index = self:EntIndex()
    if self:GetCanCapture() == false then
        local stringIndex = "CheckTime_" .. index
        if timer.Exists(stringIndex) then
            -- print(timer.TimeLeft("CheckTime_" .. self:EntIndex()))
            local time = math.Round(timer.TimeLeft("CheckTime_" .. self:EntIndex()))
            notify(ply, 1, 2, string.format("Подождите еще %i сек, для начала захвата", time))
        end
        return
    end
    if ply:ReturnFaction() == "Бандиты" and not self.isBandits then notify(ply, 1, 2, "Бандиты не могут захватывать эти точки!") return end
    if self.isBandits == 1 and (ply:ReturnFaction() ~= "Бандиты" and ply:ReturnFaction() ~= "Альянс") then
        notify(ply, 1, 2, "Вы не можете захватить эту бандитскую точку!")
        return false
    end
    if not ply:AllowCapture() then return end
    if not self.isSecondary and not self:AreAllSecondaryCaptured(ply) then
        notify(ply, 1, 2, "Все вторичные точки не захвачены!")
        return false
    end

    return true
end


function LoadPointsFromSQL(results)
    if not results then
        return
    end

    for _, row in ipairs(results) do
        local ent = ents.Create("point")
        if ent:InitializePoint(row) then
            ent:SpawnPoint()
            pointMap[ent.uniqueName] = ent
        end
    end
end

function CreateEntitiesFromDatabase()
    local results = sql.Query("SELECT * FROM triggers;")

    if not results then
        return
    end

    LoadPointsFromSQL(results)
end

hook.Add("InitPostEntity", "vizit.points", function()
    CreateEntitiesFromDatabase()
end)

-- concommand
concommand.Add("debug_test", CreateEntitiesFromDatabase)
-- hook.Add("PlayerJoinTeam","SendNet",function(ply,team)
--     timer.Simple(0.5,function()
        
--     end)
-- end) Патом
-- surface.PlaySound()
hook.Add("SetupPlayerVisibility", "vizit", function(ply) -- кмс по пвс
    if ply:AllowCapture() then
        for _, point in pairs(pointMap) do
            if IsValid(point) then
                AddOriginToPVS(point:GetPos())
            end
        end
    end
end)