
SWEP.Base = "weapon_base"

SWEP.PrintName = "Base Keypad Cracker"
SWEP.Author = "Tom.bat & NoSharp"
SWEP.Instructions = sKeypads.Lang.crackerDescription
SWEP.Category = sKeypads.Lang.systemName
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/weapons/v_c4.mdl")
SWEP.WorldModel = Model("models/weapons/w_c4.mdl")

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.AnimPrefix = "python"

SWEP.Sound = Sound("weapons/deagle/deagle-1.wav")

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.Primary.ClipSize = 0
SWEP.Primary.Ammo = ""
SWEP.Secondary.Ammo = ""

SWEP.CrackTime = 10
SWEP.Deployable = false

function SWEP:Initialize()
    self:SetHoldType("slam")
end

function SWEP:SecondaryAttack()
    self.IsCracking = false
end

function SWEP:Reload()
    return true
end

function SWEP:Reset()
    if SERVER then
        self:CallOnClient("Reset")

        if IsValid(self.CrackingEnt) then
            self.CrackingEnt:StopCrackEffects()
        end
    end

    self.IsCracking = false
    self.CrackingEnt = nil

    self:SetWeaponHoldType("slam")
end
