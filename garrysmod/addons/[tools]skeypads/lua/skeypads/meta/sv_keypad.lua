sKeypads.KEYPAD = {}
sKeypads.KEYPAD.__index = sKeypads.KEYPAD

sKeypads.KEYPAD.imAKeypad = true -- Something I will check
sKeypads.KEYPAD.time = 5
sKeypads.KEYPAD.material = "models/shadertest/shader3"
sKeypads.KEYPAD.outputMethod = "fadingdoor"

function sKeypads.KEYPAD:getOwner()
    local target = self.attachedEntity
    local ply, _ = target:CPPIGetOwner() or target:Getowning_ent() -- Prioritize the traditional CPPI method.

    if ply == CPPI_DEFER or ply == nil then
        for i = 1,10 do
            sKeypads.Utils.log("CPPI NOT PROPERLY USED IN YOUR PROP PROTECTION ON THE SERVER sKeypads WILL BE BROKEN!")
        end
        return
    end

    return ply
end

-- I'm sure some FUCKED servers would do some shit to make this break.
function sKeypads.KEYPAD:isOwner(player)
    sKeypads.Utils.checkType(player, sKeypads.Types.TYPE_PLAYER )
    return self:getOwner() == player or
           self:getOwner():SteamID() == player:SteamID() or
           self:getOwner():SteamID64() == player:SteamID64()
end

function sKeypads.KEYPAD:isOwnerValid()
    local owner = self:getOwner()

    if not IsValid(owner) then return false end

    return sKeypads.Utils.RunHook("IsOwnerValid", owner) or true
end

-- This is only called serverside!
function sKeypads.KEYPAD:isFriend(ply)
    sKeypads.Utils.checkType(ply, sKeypads.Types.TYPE_PLAYER )
    if not self:isOwnerValid() then return false end
    local owner = self:getOwner()

    if sKeypads.Config.use_cppi_friends then
        if not owner:IsPlayer() then return false end

        if not owner.CPPIGetFriends then
            sKeypads.Config.use_cppi_friends = false
            sKeypads.Utils.log("sKeypads.KEYPADs is using the CPPI Friends, but your Prop Protection doesn't support it.")
            sKeypads.Utils.log("Please set 'use_cppi_friends' to false in the config.")
            return self:isFriend(ply)
        end
        return owner:CPPIGetFriends()
    end

    return sKeypads.Data.areFriends(owner, ply)
end

function sKeypads.KEYPAD:conectToFadingDoor(ent)
    sKeypads.Utils.checkType(ent, sKeypads.Types.TYPE_ENTITY )

    self.fadingDoors[ent:EntIndex()] = ent
    sKeypads.FadingDoors.setupEntity(self, ent)
end

function sKeypads.KEYPAD:disconnectFromFadingDoor(ent)
    sKeypads.Utils.checkType(ent, sKeypads.Types.TYPE_ENTITY )

    self.fadingDoors[ent:EntIndex()] = nil
    sKeypads.FadingDoors.unsetupEntity(self, ent)
end

function sKeypads.KEYPAD:fadeConnectedDoor()
    for k,v in pairs(self.fadingDoors) do
        if not IsValid(v) then
            self.fadingDoors[k] = nil
            return
        end

        sKeypads.FadingDoors.fadeDoor(self, v, self.material, self.time)
    end

    self.open = true
end

function sKeypads.KEYPAD:addTeam(team)
    self.teams = self.teams or {}
    self.teams[team] = true
end

function sKeypads.KEYPAD:removeTeam(team)
    self.teams[team] = nil
end

function sKeypads.KEYPAD:isTeamAllowed(team)
    return self.teams[team] ~= nil
end

function sKeypads.KEYPAD:isFadingDoorValid(ent)
    if not self.fadingDoors[ent:EntIndex()] or not IsValid(self.fadingDoors[ent:EntIndex()]) then return false end
    return sKeypads.Utils.RunHook("IsValidEntity", self.name, self.fadingDoors[ent:EntIndex()]) or true
end

