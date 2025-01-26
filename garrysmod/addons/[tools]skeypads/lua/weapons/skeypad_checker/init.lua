
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.3)

    local ply = self:GetOwner()

    local tr = ply:GetEyeTrace()
    if not IsValid(tr.Entity) then return end

    local ent = tr.Entity
    if not string.StartWith(ent:GetClass(), "skeypad") then return end


    local keypadMeta = ent:GetMeta()
    net.Start("sKeypads::SendKeypadCheckerData")
     net.WriteEntity(ent)
     net.WriteEntity(keypadMeta:getFadingDoor())

     net.WriteString(keypadMeta:getName())
     net.WriteBool(keypadMeta:getProtected())
     net.WriteString(keypadMeta:getOwner():Name())
    net.Send(ply)
end

function SWEP:SecondaryAttack() end

util.AddNetworkString("sKeypads::SendKeypadCheckerData")
