
include("shared.lua")

surface.CreateFont("sKeypads.Cracker.Progress", {
    font = "Roboto",
    size = ScrH() * .024,
    weight = 700,
    antialias = true
})

SWEP.CrackStartTime = 0

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.3)

    if self.IsCracking then return end

    local tr = self.Owner:GetEyeTrace()
    local ent = tr.Entity

    if IsValid(ent) and tr.HitPos:DistToSqr(self.Owner:GetShootPos()) <= 80 ^ 2 and ent:GetClass() == "skeypad" then
        self.IsCracking = true
        self.CrackStartTime = CurTime()

        self:SetWeaponHoldType("pistol")
    end
end


surface.CreateFont("sKeypads.Cracker.Message", {
    font = "Roboto",
    size = 60,
    weight = 600,
    antialias = true
})

local circleMat = Material("skeypads/circle.png", "noclamp smooth")
local centerX = -190

local function lerpColor(t, from, to)
    local result = Color(0, 0, 0)

    result.r = Lerp(t, from.r, to.r)
    result.g = Lerp(t, from.g, to.g)
    result.b = Lerp(t, from.b, to.b)
    result.a = Lerp(t, from.a, to.a)

    return result
end

function SWEP:PostDrawViewModel(vm)
    if not IsValid(vm) then return end

    local bone = vm:LookupBone("v_weapon.c4")
    if not bone then return end

    local pos, ang = vm:GetBonePosition(bone)
    if not pos then return end

    ang:RotateAroundAxis(ang:Right(), 180)
    ang:RotateAroundAxis(ang:Forward(), -90)

    cam.Start3D2D(pos - ang:Right() * 0.75 + ang:Up() * 3.6 + ang:Forward() * 4.33, ang, 0.005)
        if not self.IsCracking then
            draw.SimpleText(self.PrintName, "sKeypads.Cracker.Message", centerX, 90, sKeypads.Config.cracker_title_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.DrawText(sKeypads.Lang.crackerScreenHint, "sKeypads.Cracker.Message", centerX, 130, sKeypads.Config.cracker_hint_color, TEXT_ALIGN_CENTER)

            cam.End3D2D()
            return
        end

        draw.SimpleText(sKeypads.Lang.crackerCrackingMessage, "sKeypads.Cracker.Message", centerX, 90, sKeypads.Config.cracker_title_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        local circleSize = 50
        local circleSpacing = 20
        local circleX = centerX- (circleSize * 3 + circleSpacing * 2) / 2

        surface.SetDrawColor(lerpColor((CurTime() - self.CrackStartTime) / self.CrackTime, sKeypads.Config.cracker_start_color, sKeypads.Config.cracker_end_color))
        surface.SetMaterial(circleMat)

        for i = 0, 2 do
            surface.DrawTexturedRect(circleX + i * (circleSize + circleSpacing), 160 + math.abs(math.sin((CurTime() + i * .2) * 2)) * 25, circleSize, circleSize)
        end
    cam.End3D2D()
end
