local cooldowns = {
	["retrime/orange/mpf/die1.wav"] = 1.8068027496338,
	["retrime/orange/mpf/die2.wav"] = 2.4383220672607,
	["retrime/orange/mpf/die3.wav"] = 2.0137641429901,
	["retrime/orange/mpf/die4.wav"] = 3.6394557952881
}

local mpfmodels = {

	["models/retrime/metropolice/rct.mdl"] = true,
	["models/retrime/metropolice/union.mdl"] = true,
	["models/retrime/metropolice/helix.mdl"] = true,
	["models/retrime/metropolice/grid.mdl"] = true,
	["models/retrime/metropolice/jury.mdl"] = true,
	["models/retrime/metropolice/maid.mdl"] = true,
	["models/retrime/metropolice/apex.mdl"] = true,
	["models/retrime/metropolice/ofc.mdl"] = true,
	["models/retrime/metropolice/epu.mdl"] = true,
	["models/retrime/metropolice/dvl.mdl"] = true,
	["models/retrime/metropolice/sec.mdl"] = true,

	["models/retrime/guardian/insp.mdl"] = true

}

local otamodels = {

	["models/retrime/overwatch/echo.mdl"] = true,
	["models/retrime/overwatch/riot.mdl"] = true,
	["models/retrime/overwatch/xray.mdl"] = true,
	["models/retrime/overwatch/mace.mdl"] = true,
	["models/retrime/overwatch/knight.mdl"] = true,
	["models/retrime/overwatch/king.mdl"] = true,
	["models/retrime/overwatch/heavy.mdl"] = true,
	["models/retrime/overwatch/sow.mdl"] = true,
	["models/retrime/overwatch/ordinal.mdl"] = true,

	["models/player/com_night_elite.mdl"] = true,
	["models/player/com_night_elite_prisonguard.mdl"] = true,
	["models/player/com_super_night_elite.mdl"] = true

}

local hecumodels = {

	["models/retrime/hecu/hecu_01.mdl"] = true,
	["models/retrime/hecu/hecu_02.mdl"] = true,
	["models/retrime/hecu/hecu_03.mdl"] = true,
	["models/retrime/hecu/hecu_04.mdl"] = true,
	["models/retrime/hecu/hecu_05.mdl"] = true,
	["models/retrime/hecu/hecu_06.mdl"] = true

}

local vortigauntmodels = {

	["models/retrime/vortigaunt.mdl"] = true
	
}

local femalemodels = {

	["models/retrime/group03/female_01.mdl"] = true,
	["models/retrime/group03/female_02.mdl"] = true,
	["models/retrime/group03/female_03.mdl"] = true,
	["models/retrime/group03/female_04.mdl"] = true,
	["models/retrime/group03/female_06.mdl"] = true,
	["models/retrime/group03/female_07.mdl"] = true,

	["models/retrime/group03m/female_01.mdl"] = true,
	["models/retrime/group03m/female_02.mdl"] = true,
	["models/retrime/group03m/female_03.mdl"] = true,
	["models/retrime/group03m/female_04.mdl"] = true,
	["models/retrime/group03m/female_06.mdl"] = true,
	["models/retrime/group03m/female_07.mdl"] = true,

	["models/retrime/group04m/female_01.mdl"] = true,
	["models/retrime/group04m/female_02.mdl"] = true,
	["models/retrime/group04m/female_03.mdl"] = true,
	["models/retrime/group04m/female_04.mdl"] = true,
	["models/retrime/group04m/female_06.mdl"] = true,
	["models/retrime/group04m/female_07.mdl"] = true,

	["models/retrime/group04/female_01.mdl"] = true,
	["models/retrime/group04/female_02.mdl"] = true,
	["models/retrime/group04/female_03.mdl"] = true,
	["models/retrime/group04/female_04.mdl"] = true,
	["models/retrime/group04/female_06.mdl"] = true,
	["models/retrime/group04/female_07.mdl"] = true,

	["models/retrime/group02/female_02.mdl"] = true,
	["models/retrime/group02/female_04.mdl"] = true,
	["models/retrime/group02/female_07.mdl"] = true,

	["models/retrime/group01/female_01.mdl"] = true,
	["models/retrime/group01/female_02.mdl"] = true,
	["models/retrime/group01/female_03.mdl"] = true,
	["models/retrime/group01/female_04.mdl"] = true,
	["models/retrime/group01/female_06.mdl"] = true,
	["models/retrime/group01/female_07.mdl"] = true,
			
	["models/retrime/metropolice/owd.mdl"] = true

}

