--[[------------------------------------------------------------

	----- -------- -----
	CIVIL WORKER'S UNION
	----- -------- -----

------------------------------------------------------------]]--
TEAM_CWU1 = DarkRP.createJob("Уборщик ГСР", {

	color = Color(204, 204, 153),
	model = {
		"models/retrime/group02/female_02.mdl",
		"models/retrime/group02/female_04.mdl",
		"models/retrime/group02/female_07.mdl",
		"models/retrime/group02/male_02.mdl",
		"models/retrime/group02/male_04.mdl",
		"models/retrime/group02/male_06.mdl",
		"models/retrime/group02/male_08.mdl"
	},
	description = "Уборщик Гражданского Союза Рабочих",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_cidcard"},
	command = "cwu1",
	max = 4,
	salary = 500,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Гражданский Союз Рабочих"

})

TEAM_CWU2 = DarkRP.createJob("Курьер ГСР", {

	color = Color(204, 204, 153),
	model = {
		"models/retrime/group02/female_02.mdl",
		"models/retrime/group02/female_04.mdl",
		"models/retrime/group02/female_07.mdl",
		"models/retrime/group02/male_02.mdl",
		"models/retrime/group02/male_04.mdl",
		"models/retrime/group02/male_06.mdl",
		"models/retrime/group02/male_08.mdl"
	},
	description = "Курьер Гражданского Союза Рабочих",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_cidcard"},
	command = "cwu2",
	max = 5,
	salary = 500,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Гражданский Союз Рабочих",
	price = 5000

})

TEAM_CWU3 = DarkRP.createJob("Повар ГСР", {

	color = Color(204, 204, 153),
	model = {
		"models/retrime/group02/male_01.mdl",
		"models/retrime/group02/male_03.mdl",
		"models/retrime/group02/male_05.mdl",
		"models/retrime/group02/male_07.mdl",
		"models/retrime/group02/male_09.mdl"
	},
	description = "Повар Гражданского Союза Рабочих",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_cidcard"},
	command = "cwu3",
	max = 2,
	salary = 500,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Гражданский Союз Рабочих",
	price = 15000,
	require = TEAM_CWU2

})

TEAM_CWU4 = DarkRP.createJob("Парамедик ГСР", {

	color = Color(204, 204, 153),
	model = {
		"models/retrime/group02/male_01.mdl",
		"models/retrime/group02/male_03.mdl",
		"models/retrime/group02/male_05.mdl",
		"models/retrime/group02/male_07.mdl",
		"models/retrime/group02/male_09.mdl"
	},
	description = "Парамедик Гражданского Союза Рабочих",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_cidcard", "darkrp_medkit"},
	command = "cwu4",
	max = 2,
	salary = 500,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Гражданский Союз Рабочих",
	price = 30000,
	require = TEAM_CWU3

})

TEAM_CWU5 = DarkRP.createJob("Фасовщик ГСР", {

	color = Color(204, 204, 153),
	model = {
		"models/retrime/worker_01.mdl",
		"models/retrime/worker_02.mdl"
	},
	description = "Фасовщик Гражданского Союза Рабочих",
	weapons = {"darkrp_cidcard"},
	command = "cwu5",
	max = 4,
	salary = 1300,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Гражданский Союз Рабочих",
	price = 50000,
	require = TEAM_CWU4

})
local cwuuuu = Vector( -2891.238281, -1173.854370, 181.744263 )
TEAM_CWU71 = DarkRP.createJob("Электрик ГСР", {

	color = Color(204, 204, 153),
	model = {
		"models/retrime/worker_01.mdl"
	},
	description = "Электрик Гражданского Союза Рабочих",
	weapons = {"darkrp_cidcard", "cityworker_pliers", "cityworker_wrench"},
	command = "cwu71",
	max = 4,
	salary = 1300,
	admin = 0,
	CSpawn = {
    cwuuuu,
    },
	vote = false,
	hasLicense = false,

	category = "Гражданский Союз Рабочих",
	price = 50000,
	require = TEAM_CWU4

})

TEAM_CWU6 = DarkRP.createJob("Глава ГСР", {

	color = Color(204, 204, 153),
	model = {
		"models/retrime/group02/male_01.mdl",
		"models/retrime/group02/male_03.mdl",
		"models/retrime/group02/male_05.mdl",
		"models/retrime/group02/male_07.mdl",
		"models/retrime/group02/male_09.mdl"
	},
	description = "Глава Гражданского Союза Рабочих",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_taxes", "darkrp_cidcard"},
	command = "cwu6",
	max = 1,
	salary = 2100,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Гражданский Союз Рабочих",
	price = 100000,
	require = TEAM_CWU5

})

TEAM_CWU7 = DarkRP.createJob("Мусорщик ГСР", {

	color = Color(204, 204, 153),
	model = {
		"models/retrime/worker_02.mdl"
	},
	description = "Мусорщик Гражданского Союза Рабочих",
	weapons = {"weapon_physgun", "gmod_tool", "ztm_trashcollector", "darkrp_cidcard", "darkrp_inventory"},
	command = "cwu7",
	max = 2,
	salary = 1000,
	admin = 0,
	vote = false,
	hasLicense = false,

	customCheck = function(ply) return ply:Donator("silver") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Silver, Gold и Platinum",
	category = "Гражданский Союз Рабочих",
	canchange = function(ply) return ply:Donator("silver") end

})

--
-- Category
--
DarkRP.createCategory{

	name = "Гражданский Союз Рабочих",
	categorises = "jobs",
	startExpanded = true,
	color = Color(204, 204, 153),
	canSee = function() return true end,
	sortOrder = 5

}