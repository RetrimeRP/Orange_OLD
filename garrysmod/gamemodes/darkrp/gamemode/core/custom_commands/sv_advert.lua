local function Advert(ply, args)
	-- args
	if args == "" then
		DarkRP.notify(ply, 0, 4, "Вы должны написать текст объявления")
		return ""
	end

	-- advert
	local jobcolor = team.GetColor(ply:Team())
	local nick = ply:Nick()
	local textcolor = Color(255, 255, 0)

	for k, v in ipairs(player.GetAll()) do
		DarkRP.talkToPerson(v, jobcolor, "[Объявление] " .. nick, textcolor, args, ply)
	end

	return ""
end
DarkRP.defineChatCommand("advert", Advert, 1.5)
DarkRP.defineChatCommand("ad", Advert, 1.5)