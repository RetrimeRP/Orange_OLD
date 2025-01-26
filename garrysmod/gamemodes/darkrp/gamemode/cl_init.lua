hook.Run("DarkRPStartedLoading")

GM.Version = "2.7.0"
GM.Name = "DarkRP"
GM.Author = "By FPtje Falco et al."

DeriveGamemode("sandbox")
DEFINE_BASECLASS("gamemode_sandbox")
GM.Sandbox = BaseClass

-- --
-- -- retrime
-- --
-- retrime = retrime or {}
-- retrime.jobs = retrime.jobs or {}
-- retrime.commands = retrime.commands or {}

local function LoadModules()

	local root = GM.FolderName .. "/gamemode/core/"
	local _, folders = file.Find(root .. "*", "LUA")

	for _, folder in SortedPairs(folders, true) do
		if DarkRP.disabledDefaults["modules"][folder] then continue end

		for _, File in SortedPairs(file.Find(root .. folder .. "/sh_*.lua", "LUA"), true) do
			if File == "sh_interface.lua" then continue end
			include(root .. folder .. "/" .. File)
		end

		for _, File in SortedPairs(file.Find(root .. folder .. "/cl_*.lua", "LUA"), true) do
			if File == "cl_interface.lua" then continue end
			include(root .. folder .. "/" .. File)
		end
	end

end

GM.Config = {}
GM.NoLicense = GM.NoLicense or {}

include("config/config.lua")
include("libraries/sh_cami.lua")
include("libraries/simplerr.lua")
include("libraries/fn.lua")
include("libraries/tablecheck.lua")
include("libraries/interfaceloader.lua")
include("libraries/disjointset.lua")
include("libraries/modificationloader.lua")

hook.Call("DarkRPPreLoadModules", GM)

LoadModules()

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
DarkRP.DARKRP_LOADING = nil

DarkRP.finish()

hook.Call("DarkRPFinishedLoading", GM)