local MODULE = GAS.Logging:MODULE()

MODULE.Category = "SAM"
MODULE.Name = "Commands"
MODULE.Colour = Color(255, 90, 0)

local whitelist = {

	["mute"]      = true,
	["unmute"]    = true,
	["gag"]       = true,
	["ungag"]     = true,
	["jail"]      = true,
	["unjail"]    = true,
	["setrank"]   = true,
	["setrankid"] = true,
	["kick"]      = true,
	["jailroom"]  = true,
	["setjob"] 	  = true -- ИЗМЕНЕНО 03.02.2022 -- Не помню. Дал возможность админам сетать профессии?

}

MODULE:Setup(function()

	MODULE:Hook("SAM.RanCommand", "SAM.LogCommand", function(ply, command, args)
		if whitelist[command] then
			args = table.concat(args, ", ")
			MODULE:Log("{1} ran command {2} with arguments {3}", (sam.isconsole(ply) and GAS.Logging:Highlight("Console")) or GAS.Logging:FormatPlayer(ply), GAS.Logging:Highlight(command), GAS.Logging:Highlight(args))
		end
	end)

end)

GAS.Logging:AddModule(MODULE)

--###################################################################################--

local MODULE = GAS.Logging:MODULE()

MODULE.Category = "SAM"
MODULE.Name = "Bans"
MODULE.Colour = Color(255, 90, 0)

MODULE:Setup(function()

	MODULE:Hook("SAM.BannedPlayer", "SAM.LogBan", function(ply, unban_date, reason, admin_steamid)
		MODULE:Log("{1} banned {2} for {3} ({4})", (admin_steamid ~= "Console" and GAS.Logging:FormatPlayer(admin_steamid)) or GAS.Logging:Highlight("Console"), GAS.Logging:FormatPlayer(ply), GAS.Logging:Highlight(sam.format_length((unban_date - os.time()) / 60)), GAS.Logging:Highlight(reason))
	end)

	MODULE:Hook("SAM.BannedSteamID", "SAM.LogBanSteamID", function(steamid, unban_date, reason, admin_steamid)
		MODULE:Log("{1} banned {2} for {3} ({4})", (admin_steamid ~= "Console" and GAS.Logging:FormatPlayer(admin_steamid)) or GAS.Logging:Highlight("Console"), GAS.Logging:FormatPlayer(steamid), GAS.Logging:Highlight(sam.format_length((unban_date - os.time()) / 60)), GAS.Logging:Highlight(reason))
	end)

	MODULE:Hook("SAM.UnbannedSteamID", "SAM.LogUnban", function(steamid, admin_steamid)
		MODULE:Log("{1} unbanned {2}", (admin_steamid ~= "Console" and GAS.Logging:FormatPlayer(admin_steamid)) or GAS.Logging:Highlight("Console"), GAS.Logging:FormatPlayer(steamid))
	end)

end)

GAS.Logging:AddModule(MODULE)

--###################################################################################--

local MODULE = GAS.Logging:MODULE()

MODULE.Category = "SAM"
MODULE.Name = "Ranks"
MODULE.Colour = Color(255, 90, 0)

MODULE:Setup(function()

	MODULE:Hook("SAM.ChangedPlayerRank", "SAM.LogRank", function(ply, new_rank, old_rank, expiry_date)
		MODULE:Log("{1} changed rank from {2} to {3} for {4}", GAS.Logging:FormatPlayer(ply), GAS.Logging:Highlight(old_rank), GAS.Logging:Highlight(new_rank), GAS.Logging:Highlight(sam.format_length((expiry_date - os.time()) / 60)))
	end)

	MODULE:Hook("SAM.ChangedSteamIDRank", "SAM.LogRankSteamID", function(steamid, new_rank, old_rank, expiry_date)
		MODULE:Log("{1} changed rank from {2} to {3} for {4}", GAS.Logging:FormatPlayer(steamid), GAS.Logging:Highlight(old_rank), GAS.Logging:Highlight(new_rank), GAS.Logging:Highlight(sam.format_length((expiry_date - os.time()) / 60)))
	end)

end)

GAS.Logging:AddModule(MODULE)