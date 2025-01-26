sKeypads.Utilities = sKeypads.Utilities or {}
sKeypads.Keypads = {}
sKeypads.Keypads.Buttons = {}
sKeypads.Keypads.Scanner = {}

function sKeypads.Utilities.findKeypadIndex(meta)
    sKeypads.Utils.checkType(meta, sKeypads.Types.TYPE_BASE_KEYPAD )
    for k,v in pairs(sKeypads.Keypads.Buttons) do
        if v == meta then return k end
    end
end

function sKeypads.Utilities.createNewButtonPad(ent)
    sKeypads.Utils.checkType(ent, sKeypads.Types.TYPE_ENTITY )

    local idx = #sKeypads.Keypads.Buttons + 1
    sKeypads.Keypads.Buttons[idx] = sKeypads.ButtonPad.new(ent)
    return sKeypads.Keypads.Buttons[idx], idx
end

function sKeypads.Utilities.createNewScannerPad(ent, door)
    sKeypads.Utils.checkType(ent, sKeypads.Types.TYPE_ENTITY )
    sKeypads.Utils.checkType(door, sKeypads.Types.TYPE_ENTITY )
    sKeypads.Keypads.Scanner = sKeypads.Keypads.Scanner or {}
    local idx = #sKeypads.Keypads.Scanner + 1
    sKeypads.Keypads.Scanner[idx] = sKeypads.ButtonPad.new(ent, door)
    return sKeypads.Keypads.Scanner[idx], idx
end

function sKeypads.Utilities.randomizeChange()
    math.randomseed(CurTime())
    local mrdn = math.random
    return mrdn(1 + (3/mrdn()), 2 + (1/mrdn(1,2)))
end

--[[
    Determines whether or not we need to actually handle the damage type.
]]--
function sKeypads.Utilities.correctDamageType(dmgType)
    local conf = sKeypads.Config

    if not conf.shoot_damage_type_whitelist_enabled then return true end
    for _,v in ipairs(conf.shoot_damage_type_whitelist) do
        if v == dmgType then return true end
    end

    return false
end
