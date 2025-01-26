SWEP.Category = "TFA Weapons"
SWEP.Spawnable = true
SWEP.PrintName = "РПГ"
SWEP.Base = "tfa_gun_base"
SWEP.Author = "VALERY"
SWEP.Contact = "https://steamcommunity.com/id/valery/"
SWEP.ViewModel = "models/weapons/c_rpg.mdl"
SWEP.ViewModelFOV = 54
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"
SWEP.Weight = 5
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.DrawCrosshair = false
SWEP.Slot = 4
SWEP.SlotPos = 2
SWEP.Primary.Ammo = "RPG_Round"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.UseHands = true

-- WEAPON HANDLING
SWEP.Primary.Sound = Sound("Weapon_Rpg.Single")
SWEP.DisableChambering = true

-- WORLDMODEL
SWEP.HoldType = "rpg"

-- SPRINTING
SWEP.RunSightsPos = Vector(0, -14, -2)
SWEP.RunSightsAng = Vector(-10, 40, 0)

-- IRONSIGHTS
SWEP.data = {}
SWEP.data.ironsights = 0

function SWEP:ShootBulletInformation()
	if CLIENT then return end

	local owner = self:GetOwner()
	local ang = owner:GetAimVector()

	local rocket = ents.Create("tfa_missile")
	rocket:SetPos(owner:GetShootPos())
	rocket:SetOwner(owner)
	rocket.Activator = owner

	rocket.FlyAngle = ang:Angle()

	rocket:Spawn()

	local phys = rocket:GetPhysicsObject()

	if IsValid(phys) then
		phys:AddGameFlag(FVPHYSICS_NO_PLAYER_PICKUP)
		phys:SetVelocity(ang * 70000)
	end
end