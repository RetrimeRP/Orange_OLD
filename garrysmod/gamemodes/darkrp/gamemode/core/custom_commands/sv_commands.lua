local function SayThroughRadio(ply,args)
    if not ply.RadioChannel then ply.RadioChannel = 1 end
    if not args or args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
        return ""
    end
    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
            return
        end
        for k,v in pairs(player.GetAll()) do
            if v.RadioChannel == ply.RadioChannel then
                DarkRP.talkToPerson(v, Color(180,180,180,255), DarkRP.getPhrase("radio_x", ply.RadioChannel), Color(180,180,180,255), text, ply)
            end
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("radio", SayThroughRadio, 1.5)

local function GroupMsg(ply, args)
    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
            return
        end

        local col = team.GetColor(ply:Team())

        local groupChats = {}
        for _, func in pairs(GAMEMODE.DarkRPGroupChats) do
            if not func(ply) then continue end

            table.insert(groupChats, func)
        end

        if #groupChats == 0 then return "" end

        for _, target in pairs(player.GetAll()) do
            for k, func in pairs(groupChats) do
                if not func(target, ply) then continue end

                DarkRP.talkToPerson(target, col, DarkRP.getPhrase("group") .. " " .. ply:Nick(), Color(255,255,255,255), text, ply)
                break
            end
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("g", GroupMsg, 0)

local function It(ply, args)
    if args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
        return ""
    end

    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
            return ""
        end
        if GAMEMODE.Config.alltalk then
            for _, target in pairs(player.GetAll()) do
                DarkRP.talkToPerson(target, team.GetColor(ply:Team()), text .. " " .. "(" .. ply:Nick() .. ")")
            end
        else
            DarkRP.talkToRange(ply, text .. " " .. "(" .. ply:Nick() .. ")", "", 250)
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("it", It, 1.5)
DarkRP.defineChatCommand("do", It, 1.5)

local function LOOC(ply, args)
	-- args
	if args == "" then
		DarkRP.notify(ply, 0, 3, "Вы должны написать текст")
		return ""
	end

	-- looc
	DarkRP.talkToRange(ply, "(LOOC) " .. ply:Nick(), args, 400)
	return ""
end

DarkRP.defineChatCommand("looc", LOOC)
DarkRP.defineChatCommand("l", LOOC)

local function Roll(ply, args)
	local DoSay = function()
		if GAMEMODE.Config.alltalk then
			for _, target in pairs(player.GetAll()) do
				DarkRP.talkToPerson(target, team.GetColor(ply:Team()), "(ROLL) " .. ply:Nick() .. " кинул кубик и выпало: " ..math.random(1,100)..".")
			end
		else
			DarkRP.talkToRange(ply, "(ROLL) " .. ply:Nick() .. " кинул кубик и выпало: " ..math.random(1,100).." из 100", "", 250)
		end
	end
	return args, DoSay
end
DarkRP.defineChatCommand("roll", Roll, 1.5)

local function Try(ply, args)
    local answers = {"(успешно)", "(безуспешно)"}
    if args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
        return ""
    end

    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
            return ""
        end
        if GAMEMODE.Config.alltalk then
            for _, target in pairs(player.GetAll()) do
                DarkRP.talkToPerson(target, team.GetColor(ply:Team()), "(TRY) " .. ply:Nick() .. " " .. text .. " " .. table.Random(answers))
            end
        else
            DarkRP.talkToRange(ply, "(TRY) " .. ply:Nick() .. " " .. text .. " " .. table.Random(answers), "", 250)
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("try", Try, 1.5)

local lastLockdown = -math.huge
function DarkRP.lockdown(ply)
    local show = ply:EntIndex() == 0 and print or fp{DarkRP.notify, ply, 1, 4}
    if GetGlobalBool("DarkRP_YellowCode") or GetGlobalBool("DarkRP_RedCode") or GetGlobalBool("DarkRP_LockDown") then
        show(DarkRP.getPhrase("unable", "/lockdown", "Уже есть активный код!"))
        return ""
    end

    if ply:EntIndex() ~= 0 and not ply:IsAdministrator() then
        show(DarkRP.getPhrase("incorrect_job", "/lockdown", "Неподходящая профессия!"))
        return ""
    end

    if lastLockdown > CurTime() - 180 then 
        show(DarkRP.getPhrase("wait_with_that"))
        return ""
    end

    for _, v in pairs(player.GetAll()) do
        v:ConCommand("play retrime/cityvoice/f_trainstation_assemble_spkr.wav \n")
    end

    net.Start("StartLockdown")
	net.Broadcast()
    
    timer.Create("RetrimeLockdownCodeEnd", 600, 1, function()
		if not GetGlobalBool("DarkRP_LockDown") then return end

		SetGlobalBool("DarkRP_LockDown", false)

		DarkRP.notifyAll(0, 3, "Комендантский час закончился")
	end)

    SetGlobalBool("DarkRP_LockDown", true)
    DarkRP.notifyAll(0, 3, "Комендантский час был активирован!")

    return ""
