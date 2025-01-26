util.AddNetworkString('Retrime::EM::StartTimer')
util.AddNetworkString('Retrime::EM::AddTime')
util.AddNetworkString('Retrime::EM::StopTimer')
util.AddNetworkString('Retrime::EM::PlayerRemoveTimer')
util.AddNetworkString('Retrime::EM::Sound')
util.AddNetworkString('Retrime::EM::BlockJobs')
util.AddNetworkString('Retrime::EM::StartCumScene')
util.AddNetworkString('Retrime::EM::StartCumEndScene')
util.AddNetworkString('StartCumFirst')
util.AddNetworkString('StartCumLast')
util.AddNetworkString('UpdateTables')
util.AddNetworkString('Retrime::EM::CL::Timer')
util.AddNetworkString('Retrime::EM::CL::TimerAdd')
util.AddNetworkString('Retrime::EM::CL::TimerRemove')
util.AddNetworkString('Retrime::EM::CL::TimerRemovePlayer')
util.AddNetworkString('Retrime::EM::CL::SendSound')
util.AddNetworkString('SendMessageTerminal')
util.AddNetworkString('ReceiveMessage')
util.AddNetworkString('StartEnd')

restricted_jobs = {}
death_jobs = {}

net.Receive('UpdateTables', function(_, ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    death_jobs = net.ReadTable()
end)

net.Receive('SendMessageTerminal', function(_, ply)
    if not IsValid(ply) then return end

    local message = net.ReadString()

    for _, v in player.Iterator() do
        v:SendLua([[AddMessage(']] .. ply:Nick() .. [[', ']] .. message .. [[' )]])
    end
end)

net.Receive("StartEnd", function(_, ply)
    if not IsValid(ply) then return end

    ply:SendLua("EM_StartEnd()")
end)

hook.Add("PlayerDeath", "DA", function(victim, inflictor, attacker)
    PrintTable(death_jobs)

    -- if not attacker:IsPlayer() then return end
    local job = RPExtraTeams[victim:Team()]

    if death_jobs[job.category] then
        print("Change to " .. death_jobs[job.category])

        local job_index


        for i = 1, #RPExtraTeams do
            if RPExtraTeams[i].name:lower() == death_jobs[job.category] then
                job_index = i
                break
            end
        end
        victim:changeTeam(job_index, true, true)
        victim.notify(victim, 0, 5, "В связи с вашей смертью профессия была сменена на " .. RPExtraTeams[job_index].name)
    end
end)

net.Receive('Retrime::EM::StartTimer', function(_, ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    if timer.Exists('Retrime::EM::Timer') then
        ply:ChatPrint('Таймер уже существует!')
        return
    end

    local seconds = net.ReadFloat()
    for _, v in player.Iterator() do
        net.Start('Retrime::EM::CL::Timer')
        net.WriteFloat(seconds)
        net.Send(v)
        v:changeTeam(GAMEMODE.DefaultTeam, true, true)
        v:Spawn()
    end

    timer.Create('Retrime::EM::Timer', seconds, 1, function() ply:ChatPrint('Таймер был завершен!') end)
end)

net.Receive('Retrime::EM::AddTime', function(_, ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    if not timer.Exists('Retrime::EM::Timer') then
        ply:ChatPrint('Таймера не существует!')
        return
    end

    local seconds = net.ReadFloat()
    for _, v in player.Iterator() do
        net.Start('Retrime::EM::CL::TimerAdd')
        net.WriteFloat(seconds)
        net.Send(v)
    end

    timer.Adjust('Retrime::EM::Timer', tonumber(seconds) + timer.TimeLeft('Retrime::EM::Timer'), 1, function() end)
end)

net.Receive('Retrime::EM::StopTimer', function(_, ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    if not timer.Exists('Retrime::EM::Timer') then
        ply:ChatPrint('Таймера не существует!')
        return
    end

    for _, v in player.Iterator() do
        net.Start('Retrime::EM::CL::TimerRemove')
        net.Send(v)
    end

    timer.Remove('Retrime::EM::Timer')
end)

net.Receive('Retrime::EM::PlayerRemoveTimer', function(_, ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    if not timer.Exists('Retrime::EM::Timer') then
        ply:ChatPrint('Таймера не существует!')
        return
    end

    local pl = net.ReadEntity()
    net.Start('Retrime::EM::CL::TimerRemovePlayer')
    net.Send(pl)
end)

net.Receive('Retrime::EM::Sound', function(_, ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    local tbl = net.ReadTable()
    local soundpath = net.ReadString()
    for _, v in player.Iterator() do
        if table.HasValue(tbl, v:getJobTable().category) then
            net.Start('Retrime::EM::CL::SendSound')
            net.WriteString(soundpath)
            net.Send(v)
        end
    end
end)

net.Receive('Retrime::EM::BlockJobs', function(_, ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    restricted_jobs = net.ReadTable()
    PrintTable(restricted_jobs)
end)

net.Receive('Retrime::EM::StartCumScene', function(_, ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    for _, v in player.Iterator() do
        net.Start('StartCumFirst')
        net.Send(v)
    end
end)

net.Receive('Retrime::EM::StartCumEndScene', function(_, ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    for _, v in player.Iterator() do
        net.Start('StartCumLast')
        net.Send(v)
    end
end)

hook.Add('PlayerSpawn', 'Retrime::EM::CheckTimer', function(ply)
    if not timer.Exists('Retrime::EM::Timer') then
        return
    end

    net.Start('Retrime::EM::CL::Timer')
    net.WriteFloat(timer.TimeLeft('Retrime::EM::Timer'))
    net.Send(ply)
end)

hook.Add('playerCanChangeTeam', 'Retrime::EM::BlockChange', function(ply, tm, force)
    if force then return true end
    if table.HasValue(restricted_jobs, team.GetName(tm)) then
        ply:ChatPrint('В данный момент, Вы не можете изменить свою профессию на эту!')
        return false
    end
end)

local RandomJobs = {TEAM_HECU7, TEAM_HECU6, TEAM_HECU5, TEAM_HECU4, TEAM_HECU3, TEAM_HECU2, TEAM_HECU1, TEAM_CWU1, TEAM_CWU2, TEAM_CWU3, TEAM_CWU4, TEAM_CWU5, TEAM_MPF1, TEAM_MPF2, TEAM_MPF3, TEAM_MPF4, TEAM_MPF5, TEAM_RESISTANCE1, TEAM_RESISTANCE2, TEAM_RESISTANCE3, TEAM_RESISTANCE4, TEAM_RESISTANCE6, TEAM_RESISTANCE7, TEAM_RESISTANCE8, TEAM_RESISTANCE9}
concommand.Add('suka_jobs', function(ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    for _, v in ipairs(player.GetAll()) do
        if v:Team() == TEAM_FSG then return end
        local availableJobs = {}
        for _, t in ipairs(RandomJobs) do
            local jobData = RPExtraTeams[t]
            if jobData and team.NumPlayers(t) < jobData.max then table.insert(availableJobs, t) end
        end

        if #availableJobs > 0 then
            local randomJob = availableJobs[math.random(#availableJobs)]
            v:changeTeam(randomJob, true, true)
        else
            v:changeTeam(TEAM_CITIZEN, true, true)
        end
    end
end)

concommand.Add('block_jobs', function(ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    for _, v in ipairs(RPExtraTeams) do
        restricted_jobs[#restricted_jobs + 1] = v.name
    end
end)

concommand.Add('unblock_jobs', function(ply)
    if not EM.HasAccess[ply:GetUserGroup()] then
        ply:ChatPrint('Пошел нахуй, у тебя нет доступа.')
        return
    end

    restricted_jobs = {}
end)