local malemodels = {

	["models/retrime/group03/male_01.mdl"] = true,
	["models/retrime/group03/male_02.mdl"] = true,
	["models/retrime/group03/male_03.mdl"] = true,
	["models/retrime/group03/male_04.mdl"] = true,
	["models/retrime/group03/male_05.mdl"] = true,
	["models/retrime/group03/male_06.mdl"] = true,
	["models/retrime/group03/male_07.mdl"] = true,
	["models/retrime/group03/male_08.mdl"] = true,
	["models/retrime/group03/male_09.mdl"] = true,

	["models/retrime/group03m/male_01.mdl"] = true,
	["models/retrime/group03m/male_02.mdl"] = true,
	["models/retrime/group03m/male_03.mdl"] = true,
	["models/retrime/group03m/male_04.mdl"] = true,
	["models/retrime/group03m/male_05.mdl"] = true,
	["models/retrime/group03m/male_06.mdl"] = true,
	["models/retrime/group03m/male_07.mdl"] = true,
	["models/retrime/group03m/male_08.mdl"] = true,
	["models/retrime/group03m/male_09.mdl"] = true,

	["models/retrime/group04m/male_01.mdl"] = true,
	["models/retrime/group04m/male_02.mdl"] = true,
	["models/retrime/group04m/male_03.mdl"] = true,
	["models/retrime/group04m/male_04.mdl"] = true,
	["models/retrime/group04m/male_05.mdl"] = true,
	["models/retrime/group04m/male_06.mdl"] = true,
	["models/retrime/group04m/male_07.mdl"] = true,
	["models/retrime/group04m/male_08.mdl"] = true,
	["models/retrime/group04m/male_09.mdl"] = true,

	["models/retrime/group04/male_01.mdl"] = true,
	["models/retrime/group04/male_02.mdl"] = true,
	["models/retrime/group04/male_03.mdl"] = true,
	["models/retrime/group04/male_04.mdl"] = true,
	["models/retrime/group04/male_05.mdl"] = true,
	["models/retrime/group04/male_06.mdl"] = true,
	["models/retrime/group04/male_07.mdl"] = true,
	["models/retrime/group04/male_08.mdl"] = true,
	["models/retrime/group04/male_09.mdl"] = true,

	["models/retrime/group02/male_02.mdl"] = true,
	["models/retrime/group02/male_04.mdl"] = true,
	["models/retrime/group02/male_06.mdl"] = true,
	["models/retrime/group02/male_08.mdl"] = true,

	["models/retrime/group02/male_01.mdl"] = true,
	["models/retrime/group02/male_03.mdl"] = true,
	["models/retrime/group02/male_05.mdl"] = true,
	["models/retrime/group02/male_07.mdl"] = true,
	["models/retrime/group02/male_09.mdl"] = true,

	["models/retrime/group01/male_01.mdl"] = true,
	["models/retrime/group01/male_02.mdl"] = true,
	["models/retrime/group01/male_03.mdl"] = true,
	["models/retrime/group01/male_04.mdl"] = true,
	["models/retrime/group01/male_05.mdl"] = true,
	["models/retrime/group01/male_06.mdl"] = true,
	["models/retrime/group01/male_07.mdl"] = true,
	["models/retrime/group01/male_08.mdl"] = true,
	["models/retrime/group01/male_09.mdl"] = true,

	["models/retrime/group02b/male_01.mdl"] = true,
	["models/retrime/group02b/male_02.mdl"] = true,
	["models/retrime/group02b/male_03.mdl"] = true,
	["models/retrime/group02b/male_04.mdl"] = true,
	["models/retrime/group02b/male_05.mdl"] = true,

	["models/retrime/likstor.mdl"] = true

}

