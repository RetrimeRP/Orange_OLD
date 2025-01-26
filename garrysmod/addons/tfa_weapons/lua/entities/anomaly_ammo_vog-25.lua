
AddCSLuaFile()
DEFINE_BASECLASS( "base_anim" )
ENT.PrintName = "Граната ВОГ-25"
ENT.Author = "Flaymi"
ENT.Information = ""
ENT.Category = "S.T.A.L.K.E.R. Anomaly"
ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false
function ENT:Initialize()
    if ( CLIENT ) then return end
    self:SetModel( "models/flaymi/anomaly/ammo/ammo_vog_25.mdl" )
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    local phys = self:GetPhysicsObject()
    phys:Wake()
end
function ENT:Use( activator, caller )
	self:Remove()
    if ( activator:IsPlayer() ) then
     activator:GiveAmmo(1, "ammo_vog-25", false)
	end
end
