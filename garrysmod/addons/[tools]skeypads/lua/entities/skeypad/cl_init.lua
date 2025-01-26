
include("shared.lua")

local imgui = include("skeypads/lib/cl_imgui.lua")

surface.CreateFont("sKeypads.Keypad.Screen", {
    font = "Roboto",
    size = 100,
    weight = 600,
    antialias = true
})

surface.CreateFont("sKeypads.Keypad.Key", {
    font = "Roboto",
    size = 90,
    weight = 500,
    antialias = true
})

surface.CreateFont("sKeypads.Keypad.KeySmall", {
    font = "Roboto",
    size = 37,
    weight = 500,
    antialias = true
})

local screenPos = Vector(-0.38, 3.589, 9.09)
local screenAngles = Angle(0, 270, 90)
local scrW, scrH = 359, 116

local padPos = Vector(-0.4, 3.589, 6.48)
local padW, padH = 479, 669

local keySize = 100
local keySpacing = 30
local keyOffsetX = 58
local keyOffsetY = 90

local fprintPos = Vector(-0.42, .8, -4.45)
local fprintSize = 100
local fprintMat = Material("skeypads/fingerprint.png", "noclamp smooth")

ENT.KeyCol = Color(255, 255, 255)

local lerp = Lerp
local function lerpColor(t, from, to)
    local newCol = Color(0, 0, 0)

    newCol.r = lerp(t, from.r, to.r)
    newCol.g = lerp(t, from.g, to.g)
    newCol.b = lerp(t, from.b, to.b)
    newCol.a = lerp(t, from.a, to.a)

    return newCol
end

local function drawOutlinedBox(x, y, w, h, thickness)
    for i = 0, thickness - 1 do
        surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
    end
end

function ENT:DrawTranslucent()
    self:DrawModel()

    local fingerprintCol = color_white

    if imgui.Entity3D2D(self, padPos, screenAngles, 0.015, 300, 200) then
        surface.SetDrawColor(0, 0, 0, 220)
        surface.DrawRect(0, 0, padW, padH, padW, padH)

        local inputBlocked = self:GetInputBlocked()

        if self:GetIsOpen() then
            self.KeyCol = lerpColor(FrameTime() * 5, self.KeyCol, sKeypads.Config.keypad_num_accepted_color)
        elseif inputBlocked then
            self.KeyCol = lerpColor(FrameTime() * 5, self.KeyCol, sKeypads.Config.keypad_num_blocked_color)
        else
            self.KeyCol = lerpColor(FrameTime() * 5, self.KeyCol, sKeypads.Config.keypad_num_color)
        end

        local keys = self.KeyRegions
        local i = 0
        for k, v in SortedPairsByMemberValue(keys, "order") do
            if not v.num then continue end

            local keyX = i % 3 * (keySize + keySpacing) + keyOffsetX
            local keyY = math.Round((i - 1) / 3) * (keySize + keySpacing) + keyOffsetY

            draw.SimpleText(v.displayText, #v.displayText > 1 and "sKeypads.Keypad.KeySmall" or "sKeypads.Keypad.Key", keyX + keySize / 2, keyY + keySize / 2, self.KeyCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            if not inputBlocked and imgui.IsHovering(keyX, keyY, keySize, keySize) then
                surface.SetDrawColor(sKeypads.Config.keypad_num_outline_color)
                drawOutlinedBox(keyX, keyY, keySize, keySize, 2)

                if imgui.IsPressed() then
                    net.Start("sKeypads::PressKey")
                    net.WriteEntity(self)
                    net.WriteString(k)
                    net.SendToServer()
                end
            end

            i = i + 1
        end

        local fprintKey = keys["fingerprint"]
        if imgui.IsHovering(fprintKey.pos[1], fprintKey.pos[2], fprintKey.size[1], fprintKey.size[2]) then
            fingerprintCol = Color(180, 180, 180)

            if imgui.IsPressed() then
                net.Start("sKeypads::PressKey")
                    net.WriteEntity(self)
                    net.WriteString("fingerprint")
                net.SendToServer()
            end
        end

        imgui.End3D2D()
    else
        return
    end
    cam.Start3D2D(self:LocalToWorld(screenPos), self:LocalToWorldAngles(screenAngles), 0.02)
        surface.SetDrawColor(0, 0, 0)
        surface.DrawRect(0, 0, scrW, scrH)

        draw.SimpleText(self:GetScreenText(), "sKeypads.Keypad.Screen", scrW / 2, scrH / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()

    cam.Start3D2D(self:LocalToWorld(fprintPos), self:LocalToWorldAngles(screenAngles), 0.015)
        surface.SetDrawColor(fingerprintCol)
        surface.SetMaterial(fprintMat)
        surface.DrawTexturedRect(0, 0, fprintSize, fprintSize)
    cam.End3D2D()
end
