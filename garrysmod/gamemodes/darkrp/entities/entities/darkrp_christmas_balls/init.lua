AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/Items/item_item_crate.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetSkin(3)

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
function ENT:Use(ply)
	if ply:Team() == TEAM_FSG then return end
	local karmani = ply:GetNWInt("Christmas_Balls", 0)
	-- local shari_v_korobke = math.random(10, 25)
	if karmani == 10 then
		DarkRP.notify(ply, 0, 4, "У вас максимум шариков.")
		return
	else
		ply:SetNWInt("Christmas_Balls", math.Clamp(karmani + 10, 0, 50))
	end
	self:Remove()
	DarkRP.notify(ply, 0, 4, "Вы собрали шары из коробки.")
end