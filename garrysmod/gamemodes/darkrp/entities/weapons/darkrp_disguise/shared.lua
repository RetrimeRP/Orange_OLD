if SERVER then

	util.AddNetworkString("OpenDisguiseMenu")
	AddCSLuaFile("cl_menu.lua")

end

if CLIENT then

	include("cl_menu.lua")

end

SWEP.Category = "Role Play"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.PrintName = "МАСКИРОВКА"
SWEP.Author = "VALERY"
SWEP.Contact = "https://steamcommunity.com/id/valery/"
SWEP.ViewModelFOV = 54
SWEP.WorldModel = ""
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false
SWEP.Weight = 1
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 5
SWEP.SlotPos = 1

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false

SWEP.UseHands = false

function SWEP:Initialize()

	self:SetHoldType("normal")

end

function SWEP:Deploy()

	local owner = self:GetOwner()

	if CLIENT or not IsValid(owner) then return true end

	owner:DrawWorldModel(false)

	return true

end

function SWEP:Holster()

	return true

end

function SWEP:PreDrawViewModel()

	return true

end

function SWEP:PrimaryAttack()

	if CLIENT then return end

	net.Start("OpenDisguiseMenu")
	net.Send(self:GetOwner())

end

function SWEP:SecondaryAttack()

	if CLIENT then return end

	net.Start("OpenDisguiseMenu")
	net.Send(self:GetOwner())

end