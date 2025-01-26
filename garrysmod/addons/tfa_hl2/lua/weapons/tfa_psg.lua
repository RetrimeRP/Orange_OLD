TFA.AddFireSound("TFA_PSG.Single", {"retrime/weapons/psg/fire.wav"}, false, ")")
TFA.AddWeaponSound("TFA_PSG.Reload", "retrime/weapons/psg/reload.wav")

SWEP.Category = "Retrime [Альянс]"
SWEP.Spawnable = true
SWEP.PrintName = "PSG"
SWEP.Base = "tfa_gun_base"
SWEP.Author = "VALERY"
SWEP.Contact = "https://steamcommunity.com/id/valery/"
SWEP.ViewModel = "models/retrime/weapons/c_psg.mdl"
SWEP.ViewModelFOV = 54
SWEP.WorldModel = "models/retrime/weapons/w_psg.mdl"
SWEP.Weight = 4
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.Slot = 3
SWEP.SlotPos = 2
SWEP.DrawCrosshair = false
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize
SWEP.Primary.Automatic = true
SWEP.UseHands = true

-- WEAPON HANDLING
SWEP.Primary.Sound = Sound("TFA_PSG.Single")
SWEP.Primary.Damage = 8
SWEP.Primary.NumShots = 12
SWEP.Primary.RPM = 350
SWEP.DisableChambering = true
SWEP.Primary.KickUp = 0.8
SWEP.Primary.KickDown = 1
SWEP.Primary.KickHorizontal = 0.6
SWEP.Primary.Spread = .07
SWEP.Primary.IronAccuracy = .07

SWEP.FiresUnderwater = true

-- WORLDMODEL
SWEP.HoldType = "ar2"

-- RANGE RELATED
SWEP.Primary.Range = 512
SWEP.Primary.RangeFalloff = 512

-- SPRINTING
SWEP.RunSightsPos = Vector(1.7, -5.6, 0)
SWEP.RunSightsAng = Vector(-4.9, 26, -5.2)

-- IRONSIGHTS
SWEP.data = {}
SWEP.data.ironsights = 0

-- EFFECTS
SWEP.MuzzleAttachment = "muzzle"
SWEP.ShellEjectAttachment = "shell"
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_energy"

SWEP.TracerName = "AR2Tracer"
SWEP.TracerCount = 1

-- EVENT TABLE
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{
			["time"] = 1,
			["type"] = "sound",
			["value"] = Sound("TFA_PSG.Reload")
		}
	}
}