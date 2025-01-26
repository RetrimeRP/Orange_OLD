--[[------------------------------------------------------------

	----- ------ ------
	METRO POLICE FORCES
	----- ------ ------

------------------------------------------------------------]]--
TEAM_MPF1 = DarkRP.createJob("C82.MPF.RCT", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/rct.mdl",
	description = "Рекрут Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard"},
	command = "mpf1",
	max = 5,
	salary = 500,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {},

	customCheck = function(ply) return not GetGlobalBool("rp_recruitblock") or ply.IsBeingRecruit end,
	CustomCheckFailMsg = "ЯРИК БАЧОК ПАТИК",
	category = "Гражданская oборона",
	PlayerLoadout = function(ply) ply:SetArmor(100) end,
	canchange = function() return not GetGlobalBool("rp_recruitblock") end

})

TEAM_MPF2 = DarkRP.createJob("C82.MPF.UNION.05", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/union.mdl",
	description = "Юнит Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_ram"},
	command = "mpf2",
	max = 5,
	salary = 500,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol"},

	ammo = {
		["pistol"] = 90
	},
	category = "Гражданская оборона",
	PlayerLoadout = function(ply) ply:SetArmor(100) end,
	price = 20000

})

TEAM_MPF3 = DarkRP.createJob("C82.MPF.HELIX.05", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/helix.mdl",
	description = "Медик Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_medkit", "darkrp_ram"},
	command = "mpf3",
	max = 3,
	salary = 500,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol", "tfa_smg"},

	ammo = {
		["pistol"] = 54,
		["smg1"] = 120
	},
	category = "Гражданская оборона",
	PlayerLoadout = function(ply) ply:SetMaxHealth(130) ply:SetHealth(130) ply:SetArmor(100) end,
	price = 30000,
	require = TEAM_MPF2

})

TEAM_MPF4 = DarkRP.createJob("C82.MPF.UNION.04", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/union.mdl",
	description = "Юнит Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_shield_01", "darkrp_ram"},
	command = "mpf4",
	max = 4,
	salary = 1300,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol", "tfa_smg"},

	ammo = {
		["pistol"] = 54,
		["smg1"] = 150
	},
	category = "Гражданская оборона",
	PlayerLoadout = function(ply) ply:SetMaxHealth(130) ply:SetHealth(130) ply:SetArmor(100) end,
	price = 50000,
	require = TEAM_MPF3

})

TEAM_MPF5 = DarkRP.createJob("C82.MPF.GRID.04", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/grid.mdl",
	description = "Инженер Гражданской обороны",
	weapons = {"weapon_physgun", "weapon_cuff_elastic", "gmod_tool", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_build", "darkrp_ram"},
	command = "mpf5",
	max = 1,
	salary = 1300,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol", "tfa_smg"},

	ammo = {
		["pistol"] = 54,
		["smg1"] = 120
	},
	category = "Гражданская оборона",
	PlayerLoadout = function(ply) ply:SetMaxHealth(130) ply:SetHealth(130) ply:SetArmor(100) end,
	price = 100000,
	require = TEAM_MPF4

})

TEAM_MPF6 = DarkRP.createJob("C82.MPF.UNION.03", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/union.mdl",
	description = "Юнит Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_shield_02", "darkrp_ram"},
	command = "mpf6",
	max = 2,
	salary = 2100,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol", "tfa_smg"},

	ammo = {
		["pistol"] = 54,
		["smg1"] = 135
	},
	category = "Гражданская оборона",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 400000,
	require = TEAM_MPF5

})

TEAM_MPF7 = DarkRP.createJob("C82.MPF.JURY.03", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/jury.mdl",
	description = "Снайпер Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_ram"},
	command = "mpf7",
	max = 1,
	salary = 2100,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol", "tfa_smg", "tfa_psrl"},

	ammo = {
		["pistol"] = 54,
		["smg1"] = 90,
		["SniperPenetratedRound"] = 20
	},
	category = "Гражданская оборона",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) ply:SetRunSpeed(300) end,
	price = 400000,
	require = TEAM_MPF6

})

