--[[
    This is an example class not used anywhere else.
]]--

sKeypads.ScannerPad = {}
sKeypads.ScannerPad.__index = sKeypads.ScannerPad

function sKeypads.ScannerPad.new(entity, door)
    local tbl = {}
    setmetatable(tbl, sKeypads.ScannerPad)
    for k,v in pairs(sKeypads.KEYPAD) do
        tbl[k] = v
    end
    tbl:attachToEntity(entity)
    tbl:conectToFadingDoor(door)
    return tbl
end

function sKeypads.ScannerPad:getName()
    return "ScannerPad"
end

function sKeypads.ScannerPad:setCode(code)
    self.code = code
end

function sKeypads.ScannerPad:isCode(code)
    return self.code == code
end

function sKeypads.ScannerPad:canOpen(code)
    return self:isCode(code) and not self.open and self:isEntityValid()
end

function sKeypads.ScannerPad:canUse(player)
    if not self.open and self:isEntityValid() and self:isOwnerValid() and self:isOwner(player) then
        -- They are the owner
        return true
    end

    if self.open and self:isFriend(player) then return true end
    return true
end
