hook.Run("DarkRPStartedLoading")

GM.Version = "1.0.0"
GM.Name = "DarkRP"
GM.Author = "By OrionRP"

DeriveGamemode("sandbox")
DEFINE_BASECLASS("gamemode_sandbox")

GM.Sandbox = BaseClass

AddCSLuaFile("libraries/sh_cami.lua")
AddCSLuaFile("libraries/simplerr.lua")
AddCSLuaFile("libraries/interfaceloader.lua")
AddCSLuaFile("libraries/modificationloader.lua")
AddCSLuaFile("libraries/disjointset.lua")
AddCSLuaFile("libraries/fn.lua")
AddCSLuaFile("libraries/tablecheck.lua")

AddCSLuaFile("config/config.lua")
AddCSLuaFile("config/jobs/mpf.lua")
AddCSLuaFile("config/jobs/ota.lua")
AddCSLuaFile("config/jobs/synths.lua")
AddCSLuaFile("config/jobs/resistance.lua")
AddCSLuaFile("config/jobs/hecu.lua")
AddCSLuaFile("config/jobs/bandits.lua")
AddCSLuaFile("config/jobs/cwu.lua")
AddCSLuaFile("config/jobs/citizens.lua")
AddCSLuaFile("config/jobs/refugees.lua")
AddCSLuaFile("config/jobs/guild.lua")
AddCSLuaFile("config/jobs/guardian.lua")
AddCSLuaFile("config/jobs/dod.lua")
AddCSLuaFile("config/jobs/others.lua")
AddCSLuaFile("config/entities.lua")
AddCSLuaFile("config/shipments.lua")

AddCSLuaFile("cl_init.lua")

GM.Config = GM.Config or {}
GM.NoLicense = GM.NoLicense or {}

include("libraries/interfaceloader.lua")

include("config/_MySQL.lua")
include("config/config.lua")

include("libraries/fn.lua")
include("libraries/tablecheck.lua")
include("libraries/sh_cami.lua")
include("libraries/simplerr.lua")
include("libraries/modificationloader.lua")
include("libraries/mysqlite/mysqlite.lua")
include("libraries/disjointset.lua")

local fol = GM.FolderName .. "/gamemode/core/"
local files, folders = file.Find(fol .. "*", "LUA")

for k, v in pairs(files) do
    if DarkRP.disabledDefaults["modules"][v:Left(-5)] then continue end
    if string.GetExtensionFromFilename(v) ~= "lua" then continue end
    include(fol .. v)
end

for _, folder in SortedPairs(folders, true) do
    if folder == "." or folder == ".." or DarkRP.disabledDefaults["modules"][folder] then continue end

    for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
        AddCSLuaFile(fol .. folder .. "/" .. File)
        if File == "sh_interface.lua" then continue end
        include(fol .. folder .. "/" .. File)
    end

    for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
        if File == "sv_interface.lua" then continue end
        include(fol .. folder .. "/" .. File)
    end

    for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
        if File == "cl_interface.lua" then continue end
        AddCSLuaFile(fol .. folder .. "/" .. File)
    end
end

DarkRP.DARKRP_LOADING = true
include("config/jobs/mpf.lua")
include("config/jobs/ota.lua")
include("config/jobs/synths.lua")
include("config/jobs/resistance.lua")
include("config/jobs/hecu.lua")
include("config/jobs/cwu.lua")
include("config/jobs/citizens.lua")
include("config/jobs/bandits.lua")
include("config/jobs/refugees.lua")
include("config/jobs/guild.lua")
include("config/jobs/guardian.lua")
include("config/jobs/dod.lua")
include("config/jobs/others.lua")
include("config/entities.lua")
include("config/shipments.lua")
include("config/config.lua")
DarkRP.DARKRP_LOADING = nil

DarkRP.finish()

hook.Call("DarkRPFinishedLoading", GM)
MySQLite.initialize()