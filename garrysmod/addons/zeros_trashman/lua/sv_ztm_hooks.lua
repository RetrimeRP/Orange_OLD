/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

if (not SERVER) then return end

// Here are some Hooks you can use for Custom Code

// Called when a player trys to start a recycling machine, return false to prevent him from doing that
hook.Add("ztm_OnRecycleStart", "ztm_OnRecycleStart_Test", function(ply, recycler, recycle_type)
    /*
    print("ztm_OnRecycleStart")
    print("Player: " .. tostring(ply))
    print("Recycler: " .. tostring(recycler))
    print("RecycleType_ID: " .. recycle_type)
    print("RecycleType_Name: " .. ztm.config.Recycler.recycle_types[recycle_type].name)
    print("----------------")
    */


    // In this examble we define a Level value inside the recycle types config and check if the player is more or equal to the specified level.
    /*
        [2] = {
            name = "Aluminium",
            trash_per_block = 200,
            recycle_time = 30,
            money = 3000,
            mat = "zerochain/props_trashman/recycleblock/ztm_recycledblock_aluminium_diff",
            ranks = {},
            level = 5 // < The trashgun level
        },
    */
    /*
    local RecycleTypeData = ztm.config.Recycler.recycle_types[recycle_type]
    local ply_lvl = ztm.Data.GetLevel(ply)
    if RecycleTypeData.level and ply_lvl < RecycleTypeData.level then
        zclib.Notify(ply, "You dont have the correct level for this! [" .. RecycleTypeData.level .. " / " .. ply_lvl .. "]", 1)
        return false
    end
    */
end)

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80

// Called when a player burns trash
hook.Add("ztm_OnTrashBurned", "ztm_OnTrashBurned_Test", function(ply, trashburner, earning, trash)
    /*
    print("ztm_OnTrashBurned")
    print("Player who started the Burning Process: " .. tostring(ply))
    print("Trashburner: " .. tostring(trashburner))
    print("Money: " .. earning)
    print("Trash: " .. trash)
    print("----------------")
    */
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

// Called when a player blows away a leafpile
hook.Add("ztm_OnLeafpileBlast", "ztm_OnLeafpileBlast_Test", function(ply, leafpile)
    /*
    print("ztm_OnLeafpileBlast")
    print("Player: " .. tostring(ply))
    print("Leafpile: " .. tostring(leafpile))
    print("----------------")
    */
end)

// Called when a player collects trash
hook.Add("ztm_OnTrashCollect", "ztm_OnTrashCollect_Test", function(ply, trash)
    /*
    print("ztm_OnTrashCollect")
    print("Player: " .. tostring(ply))
    print("Trash: " .. trash)
    print("----------------")
    */
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

// Called when a player sells a recycled trash block
hook.Add("ztm_OnTrashBlockSold", "ztm_OnTrashBlockSold_Test", function(ply, buyermachine, earning)
    /*
    print("ztm_OnTrashBlockSold")
    print("Player: " .. tostring(ply))
    print("Buyermachine: " .. tostring(buyermachine))
    print("Money: " .. earning)
    print("----------------")
    */
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

// Called when a player makes a recycled trash block
hook.Add("ztm_OnTrashBlockCreation", "ztm_OnTrashBlockCreation_Test", function(ply, recyclemachine, trashblock)
    /*
    print("ztm_OnTrashBlockCreation")
    print("Player: " .. tostring(ply))
    print("Recyclemachine: " .. tostring(recyclemachine))
    print("Trashblock: " ..  tostring(trashblock))
    print("----------------")
    */
end)
