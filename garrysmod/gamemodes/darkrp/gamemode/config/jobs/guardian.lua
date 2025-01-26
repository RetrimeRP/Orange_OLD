--[[------------------------------------------------------------

	--------
	GUARDIAN
	--------

------------------------------------------------------------]]--
TEAM_GUARDIAN1 = DarkRP.createJob("C82.GUARDIAN.OWS", {

	color = Color(127, 28, 1),
	model = "models/Player/com_night_elite.mdl",
	description = "Суперсолдат отряда Guardian",
	weapons = {"darkrp_search", "darkrp_shield_02", "tfa_pistol", "tfa_smg"},
	command = "guardian1",
	max = 6,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	CustomCheckFailMsg = "Вам запрещается состоять в Guardian на этой должности",
	ammo = {
		["pistol"] = 54,
		["smg1"] = 180,
		["SMG1_Grenade"] = 1
	},
	category = "Отряд Guardian",
	sortOrder = 1,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end

})

TEAM_GUARDIAN2 = DarkRP.createJob("C82.GUARDIAN.XRAY", {

	color = Color(127, 28, 1),
	model = "models/Player/com_night_elite.mdl",
	description = "Медик отряда Guardian",
	weapons = {"darkrp_search", "tfa_pistol", "tfa_psg"},
	command = "guardian2",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	CustomCheckFailMsg = "Вам запрещается состоять в Guardian на этой должности",
	ammo = {
		["pistol"] = 54,
		["buckshot"] = 70
	},
	category = "Отряд Guardian",
	sortOrder = 2,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end

})

TEAM_GUARDIAN3 = DarkRP.createJob("C82.GUARDIAN.OWC", {

	color = Color(127, 28, 1),
	model = "models/Player/com_night_elite.mdl",
	description = "Командир отряда Guardian",
	weapons = {"darkrp_search", "darkrp_shield_02", "tfa_pistol", "tfa_oicw"},
	command = "guardian3",
	max = 4,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	CustomCheckFailMsg = "Вам запрещается состоять в Guardian на этой должности",
	ammo = {
		["pistol"] = 54,
		["ar2"] = 120,
		["SMG1_Grenade"] = 1
	},
	category = "Отряд Guardian",
	sortOrder = 3,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end

})

TEAM_GUARDIAN4 = DarkRP.createJob("C82.GUARDIAN.EOW", {

	color = Color(127, 28, 1),
	model = "models/Player/com_super_night_elite.mdl",
	description = "Элита отряда Guardian",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_search", "darkrp_shield_02", "tfa_magnum", "tfa_ar2"},
	command = "guardian4",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	CustomCheckFailMsg = "Вам запрещается состоять в Guardian на этой должности",
	ammo = {
		["357"] = 24,
		["ar2"] = 180,
		["AR2AltFire"] = 1
	},
	category = "Отряд Guardian",
	sortOrder = 4,
	PlayerLoadout = function(ply) ply:SetMaxHealth(200) ply:SetHealth(200) ply:SetArmor(100) end

})

TEAM_GUARDIAN5 = DarkRP.createJob("C82.GUARDIAN.TECH", {

	color = Color(127, 28, 1),
	model = "models/Player/com_night_elite.mdl",
	description = "Инженер отряда Guardian",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_search", "darkrp_build", "tfa_pistol", "tfa_shotgun"},
	command = "guardian5",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	CustomCheckFailMsg = "Вам запрещается состоять в Guardian на этой должности",
	ammo = {
		["pistol"] = 54,
		["buckshot"] = 18
	},
	category = "Отряд Guardian",
	sortOrder = 5,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end

})

TEAM_GUARDIAN6 = DarkRP.createJob("C82.GUARDIAN.INSP", {

	color = Color(127, 28, 1),
	model = "models/Player/com_super_night_elite.mdl",
	description = "Инспектор отряда Guardian",
	weapons = {"darkrp_search", "tfa_ar2"},
	command = "guardian6",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	CustomCheckFailMsg = "Вам запрещается состоять в Guardian на этой должности",
	ammo = {
		["ar2"] = 120
	},
	category = "Отряд Guardian",
	sortOrder = 6,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end

})

--
-- Category
--
DarkRP.createCategory{

	name = "Отряд Guardian",
	categorises = "jobs",
	startExpanded = true,
	color = Color(127, 28, 1),
	canSee = function() return true end,
	sortOrder = 10

}