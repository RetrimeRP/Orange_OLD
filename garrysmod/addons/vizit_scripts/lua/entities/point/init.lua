AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("CaptureStart")
util.AddNetworkString("StopCapture")
util.AddNetworkString("SettingPoint")

local fmt = string.format
local notify = DarkRP.notify

-- local function removeTable()
--     local result = sql.Query("DROP TABLE IF EXISTS triggers;")
--     if result == false then
--         print("[SQL ERROR]: Не удалось удалить таблицу triggers.", sql.LastError())
--     else
--         print("[INFO]: Таблица triggers успешно удалена.")
--     end
-- end

-- removeTable()
local check
local quer = sql.Query
local sqlStr = sql.SQLStr
local sqlErr = sql.LastError

function ENT:SaveToSQL()
    -- local tableName = self.tableName or "NULL"
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
        capture_time INTEGER,
        isBandit INTEGER
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
    local bandit = self.isBandit and 1 or 0

    local query = fmt([[INSERT INTO triggers (unique_name, pos, sizeW, sizeH, is_secondary, main_point, entity_pos, entity_angle, capture_time, isBandit)
    VALUES (%s, %s, %s, %s, %d, %s, %s, %s, %d, %d)
    ON CONFLICT(unique_name) DO UPDATE SET
    pos = excluded.pos,
    sizeW = excluded.sizeW,
    sizeH = excluded.sizeH,
    is_secondary = excluded.is_secondary,
    main_point = excluded.main_point,
    entity_pos = excluded.entity_pos,
    entity_angle = excluded.entity_angle,
    capture_time = excluded.capture_time,
    isBandit = excluded.isBandit;]],
    sqlStr(self.uniqueName), sqlStr(pos), sqlStr(sizeW), sqlStr(sizeH),
    isSecondary, sqlStr(mainPoint), sqlStr(entityPos), sqlStr(ent_angle), captureTime, bandit)

    -- local result = quer(query)
    -- if result == false then
        -- print("[SQL ERROR]:", sqlErr())
    -- else
        print("[INFO]: Данные для сущности с уникальным именем", self.uniqueName, "успешно сохранены в таблицу", tableName)
    -- end
end

local function getAllFraction(fracName, func)
    for _, ply in player.Iterator() do
        if ply:ReturnFaction() == fracName then
            func(ply)
        end
    end
end


function ENT:CaptureStart(playerWhoCapture, playerTable, time)
    net.Start("CaptureStart")
    net.WriteInt(time, 32)
    net.WriteEntity(self)
    net.WriteBool(false)
    net.Send(playerWhoCapture)
    check = true 
    timer.Create("CaptureMonitor", 1, 0, function()
        if not self.playerWhoCapture then
            timer.Remove("CaptureMonitor")
            return
        end
        local ply = self.playerWhoCapture
        local eyeTrace = ply:GetEyeTraceNoCursor()
        -- print(eyeTrace.Entity:GetClass())
        if ply:GetPos():Distance(self:GetPos()) > 100 or eyeTrace.Entity ~= self or not ply:Alive() then
            net.Start("StopCapture")
            net.Send(ply)
            self.playerWhoCapture = nil
            check = false
        end
    end)

    timer.Create("CaptureAnimation", 2, math.random(1, 10), function()
        if self.playerWhoCapture then
            self.playerWhoCapture:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_GIVE)
        else
            timer.Remove("CaptureAnimation")
        end
    end)
