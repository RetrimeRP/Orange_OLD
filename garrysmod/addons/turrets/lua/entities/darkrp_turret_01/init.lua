AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local MAX_DISTANCE = 6000
local SPREAD = Vector(0.014, 0.014, 0)
local SHOT_INTERVAL = 0.08

local FindAR3At, AR3Position = ZAR3_FindAR3At, ZAR3_AR3Position
ZAR3_FindAR3At, ZAR3_AR3Position = nil, nil

--
local vec0048 = Vector(0, 0, 48)
local NormalizeAngle = math.NormalizeAngle

function ENT:SpawnFunction(ply, tr)

	if not tr.Hit then return end
	local clamped = false

	if not IsValid(tr.Entity) or tr.Entity:GetModel() ~= "models/props_combine/combine_barricade_short01a.mdl" then
		self.TurretProp = ents.Create("prop_physics")
		self.TurretProp:SetModel("models/props_combine/combine_barricade_short01a.mdl")
		self.TurretProp:SetPos(tr.HitPos + vec0048)
		self.TurretProp:SetAngles(Angle(0, NormalizeAngle(ply:EyeAngles().yaw), 0))
		self.TurretProp:Spawn()
		self.TurretProp:DropToFloor()

		local phys = self.TurretProp:GetPhysicsObject()

		if IsValid(phys) then
			phys:EnableMotion(false)
		end

		tr.Entity = self.TurretProp
		clamped = true
	end

	local clamp = tr.Entity

	if FindAR3At(clamp) then
		ply:PrintMessage(bit.bor(HUD_PRINTCONSOLE, HUD_PRINTTALK), "Cannot spawn AR3 (there's already one).")
		return
	end

	self.Turret = ents.Create("darkrp_turret_01")
	self.Turret:SetPos(AR3Position(clamp))
	self.Turret:SetAngles(clamp:GetAngles())
	self.Turret:SetParent(clamp)
	self.Turret:SetCollisionGroup(COLLISION_GROUP_WORLD) -- ИЗМЕНЕНО 15.10.2022
	self.Turret:Spawn()
	self.Turret:Activate()

	clamp:DeleteOnRemove(self.Turret)

	return clamped and clamp or self.Turret

end

local angle000 = Angle(0, 0, 0)
function ENT:Initialize()

	self:SetModel("models/props_combine/bunker_gun01.mdl")
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInitShadow(false, false)
	self.NextShot = 0
	self:SetUseType(SIMPLE_USE)

	local phys = self.Entity:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Occupied = false -- ИЗМЕНЕНО 02.01.2022 -- Фикс бага, когда пулемётом могли пользоваться 2 человека одновременно
	self.LocAng = angle000
	self.LocAngVel = angle000
	self:SetPoseParameter("aim_yaw", 0)
	self:SetPoseParameter("aim_pitch", 0)
	self:ResetSequence("idle_inactive")
	self:StartMotionController()

end

function ENT:Think()

	if IsValid(self.Controller) then
		self:GetPhysicsObject():Wake()

		if not self.Controller:Alive() or (self.Controller:GetPos() - self:GetPos()):LengthSqr() > MAX_DISTANCE then
			self:Abandon()
		elseif CurTime() > self.NextShot and self.Shooting then
			local muzzleTach = self:LookupAttachment("muzzle")
			local attach = self:GetAttachment(muzzleTach)

			local bullet = {}
			bullet.Num = 1
			bullet.Src = attach.Pos
			bullet.Dir = attach.Ang:Forward()
			bullet.Spread = SPREAD
			bullet.Tracer = 1
			bullet.TracerName = "AR2Tracer"
			bullet.Force = 20
			bullet.Damage = 44
			bullet.Attacker = self.Controller

			self:FireBullets(bullet)

			local effd = EffectData()
			effd:SetEntity(self)
			effd:SetAngles(attach.Ang)
			effd:SetOrigin(attach.Pos + attach.Ang:Forward() * 5)
			effd:SetScale(1)
			effd:SetAttachment(muzzleTach)
			effd:SetFlags(5)

			util.Effect("MuzzleFlash", effd)

			self:EmitSound("Weapon_FuncTank.Single")
			self.NextShot = CurTime() + SHOT_INTERVAL
			self:ResetSequence("fire")
		end
	end

	self:NextThink(CurTime())

	return true

