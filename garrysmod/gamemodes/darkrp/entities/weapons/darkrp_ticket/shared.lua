AddCSLuaFile()

if SERVER then

	util.AddNetworkString("OpenTicketMenu")
	AddCSLuaFile("cl_menu.lua")

end

if CLIENT then

	include("cl_menu.lua")

end

SWEP.Category = "Role Play"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.PrintName = "МИГРАЦИОННЫЙ БИЛЕТ"
SWEP.Instructions = "ЛКМ чтобы показать себе\nПКМ чтобы показать другому"
SWEP.ViewModelFOV = 54
SWEP.WorldModel = ""
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false
SWEP.Weight = 1
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = true
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 1
SWEP.SlotPos = 54

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false

SWEP.UseHands = false

SWEP.Reasons = {

	"Перевод из другого места",
	"Работа на ГСР",
	"Служба Альянсу"

}

function SWEP:Initialize()

	self:SetHoldType("normal")

	self.LastUse = CurTime()

	self.City = "Сити " .. math.random(1, 99)

	if self.City == "Сити 82" then
		self.City = "Сити 28"
	end

	self.Reason = self.Reasons[math.random(#self.Reasons)]

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
	if self.LastUse > CurTime() then return end

	local ent = self.Owner:GetEyeTrace().Entity

	if not ent:IsPlayer() then return end
	if ent:GetPos():DistToSqr(self.Owner:GetPos()) > 16384 then return end
	if not self.City then return end
	if not self.Reason then return end

	self.LastUse = CurTime() + 2

	DarkRP.notify(self.Owner, 0, 5, "Вы спросили у " .. ent:Nick() .. ", хочет ли он посмотреть ваш миграционный билет")

	DarkRP.createQuestion(self.Owner:Nick() .. " хочет показать вам свой миграционный билет", "showticket" .. tostring(self.Owner:EntIndex()), ent, 8, function(answer)
		if not tobool(answer) then return end

		net.Start("OpenTicketMenu")
		net.WriteEntity(self.Owner)
		net.WriteString(self.City)
		net.WriteString(self.Reason)
		net.Send(ent)

		DarkRP.notify(self.Owner, 0, 4, "Вы показали " .. ent:Nick() .. " миграционный билет")
	end)

end

function SWEP:SecondaryAttack()

	if CLIENT then return end
	if self.LastUse > CurTime() then return end

	if not self.City then return end
	if not self.Reason then return end

	self.LastUse = CurTime() + 2

	net.Start("OpenTicketMenu")
	net.WriteEntity(self.Owner)
	net.WriteString(self.City)
	net.WriteString(self.Reason)
	net.Send(self.Owner)

	DarkRP.notify(self.Owner, 0, 3, "Вы посмотрели на свой миграционный билет")

end