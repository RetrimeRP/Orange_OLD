PrecacheParticleSystem("generic_smoke")

local disguiselist = {

	["0"] = {
		name = "Снять маскировку",
		model = "models/player/gman_high.mdl",
		id = -1
	},

	-- METRO POLICE FORCES
	["mpf1"] = {
		name = "C82.MPF.RCT",
		model = "models/retrime/metropolice/rct.mdl",
		weapons = {"weapon_cuff_elastic", "darkrp_stunstick"},
		combine = true,
		color = Color(51, 204, 204)
	},
	["mpf2"] = {
		name = "C82.MPF.UNION.05",
		model = "models/retrime/metropolice/union.mdl",
		weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_search", "darkrp_ram", "tfa_pistol"},
		combine = true,
		color = Color(51, 204, 204)
	},
	["mpf3"] = {
		name = "C82.MPF.HELIX.05",
		model = "models/retrime/metropolice/helix.mdl",
		weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_search", "darkrp_medkit", "darkrp_ram", "tfa_pistol", "tfa_mp5k", "tfa_smg"},
		combine = true,
		color = Color(51, 204, 204)
	},
	["mpf6"] = {
		name = "C82.MPF.UNION.03",
		model = "models/retrime/metropolice/union.mdl",
		weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_search", "darkrp_shield_02", "darkrp_ram", "tfa_pistol", "tfa_smg"},
		combine = true,
		color = Color(51, 204, 204)
	},
	["mpf11"] = {
		name = "C82.MPF.APEX.01",
		model = "models/retrime/metropolice/apex.mdl",
		weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_search", "darkrp_shield_02", "darkrp_ram", "tfa_pistol", "tfa_oicw"},
		combine = true,
		color = Color(51, 204, 204)
	},
	["mpf12"] = {
		name = "C82.MPF.OFC",
		model = "models/retrime/metropolice/ofc.mdl",
		allowed = function(ply) return ply:Donator("platinum") end,
		weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_search", "darkrp_shield_02", "darkrp_ram", "tfa_smg", "tfa_shotgun"},
		combine = true,
		color = Color(51, 204, 204)
	},

	-- CIVIL WORKER'S UNION
	["cwu4"] = {
		name = "Парамедик ГСР",
		model = {
			"models/retrime/group02/male_01.mdl",
			"models/retrime/group02/male_03.mdl",
			"models/retrime/group02/male_05.mdl",
			"models/retrime/group02/male_07.mdl",
			"models/retrime/group02/male_09.mdl"
		},
		weapons = {"darkrp_medkit"},
		color = Color(204, 204, 153)
	},
	["cwu5"] = {
		name = "Фасовщик ГСР",
		model = "models/retrime/worker_01.mdl",
		allowed = function(ply) return ply:Donator("platinum") end,
		color = Color(204, 204, 153)
	},

	-- CITIZENS
	["citizen"] = {
		name = "Гражданин",
		model = {
			"models/retrime/group01/female_01.mdl",
			"models/retrime/group01/female_02.mdl",
			"models/retrime/group01/female_03.mdl",
			"models/retrime/group01/female_04.mdl",
			"models/retrime/group01/female_06.mdl",
			"models/retrime/group01/female_07.mdl",
			"models/retrime/group01/male_01.mdl",
			"models/retrime/group01/male_02.mdl",
			"models/retrime/group01/male_03.mdl",
			"models/retrime/group01/male_04.mdl",
			"models/retrime/group01/male_05.mdl",
			"models/retrime/group01/male_06.mdl",
			"models/retrime/group01/male_07.mdl",
			"models/retrime/group01/male_08.mdl",
			"models/retrime/group01/male_09.mdl"
		},
		color = Color(20, 150, 20)
	},

	-- RESISTANCE
	["resistance2"] = {
		name = "Член Сопротивления",
		model = {
			"models/retrime/group03/female_01.mdl",
			"models/retrime/group03/female_02.mdl",
			"models/retrime/group03/female_03.mdl",
			"models/retrime/group03/female_04.mdl",
			"models/retrime/group03/female_06.mdl",
			"models/retrime/group03/female_07.mdl",
			"models/retrime/group03/male_01.mdl",
			"models/retrime/group03/male_02.mdl",
			"models/retrime/group03/male_03.mdl",
			"models/retrime/group03/male_04.mdl",
			"models/retrime/group03/male_05.mdl",
			"models/retrime/group03/male_06.mdl",
			"models/retrime/group03/male_07.mdl",
			"models/retrime/group03/male_08.mdl",
			"models/retrime/group03/male_09.mdl"
		},
		allowed = function(ply) return ply:Team() == TEAM_GUILD2 end,
		color = Color(75, 75, 75)
	},
	["resistance3"] = {
		name = "Медик Сопротивления",
		model = {
			"models/retrime/group03m/female_01.mdl",
			"models/retrime/group03m/female_02.mdl",
			"models/retrime/group03m/female_03.mdl",
			"models/retrime/group03m/female_04.mdl",
			"models/retrime/group03m/female_06.mdl",
			"models/retrime/group03m/female_07.mdl",
			"models/retrime/group03m/male_01.mdl",
			"models/retrime/group03m/male_02.mdl",
			"models/retrime/group03m/male_03.mdl",
			"models/retrime/group03m/male_04.mdl",
			"models/retrime/group03m/male_05.mdl",
			"models/retrime/group03m/male_06.mdl",
			"models/retrime/group03m/male_07.mdl",
			"models/retrime/group03m/male_08.mdl",
			"models/retrime/group03m/male_09.mdl",
			"models/retrime/group04m/female_01.mdl",
			"models/retrime/group04m/female_02.mdl",
			"models/retrime/group04m/female_03.mdl",
			"models/retrime/group04m/female_04.mdl",
			"models/retrime/group04m/female_06.mdl",
			"models/retrime/group04m/female_07.mdl",
			"models/retrime/group04m/male_01.mdl",
			"models/retrime/group04m/male_02.mdl",
			"models/retrime/group04m/male_03.mdl",
			"models/retrime/group04m/male_04.mdl",
			"models/retrime/group04m/male_05.mdl",
			"models/retrime/group04m/male_06.mdl",
			"models/retrime/group04m/male_07.mdl",
			"models/retrime/group04m/male_08.mdl",
			"models/retrime/group04m/male_09.mdl"
		},
		allowed = function(ply) return ply:Team() == TEAM_GUILD2 end,
		weapons = {"darkrp_medkit"},
		color = Color(75, 75, 75)
	},

	-- GUILD
	["guild1"] = {
		name = "Оперативник NS",
		model = "models/retrime/guild/guild_01.mdl",
		allowed = function(ply) return ply:Team() == TEAM_HECU7 end,
		weapons = {"tfa_akm"},
		color = Color(75, 107, 84)
	},
	["guild3"] = {
		name = "Медик NS",
		model = "models/retrime/guild/guild_03.mdl",
		allowed = function(ply) return ply:Team() == TEAM_HECU7 end,
		weapons = {"darkrp_medkit", "tfa_grach", "tfa_mp153"},
		color = Color(75, 107, 84)
	}

}

hook.Add("DarkRPFinishedLoading", "DarkRP_Disguise", function()

	for k, v in pairs(disguiselist) do
		local job = DarkRP.getJobByCommand(k)

		if job then
			disguiselist[k].id = job.team
		end
	end

end)

function DarkRP.GetDisguiseList()

	return disguiselist

end

DarkRP.DARKRP_LOADING = true

DarkRP.registerDarkRPVar("disguise", net.WriteString, net.ReadString)

DarkRP.DARKRP_LOADING = nil