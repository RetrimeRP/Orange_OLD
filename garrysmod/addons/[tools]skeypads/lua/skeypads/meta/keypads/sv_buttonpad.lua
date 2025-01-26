sKeypads.ButtonPad = {}

sKeypads.ButtonPad.__index = sKeypads.ButtonPad

function sKeypads.ButtonPad.new(entity)
    local tbl = {}
    setmetatable(tbl, sKeypads.ButtonPad)
    for k,v in pairs(sKeypads.KEYPAD) do
        tbl[k] = v
    end

    tbl.fadingDoors = {}
    return tbl
end

function sKeypads.ButtonPad:getName()
    return "ButtonPad"
end

function sKeypads.ButtonPad:setCode(code)
    sKeypads.Utils.checkType(code, sKeypads.Types.TYPE_STRING )
    self.code = code
end

function sKeypads.ButtonPad:isCode(code)
    sKeypads.Utils.checkType(code, sKeypads.Types.TYPE_STRING )
    return self.code == code
end

function sKeypads.ButtonPad:canOpen(code)
    sKeypads.Utils.checkType(code, sKeypads.Types.TYPE_STRING )
    return self:isCode(code) and not self.open and self:isEntityValid() and not self:isCoolingDown()
end

function sKeypads.ButtonPad:canFingerPrintOpen(player)
    sKeypads.Utils.checkType(player, sKeypads.Types.TYPE_PLAYER )
    local owner = self:getOwner()
    return  self:isOwner(player) or
            self:isFriend(player) or
            sKeypads.inSParty(owner, player) or
            sKeypads.Utilities.isInBlobsParty(player,owner)
end

function sKeypads.ButtonPad:canUse(player, keys)
    sKeypads.Utils.checkType(player, sKeypads.Types.TYPE_PLAYER )
    sKeypads.Utils.checkType(keys, sKeypads.Types.TYPE_STRING )

    if not self.open and self:isEntityValid() and self:isOwnerValid() and self:isOwner(player) then
        -- They are the owner
        return true
    end

    if not self.open and self:isFriend(player) then return true end
    if not self:canOpen(keys) then return false end
    return true
end

function sKeypads.ButtonPad:setProtected(isProtected)
    sKeypads.Utils.assert(isnumber(isProtected) or isbool(isProtected), "isProtected is not a boolean or an Integer")

    if isnumber(isProtected) then
        isProtected = math.Clamp(isProtected, 0, 1) ~= 0
    end
    self.protected = isProtected
end

function sKeypads.ButtonPad:getProtected()
    return self.protected or false
end
