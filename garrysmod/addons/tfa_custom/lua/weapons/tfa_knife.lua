SWEP.Category = "TFA Weapons"
SWEP.Spawnable = true
SWEP.PrintName = "НОЖ"
SWEP.Base = "tfa_knife_base"
SWEP.Author = "VALERY"
SWEP.Contact = "https://steamcommunity.com/id/valery/"
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.ViewModelFOV = 54
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.Weight = 2
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.UseHands = true

-- WEAPON HANDLING
SWEP.Primary.Damage = 25
SWEP.Primary.Length = 60
SWEP.Secondary.Damage = 50
SWEP.Secondary.Length = 55

-- WORLDMODEL
SWEP.HoldType = "knife"

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-9, 0, 0)

function SWEP:ThrowKnife()
end

function SWEP:Reload()
end

function SWEP:CycleFireMode()
end

function SWEP:CycleSafety()
end