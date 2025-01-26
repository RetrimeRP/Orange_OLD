
AddCSLuaFile()
DEFINE_BASECLASS( "base_anim" )
ENT.PrintName = "9x18"
ENT.Author = "Вульфич"
ENT.Information = ""
ENT.Category = "Патрачи"
ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = false
function ENT:Initialize()
    if ( CLIENT ) then return end
    self:SetModel( "models/orange/ammo/ammo_9x18_fmj.mdl" )
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
     activator:GiveAmmo(16, "ammo_9x18_ap", false)
	end
end
