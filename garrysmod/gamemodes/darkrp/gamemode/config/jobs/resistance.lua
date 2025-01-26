--[[------------------------------------------------------------

	----------
	RESISTANCE
	----------

------------------------------------------------------------]]--

local donate_pos = Vector( 6580, -9829, 59)

TEAM_RESISTANCE1 = DarkRP.createJob("Рекрут Сопротивления", {

	color = Color(75, 75, 75),
	model = {
		"models/retrime/group04/female_01.mdl",
		"models/retrime/group04/female_02.mdl",
		"models/retrime/group04/female_03.mdl",
		"models/retrime/group04/female_04.mdl",
		"models/retrime/group04/female_06.mdl",
		"models/retrime/group04/female_07.mdl",
		"models/retrime/group04/male_01.mdl",
		"models/retrime/group04/male_02.mdl",
		"models/retrime/group04/male_03.mdl",
		"models/retrime/group04/male_04.mdl",
		"models/retrime/group04/male_05.mdl",
		"models/retrime/group04/male_06.mdl",
		"models/retrime/group04/male_07.mdl",
		"models/retrime/group04/male_08.mdl",
		"models/retrime/group04/male_09.mdl"
	},
	description = "Рекрут освободительной организации Сопротивления",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory"},
	command = "resistance1",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Сопротивление",
	PlayerLoadout = function(ply) ply:SetMaxHealth(130) ply:SetHealth(130) ply:SetArmor(100) end

})

TEAM_RESISTANCE2 = DarkRP.createJob("Член Сопротивления", {

	color = Color(75, 75, 75),
	model = {
		"models/retrime/group04/female_01.mdl",
		"models/retrime/group04/female_02.mdl",
		"models/retrime/group04/female_03.mdl",
		"models/retrime/group04/female_04.mdl",
		"models/retrime/group04/female_06.mdl",
		"models/retrime/group04/female_07.mdl",
		"models/retrime/group04/male_01.mdl",
		"models/retrime/group04/male_02.mdl",
		"models/retrime/group04/male_03.mdl",
		"models/retrime/group04/male_04.mdl",
		"models/retrime/group04/male_05.mdl",
		"models/retrime/group04/male_06.mdl",
		"models/retrime/group04/male_07.mdl",
		"models/retrime/group04/male_08.mdl",
		"models/retrime/group04/male_09.mdl"
	},
	description = "Член освободительной организации Сопротивления",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory"},
	command = "resistance2",
	max = 3,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Сопротивление",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 20000

})

TEAM_RESISTANCE3 = DarkRP.createJob("Медик Сопротивления", {

	color = Color(75, 75, 75),
	model = {
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
	description = "Медик освободительной организации Сопротивления",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "darkrp_medkit"},
	command = "resistance3",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Сопротивление",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 30000,
	require = TEAM_RESISTANCE2

})

TEAM_RESISTANCE4 = DarkRP.createJob("Ветеран Сопротивления", {

	color = Color(75, 75, 75),
	model = {
		"models/retrime/group04/female_01.mdl",
		"models/retrime/group04/female_02.mdl",
		"models/retrime/group04/female_03.mdl",
		"models/retrime/group04/female_04.mdl",
		"models/retrime/group04/female_06.mdl",
		"models/retrime/group04/female_07.mdl",
		"models/retrime/group04/male_01.mdl",
		"models/retrime/group04/male_02.mdl",
		"models/retrime/group04/male_03.mdl",
		"models/retrime/group04/male_04.mdl",
		"models/retrime/group04/male_05.mdl",
		"models/retrime/group04/male_06.mdl",
		"models/retrime/group04/male_07.mdl",
		"models/retrime/group04/male_08.mdl",
		"models/retrime/group04/male_09.mdl"
	},
	description = "Ветеран освободительной организации Сопротивления",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory"},
	command = "resistance4",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Сопротивление",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 50000,
	require = TEAM_RESISTANCE3

})

TEAM_RESISTANCE5 = DarkRP.createJob("Лидер Сопротивления", {

	color = Color(75, 75, 75),
	model = "models/retrime/hevsuit.mdl",
	description = "Лидер освободительной организации Сопротивления",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_crowbar", "tfa_psg", "tfa_lmg", "tfa_rpg"},
	command = "resistance5",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["buckshot"] = 35,
		["ar2"] = 120,
	},
	category = "Сопротивление",
	PlayerLoadout = function(ply) ply:SetMaxHealth(200) ply:SetHealth(200) ply:SetArmor(100) ply:SetRunSpeed(300) end,
	price = 2000000,
	require = TEAM_RESISTANCE4

})

TEAM_RESISTANCE6 = DarkRP.createJob("Инженер Сопротивления", {

	color = Color(75, 75, 75),
	model = {
		"models/retrime/group04/female_01.mdl",
		"models/retrime/group04/female_02.mdl",
		"models/retrime/group04/female_03.mdl",
		"models/retrime/group04/female_04.mdl",
		"models/retrime/group04/female_06.mdl",
		"models/retrime/group04/female_07.mdl",
		"models/retrime/group04/male_01.mdl",
		"models/retrime/group04/male_02.mdl",
		"models/retrime/group04/male_03.mdl",
		"models/retrime/group04/male_04.mdl",
		"models/retrime/group04/male_05.mdl",
		"models/retrime/group04/male_06.mdl",
		"models/retrime/group04/male_07.mdl",
		"models/retrime/group04/male_08.mdl",
		"models/retrime/group04/male_09.mdl"
	},
	description = "Инженер освободительной организации Сопротивления",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "darkrp_build", "tfa_oicw"},
	command = "resistance6",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["smg1"] = 150
	},
	category = "Сопротивление",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 300000

})

