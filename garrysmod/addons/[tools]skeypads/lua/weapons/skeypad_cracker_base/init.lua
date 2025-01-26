
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.3)

    if self.IsCracking then return end

    local tr = self.Owner:GetEyeTrace()
    local ent = tr.Entity

    if IsValid(ent) and tr.HitPos:DistToSqr(self.Owner:GetShootPos()) <= 80 ^ 2 and ent:GetClass() == "skeypad" then
        if self.Deployable then
            ent:DeployCracker(self.Owner, self.CrackTime, self.ClassName)
            self.Owner:StripWeapon(self:GetClass())
            return
        end

        self.IsCracking = true
        self.CrackingEnt = ent
        self.CrackStartTime = CurTime()

        self:SetWeaponHoldType("pistol")

        ent:StartCrackEffects(self.CrackTime)
    end
end

function SWEP:Holster()
    self:Reset()

    return true
end

function SWEP:Successful()
    self.IsCracking = false

    if IsValid(self.CrackingEnt) then
        self.CrackingEnt:Process(true, self.Owner)
    end

    self:Reset()
end

function SWEP:Think()
    if self.IsCracking then
        if not IsValid(self.CrackingEnt) then
            self:Reset()
        end

        local tr = self.Owner:GetEyeTrace()
        if not IsValid(tr.Entity) or tr.Entity != self.CrackingEnt or tr.HitPos:DistToSqr(self.Owner:GetShootPos()) > 80 ^ 2 then
            self:Reset()
        elseif CurTime() > self.CrackStartTime + self.CrackTime then
            self:Successful()
        end
    end

    self:NextThink(CurTime())
    return true
end
