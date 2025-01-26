AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/props_junk/wood_crate002a.mdl")

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
local createmark, vec1170306648 = CreateMark, Vector(1170, -3066, 48)
function ENT:Use(ply)
	-- job
	if ply:Team() ~= TEAM_CWU2 then
		notify(ply, 0, 3, "Этим может воспользоваться только курьер")
		return
	end

	-- DeliveryBox
	if ply.DeliveryBox then
		notify(ply, 0, 3, "Отнесите коробку на склады ГСР")
		return
	end

	-- DeliveryBox
	ply.DeliveryBox = true

	-- mark
	CreateMark(ply, 2, 90, "Склады ГСР", "ShowWhere", Vector(1170, -3066, 48))

	-- command
	ply:ConCommand("playmusic")

	-- notify
	notify(ply, 0, 5, "Вы взяли коробку, теперь отнесите её на склады ГСР")
end