TEAM_MPF8 = DarkRP.createJob("C82.MPF.UNION.02", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/union.mdl",
	description = "Юнит Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_shield_02", "darkrp_ram"},
	command = "mpf8",
	max = 2,
	salary = 2500,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol", "tfa_smg"},

	ammo = {
		["pistol"] = 90,
		["smg1"] = 180,
		["SMG1_Grenade"] = 2
	},
	category = "Гражданская оборона",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 400000,
	require = TEAM_MPF7

})

TEAM_MPF9 = DarkRP.createJob("C82.MPF.MAID.02", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/maid.mdl",
	description = "Снайпер Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_ram"},
	command = "mpf9",
	max = 1,
	salary = 2500,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol", "tfa_smg", "tfa_psr"},

	ammo = {
		["pistol"] = 90,
		["smg1"] = 90,
		["SniperPenetratedRound"] = 10
	},
	category = "Гражданская оборона",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) ply:SetRunSpeed(300) end,
	price = 400000,
	require = TEAM_MPF8

})

TEAM_MPF10 = DarkRP.createJob("C82.MPF.UNION.01", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/union.mdl",
	description = "Юнит Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_shield_02", "darkrp_ram"},
	command = "mpf10",
	max = 2,
	salary = 3000,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol", "tfa_smg"},

	ammo = {
		["pistol"] = 90,
		["smg1"] = 225,
		["SMG1_Grenade"] = 3
	},
	category = "Гражданская оборона",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 400000,
	require = TEAM_MPF9

})

TEAM_MPF11 = DarkRP.createJob("C82.MPF.APEX.01", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/apex.mdl",
	description = "Юнит Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_shield_02", "darkrp_ram"},
	command = "mpf11",
	max = 1,
	salary = 3000,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol", "tfa_oicw"},

	ammo = {
		["pistol"] = 54,
		["ar2"] = 120,
		["SMG1_Grenade"] = 2
	},
	category = "Гражданская оборона",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 400000,
	require = TEAM_MPF10

})

TEAM_MPF12 = DarkRP.createJob("C82.MPF.OFC", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/ofc.mdl",
	description = "Офицер Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_shield_02", "darkrp_ram"},
	command = "mpf12",
	max = 1,
	salary = 3400,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol", "tfa_smg", "tfa_shotgun"},

	ammo = {
		["pistol"] = 54,
		["smg1"] = 180,
		["SMG1_Grenade"] = 2,
		["buckshot"] = 24
	},
	category = "Гражданская оборона",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 400000,
	require = TEAM_MPF11

})

TEAM_ITZTOMBER = DarkRP.createJob("C82.MPF.SECUTOR", {

	color = Color(51, 204, 204),
	model = {"models/retrime/metropolice/secutor.mdl"},
	description = "Элитный боец ГО",
	weapons = {"weapon_physgun", "weapon_cuff_elastic", "gmod_tool", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_ram", "tfa_magnum", "tfa_lmg", "tfa_shotgun", "tfa_psrl"},
	command = "itztomber",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) 
		return ply:SteamID() == "STEAM_0:1:190680623" or ply:IsSuperAdmin()
	end,
	ammo = {
		["357"] = 24,
		["ar2"] = 240,
		["buckshot"] = 35,
		["SniperPenetratedRound"] = 40
	},
	category = "Сельскохозяйственная шарага",
	PlayerLoadout = function(ply) ply:SetMaxHealth(200) ply:SetHealth(200) ply:SetMaxArmor(200) ply:SetArmor(200) end,
	price = 0,
	canchange = function(ply) return ply:Donator("silver") end

})

TEAM_MPF13 = DarkRP.createJob("C82.MPF.EPU", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/epu.mdl",
	description = "Элитный юнит Гражданской обороны",
	weapons = {"weapon_physgun", "weapon_cuff_elastic", "gmod_tool", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_ram"},
	command = "mpf13",
	max = 1,
	salary = 3400,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_magnum", "tfa_oicw", "tfa_shotgun"},

	ammo = {
		["357"] = 24,
		["ar2"] = 90,
		["buckshot"] = 35
	},
	category = "Гражданская оборона",
	PlayerDeath = function(ply, wep, ent)
		if ent:IsPlayer() and not ent:IsCombine() then
			ply:changeTeam(GAMEMODE.DefaultTeam, true, true)
		end
	end,
	PlayerLoadout = function(ply) ply:SetMaxHealth(200) ply:SetHealth(200) ply:SetArmor(100) end,
	price = 1000000,
	require = TEAM_MPF12

})

