RTW = {}
RTW.Whitelist = false -- Включает вайтлист
RTW.WL_Restr = {
    ["trusted"] = true, -- Разрешает вход игрокам из таблицы доверенных
    ["beta-testers"] = true -- Разрешает вход игрокам из таблицы бета-тестеров
}

RTW.WL_Super = { -- Таблица игроков с постоянным доступом
    ["STEAM_0:0:216403892"] = true,
    ["STEAM_0:1:190680623"] = true
}

RTW.WL_Trusted = {
    ["STEAM_0:0:217253683"] = true
}

RTW.WL_BetaTesters = {
    -- ["STEAM_0:0:123456"] = true,
}

--[[hook.Add("CheckPassword", "RTW_Whitelist", function(s64,ip,svp,clp,n)
    if RTW.Whitelist == false then return true end

    local s = util.SteamIDFrom64(s64)

    if RTW.WL_Restr["trusted"] and RTW.WL_Trusted[s] then
        return true,
    elseif RTW.WL_Restr["beta-testers"] and RTW.WL_BetaTesters[s] then
        return true,
    elseif RTW.WL_Super[s] then
        return true
    else
        return false, "Retrime Orange | Whitelist\nВ данный момент сервер находится на технических работах, попробуйте зайти позже"
    end
end)]]--