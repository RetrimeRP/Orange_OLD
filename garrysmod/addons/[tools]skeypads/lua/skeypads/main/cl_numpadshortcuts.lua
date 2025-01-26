
local keys = {
    [KEY_PAD_ENTER] = "enter",
    [KEY_PAD_MINUS] = "clear"
}

local keyNum = 0
for i = KEY_PAD_0, KEY_PAD_9 do
    keys[i] = tostring(keyNum)
    keyNum = keyNum + 1
end

hook.Add("PlayerButtonDown", "sKeypads::NumpadInputs", function(ply, btn)
    if not keys[btn] then return end
    if ply != LocalPlayer() then return end

    local eyePos = ply:EyePos()

    local tr = util.TraceLine({
        start = eyePos,
        endpos = eyePos + ply:GetAimVector() * 65,
        filter = ply
    })

    local ent = tr.Entity
    if not IsValid(ent) or ent:GetClass() != "skeypad" then return end

    net.Start("sKeypads::PressKey")
     net.WriteEntity(ent)
     net.WriteString(keys[btn])
    net.SendToServer()
end)