end
DarkRP.defineChatCommand("lockdown", DarkRP.lockdown)

function DarkRP.unLockdown(ply)
    local show = ply:EntIndex() == 0 and print or fp{DarkRP.notify, ply, 1, 4}

    if not GetGlobalBool("DarkRP_LockDown") then
        show(DarkRP.getPhrase("unable", "/unlockdown", "Комендантский час уже отключён!"))
        return ""
    end

    if ply:EntIndex() ~= 0 and not ply:IsAdministrator() then
        show(DarkRP.getPhrase("incorrect_job", "/unlockdown", "Неподходящая профессия!"))
        return ""
    end

    DarkRP.notifyAll(0, 3, "Комендантский час был отключён!")
    SetGlobalBool("DarkRP_LockDown", false)

    lastlockdown = CurTime()

    return ""
end
DarkRP.defineChatCommand("unlockdown", DarkRP.unLockdown)

local lastyellowcode = -math.huge
function DarkRP.yellowcode(ply)
    local show = ply:EntIndex() == 0 and print or fp{DarkRP.notify, ply, 1, 4}
    if GetGlobalBool("DarkRP_YellowCode") or GetGlobalBool("DarkRP_RedCode") or GetGlobalBool("DarkRP_LockDown") then
        show(DarkRP.getPhrase("unable", "/yellowcode", "Уже есть активный код!"))
        return ""
    end

    if ply:EntIndex() ~= 0 and not (ply:CanYellowCode() or ply:CanRedCode()) then
        show(DarkRP.getPhrase("incorrect_job", "/yellowcode", "Неподходящая профессия!"))
        return ""
    end

    if lastyellowcode > CurTime() - 180 then 
        show(DarkRP.getPhrase("wait_with_that"))
        return ""
    end

    for _, v in pairs(player.GetAll()) do
        v:ConCommand("play retrime/cityvoice/f_unrestprocedure1_spkr.wav \n")
    end

    net.Start("StartYellowCode")
	net.Broadcast()

    timer.Create("RetrimeYellowCodeEnd", 600, 1, function()
		if not GetGlobalBool("DarkRP_YellowCode") then return end

		SetGlobalBool("DarkRP_YellowCode", false)

		DarkRP.notifyAll(0, 3, "Желтый код закончился")
	end)

    SetGlobalBool("DarkRP_YellowCode", true)
    DarkRP.notifyAll(0, 3, "Жёлтый код был активирован!")

    return ""
end
DarkRP.defineChatCommand("yellowcode", DarkRP.yellowcode)

function DarkRP.unYellowcode(ply)
    local show = ply:EntIndex() == 0 and print or fp{DarkRP.notify, ply, 1, 4}

    if not GetGlobalBool("DarkRP_YellowCode") then
        show(DarkRP.getPhrase("unable", "/unyellowcode", "Жёлтый код уже отключён!"))
        return ""
    end

    if ply:EntIndex() ~= 0 and not (ply:CanYellowCode() or ply:CanRedCode()) then
        show(DarkRP.getPhrase("incorrect_job", "/unyellowcode", "Неподходящая профессия!"))
        return ""
    end

    DarkRP.notifyAll(0, 3, "Жёлтый код был отключён!")
    SetGlobalBool("DarkRP_YellowCode", false)

    lastyellowcode = CurTime()

    return ""
end
DarkRP.defineChatCommand("unyellowcode", DarkRP.unYellowcode)

