AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

function ENT:Draw()
	self:DrawModel()
end

function ENT:Initialize()
	self.KaboomTime = self.KaboomTime or CurTime() + 3
	if SERVER then
		self:SetModel( "models/flaymi/anomaly/weapons/ammo/wpn_f1_throw.mdl" )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		self:DrawShadow( true )
		self:SetAngles( self:GetOwner():GetAngles() )
	end
end

function ENT:Think()
	if SERVER and self.KaboomTime <= CurTime() then
		self:Explode()
		self:Remove()
	end
end

function ENT:Explode()
	local effectdata = EffectData()
      effectdata:SetOrigin( self:GetPos() )
      util.Effect("Explosion", effectdata)
      util.BlastDamage( self, self.Owner or self, self:GetPos(), 750, 160 )
    
	self:Remove()
end

function ENT:PhysicsCollide( data )
	if SERVER and data.Speed > 220 then
	self:EmitSound( "TFA_ANOMALY.GRENADE.PHYS" )
	end
end

