--[[------------------------------------------------------------

	--------- ----------- ------ ----
	HAZARDOUS ENVIRONMENT COMBAT UNIT
	--------- ----------- ------ ----

------------------------------------------------------------]]--
TEAM_HECU1 = DarkRP.createJob("Новобранец HECU", {

	color = Color(75, 75, 75),
	model = "models/retrime/hecu/hecu_01.mdl",
	description = "Новобранец спецподразделения HECU",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_glock", "tfa_mp5sd"},
	command = "hecu1",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["pistol"] = 72,
		["smg1"] = 120
	},
	category = "Спецподразделение HECU",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) ply:SetSkin(math.random(0, 9)) end,
	price = 200000

})

TEAM_HECU2 = DarkRP.createJob("Боец HECU", {

	color = Color(75, 75, 75),
	model = "models/retrime/hecu/hecu_02.mdl",
	description = "Боец спецподразделения HECU",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_knife", "tfa_beretta", "tfa_m4a1"},
	command = "hecu2",
	max = 3,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["pistol"] = 60,
		["ar2"] = 150
	},
	category = "Спецподразделение HECU",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) ply:SetSkin(math.random(0, 9)) end,
	price = 300000,
	require = TEAM_HECU1

})

TEAM_HECU3 = DarkRP.createJob("Санитар HECU", {

	color = Color(75, 75, 75),
	model = "models/retrime/hecu/hecu_03.mdl",
	description = "Санитар спецподразделения HECU",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "darkrp_medkit", "tfa_knife", "tfa_beretta", "tfa_remington870"},
	command = "hecu3",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["pistol"] = 60,
		["buckshot"] = 80
	},
	category = "Спецподразделение HECU",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) ply:SetSkin(math.random(0, 9)) end,
	price = 500000,
	require = TEAM_HECU2

})

TEAM_HECU4 = DarkRP.createJob("Офицер HECU", {

	color = Color(75, 75, 75),
	model = "models/retrime/hecu/hecu_04.mdl",
	description = "Офицер спецподразделения HECU",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "darkrp_hackdevice", "tfa_knife", "tfa_magnum", "tfa_ar2", "tfa_l96"},
	command = "hecu4",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["357"] = 60,
		["ar2"] = 150,
		["SniperPenetratedRound"] = 20
	},
	category = "Спецподразделение HECU",
	PlayerLoadout = function(ply) ply:SetMaxHealth(200) ply:SetHealth(200) ply:SetArmor(100) end,
	price = 1000000,
	require = TEAM_HECU3

})

TEAM_HECU5 = DarkRP.createJob("Командир HECU", {

	color = Color(75, 75, 75),
	model = "models/retrime/hecu/hecu_05.mdl",
	description = "Командир спецподразделения HECU",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "darkrp_hackdevice", "tfa_knife", "tfa_magnum", "tfa_ar2", "tfa_l96", "tfa_rpg"},
	command = "hecu5",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:Donator("silver") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Silver, Gold и Platinum",
	ammo = {
		["357"] = 60,
		["ar2"] = 150,
		["SniperPenetratedRound"] = 20
	},
	category = "Спецподразделение HECU",
	PlayerLoadout = function(ply) ply:SetMaxHealth(230) ply:SetHealth(230) ply:SetArmor(100) ply:SetSkin(math.random(0, 9)) end,
	price = 2000000,
	require = TEAM_HECU4,
	canchange = function(ply) return ply:Donator("silver") end

})

TEAM_HECU6 = DarkRP.createJob("Сержант HECU", {

	color = Color(75, 75, 75),
	model = "models/retrime/hecu/hecu_06.mdl",
	description = "Сержант спецподразделения HECU",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_knife", "tfa_m249"},
	command = "hecu6",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:Donator("gold") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Gold и Platinum",
	ammo = {
		["ar2"] = 300
	},
	category = "Спецподразделение HECU",
	PlayerLoadout = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetArmor(100) end,
	canchange = function(ply) return ply:Donator("gold") end

})

TEAM_HECU7 = DarkRP.createJob("Шпион HECU", {

	color = Color(75, 75, 75),
	model = "models/retrime/hecu/hecu_04.mdl",
	description = "Шпион спецподразделения HECU",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "darkrp_disguise", "darkrp_hackdevice"},
	command = "hecu7",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:Donator("gold") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Gold и Platinum",
	category = "Спецподразделение HECU",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 1000000,
	canchange = function(ply) return ply:Donator("gold") end

})

--
-- Category
--
DarkRP.createCategory{

	name = "Спецподразделение HECU",
	categorises = "jobs",
	startExpanded = true,
	color = Color(75, 75, 75),
	canSee = function() return true end,
	sortOrder = 4

}