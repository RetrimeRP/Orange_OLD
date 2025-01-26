
sKeypads.SuperSecure = {}

local ply
local newAngle
local secureEnabled = false
function sKeypads.SuperSecure.GetRealEyeTrace()
    if not ply then return end
    if not secureEnabled then return ply:GetEyeTrace() end

    local eyePos = ply:EyePos()

    local tr = util.TraceLine({
        start = eyePos,
        endpos = eyePos + newAngle:Forward() * 10000,
        filter = function(ent) if ent:GetClass() == "skeypad" then return true end end
    })

    return tr
end

local startAngle
local finalAngle
hook.Add("Think", "sKeypads::SuperSecureThink", function()
    
    if not ply then ply = LocalPlayer() end
    if not sKeypads.Config.eyetrace_protection then return end
    local tr = sKeypads.SuperSecure.GetRealEyeTrace()
    if not tr then return end

    if not (tr.Hit and IsValid(tr.Entity)) then
        if not secureEnabled then return end

        finalAngle = Angle(0, 0, 0)
        finalAngle:Set(newAngle)

        secureEnabled = false
        startAngle = nil
        newAngle = nil

        return
    end

    if tr.Entity:GetClass() != "skeypad" then
        if not secureEnabled then return end

        finalAngle = Angle(0, 0, 0)
        finalAngle:Set(newAngle)

        secureEnabled = false
        startAngle = nil
        newAngle = nil

        return
    end

    if secureEnabled then return end
    secureEnabled = true
end)

local mouseMultiplier = sKeypads.Config.eyetrace_protection_speed
hook.Add("CreateMove", "sKeypads::SuperSecureMovement", function(cmd)
    if not sKeypads.Config.eyetrace_protection then return end
    if finalAngle then
        cmd:SetViewAngles(finalAngle)
        finalAngle = nil
        return
    end

    if not secureEnabled then return end
    if not ply then return end
    if not startAngle then
        startAngle = cmd:GetViewAngles()
        newAngle = Angle(0, 0, 0)
        newAngle:Set(startAngle)
    end

    newAngle:Add(Angle(cmd:GetMouseY() * mouseMultiplier, cmd:GetMouseX() * -mouseMultiplier, 0))

    cmd:SetMouseX(0)
    cmd:SetMouseY(0)

    cmd:SetViewAngles(startAngle)
end)

hook.Add("CalcView", "sKeypads::SuperSecureView", function(_, original, angles, fov, znear, zfar)
    if not sKeypads.Config.eyetrace_protection then return end
    if not secureEnabled then return end

    local view = {}
    view.origin = ply:EyePos()
    view.angles = newAngle
    view.fov = fov
    view.drawviewer = false

    return view
end)

hook.Add("CalcViewModelView","sKeypads", function(wep, vm, oldPos, oldang, pos, ang)
    if not secureEnabled then return end
    return pos, newAngle
end)
