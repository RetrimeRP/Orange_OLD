AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.nextUse = 0

function ENT:Initialize()

	self:SetModel("models/rebel1324/dshk_animated.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end

	self:SetDTInt(0, 70)

end

function ENT:OnRemove()

	local owner = self:GetOwner()

	if IsValid(owner) then
		owner.Turret = nil
		owner:GetViewModel():SetNoDraw(false)
	end

end

local abs = math.abs
local Clamp = math.Clamp
local vec016 = Vector(.016, .016, 0)
local mmax = math.max
local PSHK_STATIONARY_Single = Sound("PSHK_STATIONARY.Single")
function ENT:Think()

	local owner = self:GetOwner()

	if IsValid(owner) and owner:Alive() and self:GetPos():DistToSqr(owner:GetPos()) <= 4096 then
		local aimVector = owner:GetAimVector()
		local turretForward = self:GetForward()
		local turretDot = turretForward:Dot(aimVector)

		if turretDot < 0 or abs(turretDot) < .2 then
			owner:GetViewModel():SetNoDraw(false)
			owner.Turret = nil
			--owner = nil
			self:SetOwner(nil)

			owner:SetNWEntity("currentTurret", nil)
			self:SetNWEntity("currentTurret", self)
			return
		end

		local activeweapon = owner:GetActiveWeapon()

		if activeweapon:IsValid() then
			activeweapon:SetNextPrimaryFire(CurTime() + 1)
			activeweapon:SetNextSecondaryFire(CurTime() + 1)
		end

		if self.reload then
			if self:GetSequence() == 2 then
				local cycle = self:GetCycle()

				if cycle > .5 then
					self:SetDTInt(0, 70)
				end

				if cycle == 1 then
					self.reload = false
				end
			end
		end

		if self:GetDTInt(0, 0) < 70 and not self.reload then
			if (not self.nextFire or self.nextFire < CurTime()) and owner:KeyDown(IN_RELOAD) then
				self:ResetSequence("reload")
				self.nextFire = CurTime() + 2
				self.reload = true
				return
			end
		end

		if self:GetDTInt(0, 0) > 0 and not self.reload then
			if (not self.nextFire or self.nextFire < CurTime()) and owner:KeyDown(IN_ATTACK) then
				local aimVector = owner:GetAimVector()
				local turretForward = self:GetForward()
				local turretDot = turretForward:Dot(aimVector)

				local data = {}
				data.start = owner:GetShootPos()
				data.endpos = data.start + aimVector * 10000
				data.filter = {owner, self}

				local trace = util.TraceLine(data)

				local cappedVector = (turretForward - trace.Normal)
				cappedVector.x = Clamp(cappedVector.x, -.6, .6)
				cappedVector.y = Clamp(cappedVector.y, -.6, .6)
				cappedVector.z = Clamp(cappedVector.z, -.9, .3)

				local ang = (turretForward - cappedVector):Angle()
				local selfang = self:GetAngles()

				self.curAng = ang

				local bullet = {}
				bullet.Num = 1
				bullet.Src = self:GetPos() + self.curAng:Up() * 48 + self.curAng:Forward() * 60
				bullet.Dir = ang:Forward()
				bullet.Spread = vec016
				bullet.Tracer = 0
				bullet.Force = 10
				bullet.Damage = 39
				bullet.Callback = function(a, b, c)
					if not b.HitSky then
						local dir = bullet.Src - b.HitPos
						dir:Normalize()
						dir = dir:Angle()
						dir:RotateAroundAxis(b.HitNormal, 180)

						local e = EffectData()
						e:SetEntity(self)
						e:SetScale(1)
						e:SetOrigin(b.HitPos)
						e:SetNormal(dir:Forward())

						util.Effect("DSHK_IMPACT", e)
					end
				end

				self:FireBullets(bullet)

				local e = EffectData()
				e:SetEntity(self)
				e:SetScale(1)
				e:SetOrigin(self:GetPos() + self.curAng:Up() * 48 + self.curAng:Forward() * 60)
				e:SetNormal(self:GetShootDir())

				util.Effect("DSHK_BURST", e)

				self:EmitSound(PSHK_STATIONARY_Single)
				self:ResetSequence("fire")

				self.nextFire = CurTime() + 0.12

				self:SetDTInt(0, mmax(self:GetDTInt(0) - 1, 0))
			end
		end
	else
		if IsValid(owner) then
			owner:GetViewModel():SetNoDraw(false)
			owner.Turret = nil
			--self.Owner = nil
			self:SetOwner(nil)

			owner:SetNWEntity("currentTurret", nil)
			self:SetNWEntity("currentTurret", self)
		end
	end

	self:NextThink(CurTime())
	return true

end

function ENT:Use(client)

	if self.nextUse < CurTime() then
		self:OnUse(client)
		self.nextUse = CurTime() + 1
	end

end

local Func_Tank_BeginUse = Sound("Func_Tank.BeginUse")
function ENT:OnUse(client)

	local owner = self:GetOwner()

	if IsValid(owner) then
		if (owner == client) then
			self:SetNWEntity("currentTurret", self)
			self:EmitSound(Func_Tank_BeginUse)

			owner:GetViewModel():SetNoDraw(false)
			owner.Turret = nil
			--self.Owner = nil
			self:SetOwner(nil)
			owner:SetNWEntity("currentTurret", nil)
		end
	else
		local aimVector = client:GetAimVector()
		local turretForward = self:GetForward()
		local turretDot = turretForward:Dot(aimVector)

		if turretDot < 0 or abs(turretDot) < .2 then return end
		if client.Turret and IsValid(client.Turret) then return end

		self:EmitSound(Func_Tank_BeginUse)

		self:SetOwner(client)
		client:GetViewModel():SetNoDraw(true)
		client:SetNWEntity("currentTurret", self)

		self:SetNWEntity("currentTurret", client)
		client.Turret = self
	end

end