local GAMEMODE = GAMEMODE or GM

--[[------------------------------------------------------------

	-----
	OTHER
	-----

------------------------------------------------------------]]--
TEAM_ARRIVAL = DarkRP.createJob("Прибывший", {

	color = Color(20, 150, 20),
	model = {
		"models/retrime/group01/female_01.mdl",
		"models/retrime/group01/female_02.mdl",
		"models/retrime/group01/female_03.mdl",
		"models/retrime/group01/female_04.mdl",
		"models/retrime/group01/male_01.mdl",
		"models/retrime/group01/male_02.mdl",
		"models/retrime/group01/male_03.mdl",
		"models/retrime/group01/male_04.mdl",
	},
	description = "Прибывший в город",
	weapons = {"darkrp_ticket", "darkrp_cidcard"},
	command = "arrival",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	PlayerLoadout = function(ply) ply:SetRunSpeed(100) return true end

})

TEAM_ZOMBIE = DarkRP.createJob("Зомби", {

	color = Color(150, 20, 20),
	model = {
		"models/player/zombie_classic.mdl",
		"models/player/zombie_soldier.mdl",
		"models/player/zombie_fast.mdl",
	},
	description = "ЗОНДБЕЕЕЕЕЕЕЕ",
	weapons = {"weapon_fists"},
	command = "zombie",
	max = 0,
	salary = 4000,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:IsSuperAdmin() end,
	CustomCheckFailMsg = "Работа доступна только для альберта и морриса",
	PlayerLoadout = function(ply) ply:GodEnable() ply:SetHealth(2000) end

})

TEAM_FSG = DarkRP.createJob("FSG", {

	color = Color(255, 102, 51),
	model = "models/retrime/staff.mdl",
	description = "Работа администрации",
	weapons = {"weapon_physgun", "gmod_tool", "bkeypads_access_logs", "gas_log_scanner"},
	command = "fsg",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:Staff() end,
	CustomCheckFailMsg = "Работа доступна только для администрации сервера",
	PlayerLoadout = function(ply) ply:GodEnable() ply:SetHealth(99999) end

})

--
-- Door Groups
--
AddDoorGroup("Альянс",

	TEAM_MPF1,
	TEAM_MPF2,
	TEAM_MPF3,
	TEAM_MPF4,
	TEAM_MPF5,
	TEAM_MPF6,
	TEAM_MPF7,
	TEAM_MPF8,
	TEAM_MPF9,
	TEAM_MPF10,
	TEAM_MPF11,
	TEAM_MPF12,
	TEAM_MPF13,
	TEAM_MPF14,
	TEAM_MPF15,
	TEAM_MPF16,
	TEAM_SYNTH2,

	TEAM_ITZTOMBER,

	TEAM_OTA1,
	TEAM_OTA2,
	TEAM_OTA3,
	TEAM_OTA4,
	TEAM_OTA5,
	TEAM_OTA6,
	TEAM_OTA7,
	TEAM_OTA8,
	TEAM_OTA9,
	TEAM_OTA10,

	TEAM_SYNTH1,

	TEAM_ADMIN,

	TEAM_GUARDIAN1,
	TEAM_GUARDIAN2,
	TEAM_GUARDIAN3,
	TEAM_GUARDIAN4,
	TEAM_GUARDIAN5,
	TEAM_GUARDIAN6

)

AddDoorGroup("Сопротивление",

	TEAM_RESISTANCE1,
	TEAM_RESISTANCE2,
	TEAM_RESISTANCE3,
	TEAM_RESISTANCE4,
	TEAM_RESISTANCE5,
	TEAM_RESISTANCE6,
	TEAM_RESISTANCE7,
	TEAM_RESISTANCE8,
	TEAM_RESISTANCE9,
	TEAM_DONATE22,
	TEAM_DONATE23,

	TEAM_HECU1,
	TEAM_HECU2,
	TEAM_HECU3,
	TEAM_HECU4,
	TEAM_HECU5,
	TEAM_HECU6,
	TEAM_HECU7

)

AddDoorGroup("Гражданский Союз Рабочих",

	TEAM_CWU1,
	TEAM_CWU2,
	TEAM_CWU3,
	TEAM_CWU4,
	TEAM_CWU5,
	TEAM_CWU6,
	TEAM_CWU7,
	TEAM_CWU71

)

AddDoorGroup("Беженцы",

	TEAM_REFUGEE

)

AddDoorGroup("Гильдия NS",

	TEAM_GUILD1,
	TEAM_GUILD2,
	TEAM_GUILD3,
	TEAM_GUILD4,
	TEAM_GUILD5,
	TEAM_GUILD6,
	TEAM_GUILD7,
	TEAM_GUILD8,
	TEAM_GUILD9,
	TEAM_GUILD10,
	TEAM_GUILD11,
	TEAM_DOD1,
	TEAM_DOD2,
	TEAM_DOD3,
	TEAM_DOD4,
	TEAM_DOD5,
	TEAM_DOD6

)

