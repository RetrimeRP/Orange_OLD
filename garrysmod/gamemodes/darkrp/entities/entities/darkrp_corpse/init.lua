AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:PhysicsInit(SOLID_BBOX)

	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)

	self:DrawShadow(false) -- ИЗМЕНЕНО 04.07.2022

	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
end