end
net.Receive("CaptureStart", function(_, ply)
    local ent = net.ReadEntity()
    if ply ~= ent.playerWhoCapture then return end
    ent.playerWhoCapture = nil
    check = true
    local factionsToNotify = ent.isBandits and { "Альянс", "Бандиты" } or {"Альянс", "Сопротивление", "NS - DOD","Силы Коалиции и Самообороны" }
    for _, p in player.Iterator() do
        local playerFaction = p:ReturnFaction()
        if table.HasValue(factionsToNotify, playerFaction) then
            print("СТАРТАНУЛИ НЕТ")
            net.Start("CaptureStart")
            net.WriteInt(VIZIT_SCRIPTS.CAPTURETIME, 32)
            net.WriteEntity(ent)
            net.WriteBool(true)
            notify(p, 1, 6, fmt("%s начали захват точки %s!", ply:ReturnFaction(), ent.uniqueName))
            net.Send(p)
        end
    end
    timer.Create("CAPTURE_POINT", VIZIT_SCRIPTS.CAPTURETIME, 1, function()
        local prize = math.random(VIZIT_SCRIPTS.MINNAGRADA, VIZIT_SCRIPTS.MAXNAGRADA)
        ent:SetWhoCapture(ent:GetWhoWin())
        if ent:GetWhoWin() ~= "Никем" then
            for _, p in player.Iterator() do
                local playerFaction = p:ReturnFaction()
                if table.HasValue(factionsToNotify, playerFaction) then
                    notify(p, 1, 6, fmt("%s захватили точку: %s!", ent:GetWhoWin(), ent.uniqueName))
                    ent:SetCooldown(VIZIT_SCRIPTS.COOLDOWN)
                end
            end
        end
        check = false
        getAllFraction(ent:GetWhoWin(), function(pl)
            notify(pl, 1, 3, fmt("Вы получили: %s т, за захват точки", prize))
            pl:addMoney(prize)
            -- check = false
        end)
    end)
end)

function ENT:Initialize()
    self:SetModel("models/props_combine/combine_interface001.mdl")

    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()

    if self.pos then
        phys:EnableMotion(false)
    end
    timer.Create("CheckObkaks",10,0,function() -- хотяб на 10 поставлю, оптимизона чутка добавлю    
        if not self.playerWhoCapture then return end
        if not IsValid(self.playerWhoCapture) then
            self.playerWhoCapture = nil
        end
    end)
    -- эта хуйня миллисинуд жрет больше чем у меня iq
    -- timer.Create()
    phys:Wake()
end

net.Receive("SettingPoint", function(len, ply)
    if not ply:IsSuperAdmin() then
        ply:Kick("нетлогер для пидарасов, саси, гыгыгыгы")
        return
    end

    local uniqueName = net.ReadString()
    local isSecondary = net.ReadBool()
    local mainPoint = net.ReadString()
    local captureTime = net.ReadInt(8)
    local isBandit = net.ReadBool()

    local ent = ply.currentTriggerEntity

    if not IsValid(ent) then
        return
    end

    ent.uniqueName = uniqueName
    ent.isSecondary = isSecondary
    ent.mainPoint = isSecondary and mainPoint or nil
    ent.captureTime = captureTime
    ent.isBandit = isBandit

    ply:ChatPrint("[INFO]: Настройки точки обновлены: " .. (isSecondary and "Вторичная точка" or "Основная точка"))
    ply:ChatPrint("[INFO]: Уникальное имя точки сохранено: " .. uniqueName)
    ply:ChatPrint("[INFO]: Время захвата установлено на: " .. captureTime .. " секунд")
    ply:ChatPrint("[INFO]: Точка бандитская: " .. (isBandit and "Да" or "Нет"))

    ent:SaveToSQL()
end)



function ENT:Use(activator, caller)
    local curTime = CurTime()
    self.lastUseTime = self.lastUseTime or 0
    if curTime - self.lastUseTime < 3 then return end
    self.lastUseTime = curTime

    if activator.triggerEntity then
        net.Start("SettingPoint")
        net.Send(activator)

        activator.currentTriggerEntity = self
        self.triggerPos = activator.triggerEntity:GetPos()
        self.sizeTriggerW, self.sizeTriggerH = activator.triggerEntity:GetCollisionBounds()

        notify(activator, 1, 2, "[INFO]: Настройка точки обновлена.")
        return
    end
    if check then
        notify(activator,1,2,"Какая-то точка уже захватывается!")
        return
    end
    if self:AlreadyCaptured(activator) then return end
    if self:GetCaptureRequired() < VIZIT_SCRIPTS.CaptureAmount then
        notify(activator,1,2,"На точке слишком мало людей!")
        return
    end
    if self:GetAllowCapture(activator) then
        if not self.playerWhoCapture then
            self.playerWhoCapture = activator
            self:CaptureStart(activator, self.players or {}, self.captureTime or 30)
        else
            notify(activator, 1, 2, "Точка уже захватывается!")
        end
    end
end

