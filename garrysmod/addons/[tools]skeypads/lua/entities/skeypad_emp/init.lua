
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/ogl/ogl_keypad.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local physObj = self:GetPhysicsObject()
    if (physObj:IsValid()) then
        physObj:Wake()
    end

    self.Enabled = false
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end

function ENT:Use(ply)
    if self.Enabled then return end
    if sKeypads.Config.emp_owner_only and self:GetEMPOwner() != ply then return end

    self:TriggerEMP(ply)

    self.Enabled = true
end

function ENT:TriggerEMP(ply)
    sKeypads.Utils.RunHook("EMPTriggered", ply, self)

    for k,v in pairs(ents.FindInSphere(self:GetPos(), sKeypads.Config.emp_range)) do
        if v:GetClass() == "skeypad" and v.Process then
            v:Process(true, ply, sKeypads.Config.emp_disable_time)
        end
    end

    timer.Simple(sKeypads.Config.emp_disable_time, function()
        if not IsValid(self) then return end

        local effectdata = EffectData()
        effectdata:SetOrigin(self:GetPos())
        effectdata:SetMagnitude(30)
        util.Effect("ElectricSpark", effectdata, true, true)

        self:Remove()
    end)
end

function ENT:SetEMPOwner(ply)
    if self.Setowning_ent then self:Setowning_ent(ply) end
    self:CPPISetOwner(ply)
end

hook.Add("playerBoughtCustomEntity", "sKeypads::BuyEMP", function(ply, entTbl, ent, price)
    if ent:GetClass() == "skeypad_emp" then ent:SetEMPOwner(ply) end
end)
