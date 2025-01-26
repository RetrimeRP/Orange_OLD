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
local ammo = {
	["pistol"] = 50,
	["357"] = 30,
	["smg1"] = 120,
	["ar2"] = 150,
	["buckshot"] = 30,
	["SniperPenetratedRound"] = 30
}
function ENT:Use(ply)
	-- NextUse
	local curtime = CurTime()
	if self.NextUse > curtime then return end

	local team = ply:Team()

	-- job
	if not ply:IsGuild() then
		notify(ply, 0, 4, "Этим может воспользоваться только NS/DoD")
		return
	end

	-- NextArmoryUse
	if ply.NextArmoryUse and ply.NextArmoryUse > curtime then
		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. ceil(ply.NextArmoryUse - curtime) .. " секунд")
		return
	end

	-- NextUse, NextArmoryUse
	self.NextUse = curtime + 1.6
	ply.NextArmoryUse = curtime + 60

	-- bodygroup
	self:SetBodygroup(1, random(0, 1))

	-- sequence
	self:SetSequence("close")
	self:EmitSound(ammocrate_open)

	timer.Simple(0.8, function()
		self:SetSequence("open")
		self:EmitSound(ammocrate_close)
	end)

	for k, v in pairs(ammo) do
		ply:SetAmmo(ply:GetAmmoCount(k) + v, k)
	end

	if team == TEAM_GUILD9 then
		local ammocount = ply:GetAmmoCount("SMG1_Grenade")

		if ammocount < 2 then
			ply:SetAmmo(ammocount + 1, "SMG1_Grenade")
		end
	end

	-- weapons
	local weapons = ply:getJobTable().weapons

	if HasValue(weapons, "weapon_cuff_rope") then
		ply:Give("weapon_cuff_rope")
	end

	-- notify
	notify(ply, 0, 3, "Вы успешно получили патроны")
end