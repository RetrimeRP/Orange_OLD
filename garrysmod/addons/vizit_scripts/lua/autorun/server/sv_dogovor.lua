util.AddNetworkString("dogovornyak")
util.AddNetworkString("getDogovor")
local votedTeams = {}
local allowedTeams = {
    [TEAM_HECU5] = "resistanceZa",
    [TEAM_RESISTANCE5] = "resistanceZa",
    [TEAM_DOD4] = "guildZa",
    [TEAM_GUILD6] = "guildZa"
}

local counters = {
    resistanceZa = 0,
    guildZa = 0,
    maxResistance = 2,
    maxGuild = 0
}

local lastDogovorTime = 0
local dogovorCooldown = VIZIT_SCRIPTS.COOLDOWNTIME
local notify
hook.Add("DarkRPFinishedLoading","JustCheck",function()
    notify = DarkRP.notify
end)
local function notifyTeams(message, teams)
    for _, v in player.Iterator() do
        if teams[v:Team()] then
            notify(v, 1, 10, message)
        end
    end
end
local function cleanTable()
    counters.resistanceZa = 0
    counters.guildZa = 0
    votedTeams = {}
end
local function isGuildPresent()
    for _, v in player.Iterator() do
        if v:Team() == TEAM_DOD4 or v:Team() == TEAM_GUILD6 then
            return true
        end
    end
    return false
end

local function updateGuildMax()
    local count = 0
    for _, v in player.Iterator() do
        if v:Team() == TEAM_DOD4 or v:Team() == TEAM_GUILD6 then
            count = count + 1
        end
    end
    counters.maxGuild = count
end

local function sendAllResistance(notiFy)
    for _, v in player.Iterator() do
        if v:IsResistance() or v:IsGuild() then
            notify(v, 1, 6, notiFy)
        end
    end
end



local function returnDogovor(ply)
    net.Start("getDogovor")
    net.WriteBool(VIZIT_SCRIPTS.DOGOVOR)
    if not ply then
        net.Broadcast()
    else
        net.Send(ply)
    end
end

local function createMenu(ply)
    updateGuildMax()
    if not isGuildPresent() then
        notify(ply, 1, 6, "Заключить договор можно только если есть Глава DOD/Глава NS.")
        return
    end
    
    if CurTime() - lastDogovorTime < dogovorCooldown then
        notify(ply, 1, 6, "Вы не можете заключать договор так часто! Подождите.")
        return
    end
    
    local teamKey = allowedTeams[ply:Team()]
    if not teamKey then
        ply:ChatPrint("гыгы даун")
        return
    end
    
    net.Start("dogovornyak")
    net.WriteInt(counters.resistanceZa, 8)
    net.WriteInt(counters.guildZa, 8)
    net.WriteInt(counters.maxResistance, 8)
    net.WriteInt(counters.maxGuild, 8)
    net.WriteBool(VIZIT_SCRIPTS.DOGOVOR)
    net.Send(ply)
end
local function Dogovor()
    if CurTime() - lastDogovorTime < dogovorCooldown then
        return
    end
    
    lastDogovorTime = CurTime()
    
    if VIZIT_SCRIPTS.DOGOVOR then
        VIZIT_SCRIPTS.DOGOVOR = false
        sendAllResistance("Сопротивление и NS-DOD разорвали договор.")
    else
        sendAllResistance("Сопротивление и NS-DOD заключили договор.")
        VIZIT_SCRIPTS.DOGOVOR = true
    end
    returnDogovor()
    cleanTable()
end

net.Receive("dogovornyak", function(_, ply)
    local bool = net.ReadBool()
    local teamKey = allowedTeams[ply:Team()]
    if not teamKey then return end
    if bool then
        createMenu(ply)
    else
        updateGuildMax()
        if not isGuildPresent() then return end
    
        if votedTeams[teamKey] then
            notify(ply, 1, 6, "Вы или за вас уже проголосовали!")
            return
        end
        votedTeams[teamKey] = true
    
        if teamKey == "resistanceZa" and counters[teamKey] < counters.maxResistance then
            counters[teamKey] = counters[teamKey] + 1
        elseif teamKey == "guildZa" and counters[teamKey] < counters.maxGuild then
            counters[teamKey] = counters[teamKey] + 1
        end
        
        if counters.resistanceZa == counters.maxResistance and counters.guildZa == counters.maxGuild then
            Dogovor()
        elseif counters.resistanceZa == counters.maxResistance then
            notifyTeams("Сопротивление хочет заключить с вами договор", {[TEAM_DOD4] = true, [TEAM_GUILD6] = true})
        elseif counters.guildZa == counters.maxGuild then
            notifyTeams("NS - DOD хочет заключить с вами договор", {[TEAM_HECU5] = true, [TEAM_RESISTANCE5] = true})
        end
    end
end)

hook.Add("PlayerInitialSpawn", "vizit.govnocode", function(ply)
    returnDogovor(ply)
end)
