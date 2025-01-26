AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("CaptureStart")
util.AddNetworkString("StopCapture")
util.AddNetworkString("SettingPoint")
local fmt = string.format

-- ЭТО ЕБАНЫЙ УЖАС
local function removeTable()
    local result = sql.Query("DROP TABLE IF EXISTS triggers;")
    if result == false then
        print("[SQL ERROR]: Не удалось удалить таблицу triggers.", sql.LastError())
    else
        print("[INFO]: Таблица triggers успешно удалена.")
    end
end
-- removeTable()
local quer = sql.Query
local sqlStr = sql.SQLStr
local sqlErr = sql.LastError

function ENT:SaveToSQL()
    local tableName = self.tableName or NULL
    local captureTime = self.captureTime or 30

    local result = sql.Query(fmt([[CREATE TABLE IF NOT EXISTS %s (
        unique_name TEXT PRIMARY KEY,
        pos TEXT,
        sizeW TEXT,
        sizeH TEXT,
        is_secondary INTEGER,
        main_point TEXT,
        entity_pos TEXT,
        entity_angle TEXT,
        table_name TEXT, -- Добавляем поле для имени таблицы
        capture_time INTEGER
    );]], sql.SQLStr("triggers")))

    if result == false then
        print("[SQL ERROR]:", sqlErr())
    end
    local ang, posS = self:GetAngles(), self:GetPos()
    local pos = fmt("%f,%f,%f", self.triggerPos.x, self.triggerPos.y, self.triggerPos.z)
    local sizeW = fmt("%f,%f,%f", self.sizeTriggerW.x, self.sizeTriggerW.y, self.sizeTriggerW.z)
    local sizeH = fmt("%f,%f,%f", self.sizeTriggerH.x, self.sizeTriggerH.y, self.sizeTriggerH.z)
    local entityPos = fmt("%f,%f,%f", posS.x, posS.y, posS.z)
    local ent_angle = fmt("%f,%f,%f", ang.pitch, ang.yaw, ang.roll)
    local isSecondary = self.isSecondary and 1 or 0
    local mainPoint = self.mainPoint or "NULL"

    local query = fmt([[INSERT INTO triggers (unique_name, pos, sizeW, sizeH, is_secondary, main_point, entity_pos, entity_angle, table_name, capture_time)
    VALUES (%s, %s, %s, %s, %d, %s, %s, %s, %s, %d)
    ON CONFLICT(unique_name) DO UPDATE SET
    pos = excluded.pos,
    sizeW = excluded.sizeW,
    sizeH = excluded.sizeH,
    is_secondary = excluded.is_secondary,
    main_point = excluded.main_point,
    entity_pos = excluded.entity_pos,
    entity_angle = excluded.entity_angle,
    table_name = excluded.table_name,
    capture_time = excluded.capture_time;]],
    sqlStr(self.uniqueName), sqlStr(pos), sqlStr(sizeW), sqlStr(sizeH),
    isSecondary, sqlStr(mainPoint), sqlStr(entityPos), sqlStr(ent_angle), sqlStr(tableName), captureTime)

    local result = quer(query)
    if result == false then
        print("[SQL ERROR]:", sqlErr())
    else
        print("[INFO]: Данные для сущности с уникальным именем", self.uniqueName, "успешно сохранены в таблицу", tableName)
    end
end
function ENT:CaptureStart(playerWhoCapture, playerTable, time) -- таблица в этом случае является таблицей с игроками на точке, которые вошли в триггер (подробнее смотри в point_trigger)
    net.Start("CaptureStart")
    net.WriteInt(time, 8)
    net.Send(playerWhoCapture)

    timer.Create(2, 0, 0, function()
        if not self.playerWhoCapture then return end
        local ply = self.playerWhoCapture
        if ply:GetPos():Distance(self:GetPos()) > 150 or not ply:Alive() then
            net.Start("StopCapture")
            net.Send(ply)
            self.playerWhoCapture = nil
        end
    end)
end

function ENT:Initialize()
    self:SetModel("models/props_combine/combine_interface001.mdl")

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()

    if self.pos then
        phys:EnableMotion(false)
    end

    phys:Wake()
end

net.Receive("SettingPoint", function(len, ply)
    if not ply:IsSuperAdmin() then
        ply:Kick("Ты не супер админ")
        return
    end

    local uniqueName = net.ReadString()
    local isSecondary = net.ReadBool()
    local mainPoint = net.ReadString()
    local ent = ply.currentTriggerEntity

    if not IsValid(ent) then
        ply:ChatPrint("[ERROR]: Сущность не найдена или недействительна.")
        return
    end

    ent.uniqueName = uniqueName
    ent.isSecondary = isSecondary
    ent.mainPoint = isSecondary and mainPoint or nil

    ply:ChatPrint("[INFO]: Настройки точки обновлены: " .. (isSecondary and "Вторичная точка" or "Основная точка"))
    ply:ChatPrint("[INFO]: Уникальное имя точки сохранено: " .. uniqueName)

    ent:SaveToSQL()
end)

net.Receive("SettingPoint", function(len, ply)
    if not ply:IsSuperAdmin() then
        ply:Kick("ПОШЕЛ НАХУЙ")
        return
    end
    local uniqueName = net.ReadString()
    local isSecondary = net.ReadBool()
    local mainPoint = net.ReadString()
    local captureTime = net.ReadInt(8)
    local tableName = net.ReadString()

    local ent = ply.currentTriggerEntity

    if not IsValid(ent) then
        ply:ChatPrint("[ERROR]: Сущность не найдена или недействительна.")
        return
    end

    ent.uniqueName = uniqueName
    ent.isSecondary = isSecondary
    ent.mainPoint = isSecondary and mainPoint or nil
    ent.captureTime = captureTime
    ent.tableName = tableName

    ply:ChatPrint("[INFO]: Настройки точки обновлены: " .. (isSecondary and "Вторичная точка" or "Основная точка"))
    ply:ChatPrint("[INFO]: Уникальное имя точки сохранено: " .. uniqueName)
    ply:ChatPrint("[INFO]: Время захвата установлено на: " .. captureTime .. " секунд")
    ply:ChatPrint("[INFO]: Имя таблицы для сохранения данных: " .. tableName)

    ent:SaveToSQL()
end)


function ENT:Use(activator, caller)
    local captureReq = self:GetCaptureRequired()
    local curTime = CurTime()
    self.lastUseTime = self.lastUseTime or 0

    if curTime - self.lastUseTime < 3 then
        return
    end

    self.lastUseTime = curTime

    if activator.triggerEntity then
        net.Start("SettingPoint")
        net.Send(activator)
        activator.currentTriggerEntity = self
        local ent = activator.triggerEntity
        self.entityTrigger = ent
        ent.point = self
        -- self.ent_angle = 
        self.triggerPos = ent:GetPos()
        self.sizeTriggerW, self.sizeTriggerH = ent:GetCollisionBounds()
    end
    if activator:GetPos():Distance(self:GetPos()) > 150 then return end
    if activator:AllowCapture() then
        -- PrintTable(self.players)
        -- print(captureReq)
        if self.playerWhoCapture then return end
        if self.players[activator] and self:allowCapturePoint() then
            if self:GetWhoCapture() == "Никем" then
                self.playerWhoCapture = activator
                self:CaptureStart(activator, self.players, self.capture_time)
            else
                print("Fkfk")
            end
        else
            DarkRP.notify(activator, 1, 2, fmt("Недостаточно игроков, надо еще %s %s", captureReq, VIZIT_SCRIPTS.GetPlayerTextForm(captureReq)))
        end
    end
end
