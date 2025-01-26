AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/props_junk/trashdumpster01a.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)
	self:SetSkin(math.random(0, 5))

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
local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
local random = math.random
local formatMoney = DarkRP.formatMoney
local ceil = math.ceil
function ENT:Use(ply)
	-- job
	if ply:Team() ~= TEAM_CWU1 then
		notify(ply, 0, 4, "Вы должны быть уборщиком чтобы очистить эту мусорку")
		return
	end

	local curtime = CurTime()
	-- NextUse
	if self.NextUse > curtime then
		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. ceil(self.NextUse - curtime) .. " секунд")
		return
	end

	-- NextUse
	self.NextUse = curtime + random(60, 120)

	-- money
	local money = random(400, 600)

	ply:addMoney(money)

	-- notify
	notify(ply, 0, 4, "Вы успешно очистили мусорку и получили " .. formatMoney(money))
end