function sKeypads.KEYPAD:areFadingDoorsValid()
    for k,v in pairs(self.fadingDoors) do
        if not IsValid(v) then
            self.fadingDoors[k] = nil
            return false
        end

        if not (sKeypads.Utils.RunHook("IsValidEntity", self.name, v) or true) then return false end
    end

    return true
end

function sKeypads.KEYPAD:getFadingDoors()
    return self.fadingDoors
end

function sKeypads.KEYPAD:getFadingTime()
    return self.time
end

function sKeypads.KEYPAD:attachToEntity(ent)
    sKeypads.Utils.checkType(ent, sKeypads.Types.TYPE_ENTITY )
    self.attachedEntity = ent

end

function sKeypads.KEYPAD:getAttachedEntity()
    return self.attachedEntity
end

function sKeypads.KEYPAD:isEntityValid()
    if not IsValid(self.attachedEntity) then return false end
    return sKeypads.Utils.RunHook("IsValidEntity", self.name, self.attachedEntity) or true
end

function sKeypads.KEYPAD:setOpen(open)
    sKeypads.Utils.checkType(open, sKeypads.Types.TYPE_BOOL )
    self.open = open
    sKeypads.Utils.RunHook("setOpen", self, self.open)
end

function sKeypads.KEYPAD:getOpen()
    return self.open
end

function sKeypads.KEYPAD:enterKey(ply, key)
    sKeypads.Utils.checkType(ply, sKeypads.Types.TYPE_PLAYER )
    sKeypads.Utils.checkType(key, sKeypads.Types.TYPE_STRING )
    if not self:canEnterKeyPad(ply, key) then return false end
    return true
end

function sKeypads.KEYPAD:setMaterial(mat)
    sKeypads.Utils.checkType(mat, sKeypads.Types.TYPE_STRING )
    self.material = mat
end

function sKeypads.KEYPAD:setTime(time)
    sKeypads.Utils.checkType(time, sKeypads.Types.TYPE_NUMBER )
    self.time = time
end

function sKeypads.KEYPAD:getMaterial()
    return self.material
end

function sKeypads.KEYPAD:getTime()
    return self.time
end

function sKeypads.KEYPAD:canIssueCooldown()
    return self:isCoolingDown() or (self.lastCooldown or 0) < CurTime()
end

function sKeypads.KEYPAD:issueCooldown(time)
    sKeypads.Utils.checkType(time, sKeypads.Types.TYPE_NUMBER )

    local conf = sKeypads.Config

    if not time then
        time = conf.shoot_cooldown
    end

    local curTime = CurTime()

    self.cooldownDuration = time
    self.cooldown = curTime + time
    self.lastCooldown = curTime + conf.shoot_cooldown_between
end

function sKeypads.KEYPAD:isCoolingDown()
    return CurTime() < (self.cooldown or 0)
end

function sKeypads.KEYPAD:setKeyBinds(success, fail)
    sKeypads.Utils.checkType(success, sKeypads.Types.TYPE_NUMBER )
    sKeypads.Utils.checkType(fail, sKeypads.Types.TYPE_NUMBER )

    self.successBind = success
    self.failBind = fail
end

function sKeypads.KEYPAD:triggerBind(success)
    sKeypads.Utils.checkType(success, sKeypads.Types.TYPE_BOOL)

    local ply = self:getOwner()
    local bind = success and self.successBind or self.failBind

    numpad.Activate(ply, bind, true)

    timer.Simple(self.time, function()
        if not IsValid(ply) then return end
        numpad.Deactivate(ply, bind, true)
    end)
end

function sKeypads.KEYPAD:getOutputMethod()
    return self.outputMethod
end

function sKeypads.KEYPAD:setOutputMethod(type)
    sKeypads.Utils.checkType(type, sKeypads.Types.TYPE_STRING )

    if not sKeypads.Config.output_types[type] then return false end
    self.outputMethod = type
    return true
end

function sKeypads.KEYPAD:getAutoLock()
    return self.autoLock
end

