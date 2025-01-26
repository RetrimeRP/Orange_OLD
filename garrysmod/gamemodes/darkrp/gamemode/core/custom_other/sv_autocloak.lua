
hook.Add("PlayerNoClip","vizit.code",function(pl,state)
	if not pl:IsAdmin() then return end
		if state then
			sam.player.cloak(pl)
			--    pl:ChatPrint("ТЫ ЛЕТАЕШЬ")
		else
			sam.player.uncloak(pl)
		end
end)

hook.Add("OnPlayerChangedTeam","vizit.fixbug",function(pl)
	if not pl:IsAdmin() then return end
	-- pl:ChatPrint("Работаем.")
	sam.player.uncloak(pl)
end)