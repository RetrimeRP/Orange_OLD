AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local crate = {
	-- SUBMACHINE GUNS
	{class = "tfa_tmp", name = "TMP"},

	-- ASSAULT RIFLES
	{class = "tfa_galil", name = "GALIL"},
	{class = "tfa_famas", name = "FAMAS"},
	{class = "tfa_ak47", name = "AK-47"},
	{class = "tfa_m4a1", name = "M4A1"},
	{class = "tfa_sg552", name = "SG552"},
	{class = "tfa_aug", name = "AUG"},

	-- SHOTGUNS AND MACHINE GUNS
	{class = "tfa_m3super90", name = "M3 SUPER 90"},
	{class = "tfa_xm1014", name = "XM1014"},
	{class = "tfa_m249", name = "M249"},

	-- SNIPER RIFLES
	{class = "tfa_scout", name = "SCOUT"},
	{class = "tfa_awp", name = "AWP"},
	{class = "tfa_g3sg1", name = "G3SG1"},
	{class = "tfa_sg550", name = "SG550"}
}

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/props_crates/supply_crate02.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end

	-- charge
	self:SetCrateCharge(10)
end

--[[------------------------------------------------------------

	Use

------------------------------------------------------------]]--
local notify = DarkRP.notify
local ceil = math.ceil
local mrandom = math.random
function ENT:Use(ply)
	-- job
	if not ply:IsResistance() then
		notify(ply, 0, 4, "Этим может воспользоваться только Сопротивление")
		return
	end

	local curtime = CurTime()

	-- NextCrateUse_02
	if ply.NextCrateUse_02 and ply.NextCrateUse_02 > curtime then
		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. ceil(ply.NextCrateUse_02 - curtime) .. " секунд")
		return
	end

	-- weapon
	local weapon = crate[mrandom(#crate)]

	-- class
	if ply:HasWeapon(weapon.class) then
		notify(ply, 0, 5, "Вам выпало оружие, которое у вас уже есть. Попробуйте ещё раз!")
		return
	end

	local cratecharge = self:GetCrateCharge()

	-- charge
	self:SetCrateCharge(cratecharge - 1)

	if cratecharge < 1 then
		self:Remove()
	end

	-- NextCrateUse_02
	ply.NextCrateUse_02 = curtime + 300

	-- give
	ply:Give(weapon.class)

	-- notify
	notify(ply, 0, 4, "Вы успешно достали из ящика " .. weapon.name)
end