local lastredcode = -math.huge
function DarkRP.redcode(ply)
    local show = ply:EntIndex() == 0 and print or fp{DarkRP.notify, ply, 1, 4}
    if GetGlobalBool("DarkRP_YellowCode") or GetGlobalBool("DarkRP_RedCode") or GetGlobalBool("DarkRP_LockDown") then
        show(DarkRP.getPhrase("unable", "/redcode", "Уже есть активный код!"))
        return ""
    end

    if ply:EntIndex() ~= 0 and not ply:CanRedCode() then
        show(DarkRP.getPhrase("incorrect_job", "/redcode", "Неподходящая профессия!"))
        return ""
    end

    if lastredcode > CurTime() - 180 then 
        show(DarkRP.getPhrase("wait_with_that"))
        return ""
    end

    for _, v in pairs(player.GetAll()) do
        v:ConCommand("play retrime/cityvoice/f_protectionresponse_5_spkr.wav \n")
    end


    net.Start("StartRedCode")
	net.Broadcast()

    timer.Create("RetrimeRedCodeEnd", 600, 1, function()
		if not GetGlobalBool("DarkRP_RedCode") then return end

		SetGlobalBool("DarkRP_RedCode", false)

		DarkRP.notifyAll(0, 3, "Красный код закончился")
	end)

    SetGlobalBool("DarkRP_RedCode", true)
    DarkRP.notifyAll(0, 3, "Красный код был активирован!")

    return ""
end
DarkRP.defineChatCommand("redcode", DarkRP.redcode)

function DarkRP.unRedcode(ply)
    local show = ply:EntIndex() == 0 and print or fp{DarkRP.notify, ply, 1, 4}

    if not GetGlobalBool("DarkRP_RedCode") then
        show(DarkRP.getPhrase("unable", "/unredcode", "Красный код уже отключён!"))
        return ""
    end

    if ply:EntIndex() ~= 0 and not ply:CanRedCode() then
        show(DarkRP.getPhrase("incorrect_job", "/unredcode", "Неподходящая профессия!"))
        return ""
    end

    DarkRP.notifyAll(0, 3, "Красный код был отключён!")
    SetGlobalBool("DarkRP_RedCode", false)

    lastyellowcode = CurTime()

    return ""
end
DarkRP.defineChatCommand("unredcode", DarkRP.unRedcode)

local lastredcode = -math.huge
function DarkRP.recruiting(ply)
    local show = ply:EntIndex() == 0 and print or fp{DarkRP.notify, ply, 1, 4}
    if GetGlobalBool("rp_recruitblock") then
        show(DarkRP.getPhrase("unable", "/recruiting", "Уже включен!"))
        return ""
    end

    if ply:EntIndex() ~= 0 and not ply:CanRedCode() then
        show(DarkRP.getPhrase("incorrect_job", "/recruiting", "Неподходящая профессия!"))
        return ""
    end

    if lastredcode > CurTime() - 180 then 
        show(DarkRP.getPhrase("wait_with_that"))
        return ""
    end

    SetGlobalBool("rp_recruitblock", true)
    DarkRP.notifyAll(0, 3, "Системный набор в ГО был включен!")

    return ""
end
DarkRP.defineChatCommand("recruiting", DarkRP.recruiting)

function DarkRP.unrecruiting(ply)
    local show = ply:EntIndex() == 0 and print or fp{DarkRP.notify, ply, 1, 4}

    if not GetGlobalBool("rp_recruitblock") then
        show(DarkRP.getPhrase("unable", "/unrecruiting", "Набор уже выключен!"))
        return ""
    end

    if ply:EntIndex() ~= 0 and not ply:CanRedCode() then
        show(DarkRP.getPhrase("incorrect_job", "/unrecruiting", "Неподходящая профессия!"))
        return ""
    end

    DarkRP.notifyAll(0, 3, "Системный набор в ГО был выключен!")
    SetGlobalBool("rp_recruitblock", false)

    lastyellowcode = CurTime()

    return ""
end
DarkRP.defineChatCommand("unrecruiting", DarkRP.unrecruiting)

function DarkRP.recruit(ply)
    local show = ply:EntIndex() == 0 and print or fp{DarkRP.notify, ply, 1, 4}
    local ent = ply:GetEyeTrace().Entity
    if not ent:IsPlayer() then return end
	if ent:GetPos():DistToSqr(ply:GetPos()) > 16384 then return end

    if !not ent:IsCombine() then
        show(DarkRP.getPhrase("unable", "/recruit", "Этот человек уже в Альянсе!"))
        return ""
    end

    if ply:EntIndex() ~= 0 and not ply:CanRedCode() then
        show(DarkRP.getPhrase("incorrect_job", "/recruit", "Неподходящая профессия!"))
        return ""
    end

    DarkRP.createQuestion(ply:Nick() .. " хочет чтобы вы вступили в ГО", "recruting" .. tostring(ply:EntIndex()), ent, 8, function(answer)
		if not tobool(answer) then return end
        ent:changeTeam(1, true)
	end)
    show("Вы предложили вступить " .. ent:Nick() .. " В ГО")

    return ""
