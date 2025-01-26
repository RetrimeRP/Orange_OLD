AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/items/battery.mdl")

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
local min = math.min -- ИЗМЕНЕНО 05.02.2022
local battery_pickup = Sound("items/battery_pickup.wav")
function ENT:Use(ply)
	-- armor, maxarmor
	local armor = ply:Armor()
	local maxarmor = ply:GetMaxArmor()

	if armor >= maxarmor then return end

	-- remove
	self:Remove()

	-- armor
	ply:SetArmor(min(maxarmor, armor + 25))

	-- sound
	ply:EmitSound(battery_pickup)
end