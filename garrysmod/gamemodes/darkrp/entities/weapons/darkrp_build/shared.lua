-- ИЗМЕНЕНО 08.11.2022





util.PrecacheModel("models/props_combine/combine_barricade_short01a.mdl")
util.PrecacheModel("models/props_combine/bunker_gun01.mdl")
util.PrecacheModel("models/props_combine/combine_barricade_short02a.mdl")
util.PrecacheModel("models/props_combine/combine_barricade_short03a.mdl")
util.PrecacheModel("models/props_combine/combine_booth_short01a.mdl")
util.PrecacheModel("models/props_combine/combine_barricade_med02c.mdl")
util.PrecacheModel("models/props_combine/railing_128.mdl")
util.PrecacheModel("models/props_combine/railing_256.mdl")
util.PrecacheModel("models/combine_turrets/floor_turret.mdl")

util.PrecacheModel("models/props_fortifications/sandbags_corner2.mdl")
util.PrecacheModel("models/props_fortifications/sandbags_corner3.mdl")
util.PrecacheModel("models/props_fortifications/sandbags_line2.mdl")
util.PrecacheModel("models/props_fortifications/fortification_indoor_01.mdl")
util.PrecacheModel("models/rebel1324/dshk_animated.mdl")
util.PrecacheModel("models/props_misc/gazebo.mdl")
util.PrecacheModel("models/props_misc/fairground_tent_open.mdl")
util.PrecacheModel("models/props_misc/triage_tent.mdl")

SWEP.Spawnable = true
SWEP.PrintName = "СТРОИТЕЛЬСТВО"
-- SWEP.Base = "darkrp_hands"
SWEP.DrawCrosshair = true
SWEP.Slot = 5
SWEP.SlotPos = 5
SWEP.WorldModel = ""
SWEP.ViewModel = ""

function SWEP:Initialize()
	self:SetHoldType("magic")

	if SERVER then
		self:SetSelectedSlot(1)
		self.NextReloadUse = 0
	end
end

local Props_01 = {
	{
		class = "prop_physics",
		model = "models/props_combine/combine_barricade_short01a.mdl",
		type = "build_props",
		max = 10
	},
	{
		class = "darkrp_turret_01",
		model = "models/props_combine/combine_barricade_short01a.mdl",
		type = "build_turrets",
		max = 1
	},
	{
		class = "prop_physics",
		model = "models/props_combine/combine_barricade_short02a.mdl",
		type = "build_props",
		max = 10
	},
	{
		class = "prop_physics",
		model = "models/props_combine/combine_barricade_short03a.mdl",
		type = "build_props",
		max = 10
	},
	{
		class = "prop_physics",
		model = "models/props_combine/combine_booth_short01a.mdl",
		type = "build_props",
		max = 10
	},
	{
		class = "prop_physics",
		model = "models/props_combine/combine_barricade_med02c.mdl",
		type = "build_props",
		max = 10
	},
	{
		class = "prop_physics",
		model = "models/props_combine/railing_128.mdl",
		offset = Angle(0, 90, 0),
		type = "build_props",
		max = 10
	},
	{
		class = "prop_physics",
		model = "models/props_combine/railing_256.mdl",
		offset = Angle(0, 90, 0),
		type = "build_props",
		max = 10
	}
}

local Props_02 = {
	{
		class = "prop_physics",
		model = "models/props_fortifications/sandbags_corner2.mdl",
		offset = Angle(0, 180, 0),
		type = "build_props",
		max = 10
	},
	{
		class = "prop_physics",
		model = "models/props_fortifications/sandbags_corner3.mdl",
		offset = Angle(0, 180, 0),
		type = "build_props",
		max = 10
	},
	{
		class = "prop_physics",
		model = "models/props_fortifications/sandbags_line2.mdl",
		offset = Angle(0, 180, 0),
		type = "build_props",
		max = 10
	},
	{
		class = "prop_physics",
		model = "models/props_fortifications/fortification_indoor_01.mdl",
		type = "build_props",
		max = 10
	},
	{
		class = "darkrp_turret_02",
		model = "models/rebel1324/dshk_animated.mdl",
		type = "build_turrets",
		max = 1
	},
	{
		class = "prop_physics",
		model = "models/props_misc/gazebo.mdl",
		type = "build_tents",
		max = 2
	},
	{
		class = "prop_physics",
		model = "models/props_misc/fairground_tent_open.mdl",
		type = "build_tents",
		max = 2
	},
	{
		class = "prop_physics",
		model = "models/props_misc/triage_tent.mdl",
		offset = Angle(0, 180, 0),
		type = "build_bigtents",
		max = 1
	}
}

local Props_03 = {
	{
		class = "prop_physics",
		model = "models/props_fortifications/sandbags_corner2.mdl",
		offset = Angle(0, 180, 0),
		type = "build_props",
		max = 10
	},
	{
		class = "prop_physics",
		model = "models/props_fortifications/sandbags_corner3.mdl",
		offset = Angle(0, 180, 0),
		type = "build_props",
		max = 10
	},
	{
		class = "prop_physics",
		model = "models/props_fortifications/sandbags_line2.mdl",
		offset = Angle(0, 180, 0),
		type = "build_props",
		max = 10
	},
	{
		class = "prop_physics",
		model = "models/props_fortifications/fortification_indoor_01.mdl",
		type = "build_props",
		max = 10
	},
	{
		class = "darkrp_turret_02",
		model = "models/rebel1324/dshk_animated.mdl",
		type = "build_turrets",
		max = 1
	},
	{
		class = "prop_physics",
		model = "models/props_misc/gazebo.mdl",
		type = "build_tents",
		max = 2
	},
	{
		class = "prop_physics",
		model = "models/props_misc/fairground_tent_open.mdl",
		type = "build_tents",
		max = 2
	},
	{
		class = "prop_physics",
		model = "models/props_misc/triage_tent.mdl",
		offset = Angle(0, 180, 0),
		type = "build_bigtents",
		max = 1
	}
}

--[[------------------------------------------------------------

	GetSlots

------------------------------------------------------------]]--
function SWEP:GetSlots(ply)
	
	local props = {}
	local ply_team = ply:Team()
	if ply_team == TEAM_MPF5 or ply_team == TEAM_GUARDIAN5 then
		-- Props_01
		for k, v in ipairs(Props_01) do
			props[#props + 1] = v
		end
		return props
	elseif ply_team == TEAM_DOD3 then
		-- Props_02
		for k, v in ipairs(Props_02) do
			props[#props + 1] = v
		end
		return props
	end

	-- Props_03
	for k, v in ipairs(Props_03) do
		props[#props + 1] = v
	end

	return props
end

--[[------------------------------------------------------------

	SetupDataTables

------------------------------------------------------------]]--
function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "SelectedSlot")
end