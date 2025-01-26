local ColorAlpha = ColorAlpha
local include = include
local CreateFont = CreateFont
local LocalPlayer = LocalPlayer
local Vector = Vector
local Angle = Angle
local VIZIT_SCRIPTS = VIZIT_SCRIPTS

local cam3d2d = VIZIT_SCRIPTS.cam3D2D

local clrAlpha = ColorAlpha
local whiteColor = VIZIT_SCRIPTS.COLOR_VGUI[1]
local captureColor = VIZIT_SCRIPTS.COLOR_VGUI[2]
local fmt = string.format
local drawText = draw.SimpleText
local lerp = Lerp
local math_clamp = math.Clamp
local curTime = CurTime
local text
include("shared.lua")
CreateFont("pointText@Noto Sans@196")
CreateFont("pointTextCapture@Noto Sans@86")
CreateFont("pointTextControlled@Noto Sans@66")
function ENT:Draw()
    text = "Вы не можете это захватить"

    self:DrawModel()
    local distSqr = self:GetPos():DistToSqr(LocalPlayer():GetPos())
    local lerpDistSqr, maxDistSqr = 40000, 64000
    self.StartTime = (distSqr <= maxDistSqr and not self.EndTime) and (self.StartTime or curTime()) or nil
    self.EndTime = (distSqr > maxDistSqr and not self.StartTime) and (self.EndTime or curTime()) or nil

    local name = self:GetPointName() or "Неизвестная точка"
    local captureAmount = self:GetCaptureRequired()
    local whoCapture = self:GetWhoCapture()
    if self:CanCapture(LocalPlayer()) then
        captureColor = VIZIT_SCRIPTS.COLOR_VGUI[3]
        text = "Вы можете это захватить"
    end
    local min, max = self:GetModelBounds()
    local pos = self:GetPos() + (min + max) * 0.3 + Vector(0.5, 0, max.z)
    local Ang = self:GetAngles() + Angle(0, 90, 90)
    local elapsedTime = self.StartTime and (curTime() - self.StartTime) or 0
    local fadeOutTime = self.EndTime and (curTime() - self.EndTime) or 0

    local lerpFactor = math_clamp(elapsedTime / 2, 0, 1)
    local fadeOutFactor = math_clamp(1 - fadeOutTime / 2, 0, 1)
    local visibilityFactor = (distSqr <= lerpDistSqr) and 1 or math_clamp(1 - (distSqr - lerpDistSqr) / (maxDistSqr - lerpDistSqr), 0, 1)

    local alpha = visibilityFactor * math_clamp(fadeOutFactor * 255, 0, lerp(lerpFactor, 0, 255))
    local yOffset = lerp(lerpFactor, 50, 0) - lerp(fadeOutFactor, 0, 50)

    cam3d2d(pos, Ang, 0.05,function()
        drawText(fmt("Для захвата требуется еще %d %s",captureAmount,VIZIT_SCRIPTS.GetPlayerTextForm(captureAmount)), "pointTextCapture", 0, yOffset + 310,
            clrAlpha(whiteColor,alpha * 0.4), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        drawText(fmt("Контролируется: %s",whoCapture), "pointTextControlled", 0, yOffset + 380,
            clrAlpha(whiteColor,alpha * 0.4), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        drawText(name, "pointText", 0, yOffset + 200,
            clrAlpha(whiteColor,alpha * 0.4), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        drawText(text, "pointTextControlled", 0, yOffset + 440  ,
            clrAlpha(captureColor,alpha * 0.4), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end)
end