end

function ENT:TakeOver(ply)

	if IsValid(self.Controller) or IsValid(ply.ZAR3) then return end

	self.Occupied = true

	self:EmitSound("Func_Tank.BeginUse")

	ply:Flashlight(false)

	local seq, dur = self:LookupSequence("activate")
	self:ResetSequence(seq)

	timer.Simple(dur, function()
		if IsValid(ply) and ply.ZAR3 == self then
			self.Controller = ply
		end
	end)

	self.NextShot = CurTime() + dur

	umsg.Start("ZAR3_S", ply)
	umsg.Entity(self)
	umsg.End()

	timer.Simple(dur, function()
		if not IsValid(self) then return end
		local phys = self:GetPhysicsObject()
		if not IsValid(phys) then return end

		phys:Wake()
	end)

	ply.ZAR3 = self

end

function ENT:Use(activator, caller)

	if (activator:GetPos() - self:GetPos()):LengthSqr() > MAX_DISTANCE then return end

	if IsValid(self.Controller) then
		if self.Controller == activator then
			self:Abandon()
		end

		return
	end

	if self.Occupied then return end

	self:TakeOver(activator)

end

function ENT:Abandon()

	self:ResetSequence("retract")

	umsg.Start("ZAR3_S", self.Controller)
	umsg.Entity(NULL)
	umsg.End()

	self.Controller.ZAR3 = nil
	self.Controller = nil
	self.Shooting = false
	self.Occupied = false
	self:SetPoseParameter("aim_yaw", "0")
	self:SetPoseParameter("aim_pitch", "0")
	self.LocAng = Angle(0, 0, 0)
	self:GetPhysicsObject():Sleep()

end

function ENT:EnableFlashlight()

	if not IsValid(self.Flashlight) then
		self:CreateFlashlight()
	end

	if not IsValid(self.FlashlightFocus) then
		local lightAttach = self:LookupAttachment("light")
		local attach = self:GetAttachment(lightAttach)

		local flashlight = ents.Create("env_projectedtexture")
		flashlight:SetPos(attach.Pos)
		flashlight:SetAngles(attach.Ang)
		flashlight:SetKeyValue("enableshadows", "1")
		flashlight:SetKeyValue("farz", "2048")
		flashlight:SetKeyValue("nearz", "8")
		flashlight:SetKeyValue("lightfov", "23")
		flashlight:SetKeyValue("lightcolor", "147 226 240")
		flashlight:Spawn()
		flashlight:Fire("SpotlightTexture", "effects/flashlight001")
		flashlight:SetParent(self)
		flashlight:Fire("SetParentAttachment", "light")

		self.FlashlightFocus = flashlight
	end

	self.Flashlight:Fire("LightOn")
	self.FlashlightOn = true

end

local function FindCone(ent, retry)

	if not IsValid(ent) or not IsValid(ent.Flashlight) then
		if retry < 10 then
			timer.Simple(1, function()
				FindCone(ent, retry + 1)
			end)
		end

		return
	end

	for k, v in pairs(ents.FindByClass("spotlight_end")) do
		if v:GetOwner() == ent.Flashlight then
			ent.FlashlightCone = v

			return
		end
	end

	if retry < 10 then
		timer.Simple(1, function()
			FindCone(ent, retry + 1)
		end)
	end

end

