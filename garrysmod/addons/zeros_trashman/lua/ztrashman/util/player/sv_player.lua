/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

if (not SERVER) then return end
ztm = ztm or {}
ztm.PlayerTrash = ztm.PlayerTrash or {}
ztm.Player = ztm.Player or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

zclib.Player.CleanUp_Add("ztm_trashbag")
zclib.Player.CleanUp_Add("ztm_trashburner")
zclib.Player.CleanUp_Add("ztm_recycler")

zclib.Gamemode.AssignOwnerOnBuy("ztm_trashburner")
zclib.Gamemode.AssignOwnerOnBuy("ztm_recycler")

local function DropTrashOnDeath(ply)
    local swep = ply:GetWeapon("ztm_trashcollector")
    if not IsValid(swep) then return end
    local m_trash = swep:GetTrash()
    swep:SetTrash(0)
    if m_trash <= 0 then return end

    while m_trash > 0 do
        local add = 0
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

        if m_trash > ztm.config.Trashbags.capacity then
            add = ztm.config.Trashbags.capacity
        else
            add = m_trash
        end

        if add <= 0 then return end
        local ent = ents.Create("ztm_trashbag")
        ent:SetPos(ply:GetPos() + zclib.util.GetRandomPositionInsideCircle(50, 100, 50))
        ent:Spawn()
        ent:Activate()
        ent:SetTrash(add)
        zclib.Player.SetOwner(ent, ply)
        m_trash = m_trash - add
    end
end

zclib.Hook.Add("PlayerDeath", "ztm_DropTrash", function(vic, infl, attack)
    if IsValid(vic) and ztm.config.TrashSWEP.DropTrashOnDeath then
        DropTrashOnDeath(vic)
    end
end)

function ztm.PlayerTrash.SetRandomPlayerDirty()
    local valid_plys = {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

    for k, v in pairs(zclib.Player.List) do
        if IsValid(v) and v:IsPlayer() and v:Alive() and /*ztm.Player.IsTrashman(v) == false and*/ v:GetNWFloat("ztm_trash", 0) <= 0 then
            if table.Count(ztm.config.PlayerTrash.jobs) > 0 then
                if ztm.config.PlayerTrash.jobs[v:GetJobName()] then
                    table.insert(valid_plys, v)
                end
            else
                table.insert(valid_plys, v)
            end
        end
    end

    if valid_plys and table.Count(valid_plys) > 0 then
        local rnd_ply = valid_plys[math.random(#valid_plys)]
        ztm.Player.MakeDirty(rnd_ply)
    end
end

timer.Simple(0, function()
    zclib.Timer.Remove("ztm_PlayerTrash_timer")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

    if ztm.config.PlayerTrash.Enabled then
        zclib.Timer.Create("ztm_PlayerTrash_timer", ztm.config.PlayerTrash.Interval, 0, function()
            ztm.PlayerTrash.SetRandomPlayerDirty()
        end)
    end
end)

function ztm.Player.MakeDirty(ply)
    if not IsValid(ply) then return end
    if ply:Team() == TEAM_FSG or ply:Team() == TEAM_GMAN then return end
    local amount = math.random(ztm.config.PlayerTrash.trash_min, ztm.config.PlayerTrash.trash_max)
    ply:SetNWFloat("ztm_trash", math.Clamp(ply:GetNWFloat("ztm_trash", 0) + amount, 0, ztm.config.PlayerTrash.Limit))
    zclib.Debug("Set " .. ply:Nick() .. " dirty with " .. amount .. ztm.config.UoW .. " of trash!")
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

zclib.Hook.Add("PlayerChangedTeam", "ztm_player_trash", function(ply, before, after)
    local notset ={
        [TEAM_FSG] = true,
        [TEAM_GMAN] = true,
    }
    if notset[after] then
        ply:SetNWFloat("ztm_trash", 0)
    end
    if ztm.config.Jobs[after] then
        ply:SetNWFloat("ztm_trash", 0)
    end
end)

concommand.Add("ztm_debug_addbots_to_playerlist", function(ply, cmd, args)
    if zclib.Player.IsAdmin(ply) then
        for k, v in pairs(player.GetBots()) do
            if IsValid(v) and v:Alive() then
                zclib.Player.Add(v)
            end
        end
    end
end)
