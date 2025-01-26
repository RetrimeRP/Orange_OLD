--[[------------------------------------------------------------

	-----
	GUILD
	-----

------------------------------------------------------------]]--
TEAM_GUILD1 = DarkRP.createJob("Оперативник NS", {

	color = Color(75, 107, 84),
	model = "models/retrime/guild/guild_01.mdl",
	description = "Оперативник гильдии «Northern Syndicate»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_akm"},
	command = "guild1",
	max = 5,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Гильдия NS",
	sortOrder = 1,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	canchange = GuildCheck

})

TEAM_GUILD2 = DarkRP.createJob("Сепаратист NS", {

	color = Color(75, 107, 84),
	model = "models/retrime/guild/guild_02.mdl",
	description = "Оперативник гильдии «Northern Syndicate»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "darkrp_disguise", "darkrp_hackdevice"},
	command = "guild2",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в NS на этой должности",
	category = "Гильдия NS",
	sortOrder = 2,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	canchange = GuildCheck

})

TEAM_GUILD3 = DarkRP.createJob("Медик NS", {

	color = Color(75, 107, 84),
	model = "models/retrime/guild/guild_03.mdl",
	description = "Медик гильдии «Northern Syndicate»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "darkrp_medkit", "tfa_grach", "tfa_mp153"},
	command = "guild3",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в NS на этой должности",
	category = "Гильдия NS",
	sortOrder = 3,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	canchange = GuildCheck

})

TEAM_GUILD4 = DarkRP.createJob("Вербовщик NS", {

	color = Color(75, 107, 84),
	model = "models/retrime/guild/guild_04.mdl",
	description = "Вербовщик гильдии «Northern Syndicate»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_g3sg1"},
	command = "guild4",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в NS на этой должности",
	category = "Гильдия NS",
	sortOrder = 4,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	canchange = GuildCheck

})

TEAM_GUILD5 = DarkRP.createJob("Джаггернаут NS", {

	color = Color(75, 107, 84),
	model = "models/retrime/guild/guild_05.mdl",
	description = "Джаггернаут гильдии «Northern Syndicate»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_pkm"},
	command = "guild5",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в NS на этой должности",
	category = "Гильдия NS",
	sortOrder = 5,
	PlayerLoadout = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetArmor(100) end,
	canchange = GuildCheck

})

TEAM_GUILD6 = DarkRP.createJob("Глава NS", {

	color = Color(75, 107, 84),
	model = "models/retrime/guild/guild_06.mdl",
	description = "Глава гильдии «Northern Syndicate»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_ar2", "tfa_psg"},
	command = "guild6",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в NS на этой должности",
	category = "Гильдия NS",
	sortOrder = 6,
	PlayerLoadout = function(ply) ply:SetMaxHealth(230) ply:SetHealth(230) ply:SetArmor(100) end,
	canchange = GuildCheck

})

TEAM_GUILD7 = DarkRP.createJob("Убийца NS", {

	color = Color(75, 107, 84),
	model = "models/retrime/guild/guild_07.mdl",
	description = "Убийца гильдии «Northern Syndicate»",
	weapons = {"weapon_physgun", "weapon_cuff_rope", "gmod_tool", "darkrp_inventory", "tfa_mp5sd", "tfa_sv98"},
	command = "guild7",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в NS на этой должности",
	category = "Гильдия NS",
	sortOrder = 7,
	PlayerLoadout = function(ply) ply:SetMaxHealth(130) ply:SetHealth(130) ply:SetArmor(100) ply:SetJumpPower(330) ply:SetRunSpeed(360) end,
	canchange = GuildCheck

})

TEAM_GUILD8 = DarkRP.createJob("Торговец NS", {

	color = Color(75, 107, 84),
	model = "models/retrime/guild/guild_08.mdl",
	description = "Торговец гильдии «Northern Syndicate»",
	weapons = {"weapon_physgun", "gmod_tool", "tfa_magnum", "tfa_ak74u"},
	command = "guild8",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в NS на этой должности",
	category = "Гильдия NS",
	sortOrder = 8,
	PlayerLoadout = function(ply) ply:SetArmor(100) end,
	canchange = GuildCheck

})

TEAM_GUILD9 = DarkRP.createJob("Надзиратель NS", {

	color = Color(75, 107, 84),
	model = "models/retrime/guild/guild_09.mdl",
	description = "Надзиратель гильдии «Northern Syndicate»",
	weapons = {"weapon_physgun", "weapon_cuff_rope", "gmod_tool", "darkrp_inventory", "darkrp_stunstick", "tfa_oicw", "bkeypads_access_logs"},
	command = "guild9",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в NS на этой должности",
	ammo = {
		["SMG1_Grenade"] = 1
	},
	category = "Гильдия NS",
	sortOrder = 9,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) end,
	canchange = GuildCheck

})

TEAM_GUILD10 = DarkRP.createJob("Егерь NS", {

	color = Color(75, 107, 84),
	model = "models/retrime/guild/guild_10.mdl",
	description = "Егерь гильдии «Northern Syndicate»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_shotgun", "tfa_sv98"},
	command = "guild10",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в NS на этой должности",
	category = "Гильдия NS",
	sortOrder = 10,
	PlayerLoadout = function(ply) ply:SetMaxHealth(160) ply:SetHealth(160) ply:SetArmor(100) ply:SetRunSpeed(320) end,
	canchange = GuildCheck

})

TEAM_GUILD11 = DarkRP.createJob("Элита NS", {

	color = Color(75, 107, 84),
	model = "models/retrime/guild/guild_10.mdl",
	description = "Элита гильдии «Northern Syndicate»",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory", "tfa_ar2", "tfa_sv98"},
	command = "guild11",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,


	CustomCheckFailMsg = "Вам запрещается состоять в NS на этой должности",
	category = "Гильдия NS",
	sortOrder = 11,
	PlayerLoadout = function(ply) ply:SetMaxHealth(200) ply:SetHealth(200) ply:SetArmor(100) end,
	canchange = GuildCheck

})

--
-- Category
--
DarkRP.createCategory{

	name = "Гильдия NS",
	categorises = "jobs",
	startExpanded = true,
	color = Color(75, 107, 84),
	canSee = function() return true end,
	sortOrder = 9

}