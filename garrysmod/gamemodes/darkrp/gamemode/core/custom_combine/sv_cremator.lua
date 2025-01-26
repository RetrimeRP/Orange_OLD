local amb_loop = Sound("retrime/orange/cremator/amb_loop.wav") -- ИЗМЕНЕНО 05.02.2022

hook.Add("PlayerLoadout", "retrime.Cremator", function(ply)
	ply:StopSound(amb_loop)

	if ply:Team() == TEAM_SYNTH1 then
		ply:EmitSound(amb_loop, 60, 100, 0.3, CHAN_AUTO)
	end
end)

hook.Add("PostPlayerDeath", "retrime.Cremator", function(ply)
	if ply:Team() == TEAM_SYNTH1 then
		ply:StopSound(amb_loop)
	end
end)

--hook.Add("PlayerChangedTeam", "retrime.Cremator", function(ply, oldTeam, newTeam) -- ИЗМЕНЕНО 11.01.2022
---	if oldTeam == TEAM_SYNTH1 then
--		ply:StopSound(amb_loop)
--	end
--end)