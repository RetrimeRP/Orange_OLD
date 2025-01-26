/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

if (not SERVER) then return end
ztm = ztm or {}
ztm.Recycler = ztm.Recycler or {}
ztm.Recycler.List = ztm.Recycler.List or {}


function ztm.Recycler.Initialize(Recycler)
    zclib.EntityTracker.Add(Recycler)

    Recycler.IsBusy = false
    Recycler.LastPlayer = nil

    table.insert(ztm.Recycler.List,Recycler)
end

function ztm.Recycler.Touch(Recycler, other)
    if Recycler.IsBusy then return end
    if Recycler:GetTrash() >= ztm.config.Recycler.capacity then return end
    if not IsValid(other) then return end
    if other:GetClass() ~= "ztm_trashbag" and other:GetClass() ~= "ztm_trash" then return end
    if zclib.util.CollisionCooldown(other) then return end
    if other:GetTrash() <= 0 then return end

    ztm.Recycler.AddTrash(Recycler, other)
end

function ztm.Recycler.AddTrash(Recycler, trash)
    Recycler.IsBusy = true
    Recycler:SetTrash(Recycler:GetTrash() + trash:GetTrash())

    SafeRemoveEntity(trash)

    timer.Simple(1,function()
        if IsValid(Recycler) then
            Recycler.IsBusy = false
        end
    end)
end

function ztm.Recycler.USE(Recycler,ply)
    if Recycler.IsBusy == true then return end

    if Recycler.IsPublicEntity == nil and zclib.Player.IsOwner(ply, Recycler) == false then
        return
    end

    if table.Count(ztm.config.Recycler.job_restriction) > 0 and not ztm.config.Recycler.job_restriction[zclib.Player.GetJobName(ply)] then
        zclib.Notify(ply, ztm.language.General["WrongJob"], 1)
        return
    end

    if zclib.Player.RankCheck(ply,ztm.config.Recycler.rank_restriction) == false then
        zclib.Notify(ply, ztm.language.General["WrongRank"], 1)
        return
    end

    if Recycler:OnSwitchButton_Left(ply) then

        Recycler:SetSelectedType(Recycler:GetSelectedType() - 1)
        if Recycler:GetSelectedType() <= 0 then
            Recycler:SetSelectedType(table.Count(ztm.config.Recycler.recycle_types))
        end
        Recycler:EmitSound("ztm_ui_click")

    elseif Recycler:OnSwitchButton_Right(ply) then

        Recycler:SetSelectedType(Recycler:GetSelectedType() + 1)
        if Recycler:GetSelectedType() > table.Count(ztm.config.Recycler.recycle_types) then
            Recycler:SetSelectedType(1)
        end
        Recycler:EmitSound("ztm_ui_click")

    elseif Recycler:OnStartButton(ply) then

        // Check if we have enough trash for this material
        local _recycle_type = ztm.config.Recycler.recycle_types[Recycler:GetSelectedType()]

        if zclib.Player.RankCheck(ply,_recycle_type.ranks) == false then
            zclib.Notify(ply, ztm.language.General["WrongRank"], 1)
            return
        end

        // Allows for a custom check
        local result = hook.Run("ztm_OnRecycleStart",ply,Recycler,Recycler:GetSelectedType())
        if result ~= nil and result == false then return end

        if Recycler:GetTrash() >= _recycle_type.trash_per_block then
            Recycler:EmitSound("ztm_ui_click")
            Recycler:SetTrash(Recycler:GetTrash() - _recycle_type.trash_per_block)

            Recycler.LastPlayer = ply

            ztm.Recycler.StartRecycling(Recycler)
        end
        // 55435795

    end
end

