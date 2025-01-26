sKeypads.Materials = {}

function sKeypads.Materials.validateMaterial(mat)
    sKeypads.Utils.checkType(mat, sKeypads.Types.TYPE_STRING )

    local config = sKeypads.Config
    local hooks = sKeypads.Utils.RunHook("IsMaterialValid", mat)

    local found = false
    for i,v in ipairs(config.fading_door_allowed_materials) do
        if v == mat then found = true break end
    end

    if not found or hooks == false then
        return config.fading_door_material
    end

    return mat
end