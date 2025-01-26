SWEP.Gun = ("tfa_hl2_oicw")

SWEP.Category               = "Retrime [Альянс]"
SWEP.Manufacturer 			= "Smertnik and ItzTomber" 
SWEP.Author				= "ItzTomber"

SWEP.PrintName				= "AR29 OICW"	
SWEP.Slot					= 2
SWEP.SlotPos				= 1
SWEP.ViewModelFOV			= 60
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= false
SWEP.Weight					= 30
SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= true
SWEP.HoldType 				= "ar2"
SWEP.ViewModelFlip			= false
SWEP.Spawnable				= true
SWEP.UseHands 				= true
SWEP.AdminSpawnable			= true
SWEP.ViewModel				= "models/weapons/schwarzkruppzo/c_oicw.mdl"
SWEP.WorldModel				= "models/weapons/schwarzkruppzo/w_oicw.mdl"
SWEP.Base					= "tfa_gun_base"
SWEP.FiresUnderwater = true
SWEP.Secondary.IronFOV			= 50	
SWEP.data 				= {}

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 0,
        Forward = 0,
        },
        Ang = {
        Up = -1,
        Right = -2,
        Forward = 178
        },
		Scale = 1
}

SWEP.VMPos = Vector(0, 0, 0) -- The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.
SWEP.VMAng = Vector(0, 0, 0) -- The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive = true -- Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.AllowReloadWhileDraw = true
SWEP.AllowReloadWhileHolster = true
SWEP.AllowReloadWhileSprinting = true
SWEP.AllowReloadWhileNearWall = true

SWEP.Primary.NumShots	= 1
SWEP.Primary.Damage		= 40
SWEP.Primary.Sound			= Sound("Weapon_OICW.Fire")
SWEP.Primary.SilencedSound 	= Sound("weapons/tfa_ins2/mp7/fp_suppressed.wav")
SWEP.Primary.RPM			= 600

SWEP.DefaultFireMode = "auto"
SWEP.SelectiveFire = true --Allow selecting your firemode?
SWEP.Primary.RPM_Burst = 500 -- RPM for burst fire, overrides semi.  This is in Rounds Per Minute / RPM
SWEP.Primary.BurstDelay = 0.3 -- Delay between bursts, leave nil to autocalculate
SWEP.BurstFireCount = 3
SWEP.FireModes = {"Automatic","3Burst","Single"}
SWEP.Primary.ClipSize			= 30
SWEP.Primary.DefaultClip 		= SWEP.Primary.ClipSize
SWEP.Primary.KickUp				= 0.32
SWEP.Primary.MaxKick 			= 0.4
SWEP.Primary.KickDown			= 0.16
SWEP.Primary.KickHorizontal		= 0.08
SWEP.Primary.StaticRecoilFactor = 0.50 
SWEP.Primary.Automatic			= true
SWEP.DisableChambering = false
SWEP.Primary.Ammo			= "ar2"
SWEP.Secondary.Ammo			= "SMG1_Grenade"
SWEP.Secondary.Sound		= Sound("Weapon_OICW.Fire2")
SWEP.Secondary.ClipSize				= -1
SWEP.Secondary.DefaultClip			= 0
SWEP.Primary.Spread		= .014
SWEP.Primary.IronAccuracy = .0025
SWEP.Primary.Force = nil --Force value, leave nil to autocalc
SWEP.Primary.Knockback = 0 --Autodetected if nil; this is the velocity kickback
SWEP.data.ironsights			= 1

SWEP.IronInSound = Sound("TFA_INS2.IronIn") --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = Sound("TFA_INS2.IronOut") --Sound to play when ironsighting out?  nil for default

SWEP.IronSightsPos = Vector(-4.625, 0, 0.85)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunSightsPos = Vector(-1.14, -1.005, -0.679)
SWEP.RunSightsAng = Vector(-14.07, 5.548, -11.256)

SWEP.IronRecoilMultiplier	= 0.7
SWEP.CrouchRecoilMultiplier	=0.9

SWEP.Primary.SpreadMultiplierMax = 2 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = 1/1.5 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = 3 --How much the spread recovers, per second.

SWEP.InspectPos = Vector(8.843, -3.016, -1.005)
SWEP.InspectAng = Vector(10.553, 43.618, 0)

SWEP.MuzzleAttachment			= "muzzle" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "1" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled = true --Enable muzzle flash
SWEP.MuzzleAttachmentRaw = nil --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = ( TFA and TFA.YanKys_Realistic_Muzzleflashes ) and "tfa_muzzleflash_rifle" or "tfa_muzzleflash_rifle"
SWEP.SmokeParticle = nil --Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = false --Disable automatic ejection smoke

