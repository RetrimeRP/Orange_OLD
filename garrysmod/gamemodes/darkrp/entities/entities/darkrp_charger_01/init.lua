AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/props_combine/health_charger001.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end

	-- NextUse
	self.NextUse = 0
end

--[[------------------------------------------------------------

	Use

------------------------------------------------------------]]--
local suitchargeno1 = Sound("items/suitchargeno1.wav") -- ИЗМЕНЕНО 05.02.2022
local notify = DarkRP.notify
local ceil = math.ceil
local medshot4 = Sound("items/medshot4.wav")
function ENT:Use(ply)
	-- NextUse
	local curtime = CurTime()
	if self.NextUse > curtime then return end

	-- NextHealthChargerUse
	if ply.NextHealthChargerUse and ply.NextHealthChargerUse > curtime then
		self:EmitSound(suitchargeno1)

		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. ceil(ply.NextHealthChargerUse - curtime) .. " секунд")
		return
	end

	-- health, maxhealth
	local health = ply:Health()
	local maxhealth = ply:GetMaxHealth()

	if health >= maxhealth then
		self:EmitSound(suitchargeno1)
		return
	end

	-- NextUse, NextHealthChargerUse
	self.NextUse = curtime + 2
	ply.NextHealthChargerUse = curtime + 120

	-- charger
	ply:SetHealth(maxhealth)
	self:EmitSound(medshot4)
end