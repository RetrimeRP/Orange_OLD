--[[------------------------------------------------------------

	FSpectate_canSpectate

------------------------------------------------------------]]--
if SERVER then
	hook.Add("FSpectate_canSpectate", "retrime.FSG", function(ply)
		if ply:IsSuperAdmin() then return end

		if ply:Team() ~= TEAM_FSG then
			DarkRP.notify(ply, 0, 4, "Вам необходимо быть FSG")
			return false
		end
	end)
end

--[[------------------------------------------------------------

	PlayerNoClip

------------------------------------------------------------]]--
hook.Add("PlayerNoClip", "retrime.FSG", function(ply)
	if ply:IsSuperAdmin() or ply:IsSupervisor() or ply:IsManager() then return end

	if ply:Team() ~= TEAM_FSG then
		return false
	end
end)