end
DarkRP.defineChatCommand("recruit", DarkRP.recruit)

local meta = FindMetaTable("Player")
function meta:dropDRPWeapon(weapon)
    if GAMEMODE.Config.restrictdrop then
        local found = false
        for k,v in pairs(CustomShipments) do
            if v.entity == weapon:GetClass() then
                found = true
                break
            end
        end

        if not found then return end
    end

    local primAmmo = self:GetAmmoCount(weapon:GetPrimaryAmmoType())
    self:DropWeapon(weapon) -- Drop it so the model isn't the viewmodel
    weapon:SetOwner(self)

    local ent = ents.Create("spawned_weapon")

    local model = (weapon:GetModel() == "models/weapons/v_physcannon.mdl" and "models/weapons/w_physics.mdl") or weapon:GetModel()
    model = util.IsValidModel(model) and model or "models/weapons/w_rif_ak47.mdl"

    ent:SetModel(model)
    ent:SetSkin(weapon:GetSkin() or 0)
    ent:SetWeaponClass(weapon:GetClass())
    ent.nodupe = true
    ent.clip1 = weapon:Clip1()
    ent.clip2 = weapon:Clip2()
    ent.ammoadd = primAmmo

    self:RemoveAmmo(primAmmo, weapon:GetPrimaryAmmoType())
    self:RemoveAmmo(self:GetAmmoCount(weapon:GetSecondaryAmmoType()), weapon:GetSecondaryAmmoType())

    local trace = {}
    trace.start = self:GetShootPos()
    trace.endpos = trace.start + self:GetAimVector() * 50
    trace.filter = {self, weapon, ent}

    local tr = util.TraceLine(trace)

    ent:SetPos(tr.HitPos)
    ent:Spawn()

    DarkRP.placeEntity(ent, tr, self)

    hook.Call("onDarkRPWeaponDropped", nil, self, ent, weapon)

    weapon:Remove()
end

local function DropWeapon(ply)
    local ent = ply:GetActiveWeapon()
    if not ent:IsValid() or ent:GetModel() == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("cannot_drop_weapon"))
        return ""
    end

    local canDrop = hook.Call("canDropWeapon", GAMEMODE, ply, ent)
    if not canDrop then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("cannot_drop_weapon"))
        return ""
    end

    ply:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_DROP)

    timer.Simple(1, function()
        if IsValid(ply) and IsValid(ent) and ply:Alive() and ent:GetModel() ~= "" and not IsValid(ply:GetObserverTarget()) then
            ply:dropDRPWeapon(ent)
        end
    end)
    return ""
end
DarkRP.defineChatCommand("drop", DropWeapon)
DarkRP.defineChatCommand("dropweapon", DropWeapon)
DarkRP.defineChatCommand("weapondrop", DropWeapon)

DarkRP.stub{
    name = "dropDRPWeapon",
    description = "Drop the weapon with animations.",
    parameters = {
        {
            name = "weapon",
            description = "The weapon to drop",
            type = "Entity",
            optional = false
        }
    },
    returns = {
    },
    metatable = meta
}

DarkRP.hookStub{
    name = "onDarkRPWeaponDropped",
    description = "When a player drops a weapon. Use this hook (in combination with PlayerPickupDarkRPWeapon) to store extra information about a weapon. This hook cannot prevent weapon dropping. If you want to prevent weapon dropping, use canDropWeapon instead.",
    parameters = {
        {
            name = "ply",
            description = "The player who dropped the weapon.",
            type = "Player"
        },
        {
            name = "spawned_weapon",
            description = "The spawned_weapon created from the weapon that is dropped.",
            type = "Entity"
        },
        {
            name = "original_weapon",
            description = "The original weapon from which the spawned_weapon is made.",
            type = "Weapon"
        }
    },
    returns = {

    }
}

DarkRP.hookStub{
    name = "PlayerPickupDarkRPWeapon",
    description = "When a player picks up a spawned_weapon.",
    parameters = {
        {
            name = "ply",
            description = "The player who dropped the weapon.",
            type = "Player"
        },
        {
            name = "spawned_weapon",
            description = "The spawned_weapon created from the weapon that is dropped.",
            type = "Entity"
        },
        {
            name = "real_weapon",
            description = "The actual weapon that will be used by the player.",
            type = "Weapon"
        }
    },
    returns = {
        {
            name = "ShouldntContinue",
            description = "Whether weapon should be picked up or not.",
            type = "boolean"
        }
    }
}
