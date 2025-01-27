--[[------------------------------------------------------------

	-------- -- -----
	DIVISION OF DEATH
	-------- -- -----

------------------------------------------------------------]]--
TEAM_DOD1 = DarkRP.createJob("Рекрут DoD", {

	color = Color(153, 170, 181),
	model = "models/retrime/dod/dod_recruit.mdl",
	description = "Рекрут «Division of Death»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_galil"},
	command = "dod1",
	max = 6,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в DoD на этой должности",
	category = "Division of Death",
	sortOrder = 1,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	canchange = DoDCheck

})

TEAM_DOD2 = DarkRP.createJob("Боец DoD", {

	color = Color(153, 170, 181),
	model = "models/retrime/dod/dod_soldier.mdl",
	description = "Боец «Division of Death»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_aug_a1"},
	command = "dod2",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в DoD на этой должности",
	category = "Division of Death",
	sortOrder = 2,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	canchange = DoDCheck

})

TEAM_DOD3 = DarkRP.createJob("Инженер DoD", {

	color = Color(153, 170, 181),
	model = "models/retrime/dod/dod_engineer.mdl",
	description = "Инженер «Division of Death»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "darkrp_build", "tfa_remington870"},
	command = "dod3",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в DoD на этой должности",
	category = "Division of Death",
	sortOrder = 3,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	canchange = DoDCheck

})

TEAM_DOD4 = DarkRP.createJob("Глава DoD", {

	color = Color(153, 170, 181),
	model = "models/retrime/dod/dod_leader.mdl",
	description = "Глава «Division of Death»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_ar2", "tfa_magnum"},
	command = "dod4",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в DoD на этой должности",
	category = "Division of Death",
	sortOrder = 4,
	PlayerLoadout = function(ply) ply:SetMaxHealth(230) ply:SetHealth(230) ply:SetArmor(100) end,
	canchange = DoDCheck

})

TEAM_DOD5 = DarkRP.createJob("Снайпер DoD", {

	color = Color(153, 170, 181),
	model = "models/retrime/dod/dod_sniper.mdl",
	description = "Боец «Division of Death»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_l96"},
	command = "dod5",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в DoD на этой должности",
	category = "Division of Death",
	sortOrder = 2,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	canchange = DoDCheck

})

TEAM_DOD6 = DarkRP.createJob("Разведчик DoD", {

	color = Color(153, 170, 181),
	model = "models/retrime/dod/dod_girl.mdl",
	description = "Боец «Division of Death»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_trg"},
	command = "dod6",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в DoD на этой должности",
	category = "Division of Death",
	sortOrder = 2,
	PlayerLoadout = function(ply) ply:SetMaxArmor(130) ply:SetArmor(130) ply:SetJumpPower(330) ply:SetRunSpeed(360) end,
	canchange = DoDCheck

})

--
-- Category
--
DarkRP.createCategory{

	name = "Division of Death",
	categorises = "jobs",
	startExpanded = true,
	color = Color(153, 170, 181),
	canSee = function() return true end,
	sortOrder = 11

}