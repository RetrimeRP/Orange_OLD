AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Explode()

	if self.Exploded then return end

	self.Exploded = true

	local explosion = ents.Create("env_explosion")
	if self.Activator then explosion.Activator = self.Activator end -- ИЗМЕНЕНО 08.01.2022
	explosion:SetKeyValue("spawnflags", 144)
	explosion:SetKeyValue("iMagnitude", 200)
	explosion:SetKeyValue("iRadiusOverride", 256)
	explosion:SetPos(self:GetPos())
	explosion:Spawn( )
	explosion:Fire("explode", "", 0)

	self:Remove()

end

function ENT:Initialize()

	self:SetModel("models/weapons/w_missile.mdl")

	self:PhysicsInitSphere(4, "metal_bouncy")

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:SetDamping(.0001, .0001)
		phys:EnableGravity(false)
		phys:EnableDrag(false)
	end

	self:SetAngles((self:GetOwner() or self.Activator):GetAimVector():Angle())
	self:SetCollisionBounds(Vector() * -4, Vector() * 4)

	self.Sound = CreateSound(self, Sound("Missile.Accelerate"))
	self.Sound:SetSoundLevel(95)
	self.Sound:Play()

	self:StartMotionController()

end

function ENT:Think()

	if self.ShouldExplode then
		self:Explode()
	end

	self:NextThink(CurTime())
	return true

end

function ENT:PhysicsSimulate(phys, deltatime)

	if self.ShouldExplode then
		return SIM_NOTHING
	end

	local sin = math.sin(CurTime() * 20) * 1.1
	local cos = math.cos(CurTime() * 20) * 1.1

	local angular = Vector(0, 0, 0)

	local linear = (self.FlyAngle:Right() * sin) + (self.FlyAngle:Up() * cos)

	linear = linear * deltatime * 1.001

	return angular, linear, SIM_GLOBAL_FORCE

end

function ENT:PhysicsCollide()

	self.ShouldExplode = true

end

function ENT:OnRemove()

	if self.Sound then
		self.Sound:Stop()
	end

end