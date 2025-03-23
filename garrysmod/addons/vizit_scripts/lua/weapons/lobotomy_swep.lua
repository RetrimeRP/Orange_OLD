AddCSLuaFile()

SWEP.Base = "weapon_base"
SWEP.PrintName = "ЛОБОТОМИЯ"
SWEP.Author = "vizit"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "Retrime [Альянс]"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.Ammo = "none"
SWEP.UseHands = true
SWEP.HoldType = "normal"
SWEP.ViewModel = ""
SWEP.WorldModel = ""
SWEP.cooldownTime = 300
SWEP.injectDelay = 2

if SERVER then
    function SWEP:Initialize()
        self.nextUse = 0
        self.nextChatTime = 0
    end
    local function getAllowDistance(ply,target)
        return ply:GetPos():Distance(target:GetPos()) <= 100
    end

    function SWEP:PrimaryAttack()
        local ply = self:GetOwner()
        if not IsValid(ply) or CurTime() < self.nextUse then
            if CurTime() >= self.nextChatTime then
                ply:ChatPrint("Инъекция еще невозможна. Следующая инъекция через: " .. math.ceil(self.nextUse - CurTime()) .. " секунд.")
                self.nextChatTime = CurTime() + 3
            end
            return
        end

        local tr = ply:GetEyeTrace()
        local target = tr.Entity

        if IsValid(target) and target:IsPlayer() and target:Alive() then
            if target:IsMPF() or target:IsOTA() or target:IsGuardian() then
                DarkRP.notify(ply, 1, 6, "Нельзя сделать ему инъекцию")
                self.nextUse = CurTime() + self.cooldownTime
                self.nextChatTime = CurTime() + 5
                return
            end
            
            -- local dist = ply:GetPos():Distance(target:GetPos())
            if getAllowDistance(ply,target) then
                ply:ConCommand("say /me Достает шприц и готовится к инъекции...")
                
                timer.Simple(self.injectDelay, function()
                    if IsValid(ply) and IsValid(target) and target:Alive() and getAllowDistance(ply,target) then
                        ply:ConCommand("say /me Вкалывает неизвестный шприц.")
                        playSounds(target, 30)
                    end
                end)
            end
        end

        self.nextUse = CurTime() + self.cooldownTime
        self.nextChatTime = CurTime()
    end
end

function SWEP:SecondaryAttack()
end
