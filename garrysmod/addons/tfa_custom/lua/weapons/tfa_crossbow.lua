SWEP.Category = "TFA Weapons"
SWEP.Spawnable = true
SWEP.PrintName = "АРБАЛЕТ"
SWEP.Base = "tfa_scoped_base"
SWEP.Author = "VALERY"
SWEP.Contact = "https://steamcommunity.com/id/valery/"
SWEP.ViewModel = "models/weapons/c_crossbow.mdl"
SWEP.ViewModelFOV = 54
SWEP.WorldModel = "models/weapons/w_crossbow.mdl"
SWEP.Weight = 5
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.Slot = 3
SWEP.SlotPos = 3
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.UseHands = true

-- WEAPON HANDLING
SWEP.Primary.Sound = Sound("Weapon_Crossbow.Single")
SWEP.Primary.Damage = 260
SWEP.Primary.RPM = 1000
SWEP.Primary.KickUp = 1
SWEP.Primary.KickDown = 1
SWEP.Primary.KickHorizontal = 1
SWEP.Primary.Spread = .023
SWEP.Primary.IronAccuracy = .0001

SWEP.FiresUnderwater = false

-- WORLDMODEL
SWEP.HoldType = "crossbow"

-- SCOPES
SWEP.BoltAction = true
SWEP.Scoped = true
SWEP.ScopeScale = 0.6
SWEP.Secondary.UseMilDot = true

-- SPRINTING
SWEP.RunSightsPos = Vector(0, -8, 0)
SWEP.RunSightsAng = Vector(-7.9, 17.9, -14.2)

-- IRONSIGHTS
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 30
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

-- EFFECTS
SWEP.DoMuzzleFlash = false
SWEP.MuzzleAttachment = "muzzle"
SWEP.ShellEjectAttachment = "0"

-- EVENT TABLE
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{
			["time"] = 1,
			["type"] = "sound",
			["value"] = Sound("weapons/crossbow/bolt_load" .. math.random(1, 2) .. ".wav"),
			["client"] = true,
			["server"] = false
		}
	}
}

if CLIENT then
	local reloadstatus = TFA.Enum.ReloadStatus

	function SWEP:Think()
		if self:Clip1() == 1 then
			self:SendWeaponAnim(ACT_VM_IDLE)
		end

		if self:Clip1() == 0 and not reloadstatus[self:GetStatus()] then
			self.Weapon:SendWeaponAnim(ACT_VM_FIDGET)
		end
	end
end

if SERVER then
	-- ShootBulletInformation
	function SWEP:ShootBulletInformation()
		local owner = self:GetOwner()

		local pos = owner:GetShootPos()

		local aim = owner:GetAimVector()
		local ang = aim:Angle()

		local bolt = ents.Create("crossbow_bolt")
		bolt:SetPos(pos)
		bolt:SetAngles(ang)
		bolt:SetOwner(owner)
		bolt:Spawn()
		bolt:SetVelocity(aim * 3000)
	end

	-- EntityTakeDamage
	hook.Add("EntityTakeDamage", "crossbowbolt_dmg", function(ent, dmg)
		local inflictor = dmg:GetInflictor()

		if IsValid(inflictor) and inflictor:GetClass() == "crossbow_bolt" then
			dmg:SetDamageType(DMG_NEVERGIB)
			dmg:SetDamage(260)

			local owner = inflictor:GetOwner()

			if owner and IsValid(owner) then
				dmg:SetAttacker(owner)
			end
		end
	end)
end