AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/props_combine/suit_charger001.mdl")

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
local suitchargeok1 = Sound("items/suitchargeok1.wav")
local notify = DarkRP.notify
local ceil = math.ceil
local medshot4 = Sound("item/medshot4.wav")
function ENT:Use(ply)
	-- NextUse
	local curtime = CurTime()
	if self.NextUse > curtime then return end

	-- NextHealthChargerUse
	if ply.NextSuitChargerUse and ply.NextSuitChargerUse > curtime then
		self:EmitSound(suitchargeno1)

		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. ceil(ply.NextSuitChargerUse - curtime) .. " секунд")
		return
	end

	-- health, maxhealth
	local armor = ply:Armor()
	local maxarmor = ply:GetMaxArmor()

	if armor >= maxarmor then
		self:EmitSound(suitchargeno1)
		return
	end

	-- NextUse, NextHealthChargerUse
	self.NextUse = curtime + 2
	ply.NextSuitChargerUse = curtime + 120

	-- charger
	ply:SetArmor(maxarmor)
	self:EmitSound(suitchargeok1)
end