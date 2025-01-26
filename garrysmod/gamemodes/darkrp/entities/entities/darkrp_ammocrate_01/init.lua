AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/items/ammocrate_smg1.mdl")

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
local notify = DarkRP.notify
local ceil = math.ceil
local random = math.random
local ammocrate_open = Sound("items/ammocrate_open.wav")
local ammocrate_close = Sound("items/ammocrate_close.wav")
local HasValue = table.HasValue
function ENT:Use(ply)
	-- NextUse
	local curtime = CurTime()
	if self.NextUse > curtime then return end

	-- job
	if not ply:IsCombine() then
		notify(ply, 0, 4, "Этим может воспользоваться только Альянс")
		return
	end

	-- NextArmoryUse
	if ply.NextArmoryUse and ply.NextArmoryUse > curtime then
		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. ceil(ply.NextArmoryUse - curtime) .. " секунд")
		return
	end

	-- NextUse, NextArmoryUse
	self.NextUse = curtime + 1.6
	ply.NextArmoryUse = curtime + 120

	-- bodygroup
	self:SetBodygroup(1, random(0, 1))

	-- sequence
	self:SetSequence("close")
	self:EmitSound(ammocrate_open)

	timer.Simple(0.8, function()
		self:SetSequence("open")
		self:EmitSound(ammocrate_close)
	end)

	-- jobtable
	local jobtable = ply:getJobTable()

	-- ammo
	local ammo = jobtable.ammo

	if ammo then
		for k, v in pairs(ammo) do
			if ply:GetAmmoCount(k) > v then continue end

			ply:SetAmmo(v, k)
		end
	end

	-- weapons
	local weapons = jobtable.weapons

	if HasValue(weapons, "weapon_cuff_elastic") then
		ply:Give("weapon_cuff_elastic")
	end

	if HasValue(weapons, "tfa_grenade") then
		ply:Give("tfa_grenade")
	end

	-- notify
	notify(ply, 0, 3, "Вы успешно получили патроны")
end