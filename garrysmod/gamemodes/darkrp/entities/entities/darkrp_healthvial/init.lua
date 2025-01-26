AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/healthvial.mdl")

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
local min = math.min
local medshot4 = Sound("items/medshot4.wav")
function ENT:Use(ply)
	-- health, maxhealth
	local health = ply:Health()
	local maxhealth = ply:GetMaxHealth()

	if health >= maxhealth then return end

	-- remove
	self:Remove()

	-- health
	ply:SetHealth(min(maxhealth, health + 50))

	-- sound
	ply:EmitSound(medshot4)
end