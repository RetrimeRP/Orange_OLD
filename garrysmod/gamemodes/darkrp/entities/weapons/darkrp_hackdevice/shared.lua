AddCSLuaFile()

SWEP.Category = "Role Play"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.PrintName = "ВЗЛОМЩИК"
SWEP.Contact = "https://steamcommunity.com/id/valery/"
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/v_emptool.mdl"
SWEP.WorldModel = "models/weapons/w_emptool.mdl"
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false
SWEP.Weight = 1
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 5
SWEP.SlotPos = 3

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false

SWEP.UseHands = false

SWEP.NextUse = 0

function SWEP:PrimaryAttack()

	if self.NextUse > CurTime() then return end

	self.NextUse = CurTime() + 4

	local trace = self:GetOwner():GetEyeTrace()
	local ent = trace.Entity

	if not ent then return end
	if not IsValid(ent) then return end
	if ent:GetPos():DistToSqr(self:GetOwner():GetPos()) > 65536 then return end

	if SERVER then
		if ent:GetClass() == "func_door" then
			timer.Simple(1, function()
				if !DarkRP.IsCombineDoor()[ent:EntIndex()] then
				    ent:Fire("Open", "", .35)
					ent:EmitSound("AlyxEMP.Discharge")
				end
			end)
		end

		if ent:GetClass() == "darkrp_forcefield" then
			timer.Simple(1, function()
				ent:ToggleEnabled()
				ent:EmitSound("AlyxEMP.Discharge")
			end)
		end
	end

end

function SWEP:SecondaryAttack()

	self:PrimaryAttack()

end

function SWEP:Holster()

	return true

end