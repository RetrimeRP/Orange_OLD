SWEP.Base				= "tfa_gun_base"
SWEP.Category				= "Retrime [Штурмовые винтовки]" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer = nil --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "ItzTomber" --Author Tooltip
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "" --Purpose Tooltip
SWEP.Instructions				= "" --Instructions Tooltip
SWEP.Spawnable				= true -- INSTALL SHARED PARTS
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= false		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?
SWEP.PrintName				= "FN FAL"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 2			-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			-- Position in the slot
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.

--[[WEAPON HANDLING]]--
SWEP.Primary.Sound = Sound("TFA_ANOMALY.FAL.FIRE") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound = Sound("TFA_ANOMALY.FAL.FIRE_SILENCED") -- This is the sound of the weapon, when silenced.
SWEP.Primary.PenetrationMultiplier = 1 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage = 38 -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled = true --true will handle damagetype in base
SWEP.Primary.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force = nil --Force value, leave nil to autocalc
SWEP.Primary.Knockback = 0 --Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize = 0 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = true -- Automatic/Semi Auto
SWEP.Primary.RPM = 675 -- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Semi = nil -- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Burst = nil -- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay = nil --How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay = nil -- Delay between bursts, leave nil to autocalculate
SWEP.FiresUnderwater = false
--Miscelaneous Sounds
SWEP.IronSightTime = 0.46

SWEP.IronInSound = Sound("TFA_INS2.IronIn") --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = Sound("TFA_INS2.IronOut") --Sound to play when ironsighting out?  nil for default
--Silencing
SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = false --Silenced by default?
-- Selective Fire Stuff
SWEP.SelectiveFire = true --Allow selecting your firemode?
SWEP.DisableBurstFire = true --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
SWEP.DefaultFireMode = "auto" --Default to auto or whatev
SWEP.FireModeName = nil --Change to a text value to override it
--Ammo Related
SWEP.FireSoundAffectedByClipSize = false
SWEP.Primary.ClipSize = 20 -- This is the size of a clip
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "ar2" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = false --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = 0.22-- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0.22 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.44 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 1.5 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .021 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .001*2.1 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 1.5 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0.5 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 4--How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = 1000*29.75 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 840/SWEP.Primary.Range -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Penetration Related
SWEP.MaxPenetrationCounter = 2 --The maximum number of ricochets.  To prevent stack overflows.
--Misc
SWEP.IronRecoilMultiplier = 0.7 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.9 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 1 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed  * 0.6 --Multiply the player's movespeed by this when sighting.
--[[PROJECTILES]]--
SWEP.ProjectileEntity = nil --Entity to shoot
SWEP.ProjectileVelocity = 0 --Entity to shoot's velocity
SWEP.ProjectileModel = nil --Entity to shoot's model
--[[VIEWMODEL]]--
SWEP.ViewModel			= "models/orange/weapons/v_models/fal.mdl" --Viewmodel path
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
SWEP.WorldModel			= "models/orange/weapons/w_models/wpn_fal_w.mdl" -- Weapon world model path
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
		Up = 2.6,
		Right = 1.2,
		Forward = 4.8
	},
	Ang = {
		Up = 0,
		Right = -15,
		Forward = 180
	},
	Scale = 1
} --Procedural world model animation, defaulted for CS:S purposes.

SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.
--[[SCOPES]]--
SWEP.IronSightsSensitivity = 1 --Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.
SWEP.BoltAction = false --Unscope/sight after you shoot?
SWEP.Scoped = false --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.875 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = 0.5 --Scale of the scope overlay
SWEP.ReticleScale = 0.7 --Scale of the reticle overlay
--[[SHOTGUN CODE]]--
SWEP.Shotgun = false --Enable shotgun style reloading.
SWEP.ShotgunEmptyAnim = false --Enable emtpy reloads on shotguns?
SWEP.ShotgunEmptyAnim_Shell = true --Enable insertion of a shell directly into the chamber on empty reload?
SWEP.ShellTime = .35 -- For shotguns, how long it takes to insert a shell.
--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(5, -8.7, 0.85)
SWEP.RunSightsAng = Vector(-13.2, 49.5, -10)
--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.Secondary.IronFOV = 70 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(-5.603, -2, 2.678)
SWEP.IronSightsAng = Vector(-0.42, 0, 0)

SWEP.IronSightsPos_Cmore = Vector(-5.605, -2, 1.426)
SWEP.IronSightsAng_Cmore = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_Cmore = 70

SWEP.IronSightsPos_Barska = Vector(-5.624, -2, 1.51)
SWEP.IronSightsAng_Barska = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_Barska = 70

SWEP.IronSightsPos_Eotech = Vector(-5.592, -2, 1.216)
SWEP.IronSightsAng_Eotech = Vector(0, 0, 0)
SWEP.Secondary.IronFOV_Eotech = 70

