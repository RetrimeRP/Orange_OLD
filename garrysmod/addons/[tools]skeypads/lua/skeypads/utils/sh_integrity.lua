sKeypads.Utils = sKeypads.Utils or {}
sKeypads.Types = {
    TYPE_PLAYER = function(obj) return isentity(obj) and obj:IsPlayer() end,
    TYPE_ENTITY = isentity,
    TYPE_STRING = isstring,
    TYPE_NUMBER = isnumber,
    TYPE_BOOL   = isbool,
    TYPE_ANGLE  = isangle,
    TYPE_VECTOR = isvector,
    TYPE_FUNCTION = isfunction,
    TYPE_NIL = function(obj) return obj == nil end,
    TYPE_TABLE = istable,
    TYPE_BASE_KEYPAD = function(obj) return obj.imAKeypad or false end
}


function sKeypads.Utils.assert(cond, err, ...)
    assert(cond, "sKeypads:" .. err, ...)
end

function sKeypads.Utils.getType(obj)
    for k,v in pairs(sKeypads.Types) do
        if v(obj) then print(k) return k end
    end
end

function sKeypads.Utils.getTypeName(func)
    for k,v in pairs(sKeypads.Types) do
        if v == func then return k end
    end
end

function sKeypads.Utils.checkType(param, typeCheck)
    -- print(type(typeName))
    local typ = typeCheck(param)
    sKeypads.Utils.assert( typ , "Type missmatch: Expected " ..  sKeypads.Utils.getTypeName(typeCheck) .. " Got " .. type(param))
end

function sKeypads.Utils.verifyConfig()

end

function sKeypads.Utils.verifyFunction(func, expectedPath)
    sKeypads.Utils.checkType(func, sKeypads.Types.TYPE_FUNCTION )
    sKeypads.Utils.checkType(expectedPath, sKeypads.Types.TYPE_STRING )

    if not debug.getinfo then
        sKeypads.Utils.log("Superior Keypads is unable to verify the integrity of functions, Don't detour debug.getinfo")
        return true
    end

    if debug.getinfo(debug.getinfo) then
        sKeypads.Utils.log("Superior Keypads is unable to verify the integrity of functions, Don't detour debug.getinfo")
        return true
    end

    local info = debug.getinfo(func)

    if not info.short_src and not info.source then return false end
    if info.short_src == expectedPath or info.source == expectedPath then return true end
end


function sKeypads.Utils.isValidSteamID(steamid64)
    if #steamid64 != 17 then return false end
    -- if not tonumber(steamid64) then return false end

    if CLIENT and steamid64 == LocalPlayer():SteamID64() then return false end

    return true
end