--
-- Group Chats
--
DarkRP.createGroupChat(

	TEAM_MPF1,
	TEAM_MPF2,
	TEAM_MPF3,
	TEAM_MPF4,
	TEAM_MPF5,
	TEAM_MPF6,
	TEAM_MPF7,
	TEAM_MPF8,
	TEAM_MPF9,
	TEAM_MPF10,
	TEAM_MPF11,
	TEAM_MPF12,
	TEAM_MPF13,
	TEAM_MPF14,
	TEAM_MPF15,
	TEAM_MPF16,

	TEAM_ITZTOMBER,

	TEAM_OTA1,
	TEAM_OTA2,
	TEAM_SYNTH2,
	TEAM_OTA3,
	TEAM_OTA4,
	TEAM_OTA5,
	TEAM_OTA6,
	TEAM_OTA7,
	TEAM_OTA8,
	TEAM_OTA9,
	TEAM_OTA10,

	TEAM_SYNTH1,

	TEAM_ADMIN,

	TEAM_GUARDIAN1,
	TEAM_GUARDIAN2,
	TEAM_GUARDIAN3,
	TEAM_GUARDIAN4,
	TEAM_GUARDIAN5,
	TEAM_GUARDIAN6

)

DarkRP.createGroupChat(

	TEAM_RESISTANCE1,
	TEAM_RESISTANCE2,
	TEAM_RESISTANCE3,
	TEAM_RESISTANCE4,
	TEAM_RESISTANCE5,
	TEAM_RESISTANCE6,
	TEAM_RESISTANCE7,
	TEAM_RESISTANCE8,
	TEAM_DONATE22,
	TEAM_DONATE23,
	TEAM_RESISTANCE9,

	TEAM_HECU1,
	TEAM_HECU2,
	TEAM_HECU3,
	TEAM_HECU4,
	TEAM_HECU5,
	TEAM_HECU6,
	TEAM_HECU7

)

DarkRP.createGroupChat(

	TEAM_CWU1,
	TEAM_CWU2,
	TEAM_CWU3,
	TEAM_CWU4,
	TEAM_CWU5,
	TEAM_CWU6,
	TEAM_CWU7,
	TEAM_CWU71

)

DarkRP.createGroupChat(

	TEAM_GUILD1,
	TEAM_GUILD2,
	TEAM_GUILD3,
	TEAM_GUILD4,
	TEAM_GUILD5,
	TEAM_GUILD6,
	TEAM_GUILD7,
	TEAM_GUILD8,
	TEAM_GUILD9,
	TEAM_GUILD10,
	TEAM_GUILD11,
	TEAM_DOD1,
	TEAM_DOD2,
	TEAM_DOD3,
	TEAM_DOD4,
	TEAM_DOD5,
	TEAM_DOD6

)

--
-- Default Team
--
GAMEMODE.DefaultTeam = TEAM_ARRIVAL

--
-- Civil Protection
--
GAMEMODE.CivilProtection = {

	[TEAM_MPF1] = true,
	[TEAM_MPF2] = true,
	[TEAM_MPF3] = true,
	[TEAM_MPF4] = true,
	[TEAM_MPF5] = true,
	[TEAM_MPF6] = true,
	[TEAM_MPF7] = true,
	[TEAM_MPF8] = true,
	[TEAM_MPF9] = true,
	[TEAM_SYNTH2] = true,
	[TEAM_MPF10] = true,
	[TEAM_MPF11] = true,
	[TEAM_MPF12] = true,
	[TEAM_MPF13] = true,
	[TEAM_MPF14] = true,
	[TEAM_MPF15] = true,
	[TEAM_MPF16] = true,

	[TEAM_ITZTOMBER] = true,

	[TEAM_OTA1] = true,
	[TEAM_OTA2] = true,
	[TEAM_OTA3] = true,
	[TEAM_OTA4] = true,
	[TEAM_OTA5] = true,
	[TEAM_OTA6] = true,
	[TEAM_OTA7] = true,
	[TEAM_OTA8] = true,
	[TEAM_OTA9] = true,
	[TEAM_OTA10] = true,

	[TEAM_GUARDIAN1] = true,
	[TEAM_GUARDIAN2] = true,
	[TEAM_GUARDIAN3] = true,
	[TEAM_GUARDIAN4] = true,
	[TEAM_GUARDIAN5] = true,
	[TEAM_GUARDIAN6] = true,

	[TEAM_FSG] = false

}

--
-- Category
--
DarkRP.createCategory{

	name = "Other",
	categorises = "jobs",
	startExpanded = true,
	color = Color(255, 102, 51),
	canSee = function() return true end,
	sortOrder = 255

}

DarkRP.createCategory{

	name = "Личные профессии",
	categorises = "jobs",
	startExpanded = true,
	color = Color(255, 255, 255),
	canSee = function() return true end,
	sortOrder = 256

}