AddCSLuaFile()

if SERVER then

	AddCSLuaFile("cl_menu.lua")

end

if CLIENT then

	SWEP.PrintName = "КЛЮЧИ"
	SWEP.Slot = 1
	SWEP.SlotPos = 98
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false

	include("cl_menu.lua")

end

SWEP.Instructions = "Left click to lock\nRight click to unlock\nReload for door settings or animation menu"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IsDarkRPKeys = true

SWEP.WorldModel = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "rpg"

SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "Role Play"
SWEP.Sound = "doors/door_latch3.wav"

SWEP.Primary.Delay = 0.3
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.Delay = 0.3
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()

	self:SetHoldType("normal")

end

function SWEP:Deploy()

	if CLIENT or not IsValid(self:GetOwner()) then return true end

	self:GetOwner():DrawWorldModel(false)

	return true

end

function SWEP:Holster()

	return true

end

function SWEP:PreDrawViewModel()

	return true

end

local function lookingAtLockable(ply, ent, hitpos)

	local eyepos = ply:EyePos()

	return IsValid(ent) and ent:isKeysOwnable() and (ent:isDoor() and eyepos:DistToSqr(hitpos) < 2000 or ent:IsVehicle() and eyepos:DistToSqr(hitpos) < 4000)

end

local function lockUnlockAnimation(ply, snd)

	ply:EmitSound("npc/metropolice/gear" .. math.floor(math.Rand(1, 7)) .. ".wav")

	timer.Simple(0.9, function()
		if IsValid(ply) then
			ply:EmitSound(snd)
		end
	end)

	ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)

end

local function doKnock(ply, sound)

	ply:EmitSound(sound, 100, math.random(90, 110))

	ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, true)

end

function SWEP:PrimaryAttack()

	local trace = self:GetOwner():GetEyeTrace()

	if not lookingAtLockable(self:GetOwner(), trace.Entity, trace.HitPos) then return end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	if CLIENT then return end

	if self:GetOwner():canKeysLock(trace.Entity) then
		trace.Entity:keysLock()
		lockUnlockAnimation(self:GetOwner(), self.Sound)
	elseif trace.Entity:IsVehicle() then
		DarkRP.notify(self:GetOwner(), 1, 3, DarkRP.getPhrase("do_not_own_ent"))
	else
		doKnock(self:GetOwner(), "physics/wood/wood_crate_impact_hard2.wav")
	end

end

function SWEP:SecondaryAttack()

	local trace = self:GetOwner():GetEyeTrace()

	if not lookingAtLockable(self:GetOwner(), trace.Entity, trace.HitPos) then return end

	self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)

	if CLIENT then return end

	if self:GetOwner():canKeysUnlock(trace.Entity) then
		trace.Entity:keysUnLock()
		lockUnlockAnimation(self:GetOwner(), self.Sound)
	elseif trace.Entity:IsVehicle() then
		DarkRP.notify(self:GetOwner(), 1, 3, DarkRP.getPhrase("do_not_own_ent"))
	else
		doKnock(self:GetOwner(), "physics/wood/wood_crate_impact_hard3.wav")
	end

end

function SWEP:Reload()

	local trace = self:GetOwner():GetEyeTrace()

	if not IsValid(trace.Entity) or ((not trace.Entity:isDoor() and not trace.Entity:IsVehicle()) or self.Owner:EyePos():DistToSqr(trace.HitPos) > 40000) then
		return
	end

	if SERVER then
		umsg.Start("KeysMenu", self:GetOwner())
		umsg.End()
	end

end