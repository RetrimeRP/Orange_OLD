include("shared.lua")

local sparks = {"particle/rebel1324/sparks/spark2", "particle/rebel1324/sparks/spark"}
local muzzleMaterials = {}

for i = 1, 8 do

	muzzleMaterials[i] = Material("effects/fas_muzzle" .. i .. ".png", "SpriteCard")
	muzzleMaterials[i]:SetInt("$additive", 1)
	muzzleMaterials[i]:SetInt("$translucent", 1)
	muzzleMaterials[i]:SetInt("$vertexcolor", 1)
	muzzleMaterials[i]:SetInt("$vertexalpha", 1)

end

local META = FindMetaTable("CLuaEmitter")
if not META then return end

function META:DrawAt(pos, ang, fov)

	local pos, ang = WorldToLocal(EyePos(), EyeAngles(), pos, ang)

	cam.Start3D(pos, ang, fov)
		self:Draw()
	cam.End3D()

end

--[[------------------------------------------------------------

	DSHK BURST

------------------------------------------------------------]]--
local EFFECT = {}

function EFFECT:FixedParticle()

	local function maxLife(min, max) return math.Rand(math.min(min, self.lifeTime), math.min(max or self.lifeTime, self.lifeTime)) end

	for i = 1, 5 do
		local p = self.emitter:Add("effects/yellowflare", Vector())
		p:SetVelocity(math.Rand(111, 222) * Vector(math.Rand(3, 1), math.Rand(-1, 1), math.Rand(-1, 1)) * (self.scale))
		p:SetDieTime(maxLife(.1, .1))
		p:SetStartAlpha(200)
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(4, 2))
		p:SetEndSize(math.random(1, 1))
		p:SetStartLength(20)
		p:SetRoll(math.Rand(180, 480))
		p:SetRollDelta(math.Rand(-3, 3))

		self.splatter[i] = p
	end

	local p = self.emitter:Add("particle/smokesprites_000" .. math.random(1, 9), Vector(0, 0, 0))
	p:SetVelocity(222 * Vector(1, 0, 0))
	p:SetDieTime(maxLife(.1, .5))
	p:SetStartAlpha(math.Rand(155, 66))
	p:SetEndAlpha(0)
	p:SetStartSize(math.random(11, 22) * self.scale)
	p:SetEndSize(math.random(33, 66) * self.scale)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-3, 3))
	p:SetColor(150, 150, 150)
	p:SetGravity(Vector(0, 0, 100) * math.Rand(.2, 1))

	local p = self.emitter:Add(muzzleMaterials[math.random(1, 4)], Vector(-5, 0, 0))
	p:SetVelocity(math.Rand(222, 444) * Vector(1, 0, 0) * (self.scale))
	p:SetDieTime(maxLife(.1, .05))
	p:SetStartAlpha(200)
	p:SetEndAlpha(0)
	p:SetStartSize(math.random(44, 77) * self.scale)
	p:SetEndSize(math.random(77, 99) * self.scale)
	p:SetStartLength(66 * math.Rand(.9, 1.1) * self.scale)
	p:SetEndLength(88 * math.Rand(.9, 1.1) * self.scale)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-3, 3))

	local p = self.emitter:Add("particle/Particle_Glow_04_Additive", Vector(-7, 0, 0))
	p:SetVelocity(555 * Vector(1, 0, 0) * self.scale)
	p:SetDieTime(maxLife(.1, .05))
	p:SetStartAlpha(math.Rand(144, 180))
	p:SetEndAlpha(0)
	p:SetStartSize(math.random(5, 11) * self.scale)
	p:SetEndSize(math.random(88, 66) * self.scale)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-3, 3))
	p:SetColor(245, 120, 100)
	p:SetGravity(Vector(0, 0, 100) * math.Rand(.2, 1))

	local p = self.emitter:Add(muzzleMaterials[math.random(1, 8)], Vector(1, 0, 0))
	p:SetVelocity(math.Rand(55, 88) * Vector(1, 0, 0) * (self.scale * 2))
	p:SetDieTime(maxLife(.02, .05))
	p:SetStartAlpha(255)
	p:SetEndAlpha(150)
	p:SetStartSize(math.random(22, 32) * self.scale / 2)
	p:SetEndSize(math.random(22, 45) * self.scale / 2)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-3, 3))

	local p = self.emitter:Add(muzzleMaterials[math.random(1, 8)], Vector(1, 0, 0))
	p:SetVelocity(math.Rand(122, 333) * Vector(1, 0, 0) * (self.scale * 2))
	p:SetDieTime(maxLife(.1, .05))
	p:SetStartAlpha(255)
	p:SetEndAlpha(0)
	p:SetStartSize(math.random(22, 44) * self.scale / 2)
	p:SetEndSize(math.random(55, 22) * self.scale / 2)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-3, 3))

	local p = self.emitter:Add(muzzleMaterials[math.random(1, 8)], Vector(5, 0, 0))
	p:SetVelocity(math.Rand(144, 155) * Vector(1, 0, 0) * (self.scale * 2))
	p:SetDieTime(maxLife(.1, .05))
	p:SetStartAlpha(200)
	p:SetEndAlpha(0)
	p:SetStartSize(math.random(55, 44) * self.scale / 2)
	p:SetEndSize(math.random(99, 60) * self.scale / 2)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-3, 3))

	local angle = Angle(0, 0, 0)

	for i = 1, 2 do
		angle:RotateAroundAxis(Vector(1, 0, 0), 180)

		local p = self.emitter:Add("particle/Particle_Glow_04_Additive", angle:Right() * -4)
		p:SetVelocity(999 * angle:Right())
		p:SetDieTime(maxLife(.05, .03))
		p:SetStartAlpha(math.Rand(144, 180))
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(5, 11) * self.scale)
		p:SetEndSize(math.random(88, 66) * self.scale)
		p:SetRoll(math.Rand(180, 480))
		p:SetRollDelta(math.Rand(-3, 3))
		p:SetColor(245, 120, 100)
		p:SetGravity(Vector(0, 0, 100) * math.Rand(.2, 1))

		local p = self.emitter:Add(muzzleMaterials[math.random(3, 7)], angle:Right() * -4)
		p:SetVelocity(999 * angle:Right())
		p:SetDieTime(maxLife(.05, .04))
		p:SetStartAlpha(255)
		p:SetEndAlpha(150)
		p:SetStartSize(math.random(11, 14) * self.scale * 2)
		p:SetEndSize(math.random(13, 25) * self.scale * 1.2)
		p:SetRoll(math.Rand(180, 480))
		p:SetRollDelta(math.Rand(-3, 3))
		p:SetColor(255, 255, 255)
	end

