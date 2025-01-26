--[[------------------------------------------------------------

	-------
	BANDITS
	-------

------------------------------------------------------------]]--
TEAM_BANDIT = DarkRP.createJob("Бандит", {

	color = Color(20, 150, 20),
	model = {
		"models/retrime/group02b/male_01.mdl",
		"models/retrime/group02b/male_02.mdl",
		"models/retrime/group02b/male_03.mdl",
		"models/retrime/group02b/male_04.mdl",
		"models/retrime/group02b/male_05.mdl"
	},
	description = "Представитель бандитского сообщества",
	weapons = {"weapon_physgun", "gmod_tool"},
	command = "bandit",
	max = 6,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Бандиты",
	PlayerLoadout = function(ply) ply:SetSkin(math.random(0, 3)) end,
	price = 5000

})

TEAM_BOSS = DarkRP.createJob("Пахан", {

	color = Color(20, 150, 20),
	model = {
		"models/retrime/group02b/male_01.mdl",
		"models/retrime/group02b/male_02.mdl",
		"models/retrime/group02b/male_03.mdl",
		"models/retrime/group02b/male_04.mdl",
		"models/retrime/group02b/male_05.mdl"
	},
	description = "Пахан бандитского сообщества",
	weapons = {"weapon_physgun", "gmod_tool"},
	command = "boss",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Бандиты",
	PlayerLoadout = function(ply) ply:SetMaxHealth(130) ply:SetHealth(130) ply:SetSkin(math.random(0, 3)) end,
	price = 25000

})

TEAM_SMUGGLER = DarkRP.createJob("Контрабандист", {

	color = Color(20, 150, 20),
	model = {
		"models/retrime/group02b/male_01.mdl",
		"models/retrime/group02b/male_02.mdl",
		"models/retrime/group02b/male_03.mdl",
		"models/retrime/group02b/male_04.mdl",
		"models/retrime/group02b/male_05.mdl"
	},
	description = "Контрабандист бандитского сообщества",
	weapons = {"weapon_physgun", "gmod_tool"},
	command = "smuggler",
	max = 1,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Бандиты",
	PlayerLoadout = function(ply) ply:SetSkin(math.random(0, 3)) end,
	price = 20000

})

TEAM_BURGLAR = DarkRP.createJob("Вор", {

	color = Color(20, 150, 20),
	model = {
		"models/retrime/group02b/male_01.mdl",
		"models/retrime/group02b/male_02.mdl",
		"models/retrime/group02b/male_03.mdl",
		"models/retrime/group02b/male_04.mdl",
		"models/retrime/group02b/male_05.mdl"
	},
	description = "Вор бандитского сообщества",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_lockpick"},
	command = "burglar",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Бандиты",
	PlayerLoadout = function(ply) ply:SetSkin(math.random(0, 3)) end,
	price = 10000

})

--
-- Category
--
DarkRP.createCategory{

	name = "Бандиты",
	categorises = "jobs",
	startExpanded = true,
	color = Color(20, 150, 20),
	canSee = function() return true end,
	sortOrder = 7

}