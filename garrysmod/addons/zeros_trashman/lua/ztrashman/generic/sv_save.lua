/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

if (not SERVER) then return end
ztm = ztm or {}
ztm.PublicEntities = ztm.PublicEntities or {}

zclib.Hook.Add("PlayerSay", "ztm_PublicEntities", function(ply, text)
    if string.sub(string.lower(text), 1, 8) == "!saveztm" and zclib.Player.IsAdmin(ply) then
        ztm.PublicEntities.SaveAll(ply)
    end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

function ztm.PublicEntities.RemoveAll(ply)
    zclib.STM.Remove("ztm_leafpile")
    zclib.STM.Remove("ztm_manhole")
    zclib.STM.Remove("ztm_buyermachine")
    zclib.STM.Remove("ztm_recycler")
    zclib.STM.Remove("ztm_trash")
    zclib.STM.Remove("ztm_trashburner")
    zclib.Notify(ply, "All Trash entities have been removed for the map " .. game.GetMap() .. "!", 0)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

function ztm.PublicEntities.SaveAll(ply)
    zclib.STM.Save("ztm_leafpile")
    zclib.STM.Save("ztm_manhole")
    zclib.STM.Save("ztm_buyermachine")
    zclib.STM.Save("ztm_recycler")
    zclib.STM.Save("ztm_trash")
    zclib.STM.Save("ztm_trashburner")
    zclib.Notify(ply, "All Trash entities have been saved for the map " .. game.GetMap() .. "!", 0)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

concommand.Add("ztm_save_all", function(ply, cmd, args)
    if zclib.Player.IsAdmin(ply) then
        ztm.PublicEntities.SaveAll(ply)
    end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

concommand.Add("ztm_remove_all", function(ply, cmd, args)
    if zclib.Player.IsAdmin(ply) then
        ztm.PublicEntities.RemoveAll(ply)
    end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8
