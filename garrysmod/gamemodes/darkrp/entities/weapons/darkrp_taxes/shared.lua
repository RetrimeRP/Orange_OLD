SWEP.Category = "Role Play"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.PrintName = "СБОР НАЛОГОВ"
SWEP.ViewModelFOV = 54
SWEP.WorldModel = ""
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false
SWEP.Weight = 1
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Slot = 1
SWEP.SlotPos = 44

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

function SWEP:PreDrawViewModel()

	return true

end

function SWEP:PrimaryAttack()
    local trace = self:GetOwner():GetEyeTrace()
    local target = trace.Entity
    if not IsValid(target) or not target:IsPlayer() or target:GetPos():DistToSqr(self:GetOwner():GetPos()) > 10000 then return end
	local price = math.random(2500,5000)

    if not target:IsCWU() then
        if SERVER then
            DarkRP.notify(self:GetOwner(), 1, 3, "Это не Сотрудник ГСР!")
        end

        return
    end

    target.fucktime = target.fucktime or 0

    if target.fucktime > CurTime() then
        if SERVER then
            DarkRP.notify(self:GetOwner(), 1, 3, "С этого рабочего недавно собирали налог!")
        end

        return
    end

    if SERVER and target:getDarkRPVar("money") <= 6500 then
        if SERVER then
            DarkRP.notify(self:GetOwner(), 1, 3, "Этот рабочий не имеет токенов!")
        end

        return
    end

    target.fucktime = CurTime() + 600
    self:EmitSound("npc/combine_soldier/gear6.wav", 50, 100)

    if SERVER then
        target:addMoney(-price, "Сбор налогов")
        self:GetOwner():addMoney(price, "Сбор налогов")

        DarkRP.notify(self:GetOwner(), 3, 3, "Вы собрали налог в размере " .. DarkRP.formatMoney(price) .. " с " .. target:Name())
        DarkRP.notify(target, 3, 3, self:GetOwner():Name() .." Собрал налог в размере " .. DarkRP.formatMoney(price))
    end

    self:GetOwner():EmitSound("npc/combine_soldier/gear6.wav", 50, 110)
end