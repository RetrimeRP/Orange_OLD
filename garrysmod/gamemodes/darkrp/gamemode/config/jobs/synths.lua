TEAM_SYNTH1 = DarkRP.createJob("C82.SYNTH.CREAMOR", {
	color = Color(51, 204, 204),
	model = "models/retrime/orange/other/cremator_01.mdl",
	description = "Уборщик трупов",
	weapons = {"weapon_immolator"},
	command = "synth1",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	-- darkrp
	category = "Синтеты",
	sortOrder = 1,
	PlayerLoadout = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetMaxArmor(300) ply:SetArmor(300) ply:SetWalkSpeed(100) ply:SetRunSpeed(100) end,

	-- retrime
	price = 8000000
})

DarkRP.createCategory{
	name = "Синтеты",
	categorises = "jobs",
	startExpanded = true,
	color = Color(51, 204, 204),
	canSee = function() return true end,
	sortOrder = 12
}
local stalkeryobani = Vector( 1615.101807, 3530.753906, 29.688068 )

TEAM_SYNTH2 = DarkRP.createJob("C82.SYNTH.STALKER", {
	color = Color(51, 204, 204),
	model = "models/player/zelpa/stalker.mdl",
	description = "Чинит терминалы альянса",
	weapons = {""},
	command = "synth2",
	max = 2,
	salary = 0,
	admin = 0,
	CSpawn = {
		stalkeryobani,
	},
	vote = false,
	hasLicense = false,

	-- darkrp
	customCheck = function(ply) return ply:Donator("gold") end,
	CustomCheckFailMsg = "Работа доступна только для игроков Gold и Platinum",
	category = "Синтеты",
	sortOrder = 1,
	PlayerLoadout = function(ply) ply:SetMaxHealth(300) ply:SetHealth(300) ply:SetMaxArmor(300) ply:SetArmor(300) ply:SetWalkSpeed(120) ply:SetRunSpeed(200) end,

	-- retrime
	price = 1000000
})

