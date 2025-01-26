--[[------------------------------------------------------------

	--------
	REFUGEES
	--------

------------------------------------------------------------]]--
TEAM_REFUGEE = DarkRP.createJob("Беженец", {

	color = Color(75, 75, 75),
	model = {
		"models/retrime/group02/female_02.mdl",
		"models/retrime/group02/female_04.mdl",
		"models/retrime/group02/female_07.mdl",
		"models/retrime/group02/male_02.mdl",
		"models/retrime/group02/male_04.mdl",
		"models/retrime/group02/male_06.mdl",
		"models/retrime/group02/male_08.mdl"
	},
	description = "Беженец",
	weapons = {"weapon_physgun", "gmod_tool", "darkrp_inventory"},
	command = "refugee",
	max = 4,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,

	category = "Беженцы"

})

--
-- Category
--
DarkRP.createCategory{

	name = "Беженцы",
	categorises = "jobs",
	startExpanded = true,
	color = Color(75, 75, 75),
	canSee = function() return true end,
	sortOrder = 8

}