function ENT:CreateFlashlight()

	if not IsValid(self.Flashlight) then
		local lightAttach = self:LookupAttachment("light")
		local attach = self:GetAttachment(lightAttach)

		local flashlight = ents.Create("point_spotlight")
		flashlight:SetPos(attach.Pos)
		flashlight:SetAngles(attach.Ang)
		flashlight:SetKeyValue("maxdxlevel", "0")
		flashlight:SetKeyValue("mindxlevel", "0")
		flashlight:SetKeyValue("rendermode", "0")
		flashlight:SetKeyValue("disablereceivershadows", "0")
		flashlight:SetKeyValue("renderfx", "0")
		flashlight:SetKeyValue("HDRColorScale", "1.0")
		flashlight:SetKeyValue("spotlightwidth", "70")
		flashlight:SetKeyValue("renderamt", "255")
		flashlight:SetKeyValue("spotlightlength", "2048")
		flashlight:SetKeyValue("rendercolor", "147 226 240")
		flashlight:SetKeyValue("spawnflags", "0")
		flashlight:Spawn()
		flashlight:SetParent(self)
		flashlight:Fire("SetParentAttachment", "light")

		timer.Simple(0, function()
			FindCone(self, 0)
		end)

		self.Flashlight = flashlight
		self.FlashlightOn = false
	end

end

function ENT:DisableFlashlight()

	if IsValid(self.Flashlight) then
		self.Flashlight:Fire("LightOff")
		self.FlashlightOn = false
	end

	if IsValid(self.FlashlightFocus) then
		self.FlashlightFocus:Remove()
	end

end

local Clamp = math.Clamp
local AngleDifference = math.AngleDifference
function ENT:TrackTarget()

	local angles = self:AimBarrelAtPlayerCrosshair()
	local currentAngles = self.LocAng
	local yawDiff = Clamp(AngleDifference(angles.yaw, currentAngles.yaw), -5, 5)
	local pitchDiff = Clamp(AngleDifference(angles.pitch, currentAngles.pitch), -5, 5)

	self.LocAng.yaw = NormalizeAngle(currentAngles.yaw + yawDiff)
	self.LocAng.pitch = NormalizeAngle(currentAngles.pitch + pitchDiff)

end

function ENT:CalcPlayerCrosshairTarget()

	local player = self.Controller
	local vecStart, vecDir
	local tr
	vecStart = player:EyePos()
	vecDir = player:GetAimVector()

	tr = util.TraceLine({
		start = vecStart + vecDir * 24,
		endpos = vecStart + vecDir * 8192,
		mask = MASK_OPAQUE_AND_NPCS,
		filter = {self, player, self:GetParent()}
	})

	return tr.HitPos

end

function ENT:AimBarrelAtPlayerCrosshair()

	local vecTarget = self:CalcPlayerCrosshairTarget()

	return self:AimBarrelAt(self:WorldToLocal(vecTarget))

end

local vec20018 = Vector(20.8, 0, 18.15)
local atan2 = math.atan2
local sqrt = math.sqrt
local Rad2Deg = math.Rad2Deg
function ENT:AimBarrelAt(parentTarget)

	local m_barrelPos = vec20018
	local target = parentTarget - self:WorldToLocal(self:GetAttachment(self:LookupAttachment("aimrotation")).Pos)

	local quadTarget = target:LengthSqr()
	quadTargetXY = target.x * target.x + target.y * target.y

	local targetToCenterYaw = atan2(target.y, target.x)
	local centerToGunYaw = atan2(m_barrelPos.y, sqrt(quadTarget - (m_barrelPos.y * m_barrelPos.y)))
	local targetToCenterPitch = atan2(target.z, sqrt(quadTargetXY))
	local centerToGunPitch = atan2(-m_barrelPos.z, sqrt(quadTarget - (m_barrelPos.z * m_barrelPos.z)))

	return Angle(NormalizeAngle(-Rad2Deg(targetToCenterPitch + centerToGunPitch)), NormalizeAngle(Rad2Deg(targetToCenterYaw + centerToGunYaw)), 0)

