
AddCSLuaFile()
DEFINE_BASECLASS( "base_anim" )
ENT.PrintName = "Патроны 5,45x39 мм ПС"
ENT.Author = "Flaymi"
ENT.Information = ""
ENT.Category = "Патрики"
ENT.Editable = true
ENT.Spawnable = true
ENT.AdminOnly = true
function ENT:Initialize()
    if ( CLIENT ) then return end
    self:SetModel( "models/orange/ammo/ammo_545x39_fmj.mdl" )
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
     activator:GiveAmmo(15, "ammo_545x39_fmj", true)
	end
end