end

function EFFECT:FreeParticle(at)

	local p = self.freeEmitter:Add("particle/smokesprites_000" .. math.random(1, 9), self.origin)
	p:SetVelocity(444 * self.dir)
	p:SetDieTime(math.Rand(.15, .3))
	p:SetStartAlpha(math.Rand(155, 66))
	p:SetEndAlpha(0)
	p:SetStartSize(math.random(11, 22) * self.scale)
	p:SetEndSize(math.random(33, 55) * self.scale)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-3, 3))
	p:SetAirResistance(222)
	p:SetColor(150, 150, 150)
	p:SetGravity(Vector(0, 0, 100) * math.Rand(.2, 1))

end

function EFFECT:Init(data)

	self.ent = data:GetEntity()
	self.scale = math.Rand(0.6, 1.1)
	self.origin = data:GetOrigin()
	self.dir = data:GetNormal()
	self.lifeTime = .1
	self.decayTime = CurTime() + self.lifeTime
	self.emitter = self.ent.emitter or ParticleEmitter(Vector(0, 0, 0))
	self.freeEmitter = ParticleEmitter(Vector(0, 0, 0))

	local hvec = Vector(65536, 65536, 65536)

	self:SetRenderBounds(-hvec, hvec)
	self.fired = false
	self.emitter:SetNoDraw(true)
	self.splatter = {}
	self:FreeParticle()
	self:FixedParticle()

	local vec = Vector(0, 2, 0)

	self.ent.push = vec

	if self.ent and self.ent.addAng then
		self.ent.addAng = self.ent.addAng + Angle(math.Rand(-1, 1), 1.5, 0) * .4
	end

end

function EFFECT:Render()

	return false

end

function EFFECT:Think()

	if self.decayTime < CurTime() then
		self:Remove()
		return false
	end

	for k, v in ipairs(self.splatter) do
		v:SetPos(v:GetPos() + VectorRand() * 2.2)
	end

	return true

end

effects.Register(EFFECT, "DSHK_BURST")

--[[------------------------------------------------------------

	DSHK IMPACT

------------------------------------------------------------]]--
local EFFECT = {}