function ztm.Recycler.StartRecycling(Recycler)
    zclib.Debug("Start Recycle")
    local _recycle_type = ztm.config.Recycler.recycle_types[Recycler:GetSelectedType()]

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

    // Tells the client script to play the close animation
    Recycler:SetRecycleStage(1)

    Recycler:SetStartTime(CurTime())
    Recycler.IsBusy = true

    // Tells the client script to play the recycle animation
    timer.Simple(1,function()
        if IsValid(Recycler) then
            Recycler:SetRecycleStage(2)
            zclib.Debug("Play Recycle animation")
        end
    end)

    local timerID = "ztm_Recycler_recycling_" .. Recycler:EntIndex() .. "_timer"
    zclib.Timer.Remove(timerID)

    zclib.Timer.Create(timerID, _recycle_type.recycle_time, 1, function()
        zclib.Timer.Remove(timerID)

        if IsValid(Recycler) then
            ztm.Recycler.FinishRecycling(Recycler)
        end
    end)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

function ztm.Recycler.FinishRecycling(Recycler)
    zclib.Debug("Output Recycle Block")

    Recycler:SetRecycleStage(3)

    timer.Simple(1.6,function()
        if IsValid(Recycler) then

            local _recycle_type = ztm.config.Recycler.recycle_types[Recycler:GetSelectedType()]

            local ent = ents.Create("ztm_recycled_block")
            ent:SetPos(Recycler:GetPos() + Recycler:GetUp() * 35 + Recycler:GetRight() * 100)
            ent:SetAngles(Recycler:GetAngles())
            ent:Spawn()
            ent:Activate()
            ent:SetRecycleType(Recycler:GetSelectedType())
            ent:SetMaterial( _recycle_type.mat, true )

            // Custom Hook
            hook.Run("ztm_OnTrashBlockCreation" , Recycler.LastPlayer, Recycler, ent)


            ztm.Recycler.Reset(Recycler)
        end
    end)
end

function ztm.Recycler.Reset(Recycler)
    zclib.Debug("Reset Recycler")
    Recycler.IsBusy = false
    Recycler.LastPlayer = nil
    Recycler:SetRecycleStage(0)
    Recycler:SetStartTime(-1)
end

concommand.Add("ztm_debug_SpawnTrashBlock", function(ply, cmd, args)
    if zclib.Player.IsAdmin(ply) then
        local tr = ply:GetEyeTrace()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

        if tr.Hit and tr.HitPos then
            local ent = ents.Create("ztm_recycled_block")
            ent:SetPos(tr.HitPos)
            ent:SetRecycleType(math.random(#ztm.config.Recycler.recycle_types))
            ent:Spawn()
            ent:Activate()
        end
    end
end)


///////////////////////////////////////////
file.CreateDir("ztm")

concommand.Add( "ztm_recycler_save", function( ply, cmd, args )
    if zclib.Player.IsAdmin(ply) then
        zclib.Notify(ply, "Recycler entities have been saved for the map " .. game.GetMap() .. "!", 0)
        zclib.STM.Save("ztm_recycler")
    end
end )

concommand.Add( "ztm_recycler_remove", function( ply, cmd, args )
    if zclib.Player.IsAdmin(ply) then
        zclib.Notify(ply, "Recycler entities have been removed for the map " .. game.GetMap() .. "!", 0)
        zclib.STM.Remove("ztm_recycler")
    end
end )


zclib.STM.Setup("ztm_recycler", "ztm/" .. string.lower(game.GetMap()) .. "_recyclers.txt", function()
    local data = {}

    for u, j in pairs(ztm.Recycler.List) do
        if IsValid(j) then
            table.insert(data, {
                pos = j:GetPos(),
                ang = j:GetAngles()
            })
        end
    end

    return data
end, function(data)
    for k, v in pairs(data) do
        local ent = ents.Create("ztm_recycler")
        ent:SetPos(v.pos)
        ent:SetAngles(v.ang)
        ent:Spawn()
        ent:Activate()
        ent.IsPublicEntity = true
        local phys = ent:GetPhysicsObject()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80

        if (phys:IsValid()) then
            phys:Wake()
            phys:EnableMotion(false)
        end
    end

    ztm.Print("Finished loading Recycler Entities.")
end, function()
    for k, v in pairs(ztm.Recycler.List) do
        if IsValid(v) then
            v:Remove()
        end
    end
end)
