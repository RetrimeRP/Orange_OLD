include("shared.lua")

function ENT:Initialize()

	self.Color = Color( 255, 255, 255, 255 )

	self.Emitter = ParticleEmitter( self.Entity:GetPos() )
	self.PixVis = util.GetPixelVisibleHandle()

end

function ENT:Think()

	local Gravity = Vector(0, 0, -10)
	local Velocity = self:GetVelocity()

	if (self.Emitter) then
		self.LastParticlePos = self.LastParticlePos or self:GetPos()

		local vDist = self:GetPos() - self.LastParticlePos
		local Length = vDist:Length()
		local vNorm = vDist:GetNormalized()

		for i = 0, Length, 8 do
			self.LastParticlePos = self.LastParticlePos + vNorm * 8
			self.ParticlesSpawned = self.ParticlesSpawned or 1
			self.ParticlesSpawned = self.ParticlesSpawned + 1

			if math.random(3) > 1 then
				local particle = self.Emitter:Add("particles/smokey", self.LastParticlePos)
				particle:SetVelocity(VectorRand() * 40)
				particle:SetLifeTime(0)
				particle:SetDieTime(math.Rand(1.0, 1.5))
				particle:SetStartAlpha(math.Rand(150, 200))
				particle:SetEndAlpha(0)
				particle:SetStartSize(math.random(5, 10))
				particle:SetEndSize(math.random(20, 50))
				local dark = math.Rand(100, 200)
				particle:SetColor(dark, dark, dark)
				particle:SetAirResistance(50)
				particle:SetGravity(Vector(0, 0, math.random(-50, 50)))
				particle:SetCollide(true)
				particle:SetBounce(0.2)
			end

			if math.random(3) == 3 then
				local particle = self.Emitter:Add("effects/muzzleflash" .. math.random(1, 4), self.LastParticlePos)
				particle:SetVelocity(VectorRand() * 30 + Vector(0, 0, 20))
				particle:SetLifeTime(0)
				particle:SetDieTime(math.Rand(0.1, 0.2))
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(math.random(6, 12))
				particle:SetEndSize(1)
				particle:SetColor(math.Rand(150, 255), math.Rand(100, 150), 100)
				particle:SetAirResistance(50)
			end

			if (self.ParticlesSpawned > 8) then
				self.Emitter:Finish()
				self.Emitter = ParticleEmitter(self:GetPos())
				self.ParticlesSpawned = 0
			end
		end
	end

	local dlight = DynamicLight(self:EntIndex())

	if (dlight) then
		dlight.Pos = self:GetPos()
		dlight.r = 255
		dlight.g = 230
		dlight.b = 200
		dlight.Brightness = 4 * math.Rand(0.8, 1.0)
		dlight.Decay = 128
		dlight.size = 1024 * math.Rand(0.8, 1.0)
		dlight.DieTime = CurTime() + 0.2
	end

end

function ENT:OnRemove()

	if self.Emitter then
		self.Emitter = nil
	end

end