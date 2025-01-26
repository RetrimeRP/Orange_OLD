sKeypads.FadingDoors = {}

local collisionGroup = COLLISION_GROUP_WORLD
-- local extraRadius = Vector(10,20,20)


function sKeypads.FadingDoors.fadeDoor(inst, door, mat, dur)
    sKeypads.Utils.checkType(inst, sKeypads.Types.TYPE_BASE_KEYPAD )
    sKeypads.Utils.checkType(door, sKeypads.Types.TYPE_ENTITY )
    sKeypads.Utils.checkType(mat, sKeypads.Types.TYPE_STRING )
    sKeypads.Utils.checkType(dur, sKeypads.Types.TYPE_NUMBER )

    if not IsValid(door) then return end -- Make sure the door is valid before fading it.
    if not isentity(door) then return end -- They're not an entity.
    if door:GetClass() ~= "prop_physics" then return end -- The Entity is a prop-physics.

    local instanceIsKeypad = inst.imAKeypad or false

    door.skOldCollision = door:GetCollisionGroup()
    door.skOldMaterial = door:GetMaterial()

    local settingMaterial = true
    if not door.SetMaterial then
        sKeypads.Utils.log("Can't set the material of the entity, This will not stop skeypads from working!")
        settingMaterial = false
    end

    if not door.SetCollisionGroup then
        sKeypads.Utils.log("Something is breaking SetCollisionGroup, This will stop skeypads from working!")
        return
    end

    door:SetCollisionGroup(collisionGroup)

    if settingMaterial then
        door:SetMaterial(mat)
    end

    sKeypads.Utils.assert(door:GetCollisionGroup() == collisionGroup,
        "Cannot change the collision group of the door."
    )

    if inst and instanceIsKeypad then
        inst:setOpen(true) -- Set the keypad to open!
    end

    timer.Simple(dur, function()
        sKeypads.FadingDoors.unFadeDoor(inst, door)
    end)
end

function sKeypads.FadingDoors.insideDoor(ply, door)
    local plyPos = door:WorldToLocal(ply:GetPos())

    local doorMins, doorMaxs = door:GetCollisionBounds()
    local plyMins, plyMaxs = ply:GetCollisionBounds()

    plyMins = plyMins + plyPos
    plyMaxs = plyMaxs + plyPos

    return  (doorMins[1] <= plyMaxs[1] and doorMaxs[1] >= plyMins[1]) and
            (doorMins[2] <= plyMaxs[2] and doorMaxs[2] >= plyMins[2]) and
            (doorMins[3] <= plyMaxs[3] and doorMaxs[3] >= plyMins[3])
end

function sKeypads.FadingDoors.unFadeDoor(inst, door)
    if not IsValid(door) then return end -- Door is nolonger valid don't do anything.
    local config = sKeypads.Config
    if config.fading_door_stop_stuck then
        local doorFunc = sKeypads.FadingDoors.insideDoor
        local found = false
        for k,v in pairs(player.GetAll()) do
            if doorFunc(v, door) then
                found = true
                break
            end
        end

        if found then
            timer.Simple(config.fading_door_stuck_check_interval, function()
                sKeypads.FadingDoors.unFadeDoor(inst, door)
            end)
            return
        end
    end
    if not door.skOldCollision then
        sKeypads.Utils.log("There is something unsetting the old collision group.")
        return
    end

    door:SetCollisionGroup(door.skOldCollision)

    if inst then
        inst:setOpen(false)
    end

    if not door.skOldMaterial then
        return
    end

    door:SetMaterial(door.skOldMaterial)

end

function sKeypads.FadingDoors.setupEntity(inst, door)
    door.fadeActive = false
    door.isFadingDoor = true
    door.fadeActivate = function(ent)
        ent.fadeActive = true
        sKeypads.FadingDoors.fadeDoor(inst, ent, inst.material, inst.time)
    end

    door.fadeDeactivate = function(ent)
        ent.fadeActive = false
        sKeypads.FadingDoors.unFadeDoor(inst, ent, inst.material, inst.time)
    end
end

function sKeypads.FadingDoors.unsetupEntity(inst, door)
    door.fadeActive = nil
    door.isFadingDoor = nil
    door.fadeActivate = nil
    door.fadeDeactivate = nil
end
