--[[------------------------------------------------------------

	--------
	CITIZENS
	--------

------------------------------------------------------------]]--
TEAM_CITIZEN = DarkRP.createJob("Гражданин", {

	color = Color(20, 150, 20),
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
	description = "Обычный гражданин",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_cidcard"},
	command = "citizen",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Гражданские"

})

TEAM_LOYALIST1 = DarkRP.createJob("Лоялист", {

	color = Color(20, 150, 20),
	model = {
		"models/retrime/group01l/male_01.mdl",
		"models/retrime/group01l/male_02.mdl",
		"models/retrime/group01l/male_03.mdl",
		"models/retrime/group01l/male_04.mdl",
		"models/retrime/group01l/male_05.mdl",
		"models/retrime/group01l/male_06.mdl",
		"models/retrime/group01l/male_07.mdl",
		"models/retrime/group01l/male_08.mdl",
		"models/retrime/group01l/male_09.mdl"
	},
	description = "Участник сообщества лоялистов",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_cidcard"},
	command = "loyalist1",
	max = 6,
	salary = 2100,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Гражданские",
	price = 200000

})

TEAM_LOYALIST2 = DarkRP.createJob("Лоялист смотритель", {

	color = Color(20, 150, 20),
	model = {
		"models/retrime/group01l/male_01.mdl",
		"models/retrime/group01l/male_02.mdl",
		"models/retrime/group01l/male_03.mdl",
		"models/retrime/group01l/male_04.mdl",
		"models/retrime/group01l/male_05.mdl",
		"models/retrime/group01l/male_06.mdl",
		"models/retrime/group01l/male_07.mdl",
		"models/retrime/group01l/male_08.mdl",
		"models/retrime/group01l/male_09.mdl"
	},
	description = "Смотритель сообщества лоялистов",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_cidcard"},
	command = "loyalist2",
	max = 2,
	salary = 2100,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Гражданские",
	price = 300000,
	require = TEAM_LOYALIST1

})

TEAM_LOYALIST3 = DarkRP.createJob("Лоялист комендант", {

	color = Color(20, 150, 20),
	model = {
		"models/retrime/group01l/male_01.mdl",
		"models/retrime/group01l/male_02.mdl",
		"models/retrime/group01l/male_03.mdl",
		"models/retrime/group01l/male_04.mdl",
		"models/retrime/group01l/male_05.mdl",
		"models/retrime/group01l/male_06.mdl",
		"models/retrime/group01l/male_07.mdl",
		"models/retrime/group01l/male_08.mdl",
		"models/retrime/group01l/male_09.mdl"
	},
	description = "Руководитель сообщества лоялистов",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_cidcard", "tfa_pistol"},
	command = "loyalist3",
	max = 1,
	salary = 2500,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["pistol"] = 90
	},
	category = "Гражданские",
	price = 500000,
	require = TEAM_LOYALIST2

})

TEAM_ADMIN = DarkRP.createJob("Администратор города", {

	color = Color(20, 150, 20),
	model = "models/retrime/administrator.mdl",
	description = "Администратор Сити 82",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_cidcard", "tfa_magnum"},
	command = "admin",
	max = 1,
	salary = 3400,
	admin = 0,
	vote = false,
	hasLicense = false,

	ammo = {
		["357"] = 30
	},
	category = "Гражданские",
	PlayerDeath = function(ply, wep, ent)
		if ent:IsPlayer() and not ent:IsCombine() then
			ply:changeTeam(GAMEMODE.DefaultTeam, true, true)
		end
	end,
	price = 1000000,
	require = TEAM_LOYALIST3

})

TEAM_GMAN = DarkRP.createJob("G-Man", {

	color = Color(20, 150, 20),
	model = "models/player/gman_high.mdl",
	description = "Информация была засекречена",
	weapons = {},
	command = "gman",
	max = 1,
	salary = 10000,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:Donator("platinum") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Platinum",
	category = "Гражданские",
	PlayerLoadout = function(ply) ply:GodEnable() ply:SetHealth(99999) ply:SetJumpPower(300) ply:SetRunSpeed(900) end,
	price = 6000000,
	canchange = function(ply) return ply:Donator("platinum") end

})

--
-- Category
--
DarkRP.createCategory{

	name = "Гражданские",
	categorises = "jobs",
	startExpanded = true,
	color = Color(20, 150, 20),
	canSee = function() return true end,
	sortOrder = 6

}