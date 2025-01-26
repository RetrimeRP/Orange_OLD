AddCSLuaFile()

if CLIENT then

	SWEP.PrintName = "ДУБИНКА"
	SWEP.Slot = 0
	SWEP.SlotPos = 0
	SWEP.RenderGroup = RENDERGROUP_BOTH

	killicon.AddAlias("stunstick", "weapon_stunstick")

	CreateMaterial("darkrp/stunstick_beam", "UnlitGeneric", {
		["$basetexture"] = "sprites/lgtning",
		["$additive"] = 1
	})

end

DEFINE_BASECLASS("darkrp_stick")

SWEP.Instructions = "Left click to discipline\nRight click to kill\nHold reload to threaten"
SWEP.IsDarkRPStunstick = true

SWEP.Spawnable = true
SWEP.Category = "Role Play"

SWEP.StickColor = Color(255, 255, 255)

function SWEP:Initialize()

	BaseClass.Initialize(self)

	self.Hit = {
		Sound("weapons/stunstick/stunstick_impact1.wav"),
		Sound("weapons/stunstick/stunstick_impact2.wav")
	}

	self.FleshHit = {
		Sound("weapons/stunstick/stunstick_fleshhit1.wav"),
		Sound("weapons/stunstick/stunstick_fleshhit2.wav")
	}

end

function SWEP:SetupDataTables()

	BaseClass.SetupDataTables(self)

	self:NetworkVar("Float", 6, "LastReload")

end

function SWEP:Think()

	BaseClass.Think(self)

	if self.WaitingForAttackEffect and self:GetSeqIdleTime() ~= 0 and CurTime() >= self:GetSeqIdleTime() - 0.35 then
		self.WaitingForAttackEffect = false

		local owner = self:GetOwner()

		local effectData = EffectData()
		effectData:SetOrigin(owner:GetShootPos() + (owner:EyeAngles():Forward() * 45))
		effectData:SetNormal(owner:EyeAngles():Forward())

		util.Effect("StunstickImpact", effectData)
	end

end

function SWEP:DoFlash(ply)

	if IsValid(ply) and ply:IsPlayer() then
		ply:ScreenFade(SCREENFADE.IN, color_white, 1.2, 0)
	end

end

local stunstickMaterial = Material("sprites/light_glow02_add")
local stunstickBeam = Material("!darkrp/stunstick_beam")

function SWEP:PostDrawViewModel(vm)

	if self:GetSeqIdleTime() ~= 0 or self:GetLastReload() >= CurTime() - 0.1 then
		local attachment = vm:GetAttachment(1)
		local pos = attachment.Pos

		cam.Start3D(EyePos(), EyeAngles())
			render.SetMaterial(stunstickMaterial)
			render.DrawSprite(pos, 12, 12, Color(255, 255, 255))

			for i = 1, 3 do
				local randVec = VectorRand() * 3
				local offset = (attachment.Ang:Forward() * randVec.x) + (attachment.Ang:Right() * randVec.y) + (attachment.Ang:Up() * randVec.z)

				render.SetMaterial(stunstickBeam)
				render.DrawBeam(pos, pos + offset, 3.25 - i, 1, 1.25, Color(180, 180, 180))

				pos = pos + offset
			end
		cam.End3D()
	end

end

local light_glow02_add = Material("sprites/light_glow02_add")

function SWEP:DrawWorldModelTranslucent()

	if CurTime() <= self:GetLastReload() + 0.1 then
		local owner = self:GetOwner()
		local bone = owner:LookupBone("ValveBiped.Bip01_R_Hand")

		if not bone then
			self:DrawModel()
			return
		end

		local bonePos, boneAng = owner:GetBonePosition(bone)

		if bonePos then
			local pos = bonePos + (boneAng:Up() * -16) + (boneAng:Right() * 3) + (boneAng:Forward() * 6.5)

			render.SetMaterial(light_glow02_add)
			render.DrawSprite(pos, 32, 32, Color(255, 255, 255))
		end
	end

	self:DrawModel()

end

local entMeta = FindMetaTable("Entity")

function SWEP:DoAttack(dmg)

	if CLIENT then return end

	local owner = self:GetOwner()

	owner:LagCompensation(true)

	local trace = util.QuickTrace(owner:EyePos(), owner:GetAimVector() * 90, {owner})

	owner:LagCompensation(false)

	local ent = trace.Entity

	if IsValid(ent) and ent.onStunStickUsed then
		ent:onStunStickUsed(owner)
		return
	end

	self.WaitingForAttackEffect = true

	local ent = owner:getEyeSightHitEntity(self.stickRange, 15, fn.FAnd{fp{fn.Neq, owner}, fc{IsValid, entMeta.GetPhysicsObject}, entMeta.IsSolid})

	if not IsValid(ent) then return end
	if not ent:IsPlayer() then return end
	if not ent:Alive() then return end
	if ent:Team() == TEAM_FSG then return end

	if dmg > 0 then
		ent:TakeDamage(dmg, owner, self)
	end

	self:DoFlash(ent)
	owner:EmitSound(self.FleshHit[math.random(#self.FleshHit)])

	if ent:IsMPF() then return end
	if ent:IsOTA() then return end
	if ent:IsResistance() then return end
	if ent:IsGuild() then return end
	if ent:IsGuardian() then return end

	local timername = "DarkRP_Stunstick" .. tostring(ent:EntIndex())

	if timer.Exists(timername) then
		ent:Freeze(false)
		timer.Remove(timername)
	end

	ent:Freeze(true)

	timer.Create(timername, 4, 1, function()
		if IsValid(ent) then
			ent:Freeze(false)
		end
	end)

end

function SWEP:PrimaryAttack()

	BaseClass.PrimaryAttack(self)

	self:SetNextSecondaryFire(self:GetNextPrimaryFire())
	self:DoAttack(0)

end

function SWEP:SecondaryAttack()

	BaseClass.PrimaryAttack(self)

	self:SetNextSecondaryFire(self:GetNextPrimaryFire())
	self:DoAttack(10)

end

function SWEP:Reload()

	self:SetHoldTypeChangeTime(CurTime() + 0.1)

	if self:GetLastReload() + 0.1 > CurTime() then
		self:SetLastReload(CurTime())
		return
	end

	self:SetLastReload(CurTime())
	self:EmitSound("weapons/stunstick/spark" .. math.random(1, 3) .. ".wav")

end