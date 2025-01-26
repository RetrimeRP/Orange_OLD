AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/props_junk/cardboard_box002a.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end
end

--[[------------------------------------------------------------

	Use

------------------------------------------------------------]]--
local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
local cardboard_box_break3 = Sound("physics/cardboard/cardboard_box_break3.wav")
function ENT:Use(ply)
	local uniforms = {
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
	}
	-- job
	if not ply:IsBandits() then
		notify(ply, 0, 4, "Этим могут воспользоваться только бандиты")
		return
	end

	-- model
	local model = uniforms[ply:GetModel()]

	if model then
		notify(ply, 0, 4, "Вы не можете этим воспользоваться")
		return
	end

	-- remove
	self:Remove()

	-- model
	ply:SetModel(table.Random( uniforms ))
	ply:SetupHands()

	-- sound
	ply:EmitSound(cardboard_box_break3)

	-- notify
	notify(ply, 0, 4, "Вы успешно надели на себя униформу Гражданина")
end