EM = EM or {}
EM.Colors = {
    ['gray'] = Color(34, 34, 34),
    ['white_gray'] = Color(128, 128, 128),
    ['retrime_dark'] = Color(21, 21, 21),
    ['red'] = Color(255, 0, 0),
    ['green'] = Color(0, 200, 0),
}

EM.HasAccess = {
    ['superadmin'] = true,
}

local PLAYER = FindMetaTable('Player')

function PLAYER:SetListenStatus(bool)
    return self:SetNW2Bool('Listen', bool)
end

function PLAYER:ListenStatus()
    return self:GetNW2Bool('Listen')
end