TEAM_RESISTANCE7 = DarkRP.createJob("Скаут Сопротивления", {

	color = Color(75, 75, 75),
	model = {
		"models/retrime/group04/female_01.mdl",
		"models/retrime/group04/female_02.mdl",
		"models/retrime/group04/female_03.mdl",
		"models/retrime/group04/female_04.mdl",
		"models/retrime/group04/female_06.mdl",
		"models/retrime/group04/female_07.mdl",
		"models/retrime/group04/male_01.mdl",
		"models/retrime/group04/male_02.mdl",
		"models/retrime/group04/male_03.mdl",
		"models/retrime/group04/male_04.mdl",
		"models/retrime/group04/male_05.mdl",
		"models/retrime/group04/male_06.mdl",
		"models/retrime/group04/male_07.mdl",
		"models/retrime/group04/male_08.mdl",
		"models/retrime/group04/male_09.mdl"
	},
	description = "Скаут освободительной организации Сопротивления",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_bm16", "tfa_crossbow"},
	command = "resistance7",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:Donator("silver") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Silver, Gold и Platinum",
	ammo = {
		["smg1"] = 90,
		["XBowBolt"] = 3
	},
	category = "Сопротивление",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 1000000,
	canchange = function(ply) return ply:Donator("silver") end

})

TEAM_RESISTANCE8 = DarkRP.createJob("Шпион Сопротивления", {

	color = Color(75, 75, 75),
	model = {
		"models/retrime/group04/female_01.mdl",
		"models/retrime/group04/female_02.mdl",
		"models/retrime/group04/female_03.mdl",
		"models/retrime/group04/female_04.mdl",
		"models/retrime/group04/female_06.mdl",
		"models/retrime/group04/female_07.mdl",
		"models/retrime/group04/male_01.mdl",
		"models/retrime/group04/male_02.mdl",
		"models/retrime/group04/male_03.mdl",
		"models/retrime/group04/male_04.mdl",
		"models/retrime/group04/male_05.mdl",
		"models/retrime/group04/male_06.mdl",
		"models/retrime/group04/male_07.mdl",
		"models/retrime/group04/male_08.mdl",
		"models/retrime/group04/male_09.mdl"
	},
	description = "Шпион освободительной организации Сопротивления",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "darkrp_disguise", "darkrp_hackdevice"},
	command = "resistance8",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Сопротивление",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 500000

})

TEAM_RESISTANCE9 = DarkRP.createJob("Вортигонт", {

	color = Color(75, 75, 75),
	model = "models/retrime/vortigaunt.mdl",
	description = "Вортигонт освободительной организации Сопротивления",
	weapons = {"weapon_physgun", "weapon_vortbeam", "gmod_tool"},
	command = "resistance9",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Сопротивление",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 100000

})

TEAM_DONATE22 = DarkRP.createJob("Распорядитель", {

	color = Color(255, 0, 0),
	model = {"models/bo6/frontman/frontman_pm.mdl"},
	description = "Таинственный распорядитель блуждающий по миру, нанимая потенциальных людей.",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_l96", "tfa_vihr", "tfa_magnum", "weapon_physcannon", "darkrp_keys", "darkrp_disguise", "darkrp_hackdevice"},
	command = "donate2",
	max = 1,
	salary = 0,
	rebel = true,
	admin = 0,
	vote = false,
	CSpawn = {
    donate_pos,
    },
	hasLicense = false,

	customCheck = function(ply) 
		return ply:SteamID() == "STEAM_0:0:541451703" or ply:IsSuperAdmin()
	end,
	ammo = {
		["ar2"] = 90,
		["357"] = 24,
		["SniperPenetratedRound"] = 10
	},
	category = "Томас Вилка",
	PlayerLoadout = function(ply) ply:SetMaxHealth(100) ply:SetHealth(100) ply:SetArmor(170) ply:SetRunSpeed(320) end,
	price = 0,
	canchange = function(ply) return ply:Donator("silver") end

})


TEAM_DONATE23 = DarkRP.createJob("Инквизитор", {

	color = Color(0, 55, 230),
	model = {"models/mwiii/cybercat/cybercat_pm.mdl"},
	description = "Скрытый убийца, выполняющий боевые задание.",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_vihr", "tfa_l96", "tfa_glock", "weapon_physcannon", "darkrp_keys"},
	command = "donate23",
	max = 1,
	salary = 0,
	rebel = true,
	admin = 0,
	vote = false,
	CSpawn = {
    donate_pos,
    },
	hasLicense = false,

	customCheck = function(ply) 
		return ply:SteamID() == "STEAM_0:0:541451703" or ply:IsSuperAdmin()
	end,
	ammo = {
		["smg1"] = 90,
		["pistol"] = 24,
		["SniperPenetratedRound"] = 10
	},
	category = "Томас Вилка",
	PlayerLoadout = function(ply) ply:SetMaxHealth(130) ply:SetHealth(130) ply:SetArmor(100) ply:SetJumpPower(330) ply:SetRunSpeed(360) end,
	price = 0,
	canchange = function(ply) return ply:Donator("silver") end

})


--
-- Category
--
DarkRP.createCategory{

	name = "Сопротивление",
	categorises = "jobs",
	startExpanded = true,
	color = Color(75, 75, 75),
	canSee = function() return true end,
	sortOrder = 3

}

DarkRP.createCategory{

	name = "Томас Вилка",
	categorises = "jobs",
	startExpanded = true,
	color = Color(75, 75, 75),
	canSee = function() return true end,
	sortOrder = 256

}