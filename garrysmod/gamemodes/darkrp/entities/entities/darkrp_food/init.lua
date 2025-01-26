AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel(self.Food.Model)

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
function ENT:Use(ply)
	-- remove
	self:Remove()

	-- food
	ply:setSelfDarkRPVar("Energy", math.Clamp( ( ply:getDarkRPVar("Energy") or 100 ) + math.floor(self.Food.Amount), 0, 100 ))

	-- health
	if self.Food.Health then
		local health = ply:Health()
		local maxhealth = ply:GetMaxHealth()

		if health < maxhealth then
			ply:SetHealth(min(maxhealth, health + self.Food.Health))
		end
	end

	-- use
	if self.Food.Use then
		if not ply:IsCombine() then
			self.Food.Use(ply)
		end
	end

	-- sound
	ply:EmitSound(self.Food.Sound)
end