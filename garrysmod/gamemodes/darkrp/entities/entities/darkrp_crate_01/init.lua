AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/props_crates/static_crate_40.mdl")

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
	self:SetCrateCharge(15)
end

--[[------------------------------------------------------------

	Use

------------------------------------------------------------]]--
local notify = DarkRP.notify
local ceil = math.ceil
local mrandom = math.random
	-- random
local random = {
	"darkrp_ration_01",
	"darkrp_ration_02",
	"darkrp_ration_03"
}
function ENT:Use(ply)
	-- job
	if not ply:IsResistance() then
		notify(ply, 0, 4, "Этим может воспользоваться только Сопротивление")
		return
	end

	local curtime = CurTime()

	-- NextCrateUse_01
	if ply.NextCrateUse_01 and ply.NextCrateUse_01 > curtime then
		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. ceil(ply.NextCrateUse_01 - curtime) .. " секунд")
		return
	end

	local cratecharge = self:GetCrateCharge() - 1 -- ИЗМЕНЕНО 18.09.2022

	-- charge
	self:SetCrateCharge(cratecharge)

	if cratecharge < 1 then
		self:Remove()
	end

	-- NextCrateUse_01
	ply.NextCrateUse_01 = curtime + 600

	-- ration
	local ration = random[mrandom(#random)]

	-- ent
	local ent = ents.Create(ration)
	ent:SetPos(self:GetPos() + (self:GetUp() * 52))
	ent:SetAngles(self:GetAngles())
	ent:Spawn()

	-- notify
	notify(ply, 0, 4, "Вы успешно достали из ящика один рацион")
end