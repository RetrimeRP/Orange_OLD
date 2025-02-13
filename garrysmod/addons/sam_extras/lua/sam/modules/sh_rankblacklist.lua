local blacklist = {
	["silver"] = true,
	["gold"] = true,
	["platinum"] = true,
	["manager"] = true,
	["supervisor"] = true
}

hook.Add("SAM.CanRunCommand", "SAM.RankBlacklist", function(ply, command, args)
	if command == "setrank" or command == "setrankid" then
		if not IsValid(ply) then return end
		if ply:IsSuperAdmin() then return end

		if blacklist[args[3]] then
			ply:sam_send_message("Ошибка: этого ранга нет в вайтлисте!")
			return false
		end
	end
end)