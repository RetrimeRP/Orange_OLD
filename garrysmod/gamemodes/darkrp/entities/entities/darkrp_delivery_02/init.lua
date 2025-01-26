AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/retrime/group02/male_07.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)
	self:SetHullSizeNormal()
	self:SetSkin(math.random(0, 20))

	self:CapabilitiesAdd(bit.bor(CAP_ANIMATEDFACE, CAP_TURN_HEAD))
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
end

--[[------------------------------------------------------------

	Use

------------------------------------------------------------]]--
local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
local random = math.random
local formatMoney = DarkRP.formatMoney
function ENT:Use(ply)
	-- job
	if ply:Team() ~= TEAM_CWU2 then
		notify(ply, 0, 3, "Этим может воспользоваться только курьер")
		return
	end

	-- DeliveryBox
	if not ply.DeliveryBox then
		notify(ply, 0, 4, "Вам нужно иметь при себе коробку")
		return
	end

	-- DeliveryBox
	ply.DeliveryBox = nil

	-- money
	local money = random(1000, 1500)

	ply:addMoney(money)

	-- notify
	notify(ply, 0, 4, "Вы успешно отнесли коробку и получили " .. formatMoney(money))
end