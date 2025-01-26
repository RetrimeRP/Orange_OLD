SWEP.Category				= "Retrime [Холодное оружие]"
SWEP.Author				= "ItzTomber"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Топор"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 3			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "knife"		-- how others view you carrying the weapon
SWEP.Type = "Топор"
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/orange/weapons/v_models/wpn_axe2.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/orange/weapons/w_models/wpn_axe3.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "tfa_knife_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 1.2,
		Forward = 4
	},
	Ang = {
		Up = 0,
		Right = 90,
		Forward = 0
	},
	Scale = 1.0
}

SWEP.ViewModelFOV			= 55		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.

SWEP.SlashTable = {"anm_attack", "anm_attack"} --Table of possible hull sequences
SWEP.StabTable = {"anm_attack2"} --Table of possible hull sequences
SWEP.StabMissTable = {"anm_attack2"} --Table of possible hull sequences

SWEP.Primary.RPM = 50 --Primary Slashs per minute
SWEP.Secondary.RPM = 50 --Secondary stabs per minute
SWEP.Primary.Delay = 0.8 --Delay for hull (primary)
SWEP.Secondary.Delay = 0.8 --Delay for hull (secondary)
SWEP.Primary.Damage = 42
SWEP.Secondary.Damage = 62

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1

SWEP.Primary.Sound = Sound("weapons/orange/axe/knife_1.wav", "weapons/orange/axe/knife_2.wav", "weapons/orange/axe/knife_3.wav") --Sounds
SWEP.KnifeShink = Sound("weapons/orange/axe/impact_wpn_large_asphalt2.wav", "weapons/orange/axe/impact_wpn_large_earth1.wav")
SWEP.KnifeSlash = Sound("weapons/orange/axe/hurt4.wav")
SWEP.KnifeStab = Sound("weapons/orange/axe/knife_1.wav", "weapons/orange/axe/knife_2.wav", "weapons/orange/axe/knife_3.wav")

SWEP.Primary.Length = 60
SWEP.Secondary.Length = 55

SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)

SWEP.InspectPos = Vector(5, -6, -3)
SWEP.InspectAng = Vector(20, 35, 5)

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "anm_idle_sprint", --Number for act, String/Number for sequence
		["is_idle"] = true
	}
}


function SWEP:ThrowKnife()
end