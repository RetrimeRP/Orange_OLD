function EFFECT:Init(data)

	self.WeaponEntity = data:GetEntity()

	if not IsValid(self.WeaponEntity) then return end

	self.Attachment = data:GetAttachment()

	self.Position = self:GetTracerShootPos(data:GetOrigin(), self.WeaponEntity, self.Attachment)
	self.WeaponOwner = self.WeaponEntity:GetOwner()

	self.Velocity = data:GetNormal()
	self.Scale = data:GetScale()

	self.Position = self.Position + self.Velocity

	local addvelocity = self.WeaponOwner:GetVelocity() * 0.5
	local particles1 = math.ceil(self.Scale / 81) + 1
	local particles2 = math.ceil(self.Scale / 190) + 1

	local emitter = ParticleEmitter(self.Position)

	for i = 1, particles1 do
		local fire = emitter:Add("particles/flamelet" .. math.random(1, 5), self.Position + self.Velocity * i * math.Rand(1.6, 3))

		local velocity = self.Velocity + Vector(math.Rand(-0.04, 0.04), math.Rand(-0.04, 0.04), math.Rand(-0.04, 0.04))
		velocity = velocity * math.Rand(self.Scale / 0.7, self.Scale / 0.8) + addvelocity

		local expires = self.Scale / velocity:Length()
		expires = (expires > 0.85 and 0.85) or expires

		fire:SetVelocity(velocity)
		fire:SetDieTime(expires)
		fire:SetStartAlpha(math.Rand(100, 150))
		fire:SetStartSize(1.7)
		fire:SetEndSize(math.Rand(72, 96))
		fire:SetRoll(math.Rand(0, 360))
		fire:SetRollDelta(math.Rand(-1, 1))
		fire:SetColor(math.Rand(130, 230), math.Rand(100, 160), 120)
	end

	for i = 0, particles2 do
		local fire = emitter:Add("particles/flamelet" .. math.random(1, 5), self.Position + self.Velocity * i * math.Rand(0.3, 0.6))
		fire:SetVelocity(self.Velocity * math.Rand(0.42 * self.Scale / 0.3, 0.42 * self.Scale / 0.4) + addvelocity)
		fire:SetDieTime(math.Rand(0.3, 0.4))
		fire:SetStartAlpha(255)
		fire:SetStartSize(0.6 * i)
		fire:SetEndSize(math.Rand(24, 32))
		fire:SetRoll(math.Rand(0, 360))
		fire:SetRollDelta(math.Rand(-0.5, 0.5))
		fire:SetColor(30, 15, math.Rand(190, 225))
	end

	emitter:Finish()
end

function EFFECT:Think()

	return false

end

function EFFECT:Render()
end