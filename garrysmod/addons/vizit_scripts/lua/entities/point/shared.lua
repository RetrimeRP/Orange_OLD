ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Point"
ENT.Author = "VALERY"
ENT.Contact = "https://steamcommunity.com/id/valery/" -- govnocoder

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "PointName")
    self:NetworkVar("Int", 0, "CaptureRequired")
    self:NetworkVar("String",1,"WhoCapture")
    self:NetworkVar("Bool",0,"CanCapture")
    if SERVER then
        timer.Simple(0,function()
            self:SetPointName(self.uniqueName or "Random")
            self:SetCaptureRequired(VIZIT_SCRIPTS.CaptureAmount)
            self:SetWhoCapture("Никем")
            self:SetCanCapture(true)
        end)
    end
end