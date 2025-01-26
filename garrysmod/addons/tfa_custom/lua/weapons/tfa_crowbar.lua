SWEP.Category = "Old"
SWEP.Spawnable = true
SWEP.PrintName = "МОНТИРОВКА"
SWEP.Base = "tfa_melee_base"
SWEP.Author = "VALERY"
SWEP.Contact = "https://steamcommunity.com/id/valery/"
SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.ViewModelFOV = 54
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.Weight = 2
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = true
SWEP.UseHands = true

-- WORLDMODEL
SWEP.HoldType = "melee"

SWEP.Primary.MaxCombo = -1

SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSCENTER,
		["len"] = 55,
		["src"] = Vector(0, 0, 0),
		["dir"] = Vector(0, 12, 0),
		["dmg"] = 60,
		["dmgtype"] = bit.bor(DMG_CLUB, DMG_SLASH),
		["delay"] = 0.1,
		["spr"] = true,
		["snd"] = "Weapon_Crowbar.Single",
		["hitflesh"] = "Weapon_Crowbar.Melee_Hit",
		["hitworld"] = "Weapon_Crowbar.Melee_Hit",
		["viewpunch"] = Angle(0, 1, 0),
		["end"] = 0.575,
		["hull"] = 10,
		["callback"] = function(tbl, wep, tr)
			if tr.Hit then
				wep:PlaySwing(ACT_VM_HITCENTER)
			end
		end
	}
}

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end