SWEP.IronSightsPos_ACOG = Vector(-5.673, 15, 1.477)
SWEP.IronSightsAng_ACOG = Vector(0.2, -0.1, 0)
SWEP.Secondary.IronFOV_ACOG = 40

--[[INSPECTION]]--
SWEP.InspectPos = Vector(7, -6, -4)
SWEP.InspectAng = Vector(20, 35, 5)
--[[VIEWMODEL ANIMATION HANDLING]]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-2,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = true --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "RifleShellEject"--Which shell effect to use
--[[VIEWMODEL PROCEDURAL ANIMATION]]--
SWEP.DoProceduralReload = false--Animate first person reload using lua?
SWEP.ProceduralReloadTime = 1 --Procedural reload time?
--[[HOLDTYPES]]--
SWEP.IronSightHoldTypeOverride = "" --This variable overrides the ironsights holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.SprintHoldTypeOverride = "" --This variable overrides the sprint holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
--[[ANIMATION]]--

SWEP.StatusLengthOverride = {
	["base_reload"] = 68 / 30,
	["base_reload_empty"] = 68 / 30,
	["foregrip_reload"] = 68 / 30,
	["foregrip_reload_empty"] = 68 / 30,
} --Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
SWEP.SequenceLengthOverride = {} --Changes both the status delay and the nextprimaryfire of a given animation
SWEP.SequenceRateOverride = {} --Like above but changes animation length to a target
SWEP.SequenceRateOverrideScaled = {} --Like above but scales animation length rather than being absolute

