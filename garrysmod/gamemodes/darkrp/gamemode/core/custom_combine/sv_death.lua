hook.Add("DoPlayerDeath", "CombineDeath", function(ply)
	if ply:IsCombine() then
		-- players
		local players = {}
		local playerscount = 0
		local job = ply:getDarkRPVar("job")
		job = string.Explode(" ", job)

		for k, v in ipairs(player.GetAll()) do
			if not v:IsCombine() or v == ply then continue end

			playerscount = playerscount + 1
			players[playerscount] = v
		end

		-- mark
		CreateMark(players, 3, 60, "Потеря биосигнала UID: " .. job[2], "CombineDeath" .. tostring(ply:EntIndex()), ply:GetPos())
	end
end)