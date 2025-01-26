--[[------------------------------------------------------------

	--------- ---------- ---
	OVERWATCH TRANSHUMAN ARM
	--------- ---------- ---

------------------------------------------------------------]]--
TEAM_OTA1 = DarkRP.createJob("C82.OTA.ECHO", {

	color = Color(51, 204, 204),
	model = "models/retrime/overwatch/echo.mdl",
	description = "Суперсолдат Сверхчеловеческого отдела",
	weapons = {"darkrp_search", "darkrp_ram", "tfa_grenade", "tfa_smg"},
	command = "ota1",
	max = 2,
	salary = 2100,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["grenade"] = 2,
		["smg1"] = 180
	},
	category = "Сверхчеловеческий отдел",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 400000

})

TEAM_OTA2 = DarkRP.createJob("C82.OTA.RIOT", {

	color = Color(51, 204, 204),
	model = "models/retrime/overwatch/riot.mdl",
	description = "Внегородской суперсолдат Сверхчеловеческого отдела",
	weapons = {"darkrp_search", "darkrp_ram", "tfa_grenade", "tfa_oicw"},
	command = "ota2",
	max = 2,
	salary = 2100,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["grenade"] = 2,
		["ar2"] = 120,
		["SMG1_Grenade"] = 2
	},
	category = "Сверхчеловеческий отдел",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 600000

})

TEAM_OTA3 = DarkRP.createJob("C82.OTA.XRAY", {

	color = Color(51, 204, 204),
	model = "models/retrime/overwatch/xray.mdl",
	description = "Медик суперсолдат Сверхчеловеческого отдела",
	weapons = {"darkrp_search", "darkrp_ram", "tfa_psg"},
	command = "ota3",
	max = 1,
	salary = 2100,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["buckshot"] = 70
	},
	category = "Сверхчеловеческий отдел",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 600000

})

TEAM_OTA4 = DarkRP.createJob("C82.OTA.MACE", {

	color = Color(51, 204, 204),
	model = "models/retrime/overwatch/mace.mdl",
	description = "Суперсолдат с дробовиком Сверхчеловеческого отдела",
	weapons = {"darkrp_search", "darkrp_shield_02", "darkrp_ram", "tfa_shotgun"},
	command = "ota4",
	max = 2,
	salary = 2100,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["buckshot"] = 18
	},
	category = "Сверхчеловеческий отдел",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	price = 400000

})

TEAM_OTA5 = DarkRP.createJob("C82.OTA.KNIGHT", {

	color = Color(51, 204, 204),
	model = "models/retrime/overwatch/knight.mdl",
	description = "Элитный суперсолдат Сверхчеловеческого отдела",
	weapons = {"darkrp_search", "darkrp_ram", "tfa_ar2"},
	command = "ota5",
	max = 1,
	salary = 3400,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["ar2"] = 150,
		["AR2AltFire"] = 1
	},
	category = "Сверхчеловеческий отдел",
	PlayerLoadout = function(ply) ply:SetMaxHealth(200) ply:SetHealth(200) ply:SetArmor(100) end,
	price = 2000000

})

TEAM_OTA6 = DarkRP.createJob("C82.OTA.KING", {

	color = Color(51, 204, 204),
	model = "models/retrime/overwatch/king.mdl",
	description = "Командир суперсолдат Сверхчеловеческого отдела",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_search", "darkrp_shield_03", "darkrp_ram", "tfa_magnum", "tfa_ar2", "tfa_psg", "tfa_lmg"},
	command = "ota6",
	max = 1,
	salary = 4200,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:Donator("platinum") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Platinum",
	ammo = {
		["357"] = 24,
		["ar2"] = 300,
		["AR2AltFire"] = 2,
		["buckshot"] = 35
	},
	category = "Сверхчеловеческий отдел",
	PlayerLoadout = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetArmor(100) ply:SetRunSpeed(200) end,
	price = 6000000,
	require = TEAM_OTA5,
	canchange = function(ply) return ply:Donator("platinum") end

})

TEAM_OTA7 = DarkRP.createJob("C82.OTA.HEAVY", {

	color = Color(51, 204, 204),
	model = "models/retrime/overwatch/heavy.mdl",
	description = "Суперсолдат с тяжелой броней Сверхчеловеческого отдела",
	weapons = {"darkrp_search", "darkrp_shield_02", "darkrp_ram", "tfa_lmg"},
	command = "ota7",
	max = 1,
	salary = 3400,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:Donator("gold") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Gold и Platinum",
	ammo = {
		["ar2"] = 180
	},
	category = "Сверхчеловеческий отдел",
	PlayerLoadout = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetArmor(100) ply:SetRunSpeed(200) end,
	canchange = function(ply) return ply:Donator("gold") end

})

TEAM_OTA8 = DarkRP.createJob("C82.OTA.SOW", {

	color = Color(51, 204, 204),
	model = "models/retrime/overwatch/sow.mdl",
	description = "Снайпер суперсолдат Сверхчеловеческого отдела",
	weapons = {"darkrp_search", "darkrp_ram", "tfa_smg", "tfa_psr"},
	command = "ota8",
	max = 1,
	salary = 3400,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:Donator("gold") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Gold и Platinum",
	ammo = {
		["smg1"] = 120,
		["SniperPenetratedRound"] = 20
	},
	category = "Сверхчеловеческий отдел",
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	canchange = function(ply) return ply:Donator("gold") end

})

TEAM_OTA9 = DarkRP.createJob("C82.OTA.ASSASSIN", {

	color = Color(51, 204, 204),
	model = "models/retrime/overwatch/assassin.mdl",
	description = "Суперсолдат убийца Сверхчеловеческого отдела",
	weapons = {"darkrp_search", "darkrp_ram", "tfa_psrl"},
	command = "ota9",
	max = 1,
	salary = 3400,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:Donator("gold") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Gold и Platinum",
	ammo = {
		["SniperPenetratedRound"] = 40
	},
	category = "Сверхчеловеческий отдел",
	PlayerLoadout = function(ply) ply:SetMaxHealth(130) ply:SetHealth(130) ply:SetArmor(100) ply:SetJumpPower(330) ply:SetRunSpeed(360) end,
	canchange = function(ply) return ply:Donator("gold") end

})

TEAM_OTA10 = DarkRP.createJob("C82.OTA.ORDINAL", {

	color = Color(51, 204, 204),
	model = "models/retrime/overwatch/ordinal.mdl",
	description = "Офицер суперсолдат Сверхчеловеческого отдела",
	weapons = {"darkrp_search", "darkrp_ram", "tfa_ar2", "tfa_shotgun"},
	command = "ota10",
	max = 1,
	salary = 3400,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["ar2"] = 120,
		["buckshot"] = 18
	},
	category = "Сверхчеловеческий отдел",
	PlayerLoadout = function(ply) ply:SetMaxHealth(200) ply:SetHealth(200) ply:SetArmor(100) end,
	price = 2000000

})

--
-- Category
--
DarkRP.createCategory{

	name = "Сверхчеловеческий отдел",
	categorises = "jobs",
	startExpanded = true,
	color = Color(51, 204, 204),
	canSee = function() return true end,
	sortOrder = 2

}