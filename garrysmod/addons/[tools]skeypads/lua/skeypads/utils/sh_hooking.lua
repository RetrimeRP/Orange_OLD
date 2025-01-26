sKeypads.Utils = sKeypads.Utils or {}
function sKeypads.Utils.RunHook(name, ...)
    sKeypads.Utils.checkType(name, sKeypads.Types.TYPE_STRING )
    return hook.Run("sKeypads::" .. name, ...)
end