-- --
-- -- This checks if a player joined your server using a lent account that is banned
-- -- eg. player got banned so he decided to make an alt account and used https://store.steampowered.com/promotion/familysharing
-- --

-- --
-- -- Get yours from https://steamcommunity.com/dev/apikey
-- --
-- local SteamAPI_Key = "E2EEEF1CF1D5F61CD714F597DED07AD0" --"E91030835B10C9694A71E7B84F1A4D7E"

-- local BanMessage = "Обход бана. (alt: %s)"

-- --
-- -- Do you want to kick players using family shared accounts?
-- --
-- local BlockFamilySharing = true
-- local BlockFamilySharingMessage = "Запрещается использование family shared аккаунтов"

-- --
-- --
-- -- DO NOT TOUCH --
-- --
-- --

-- --[[hook.Add("PlayerInitialSpawn", "CheckSteamFamily", function(ply)
-- 	local ply_steamid = ply:SteamID()
-- 	http.Fetch(string.format("http://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v0001/?key=%s&format=json&steamid=%s&appid_playing=4000", SteamAPI_Key, ply:SteamID64()), function(body)
-- 		body = util.JSONToTable(body)

-- 		if not body or not body.response or not body.response.lender_steamid then
-- 			sam.print(Color(255, 0, 0), "Invalid Steam API Key to check for steam family sharing check.")
-- 			debug.Trace()
-- 			return
-- 		end

-- 		local lender = body.response.lender_steamid
-- 		if lender == "0" then return end

-- 		if BlockFamilySharing then
-- 			ply:Kick(BlockFamilySharingMessage)
-- 		else
-- 			lender = util.SteamIDFrom64(lender)
-- 			sam.player.is_banned(lender, function(banned)
-- 				if banned then
-- 					RunConsoleCommand("sam", "banid", ply_steamid, "0", BanMessage:format(lender))
-- 				end
-- 			end)
-- 		end
-- 	end)
-- end)]]

-- local util = util
-- local IsValid = IsValid
-- local timer = timer

-- hook.Add("PlayerInitialSpawn", "CheckSteamFamily", function(ply)
-- 	timer.Simple(0.1, function()
-- 		if not IsValid(ply) then return end
-- 		local ply_steamid64 = ply:SteamID64()
-- 		local owner_steamid64 = ply:OwnerSteamID64()

-- 		if ply_steamid64 == owner_steamid64 then return end

-- 		print(ply_steamid64 .. " USING FAMILY SHARE")

-- 		if BlockFamilySharing then
-- 			ply:Kick(BlockFamilySharingMessage)
-- 		else
-- 			local lender = util.SteamIDFrom64(owner_steamid64)
-- 			ply_steamid = util.SteamIDFrom64(ply_steamid64)
-- 			if lender == "0" then print("FAMILY CHECK FAILED ON UTIL") return end
-- 			sam.player.is_banned(lender, function(banned)
-- 				if banned then
-- 					RunConsoleCommand("sam", "banid", ply_steamid, "0", BanMessage:format(lender))
-- 				end
-- 			end)
-- 		end
-- 	end)
-- end)