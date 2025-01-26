AddCSLuaFile()

do

	util.PrecacheModel("models/pg_props/pg_weapons/pg_cp_shield_w.mdl")

end

SWEP.Category = "Role Play"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.PrintName = "ЩИТ"
SWEP.ViewModelFOV = 54
SWEP.WorldModel = ""
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false
SWEP.Weight = 1
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 1
SWEP.SlotPos = 67

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false

SWEP.UseHands = false

function SWEP:Initialize()

	self:SetHoldType("melee2")

end

function SWEP:PreDrawViewModel()

	return true

end

function SWEP:CanPrimaryAttack()

	return false

end

function SWEP:CanSecondaryAttack()

	return false

end

if SERVER then

	function SWEP:CreateShield()
		if self.Shield then return end

		local attachment = self.Owner:LookupAttachment("anim_attachment_head")

		self.Shield = ents.Create("prop_physics")
		self.Shield:SetModel("models/pg_props/pg_weapons/pg_cp_shield_w.mdl")
		self.Shield:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self.Shield:SetMoveType(MOVETYPE_NONE)
		self.Shield:SetPos(self.Owner:GetPos())
		self.Shield:SetParent(self.Owner, attachment)
		self.Shield:SetLocalAngles(Angle(65, 75, -10))
		self.Shield:SetLocalPos(Vector(2, -53, -30))
		self.Shield:Spawn()
	end

	function SWEP:RemoveShield()
		if self.Shield then
			if not IsValid(self.Shield) then self.Shield = nil return end

			self.Shield:Remove()
			self.Shield = nil
		end
	end

	function SWEP:Deploy()
		self:CreateShield()
		self.Owner:DrawWorldModel(false)
		return true
	end

	function SWEP:Holster()
		self:RemoveShield()
		return true
	end

	function SWEP:OnRemove()
		self:RemoveShield()
	end

	function SWEP:OnDrop()
		self:RemoveShield()
		return true
	end

end