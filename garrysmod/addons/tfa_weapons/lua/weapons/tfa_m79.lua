SWEP.Base				= "tfa_gun_base"
SWEP.Category				= "Retrime [Донат оружие]" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer = nil --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "ItzTomber" --Author Tooltip
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.Spawnable				= true -- INSTALL SHARED PARTS
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= false		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?
SWEP.PrintName				= "M79"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 4			-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			-- Position in the slot
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30		
SWEP.MoveSpeed				= 1
SWEP.Type = "Гранатомёт"

SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox		= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   	= false		-- Should the weapon icon bounce?
SWEP.HoldType 				= "rpg"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg makes for good sniper rifles


SWEP.FiresUnderwater = false
SWEP.DisableChambering = true
SWEP.FireSoundAffectedByClipSize = false

SWEP.Primary.Sound			= "TFA_ANOMALY.M79.FIRE"
SWEP.Primary.RPM			= 200			-- This is in Rounds Per Minute
SWEP.Primary.ClipSize			= 1		-- Size of a clip
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize		-- Bullets you start with
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.KickUp			= 0.25	-- Maximum up recoil (rise)
SWEP.Primary.KickDown			= 0.25		-- Maximum down recoil (skeet)
SWEP.Primary.KickHorizontal		= 0.50		-- Maximum up recoil (stock)
SWEP.Primary.Automatic			= false	-- Automatic = true; Semi Auto = false
SWEP.Primary.Ammo			= "ammo_m209"			-- pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, AirboatGun
SWEP.Primary.Force = nil --Force value, leave nil to autocalc
SWEP.Primary.Knockback = 0 --Autodetected if nil; this is the velocity kickback

SWEP.Primary.Spread = .076 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .076 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 1.5 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0.5 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 4--How much the spread recovers, per second. Example val: 3

SWEP.Primary.StaticRecoilFactor = 3.02 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
SWEP.IronRecoilMultiplier = 0.9 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.9 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate



SWEP.SmokeParticle = false --Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable

SWEP.SelectiveFire		= false
SWEP.DisableBurstFire = false --Only auto/single?
SWEP.Shotgun = false --Enable shotgun style reloading.


SWEP.data 				= {}				--The starting firemode

SWEP.Primary.Damage		= 150	-- Base damage per bullet

-- Enter iron sight info and bone mod info below
SWEP.IronSightTime = 0.46

SWEP.Secondary.IronFOV			= 70		-- How much you 'zoom' in. Less is more! 	
SWEP.IronSightsPos = Vector(-4.8265, 3, -3.493)
SWEP.IronSightsAng = Vector(9.15, 0, 0)

SWEP.RunSightsPos = Vector(7, -4.8, 0.7)
SWEP.RunSightsAng = Vector(-15, 50, -11)
SWEP.InspectPos = Vector(9, -6, -4)
SWEP.InspectAng = Vector(20, 35, 5)


SWEP.MuzzleAttachment			= "1" 	-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "shell" 	-- Should be "2" for CSS models or "1" for hl2 models

SWEP.ViewModel			= "models/orange/weapons/v_models/m79.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 55		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.VMPos = Vector(0,0,0) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(0,0,0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = true --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CenteredPos = nil --The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng = nil --The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V = nil --{
	--[0] = 1,
	--[1] = 4,
	--[2] = etc.
--}
--[[WORLDMODEL]]--
SWEP.WorldModel			= "models/orange/weapons/w_models/wpn_m79_w.mdl" -- Weapon world model path
SWEP.Bodygroups_W = nil --{
--[0] = 1,
--[1] = 4,
--[2] = etc.
--}
SWEP.HoldType = "ar2" -- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = 3.7,
		Right = 1.3,
		Forward = 4.7
	},
	Ang = {
		Up = 5,
		Right = -15,
		Forward = 180
	},
	Scale = 1
} --Procedural world model animation, defaulted for CS:S purposes.

SWEP.VElements = {
}

SWEP.Attachments = {
}

SWEP.WElements = {

}

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_ANI --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult = 0
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "lancew_m79_sprint", --Number for act, String/Number for sequence
		["value_empty"] = "lancew_m79_sprint",
		["is_idle"] = true
	}
}

SWEP.ProjectileEntity = "anomaly_40mm_rocket" --Entity to shoot
SWEP.ProjectileVelocity = 295 * 16 / 12 * 39.3701  --Entity to shoot's velocity
SWEP.ProjectileModel = "models/orange/ammo/ammo_m209.mdl" --Entity to shoot