TEAM_MPF14 = DarkRP.createJob("C82.MPF.DVL", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/dvl.mdl",
	description = "Дивизионный лидер Гражданской обороны",
	weapons = {"weapon_physgun", "weapon_cuff_elastic", "gmod_tool", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_ram"},
	command = "mpf14",
	max = 1,
	salary = 3400,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_magnum", "tfa_oicw", "tfa_shotgun"},

	ammo = {
		["357"] = 24,
		["ar2"] = 120,
		["SMG1_Grenade"] = 1,
		["buckshot"] = 35
	},
	category = "Гражданская оборона",
	PlayerDeath = function(ply, wep, ent)
		if ent:IsPlayer() and not ent:IsCombine() then
			ply:changeTeam(GAMEMODE.DefaultTeam, true, true)
		end
	end,
	PlayerLoadout = function(ply) ply:SetMaxHealth(200) ply:SetHealth(200) ply:SetArmor(100) end,
	price = 1000000,
	require = TEAM_MPF13

})

TEAM_MPF15 = DarkRP.createJob("C82.MPF.SEC", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/sec.mdl",
	description = "Секторальный лидер Гражданской обороны",
	weapons = {"weapon_physgun", "weapon_cuff_elastic", "gmod_tool", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_ram"},
	command = "mpf15",
	max = 1,
	salary = 4200,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_magnum", "tfa_oicw", "tfa_shotgun"},

	ammo = {
		["357"] = 24,
		["ar2"] = 150,
		["SMG1_Grenade"] = 2,
		["buckshot"] = 35
	},
	category = "Гражданская оборона",
	PlayerDeath = function(ply, wep, ent)
		if ent:IsPlayer() and not ent:IsCombine() then
			ply:changeTeam(GAMEMODE.DefaultTeam, true, true)
		end
	end,
	PlayerLoadout = function(ply) ply:SetMaxHealth(230) ply:SetHealth(230) ply:SetArmor(100) end,
	price = 1000000,
	require = TEAM_MPF14

})

TEAM_MPF16 = DarkRP.createJob("C82.MPF.OWD", {

	color = Color(51, 204, 204),
	model = "models/retrime/metropolice/owd.mdl",
	description = "Диспетчер Гражданской обороны",
	weapons = {"weapon_cuff_elastic", "darkrp_stunstick", "darkrp_uidcard", "darkrp_search", "darkrp_ram"},
	command = "mpf16",
	max = 1,
	salary = 2500,
	admin = 0,
	vote = false,
	hasLicense = false,
	locker = {"tfa_pistol"},

	customCheck = function(ply) return ply:Donator("silver") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Silver, Gold и Platinum",
	ammo = {
		["pistol"] = 90,
	},
	category = "Гражданская оборона",
	PlayerDeath = function(ply, wep, ent)
		if ent:IsPlayer() and not ent:IsCombine() then
			ply:changeTeam(GAMEMODE.DefaultTeam, true, true)
		end
	end,
	PlayerLoadout = function(ply) ply:SetMaxHealth(130) ply:SetHealth(130) ply:SetArmor(100) end,
	price = 1000000,
	canchange = function(ply) return ply:Donator("silver") end

})

--
-- Categories
--
DarkRP.createCategory{

	name = "Гражданская oборона",
	categorises = "jobs",
	startExpanded = true,
	color = Color(51, 204, 204),
	canSee = function() return true end,
	sortOrder = 0

}

DarkRP.createCategory{

	name = "Гражданская оборона",
	categorises = "jobs",
	startExpanded = true,
	color = Color(51, 204, 204),
	canSee = function() return true end,
	sortOrder = 1

}

DarkRP.createCategory{

	name = "Сельскохозяйственная шарага",
	categorises = "jobs",
	startExpanded = true,
	color = Color(51, 204, 204),
	canSee = function() return true end,
	sortOrder = 1

}