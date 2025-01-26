local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
local concat = table.concat
local len = string.len
local findPlayer = DarkRP.findPlayer
DarkRP.defineChatCommand("fire", function(ply, args)
    -- jobs
    local jobs = DarkRP.GetFireJobs()[ply:Team()]

    if not jobs then
        notify(ply, 0, 3, "Вы не можете увольнять игроков")
        return ""
    end

    -- args
    if #args == 1 then
        notify(ply, 0, 4, "Вы должны написать причину увольнения")
        return ""
    end
    
    -- reason
    local reason = concat(args, " ", 2)
    
    if reason == "" then
        notify(ply, 0, 4, "Вы должны написать причину увольнения")
        return ""
    end
    
    if len(reason) >= 60 then
        notify(ply, 0, 4, "Причина должна быть меньше 60 символов")
        return ""
    end
    
    -- target
    local target = findPlayer(args[1])
    
    if not target then
        notify(ply, 0, 4, "Игрок не был найден")
        return ""
    end
    
    -- disguise
    local disguise = target:getDarkRPVar("disguise")
    
    if disguise and jobs[disguise] then
        notify(target, 0, 5, "Вас попытались уволить и ваша маскировка была раскрыта")
        notify(ply, 0, 4, "Ошибка... ЭТО ЖЕ ШПИОН!")
        return ""
    end
    
    -- job
    if not jobs[target:Team()] then
        notify(ply, 0, 4, "Вы не можете уволить человека с этой работой")
        return ""
    end
    
    -- dismissal
    target:teamBan() -- ИЗМЕНЕНО 04.01.2022
    target:changeTeam(GAMEMODE.DefaultTeam, true, true)
    target:ConCommand("gmod_cleanup")
    target:ConCommand("darkrp unownalldoors")
    
    hook.Call("PlayerFired", DarkRP.Hooks, ply, target, reason)
    
    -- notify
    notify(ply, 0, 6, "Вы уволили " .. target:Nick() .. " (" .. reason .. ")")
    notify(target, 0, 6, "Вас уволил " .. ply:Nick() .. " (" .. reason .. ")")
    return ""
end)