AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/props_interiors/vendingmachinesoda01a.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end
end

--[[------------------------------------------------------------

	Use

------------------------------------------------------------]]--
local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
local min = math.min
local ammocrate_close = Sound("items/ammocrate_close.wav")
function ENT:Use(ply)
	-- money
	if not ply:canAfford(200) then
		notify(ply, 0, 3, "У вас нет денег на газированную воду")
		return
	end

	ply:addMoney(-200)

	-- hunger
	ply:setSelfDarkRPVar("Energy", math.Clamp( ( ply:getDarkRPVar("Energy") or 100 ) + math.floor(20), 0, 100 ))

	-- notify
	notify(ply, 0, 4, "Вы купили газированную воду за 200 токенов")

	-- sound
	self:EmitSound(ammocrate_close)
end