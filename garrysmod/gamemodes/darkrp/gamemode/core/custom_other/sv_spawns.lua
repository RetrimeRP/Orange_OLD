local mpf = {
	Vector(2993, 3335, 64),
	Vector(2992, 3190, 64),
	Vector(2877, 3191, 64),
	Vector(2888, 3325, 64.),
	Vector(2771, 3324, 64),
	Vector(2768, 3183, 64),
	Vector(2660, 3327, 64),
	Vector(2658, 3185, 64)
}

local ota = {
	Vector(1188, 3528, 64),
	Vector(1540, 3527, 64),
	Vector(1927, 3526, 64),
	Vector(2216, 3521, 64)
}
local resistance = {
	Vector(6656, -9768, 40),
	Vector(6656, -9827, 40),
	Vector(6612, -9849, 40),
	Vector(6611, -9765, 40)
}

local cwu = {
	Vector(-2746, -1171, 148),
	Vector(-2831, -1164, 148),
	Vector(-2832, -1229, 148),
	Vector(-2741, -1230, 148)
}

local citizens = {
	Vector(-4480, 1632, 42),
	Vector(-4544, 1632, 42),
	Vector(-4608, 1632, 42),
	Vector(-4480, 1534, 42),
	Vector(-4544, 1534, 42),
	Vector(-4608, 1534, 42)
}

local bandits = {
	Vector(-1411, -2279, 12),
	Vector(-1490, -2302, 12),
	Vector(-1341, -2301, 12),
	Vector(-1463, -2153, 12)
}

local guild = {
	Vector(15291, -7647, -370),
	Vector(15295, -7568, -370),
	Vector(15301, -7490, -370),
	Vector(15402, -7570, -370)
}

local random = math.random
hook.Add("PlayerSelectSpawn", "JobSpawns", function(ply)
	if ply:isArrested() then return end

	-- job
	local job = ply:Team()

	--
	-- single jobs
	--

	-- admin
	if job == TEAM_ADMIN then
		return false, Vector(1574, 4319, 412)
	end
	
	-- refuqu
	if job == TEAM_REFUGEE then
		return false, Vector(-4784, -7092, 2)
	end

	-- fsg
	if job == TEAM_FSG then
		return false, Vector(610, 9024, 1570)
	end

	--
	-- multiple jobs
	--
	-- mpf
	if ply:IsMPF() then
		return false, mpf[random(#mpf)]
	end

	-- ota
	if ply:IsOTA() or ply:IsGuardian() or ply:IsSynth() then
		return false, ota[random(#ota)]
	end

	-- resistance
	if ply:IsResistance() then
		return false, resistance[random(#resistance)]
	end

	-- cwu
	if ply:IsCWU() then
		return false, cwu[random(#cwu)]
	end

	-- citizens
	if ply:IsCitizen() then
		return false, citizens[random(#citizens)]
	end

	-- bandits
	if ply:IsBandits() then
		return false, bandits[random(#bandits)]
	end

	-- guild
	if ply:IsGuild() then
		return false, guild[random(#guild)]
	end
end)


hook.Add("PlayerSelectSpawn", "SpawnPosED", function(ply)
  if RPExtraTeams[ply:Team()].CSpawn then
    local spawntable = RPExtraTeams[ply:Team()].CSpawn
    return ply, spawntable[math.random(1, #spawntable)]
  end
end)