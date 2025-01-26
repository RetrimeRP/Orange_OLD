local ents = ents
local table = table
local timer = timer
local sql = sql
local pairs = pairs
local ipairs = ipairs
local IsValid = IsValid
local Vector = Vector
local Angle = Angle
local FindMetaTable = FindMetaTable
local strSp = string.Split
local unp = unpack
local entMeta = FindMetaTable("Entity")
local pointMap = {}
local secondaryPoints = {}
local function findEntityByName(name)
    return pointMap[name]
end
function entMeta:InitializePoint(data)
    if not data.table_name or data.table_name == "" then
        print("[ERROR]: Пустое имя таблицы для точки!")
        return false
    end

    self.uniqueName = data.unique_name
    self.isSecondary = data.is_secondary == 1
    self.mainPoint = (data.main_point == "NULL") and nil or data.main_point
    self.pos = strSp(data.pos, ",")
    self.entityPos = strSp(data.entity_pos, ",")
    self.entityAngle = strSp(data.entity_angle, ",")
    self.sizeTriggerW = strSp(data.sizeW, ",")
    self.sizeTriggerH = strSp(data.sizeH, ",")
    self.tableName = data.table_name
    self.capturedBy = nil
    self.captureProgress = 0
    self.secondaryPoints = {}

    return true
end

function entMeta:AddSecondaryPoint(secondaryPoint)
    table.insert(self.secondaryPoints, secondaryPoint)
end

function entMeta:SpawnPoint()
    self:Spawn()
    self:SetPos(Vector(unp(self.entityPos)))
    self:SetAngles(Angle(unp(self.entityAngle)))

    local trigger = ents.Create("point_trigger")
    trigger:Spawn()
    trigger:SetPos(Vector(unp(self.pos)))

    timer.Simple(0.1, function()
        trigger:SetCollisionBounds(Vector(unp(self.sizeTriggerW)), Vector(unp(self.sizeTriggerH)))
    end)

    trigger:SetModel("models/props_c17/furnitureStove001a.mdl")
    trigger.point = self
    if self.isSecondary then
        self:SetSecondary(self.mainPoint)
        local papa = findEntityByName(self.mainPoint)
        table.insert(papa.secondaryPoints,self)
        printTable(papa.secondaryPoints)
    end
    print("[INFO]: ТОЧКА ПОД УНИКАЛЬНЫМ ИМЕНЕМ:", self.uniqueName, "успешно создана!")
    
end


function entMeta:AreAllSecondaryCaptured()
    for _, secondary in ipairs(self.secondaryPoints) do
        if secondary.capturedBy == nil then
            print("[INFO]: Вспомогательная точка", secondary.uniqueName, "не захвачена!")
            return false
        end
    end
    return true
end

function entMeta:StartCapture(ply)
    if not self:GetAllowCapture(ply) then
        print("[INFO]: Захват точки", self.uniqueName, "недоступен!")
        return
    end
end

function entMeta:GetAllowCapture(ply)
    if not self.isSecondary and not self:AreAllSecondaryCaptured() then
        print("[INFO]: Основная точка", self.uniqueName, "не может быть захвачена, пока не захвачены все вспомогательные!")
        return false
    end

    if self.mainPoint then
        local mainPointEnt = findEntityByName(self.mainPoint)
        if not mainPointEnt then
            print("[ERROR]: Главная точка", self.mainPoint, "не найдена!")
            return false
        end

        return mainPointEnt.capturedBy == ply:ReturnFaction()
    end

    return true
end

function entMeta:SetSecondary(mainPointName)
    self.isSecondary = true
    self.mainPoint = mainPointName

end

function entMeta:SetAsMain()
    self.isSecondary = false
    self.mainPoint = nil
end

function LoadPointsFromSQL(results)
    if not results then
        print("[SQL ERROR]: Не удалось получить данные из таблицы triggers.", sql.LastError())
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
        print("[SQL ERROR]: Не удалось получить данные из таблицы triggers.", sql.LastError())
        return
    end

    LoadPointsFromSQL(results)
end

hook.Add("InitPostEntity", "vizit.points", function()
    CreateEntitiesFromDatabase()
end)

function printTable()
    PrintTable(pointMap)
end
-- concommand
concommand.Add("debug_test", CreateEntitiesFromDatabase)