function EFFECT:Init(data)

	local origin = data:GetOrigin()
	local normal = data:GetNormal()

	self.emitter = ParticleEmitter(Vector(0, 0, 0))
	self.lifeTime = CurTime() + 1

	local p = self.emitter:Add("particle/smokesprites_000" .. math.random(1, 9), origin)
	p:SetVelocity(666 * normal)
	p:SetDieTime(.1)
	p:SetStartAlpha(math.Rand(225, 15))
	p:SetEndAlpha(0)
	p:SetStartSize(math.random(22, 24) * 1)
	p:SetEndSize(math.random(46, 48) * 1)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-3, 3))
	p:SetColor(144, 144, 144)
	p:SetAirResistance(300)
	p:SetGravity(Vector(0, 0, 100) * math.Rand(.2, 1))

	local p = self.emitter:Add("effects/yellowflare", origin + normal * 2)
	p:SetVelocity(11 * normal)
	p:SetDieTime(.03)
	p:SetStartAlpha(math.Rand(255, 255))
	p:SetEndAlpha(0)
	p:SetStartSize(math.random(33, 66) * 1)
	p:SetEndSize(math.random(6, 8) * 1)
	p:SetRoll(math.Rand(180, 480))
	p:SetRollDelta(math.Rand(-3, 3))
	p:SetColor(255, 230, 200)
	p:SetGravity(Vector(0, 0, 100) * math.Rand(.2, 1))

	for i = 1, 4 do
		local p = self.emitter:Add(sparks[math.random(1, 2)], origin - normal * 2)
		local dir = (normal + Vector(math.Rand(-.5, .5), math.Rand(-.5, .5), math.Rand(-.5, .5)) * 1.1):Angle()
		p:SetVelocity(100 * dir:Forward())
		p:SetDieTime(.05)
		p:SetStartAlpha(math.Rand(1, 1))
		p:SetEndAlpha(0)
		p:SetStartSize(math.random(22, 44) * 1)
		p:SetEndSize(math.random(2, 1) * 1)
		p:SetStartLength(0)
		p:SetEndLength(math.Rand(1, 50))
		p:SetAirResistance(1000)
		p:SetColor(255, 230, 200)
	end

	local p = self.emitter:Add(sparks[math.random(1, 2)], origin - normal * 2)
	local dir = (normal + Vector(math.Rand(-.5, .5), math.Rand(-.5, .5), math.Rand(-.5, .5)) * 1.1):Angle()
	p:SetVelocity(100 * dir:Forward())
	p:SetDieTime(.05)
	p:SetStartAlpha(math.Rand(1, 1))
	p:SetEndAlpha(0)
	p:SetStartSize(math.random(22, 44) * 1)
	p:SetEndSize(math.random(2, 4) * 1)
	p:SetStartLength(0)
	p:SetEndLength(math.Rand(77, 100))
	p:SetAirResistance(1000)
	p:SetColor(255, 230, 200)

end

function EFFECT:Render()
end

function EFFECT:Think()

	if self.lifeTime < CurTime() then
		self.Entity:Remove()
		self:Remove()
	end

	return true

end

effects.Register(EFFECT, "DSHK_IMPACT")

--[[------------------------------------------------------------

	DSHK DRAW

------------------------------------------------------------]]--
local bones = {13, 14, 15, 16, 17, 18, 19, 20, 22}

local reloadEvents = {

	[2] = "pkm_coverup.wav",
	[8] = "pkm_bullet.wav",
	[25] = "pkm_boxout.wav",
	[47] = "pkm_boxin.wav",
	[48] = "pkm_bullet.wav",
	[70] = "pkm_coverup.wav"

}

function ENT:Draw()

	self:DrawModel()

	local owner = self:GetNWEntity("currentTurret", nil)

	if IsValid(owner) and owner:IsPlayer() then
		local aimVector = owner:GetAimVector()
		local turretForward = self:GetForward()
		local turretDot = turretForward:Dot(aimVector)

		local data = {}
		data.start = owner:GetShootPos()
		data.endpos = data.start + aimVector * 10000
		data.filter = {owner, self}

		local trace = util.TraceLine(data)

		local cappedVector = (turretForward - trace.Normal)
		cappedVector.x = math.Clamp(cappedVector.x, -.6, .6)
		cappedVector.y = math.Clamp(cappedVector.y, -.6, .6)
		cappedVector.z = math.Clamp(cappedVector.z, -.9, .3)

		local ang = (turretForward - cappedVector):Angle()

		self.addAng = self.addAng or Angle()

		local selfang = self:GetAngles()

		self.addAng = LerpAngle(FrameTime() * 10, self.addAng, Angle())

		self:ManipulateBoneAngles(1, Angle(ang[2] - selfang[2] - math.min(2, self.addAng[1]), 0, 0))
		self:ManipulateBoneAngles(4, Angle(0, 0, ang[1] - selfang[1] - math.min(2, self.addAng[2])) * -1)

		local ammoLeft = self:GetDTInt(0, 70)

		if self:GetSequence() == 2 then
			self.relLog = self.relLog or {}

			local relCycle = 74
			local cycle = self:GetCycle()
			local inReload = (cycle >= 1 / relCycle * 28 and cycle <= 1 / relCycle * 46)
			local scale = inReload and Vector() or Vector(1, 1, 1)

			for k, v in pairs(reloadEvents) do
				if (not self.relLog[k] and cycle >= 1 / relCycle * k) then
					self:EmitSound(Sound(v))
					self.relLog[k] = true
				end
			end

			for k, v in ipairs(bones) do
				self:ManipulateBoneScale(v, scale)
			end

			if (not inReload) then
				for i = 1, 8 do
					if (i < ammoLeft) then
						self:ManipulateBoneScale(bones[i], Vector(1, 1, 1))
					else
						self:ManipulateBoneScale(bones[i], Vector())
					end
				end
			end
		else
			self.relLog = {}

			for i = 1, 8 do
				if (i < ammoLeft) then
					self:ManipulateBoneScale(bones[i], Vector(1, 1, 1))
				else
					self:ManipulateBoneScale(bones[i], Vector())
				end
			end
		end
	end

end

function ENT:DrawTranslucent()

	self.emitter = self.emitter or ParticleEmitter(Vector())

	self.emitter:SetNoDraw(true)
	self.emitter:DrawAt(self:GetShootPos(), self:GetShootDir():Angle())

end