local loyalistmodels = {

	["models/retrime/group01l/male_01.mdl"] = true,
	["models/retrime/group01l/male_02.mdl"] = true,
	["models/retrime/group01l/male_03.mdl"] = true,
	["models/retrime/group01l/male_04.mdl"] = true,
	["models/retrime/group01l/male_05.mdl"] = true,
	["models/retrime/group01l/male_06.mdl"] = true,
	["models/retrime/group01l/male_07.mdl"] = true,
	["models/retrime/group01l/male_08.mdl"] = true,
	["models/retrime/group01l/male_09.mdl"] = true
	
}

--[[------------------------------------------------------------

	GetHurtSound

------------------------------------------------------------]]--
local random = math.random
local function GetHurtSound(mdl)

	-- male
	if malemodels[mdl] then 
		return "retrime/orange/male/hit" .. random(1, 7) .. ".wav"
	end

	-- female
	if femalemodels[mdl] then
		return "retrime/orange/female/hit" .. random(1, 7) .. ".wav"
	end

	-- mpf
	if mpfmodels[mdl] then
		return "npc/metropolice/pain" .. random(1, 4) .. ".wav"
	end

	-- ota
	if otamodels[mdl] then
		return "npc/combine_soldier/pain" .. random(1, 3) .. ".wav"
	end

	-- hecu
	if hecumodels[mdl] then
		return "retrime/orange/hecu/hit" .. random(1, 7) .. ".wav"
	end

	-- vortigaunt
	if vortigauntmodels[mdl] then
		return "retrime/orange/vortigaunts/hit.wav"
	end

	return false
end

--[[------------------------------------------------------------

	GetDeathSound

------------------------------------------------------------]]--
local function GetDeathSound(mdls)
	-- male
	if malemodels[mdl] then 
		return "retrime/orange/male/hit" .. random(1, 7) .. ".wav"
	end

	-- female
	if femalemodels[mdl] then
		return "retrime/orange/female/die" .. random(1, 5) .. ".wav"
	end

	-- mpf
	if mpfmodels[mdl] then
		return "retrime/orange/mpf/die" .. random(1, 4) .. ".wav", true
	end

	-- ota
	if otamodels[mdl] then
		return "retrime/orange/ota/die" .. random(1, 3) .. ".wav"
	end

	-- hecu
	if hecumodels[mdl] then
		return "retrime/orange/hecu/die" .. random(1, 7) .. ".wav"
	end

	-- vortigaunt
	if vortigauntmodels[mdl] then
		return "retrime/orange/vortigaunts/die.wav"
	end

	return false
end

--[[------------------------------------------------------------

	PlayerHurt

------------------------------------------------------------]]--
hook.Add("PlayerHurt", "retrime.HurtSounds", function(ply)
	if ply.HurtSoundDelay and ply.HurtSoundDelay > CurTime() then return end

	local sound = GetHurtSound(ply:GetModel())

	if sound then
		ply.HurtSoundDelay = CurTime() + 3
		ply:EmitSound(sound)
	end
end)

--[[------------------------------------------------------------

	DoPlayerDeath

------------------------------------------------------------]]--
local biosignal = Sound("retrime/orange/biosignal.wav")
local timer = timer
hook.Add("DoPlayerDeath", "retrime.DeathSound", function(ply)
	local sound = "retrime/orange/mpf/die" .. random(1, 4) .. ".wav"

	if sound then
		-- mpf
		if not ply:IsMPF() then return end

		ply:EmitSound(sound)

		timer.Simple(cooldowns[sound], function()
			if not ply:IsValid() then return end

			ply:EmitSound(biosignal, 75, 100, 0.7, CHAN_BODY)
		end)
	end
end)

--[[------------------------------------------------------------

	PlayerDeathSound

------------------------------------------------------------]]--
hook.Add("PlayerDeathSound", "retrime.DeathSound", function()
	return true
end)