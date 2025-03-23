ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Point"
ENT.Author = "VALERY"
ENT.Contact = "https://steamcommunity.com/id/valery/" -- govnocoder
-- ПРОСТИ ГОСПОДЬ(
function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "PointName")
    self:NetworkVar("Int", 0, "CaptureRequired")
    self:NetworkVar("String", 3, "WhoWin")
    self:NetworkVar("String",1,"WhoCapture")
    self:NetworkVar("Bool",0,"CanCapture")
    if SERVER then
        timer.Simple(0,function()
            self:SetPointName(self.uniqueName or "Random")
            self:SetCaptureRequired(VIZIT_SCRIPTS.CaptureAmount)
            self:SetWhoCapture("Никем")
            self:SetCanCapture(true)
            self:SetWhoWin("Никем")
        end)
    end
end
-- Здраствуйте, если вы это читаете значит я проломил себе череп, за говнокод мне стыдно, но нетку постоянно кидать мне тоже не хочется, поймите меня.