SWEP.ProceduralHoslterEnabled = nil
SWEP.ProceduralHolsterTime = 0.3
SWEP.ProceduralHolsterPos = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng = Vector(-40, -30, 10)

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult = 0
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
--MDL Animations Below
SWEP.IronAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "anm_idle_aim", --Number for act, String/Number for sequence
		["value_empty"] = "anm_idle_aim"
	},
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "anm_shots_aim", --Number for act, String/Number for sequence
		["value_last"] = "anm_shots_aim",
		["value_empty"] = "anm_shots_aim"
	}
}
SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "anm_idle_sprint", --Number for act, String/Number for sequence
		["value_empty"] = "anm_idle_sprint",
		["is_idle"] = true
	}
}
--[[EFFECTS]]--
--Attachments
SWEP.MuzzleAttachment			= "muzzle" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "shell" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled = true --Enable muzzle flash
SWEP.MuzzleAttachmentRaw = nil --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = nil --Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.
SWEP.SmokeParticle = false --Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = false --Disable automatic ejection smoke
--Shell eject override
SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "RifleShellEject" --The effect used for shell ejection; Defaults to that used for blowback
SWEP.LuaShellScale = 0.38
SWEP.LuaShellModel = "models/tfa/rifleshell.mdl"
--Tracer Stuff
SWEP.TracerName 		= nil 	--Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 3 	--0 disables, otherwise, 1 in X chance
--Impact Effects
SWEP.ImpactEffect = nil--Impact Effect
SWEP.ImpactDecal = nil--Impact Decal
--[[EVENT TABLE]]--
--example:
--SWEP.EventTable = {
--	[ACT_VM_RELOAD] = {
--		{ ["time"] = 0.1, ["type"] = "lua", ["value"] = function( wep, viewmodel ) end, ["client"] = true, ["server"] = true},
--		{ ["time"] = 0.1, ["type"] = "sound", ["value"] = Sound("x") }
--	}
--}
--[[RENDER TARGET]]--
SWEP.RTMaterialOverride = nil -- Take the material you want out of print(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
SWEP.RTOpaque = false -- Do you want your render target to be opaque?
SWEP.RTCode = nil--function(self) return end --This is the function to draw onto your rendertarget
--[[AKIMBO]]--
SWEP.Akimbo = false --Akimbo gun?  Alternates between primary and secondary attacks.
SWEP.AnimCycle = 0 -- Start on the right
--[[ATTACHMENTS]]--

SWEP.ViewModelBoneMods = {
}

SWEP.WorldModelBoneMods = {
}

SWEP.VElements = {
	["sight_anomaly_barska"] = { type = "Model", model = "models/orange/weapons/attachments/v_models/atta_barska/wpn_aug_a3_barska_hud.mdl", bone = "wpn_body", rel = "", pos = Vector(0.02, -0.3, -2.5), angle = Angle(-90, 90, 0), size = Vector(0.97, 0.97, 0.97), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = false },
	["sight_anomaly_barska_lense"] = { type = "Model", model = "models/orange/weapons/attachments/v_models/atta_barska/wpn_aug_a3_barska_lense_hud.mdl", bone = "wpn_body", rel = "", pos = Vector(0.02, -0.3, -2.5), angle = Angle(-90, 90, 0), size = Vector(0.97, 0.97, 0.97), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = false },
	["scope_anomaly_acog"] = { type = "Model", model = "models/orange/weapons/attachments/v_models/atta_ace21_acog/wpn_ace21_acog_hud.mdl", bone = "wpn_scope", rel = "", pos = Vector(0.05, 4.28, 7.25), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = false },
	["sight_anomaly_eotech"] = { type = "Model", model = "models/orange/weapons/attachments/v_models/atta_ace21_acog/wpn_ace21_eot_hud.mdl", bone = "wpn_body", rel = "", pos = Vector(0, -0.2, 0.8), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = false },
	["sight_anomaly_eotech_lense"] = { type = "Model", model = "models/orange/weapons/attachments/v_models/atta_ace21_acog/wpn_ace21_eot_lense_hud.mdl", bone = "wpn_body", rel = "", pos = Vector(0, -0.2, 0.8), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = false },
	["sight_anomaly_cmore"] = { type = "Model", model = "models/orange/weapons/attachments/v_models/atta_ash12/wpn_ash12_c-more.mdl", bone = "wpn_body", rel = "", pos = Vector(0, 2.65, -2.14), angle = Angle(-90, 90, 0), size = Vector(0.97, 0.97, 0.97), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = false },
	["sight_anomaly_cmore_lense"] = { type = "Model", model = "models/orange/weapons/attachments/v_models/atta_ash12/wpn_ash12_c-more_lense.mdl", bone = "wpn_body", rel = "", pos = Vector(0, 2.65, -2.14), angle = Angle(-90, 90, 0), size = Vector(0.97, 0.97, 0.97), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = false },
	["anomaly_sil_nato"] = { type = "Model", model = "models/orange/weapons/attachments/v_models/atta_silencer_phantom/wpn_addon_silencer_phantom_hud.mdl", bone = "wpn_silencer", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },

}

SWEP.WElements = {
	["sight_anomaly_barska"] = { type = "Model", model = "models/orange/weapons/attachments/w_models/atta_barska/w_aug_a3_barska_hud.mdl", bone = "wpn_body", rel = "", pos = Vector(0, 1.75, -1.5), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = false },
	["scope_anomaly_acog"] = { type = "Model", model = "models/orange/weapons/attachments/w_models/atta_ace21_acog/w_wpn_ace21_acog_hud.mdl", bone = "wpn_body", rel = "", pos = Vector(0.03, 1.68, 4.1), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = false },
	["sight_anomaly_eotech"] = { type = "Model", model = "models/orange/weapons/attachments/w_models/atta_ace21_acog/w_wpn_ace21_eot_hud.mdl", bone = "wpn_body", rel = "", pos = Vector(0.02, 1.73, 1.1), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = false },
	["sight_anomaly_cmore"] = { type = "Model", model = "models/orange/weapons/attachments/w_models/atta_ash12/w_ash12_c-more.mdl", bone = "wpn_body", rel = "", pos = Vector(0, 9.2, -2.05), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = false },
	["anomaly_sil_nato"] = { type = "Model", model = "models/orange/weapons/attachments/w_models/atta_silencer_phantom/wpn_addon_silencer_phantom_w.mdl", bone = "wpn_body", rel = "", pos = Vector(0, 1.86, -0.8), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },

}

SWEP.Attachments = {
	[1] = { offset = { 0, 0 }, atts = { "anomaly_sil_nato" }, order = 1 },
	[7] = { offset = { 0, 0 }, atts = { "anomaly_barska", "anomaly_acog", "anomaly_eotech", "anomaly_cmore" }, order = 2 },
	[2] = { offset = { 0, 0 }, atts = { "anomaly_ammo_762x51_ap"  }, order = 6 },
}

SWEP.MuzzleAttachmentSilenced = 2

SWEP.LaserSightModAttachment = 1
SWEP.LaserSightModAttachmentWorld = 4
SWEP.LaserDotISMovement = true

SWEP.RTAttachment_PSO1 = 8
SWEP.ScopeOverlayTransforms_PSO1 = { 0, 0 }
SWEP.ScopeDistanceMin_PSO1 = 3
SWEP.ScopeDistanceRange_PSO1 = 4

SWEP.RTAttachment_PSO1M21 = 8
SWEP.ScopeOverlayTransforms_PSO1M21 = { 0, 0 }
SWEP.ScopeDistanceMin_PSO1M21 = 3
SWEP.ScopeDistanceRange_PSO1M21 = 4

SWEP.RTAttachment_1P29 = 8
SWEP.ScopeOverlayTransforms_1P29 = { 0, 0 }
SWEP.ScopeDistanceMin_1P29 = 3
SWEP.ScopeDistanceRange_1P29 = 4

DEFINE_BASECLASS( SWEP.Base )