end

local m_yawCenter, m_pitchCenter = 0, 7.5
local m_yawRange, m_yawTolerance = 60, 15
local m_pitchRange, m_pitchTolerance = 60, 15
local m_yawRate, m_pitchRate = 200, 120

local abs = math.abs
function ENT:RotateTankToAngles(angles)

	local bClamped = false
	local offsetY = AngleDifference(angles.yaw, m_yawCenter)
	local offsetX = AngleDifference(angles.pitch, m_pitchCenter)
	local flActualYaw = m_yawCenter + offsetY
	local flActualPitch = m_pitchCenter + offsetX

	if (abs(offsetY) > m_yawRange + m_yawTolerance) or (abs(offsetX) > m_pitchRange + m_pitchTolerance) then
		flActualYaw = Clamp(flActualYaw, m_yawCenter - m_yawRange, m_yawCenter + m_yawRange)
		flActualPitch = Clamp(flActualPitch, m_pitchCenter - m_pitchRange, m_pitchCenter + m_pitchRange)

		bClamped = true
	end

	local vecAngVel = self.LocAngVel
	local distY = AngleDifference(flActualYaw, self:GetPoseParameter("aim_yaw"))
	vecAngVel.yaw = distY * 10
	vecAngVel.yaw = Clamp(vecAngVel.yaw, -m_yawRate, m_yawRate)

	local distX = AngleDifference(flActualPitch, self:GetPoseParameter("aim_pitch"))
	vecAngVel.pitch = distX * 10
	vecAngVel.pitch = Clamp(vecAngVel.pitch, -m_pitchRate, m_pitchRate)

	self.LocAngVel = vecAngVel

	return bClamped

end

function ENT:PhysicsSimulate()

	if not IsValid(self) or not IsValid(self.Controller) then return SIM_NOTHING end

	local newAngles = self.Controller:EyeAngles()
	local oldangles = self:GetAngles()
	newAngles.pitch = NormalizeAngle(newAngles.pitch - oldangles.pitch)
	newAngles.yaw = NormalizeAngle(newAngles.yaw - oldangles.yaw)

	local angles = Angle(self:GetPoseParameter("aim_pitch"), self:GetPoseParameter("aim_yaw"), 0)
	local newPitch = Clamp(AngleDifference(newAngles.pitch + 7, angles.pitch), -1, 1)
	local newYaw = Clamp(AngleDifference(newAngles.yaw, angles.yaw), -2, 2)

	self:SetPoseParameter("aim_yaw", Clamp(NormalizeAngle(angles.yaw + newYaw), -60, 60))
	self:SetPoseParameter("aim_pitch", Clamp(NormalizeAngle(angles.pitch + newPitch), -35, 50))

	return SIM_NOTHING

end

function ENT:OnRemove()

	FindCone(self, 10)

	self:DisableFlashlight()

	if IsValid(self.Controller) then
		self:Abandon()
	end

	if IsValid(self.FlashlightCone) then
		self.FlashlightCone:Remove()
	end

end

concommand.Add("zar3_attack", function(ply, cmd, args)

	if not IsValid(ply.ZAR3) then return end

	ply.ZAR3.Shooting = args[1] == "1"

end)

hook.Add("PlayerSwitchFlashlight", "_ZAR3PlayerSwitchFlashlight", function(ply, on)

	if IsValid(ply.ZAR3) then
		ply.ZAR3[(ply.ZAR3.FlashlightOn and "Disable" or "Enable") .. "Flashlight"](ply.ZAR3)

		return false
	end

end)

hook.Add("PhysgunDrop", "_ZAR3PhysgunDrop", function(ply, ent)

	if IsValid(ent) and ent.ZAR3NoCollided then
		local phys = ent:GetPhysicsObject()

		if IsValid(phys) then
			phys:EnableMotion(false)
		end
	end

end)