function sKeypads.KEYPAD:setAutoLock(enabled)
    sKeypads.Utils.checkType(enabled, sKeypads.Types.TYPE_BOOL )

    self.autoLock = enabled

    if self.autoLock and self.mapDoor and IsValid(self.mapDoor) then
        self.mapDoor:Fire("lock")
    end
end

function sKeypads.KEYPAD:connectToMapDoor(ent)
    sKeypads.Utils.checkType(ent, sKeypads.Types.TYPE_ENTITY )

    self.mapDoor = ent
end

function sKeypads.KEYPAD:openMapDoor()
    if not (self.mapDoor and IsValid(self.mapDoor)) then return false end

    self.mapDoor:Fire("unlock")
    self.mapDoor:Fire("Open", "", 0)

    timer.Simple(self.time, function()
        if not IsValid(self.mapDoor) then return end

        self.mapDoor:Fire("Close", "", 0)
        if self.autoLock then self.mapDoor:Fire("lock") end
    end)
end

function sKeypads.KEYPAD:setupWireOutput(onLevel, offLevel)
    sKeypads.Utils.checkType(onLevel, sKeypads.Types.TYPE_NUMBER)
    sKeypads.Utils.checkType(offLevel, sKeypads.Types.TYPE_NUMBER)

    if not WireLib then return false end
    if onLevel > 10 or onLevel < -10 then return false end
    if offLevel > 10 or offLevel < -10 then return false end

    self.wireOnLevel = onLevel
    self.wireOffLevel = offLevel

    return true
end

function sKeypads.KEYPAD:triggerWireOutput(success)
    sKeypads.Utils.checkType(success, sKeypads.Types.TYPE_BOOL)

    if not WireLib then return end
    if not (self.wireOnLevel and self.wireOffLevel) then return end

    if success then
        Wire_TriggerOutput(self.attachedEntity, "success", self.wireOnLevel)
        Wire_TriggerOutput(self.attachedEntity, "fail", self.wireOffLevel)
    else
        Wire_TriggerOutput(self.attachedEntity, "fail", self.wireOnLevel)
        Wire_TriggerOutput(self.attachedEntity, "success", self.wireOffLevel)
    end

    timer.Simple(self.time, function()
        if not IsValid(self.attachedEntity) then return end

        Wire_TriggerOutput(self.attachedEntity, "success", self.wireOffLevel)
        Wire_TriggerOutput(self.attachedEntity, "fail", self.wireOffLevel)
    end)
end

function sKeypads.KEYPAD:executeSuccess()
    -- sKeypads.Utils.checkType(ply, sKeypads.Types.TYPE_PLAYER)

    if self.outputMethod == "fadingdoor" then
        self:fadeConnectedDoor()
    elseif self.outputMethod == "keybind" then
        self:triggerBind(true)
    elseif self.outputMethod == "mapdoor" then
        self:openMapDoor()
    elseif self.outputMethod == "wiremod" then
        self:triggerWireOutput(true)
    end
end

function sKeypads.KEYPAD:executeFail(ply)
    sKeypads.Utils.checkType(ply, sKeypads.Types.TYPE_PLAYER)

    if self.outputMethod == "fadingdoor" then return end

    if self.outputMethod == "keybind" then
        self:triggerBind(false)
    elseif self.outputMethod == "wiremod" then
        self:triggerWireOutput(false)
    end
end

function sKeypads.KEYPAD:setSound(sound)
    self.sound = sound
end

function sKeypads.KEYPAD:getSound()
    return self.sound
end

function sKeypads.KEYPAD:getPrice()
    return self.price
end

function sKeypads.KEYPAD:setPrice(price)
    self.price = price
end

function sKeypads.KEYPAD:setPaid(paid)
    self.paid = paid
end

function sKeypads.KEYPAD:getPaid()
    return self.paid
end

-- Abstract
function sKeypads.KEYPAD:canEnterKeyPad(ply, key)
    return true
end

-- Abstract
function sKeypads.KEYPAD:canUse(player, keys)
    return false
end

-- Abstract
function sKeypads.KEYPAD:isValidKeypad()
    return false
end

-- Abstract
function sKeypads.KEYPAD:getName()
    return "BASE"
end
