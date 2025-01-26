DarkRP.declareChatCommand{command = "advert", description = "Message all players on the server.", delay = 2}
DarkRP.declareChatCommand{command = "ad", description = "Message all players on the server.", delay = 2}
DarkRP.declareChatCommand{command = "roll", description = "Roll a random number.", delay = 2}
DarkRP.declareChatCommand{command = "try", description = "Try action.", delay = 2}
DarkRP.declareChatCommand{command = "do", description = "Do action.", delay = 2}
DarkRP.declareChatCommand{command = "l", description = "Local OOC chat.", delay = 1.5}
DarkRP.declareChatCommand{command = "looc", description = "Local OOC chat.", delay = 1.5}

DarkRP.declareChatCommand{command = "fire", description = "Fire someone.", delay = 4, condition = fn.Compose{fn.Curry(fn.Flip(fn.Gt), 2)(1), fn.Length, player.GetAll}, tableArgs = true}

DarkRP.declareChatCommand{command = "cityvoice", description = "City voice message.", delay = 2}
DarkRP.declareChatCommand{command = "radiovoice", description = "Radio voice message.", delay = 2}
DarkRP.declareChatCommand{command = "yellowcode", description = "Start yellow code.", delay = 1.5}
DarkRP.declareChatCommand{command = "redcode", description = "Start red code.", delay = 1.5}
DarkRP.declareChatCommand{command = "unyellowcode", description = "Undo yellow code.", delay = 1.5}
DarkRP.declareChatCommand{command = "unredcode", description = "Undo red code.", delay = 1.5}
DarkRP.declareChatCommand{command = "radiotoggle", description = "Radio toggle.", delay = 2}
DarkRP.declareChatCommand{command = "radiotoggleall", description = "Radio toggle all.", delay = 2}

DarkRP.declareChatCommand{command = "award", description = "award.", delay = 3}
DarkRP.declareChatCommand{command = "awardall", description = "award all.", delay = 3}

DarkRP.declareChatCommand{command = "recruiting", description = "Recruiting.", delay = 2}
DarkRP.declareChatCommand{command = "unrecruiting", description = "Undo recruiting.", delay = 2}
DarkRP.declareChatCommand{command = "recruit", description = "Recruit.", delay = 1}


--[[------------------------------------------------------------



	Remove



------------------------------------------------------------]]--

timer.Simple(10, function()

	DarkRP.removeChatCommand("addspawn")
	DarkRP.removeChatCommand("arrest")
	DarkRP.removeChatCommand("broadcast")
	DarkRP.removeChatCommand("channel")
	DarkRP.removeChatCommand("demote")
	DarkRP.removeChatCommand("forcerpname")
	DarkRP.removeChatCommand("freerpname")
	DarkRP.removeChatCommand("job")
	DarkRP.removeChatCommand("jobswitch")
	DarkRP.removeChatCommand("price")
	DarkRP.removeChatCommand("radio")
	DarkRP.removeChatCommand("setprice")
	DarkRP.removeChatCommand("setspawn")
	DarkRP.removeChatCommand("switchjob")
	DarkRP.removeChatCommand("switchjobs")
	DarkRP.removeChatCommand("teamban")
	DarkRP.removeChatCommand("teamunban")
	DarkRP.removeChatCommand("unarrest")
	DarkRP.removeChatCommand("unwarrant")

	for k, v in ipairs(RPExtraTeams) do

		if v.command ~= "fsg" then

			DarkRP.removeChatCommand(v.command)

		end

	end

end)