include("shared.lua")

surface.CreateFont("sKeypads.AdminChecker.Info", {
    font = "Roboto",
    size = ScrH() * .018,
    weight = 700,
    antialias = true
})

local keypadInfo = false

local boxColor = Color(10, 10, 10, 180)
function SWEP:DrawHUD()
    local scale = ScrH() / 1080

    local infoText = sKeypads.Lang.checkerHint

    if keypadInfo then
        infoText = string.Replace(sKeypads.Lang.checkerShowData, "%t", keypadInfo.keypadType)
        infoText = string.Replace(infoText, "%p", tostring(keypadInfo.isProtected))
        infoText = string.Replace(infoText, "%o", keypadInfo.ownerName)

        if not (IsValid(keypadInfo.keypad) and IsValid(keypadInfo.fadingDoor)) then
            keypadInfo = false
            hook.Remove("PreDrawHalos", "sKeypads::AdminCheckerHalos")
            return
        end

        cam.Start3D(EyePos(), EyeAngles())
            render.SetColorMaterial()
            render.DrawBeam(keypadInfo.keypad:GetPos(), keypadInfo.fadingDoor:GetPos(), 2, 0.01, 20, color_white)
        cam.End3D()
    end

    local splitText = string.Split(infoText, "\n")
    local rowY = ScrH() / 2
    for k, v in ipairs(splitText) do
        draw.WordBox(2  , 10 * scale, rowY + (k - 1) * 26, v, "sKeypads.AdminChecker.Info", boxColor, color_white)
    end
end

function SWEP:SecondaryAttack()
    keypadInfo = false
    hook.Remove("PreDrawHalos", "sKeypads::AdminCheckerHalos")
end

function SWEP:Holster()
    keypadInfo = false
    hook.Remove("PreDrawHalos", "sKeypads::AdminCheckerHalos")
end

net.Receive("sKeypads::SendKeypadCheckerData", function(len)
    keypadInfo = {
        keypad = net.ReadEntity(),
        fadingDoor = net.ReadEntity(),

        keypadType = net.ReadString(),
        isProtected = net.ReadBool(),
        ownerName = net.ReadString()
    }

    hook.Add("PreDrawHalos", "sKeypads::AdminCheckerHalos", function()
        halo.Add({keypadInfo.keypad, keypadInfo.fadingDoor}, sKeypads.Config.door_halo_color, 5, 5, 2, nil, true)
    end)
end)
