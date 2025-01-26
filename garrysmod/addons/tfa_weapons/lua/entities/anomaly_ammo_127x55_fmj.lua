
AddCSLuaFile()
DEFINE_BASECLASS( "base_anim" )
ENT.PrintName = "Патроны 12,7x55 мм СЦ-130"
ENT.Author = "Flaymi"
ENT.Information = ""
ENT.Category = "S.T.A.L.K.E.R. Anomaly"
ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false
function ENT:Initialize()
    if ( CLIENT ) then return end
    self:SetModel( "models/flaymi/anomaly/ammo/ammo_127x55_fmj.mdl" )
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
     activator:GiveAmmo(10, "ammo_127x55_fmj", false)
	end
end
