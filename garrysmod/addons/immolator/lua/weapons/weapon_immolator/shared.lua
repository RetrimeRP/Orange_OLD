SWEP.Category = "Other"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.PrintName = "ИММОЛЯТОР"
SWEP.Author = "VALERY"
SWEP.Contact = "https://steamcommunity.com/id/valery/"
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/retrime/orange/weapons/v_immolator.mdl"
SWEP.WorldModel = ""
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false
SWEP.Weight = 1
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.Slot = 1
SWEP.SlotPos = 44

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false

SWEP.UseHands = false

local immolator_attack = Sound("fire_large")

--[[------------------------------------------------------------

	Stop Sounds, Initialize, Think

------------------------------------------------------------]]--
function SWEP:StopSounds()

	if self.EmittingSound then
		self.EmittingSound = false
		self:StopSound(immolator_attack)
	end

end

function SWEP:Initialize()

	self:SetHoldType("normal")

	self.EmittingSound = false
	self.NextCheck = CurTime()

end

function SWEP:Think()

	local owner = self:GetOwner()

	if owner:KeyReleased(IN_ATTACK) then
		self:StopSounds()
	end

end

--[[------------------------------------------------------------

	Primary Attack, Secondary Attack

------------------------------------------------------------]]--
function SWEP:PrimaryAttack()

	local owner = self:GetOwner()

	-- WaterLevel
	if owner:WaterLevel() > 1 then
		self:StopSounds()
		return
	end

	-- Alive
	if not owner:Alive() then
		self:StopSounds()
		return
	end

	-- EmittingSound
	if not self.EmittingSound then
		self.EmittingSound = true
		self:EmitSound(immolator_attack)
	end

	-- TraceHull
	local pos = owner:GetShootPos()
	local ang = owner:GetAimVector()

	local trace = {}
	trace.start = pos
	trace.endpos = pos + (ang * 356)
	trace.filter = owner

	--if owner:IsPlayer() then
		owner:LagCompensation(true)
	--end

	local tr = util.TraceHull(trace)

	--if owner:IsPlayer() then
		owner:LagCompensation(false)
	--end

	local scale = (tr.HitPos - pos):Length()
	scale = (scale > 256 and 256) or scale
	scale = (scale < 6 and 6) or scale

	local att = owner:LookupAttachment("muzzle")
	att = (att > 0 and owner:GetAttachment(att).Pos) or pos

	local effect = EffectData()
	effect:SetEntity(self)
	effect:SetAttachment(1)
	effect:SetOrigin(att)
	effect:SetNormal(ang)
	effect:SetScale(scale)

	util.Effect("immolator", effect)

	if SERVER then
		if self.NextCheck > CurTime() then return end

		self.NextCheck = CurTime() + 0.3

		-- ent
		local ent = tr.Entity

		if IsValid(ent) then
			-- IgnitePlayer
			if ent:IsPlayer() then
				self:IgnitePlayer(ent, owner)
				return
			end

			if not ent:IsOnFire() then
				local class = ent:GetClass()

				-- IgniteBuild
				if class == "prop_physics" and ent.EntityOwner then
					self:IgniteBuild(ent, ent.EntityOwner)
					return
				end

				-- IgniteCorpse
				if class == "darkrp_corpse" then
					self:IgniteCorpse(ent, owner)
					return
				end
			end
		end
	end

end

function SWEP:SecondaryAttack()
end

--[[------------------------------------------------------------

	Holster, On Remove

------------------------------------------------------------]]--
function SWEP:Holster()

	self:StopSounds()
	return true

end

function SWEP:OnRemove()

	self:StopSounds()
	return true

end