SWEP.SecondaryMuzzleFlash = "tfa_muzzleflash_shotgun"

SWEP.Blowback_Shell_Enabled = true --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect 	= "RifleShellEject"--Which shell effect to use
SWEP.LuaShellEject 			= true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay 	= 0 --The delay to actually eject things
SWEP.LuaShellEffect 		= "RifleShellEject" --The effect used for shell ejection; Defaults to that used for blowback

SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{["time"] = 0.179, ["type"] = "sound", ["value"] = Sound("Weapon_OICW.ClipOut")},
		{["time"] = 1.606, ["type"] = "sound", ["value"] = Sound("Weapon_OICW.ClipIn")}
	},
	[ACT_VM_DRAW] = {
		{["time"] = 0.1, ["type"] = "sound", ["value"] = Sound("Weapon_OICW.Draw")},
		{["time"] = 0.3, ["type"] = "sound", ["value"] = Sound("Weapon_OICW.BoltForward")},
		{["time"] = 0.666, ["type"] = "sound", ["value"] = Sound("Weapon_OICW.BoltBack")},
	},
	[ACT_VM_HOLSTER] = {
		{["time"] = 0.1, ["type"] = "sound", ["value"] = Sound("TFA_INS2.Holster")},
	},
}


SWEP.IronAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "idle", --Number for act, String/Number for sequence
		["value_empty"] = "idle"
	}, --Looping Animation

	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_1, --Number for act, String/Number for sequence
		//["value_last"] = ACT_VM_PRIMARYATTACK_1,
		//["value_empty"] = ACT_VM_PRIMARYATTACK_1
	} --What do you think
}

SWEP.WalkAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "walk", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
}

SWEP.Attachments = {
	[1] = { atts = { "oicw_si" }, sel = "oicw_si", default = "oicw_si" },
}

SWEP.VElements = {
	["scope_oicw"] = { type = "Model", model = "models/weapons/schwarzkruppzo/a_optic_oicw.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 200, 200, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
}

SWEP.MuzzleAttachmentSilenced = 1

SWEP.LaserSightModAttachment      = 1
SWEP.LaserSightModAttachmentWorld = 0

SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Walk_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0.5
SWEP.WalkBobMult = 0.5

DEFINE_BASECLASS( "tfa_gun_base" )

function SWEP:CanSecondaryAttack()
	if self:Ammo2() < 1 then
		if !self.HasPlayedEmptyClick then
			self:EmitSound("Weapon_OICW.Empty")

			self.HasPlayedEmptyClick = true
		end

		return false
	end
	
	if self.FiresUnderwater == false and self:GetOwner():WaterLevel() >= 3 then
		self:SetNextSecondaryFire(CurTime() + 0.5)
		self:EmitSound("Weapon_OICW.Empty")

		return false
	else
		return true
	end
end

local sp = game.SinglePlayer()
function SWEP:AltAttack()
	local vecSrc = self.Owner:GetShootPos()
	local Forward = self.Owner:EyeAngles():Forward()
	local Right = self.Owner:EyeAngles():Right()
	local Up = self.Owner:EyeAngles():Up()
	local vecThrow = self.Owner:GetAimVector() * 1000
	
	if CurTime() > self:GetNextSecondaryFire() and self:CanSecondaryAttack() and self:Ammo2() > 0 and TFA.Enum.ReadyStatus[self:GetStatus()] and !self:GetSprinting() then
		if SERVER then
			local ent = ents.Create("grenade_ar2")
			self:EmitSound(self.Secondary.Sound)
			if self:GetIronSights() then
				ent:SetPos(self.Owner:EyePos() + ( self.Owner:GetAimVector() * 25 ))
			else
				ent:SetPos(self.Owner:GetShootPos() + Forward * 12 + Right * 6 + Up * 0 )
			end
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:Spawn()
			ent:Activate()
			ent:SetVelocity(Forward * 1750)
            ent:SetOwner(self.Owner)
		end

		self:SendViewModelAnim(ACT_VM_SECONDARYATTACK)
		
		local fx1 = EffectData()
		fx1:SetEntity(self)
		fx1:SetAttachment(self:LookupAttachment("muzzle2"))
		fx1:SetOrigin(self.Owner:GetShootPos())
		fx1:SetNormal(self.Owner:GetAimVector())
		util.Effect(self.SecondaryMuzzleFlash, fx1)
		
		self:SetNextSecondaryFire(CurTime() + 1.0)

		self:TakeSecondaryAmmo(1)

		if !sp then
			self:EmitSoundSafe(self.Secondary.Sound)
		else
			self:EmitSound(self.Secondary.Sound)
		end
	end
end