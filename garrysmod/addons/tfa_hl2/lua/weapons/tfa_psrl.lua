SWEP.Category = "Retrime [Альянс]"
SWEP.Spawnable = true
SWEP.PrintName = "PSR-L"
SWEP.Base = "tfa_scoped_base"
SWEP.Author = "VALERY"
SWEP.Contact = "https://steamcommunity.com/id/valery/"
SWEP.ViewModel = "models/retrime/weapons/c_sniper1.mdl"
SWEP.ViewModelFOV = 54
SWEP.WorldModel = "models/retrime/weapons/w_sniper1.mdl"
SWEP.Weight = 5
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.DrawCrosshair = false
SWEP.Slot = 3
SWEP.SlotPos = 4
SWEP.Primary.Ammo = "SniperPenetratedRound"
SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize
SWEP.Primary.Automatic = true
SWEP.UseHands = true

-- WEAPON HANDLING
SWEP.Primary.Sound = Sound("Weapon_G3SG1.Single")
SWEP.Primary.Damage = 100
SWEP.Primary.RPM = 300
SWEP.DisableChambering = true
SWEP.Primary.KickUp = 0.9
SWEP.Primary.KickDown = 0.9
SWEP.Primary.KickHorizontal = 0.9
SWEP.Primary.Spread = 1
SWEP.Primary.IronAccuracy = .0001
SWEP.IronSightsMoveSpeed = 0.52

SWEP.FiresUnderwater = false

-- MISCELANEOUS SOUNDS
SWEP.IronInSound = "sniper_military_zoom.wav"

-- WORLDMODEL
SWEP.HoldType = "ar2"

-- SCOPES
SWEP.Scoped = true
SWEP.ScopeScale = 0.667
SWEP.Secondary.UseMilDot = true

-- SPRINTING
SWEP.RunSightsPos = Vector(2, -6, -3)
SWEP.RunSightsAng = Vector(-10, 26, -5.2)

-- IRONSIGHTS
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 15
SWEP.IronSightsPos = Vector(0, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

-- EFFECTS
SWEP.MuzzleAttachment = "muzzle"
SWEP.ShellEjectAttachment = "shell"
SWEP.MuzzleFlashEffect = "tfa_muzzleflash_sniper_energy"

SWEP.TracerName = "AR2Tracer"
SWEP.TracerCount = 1