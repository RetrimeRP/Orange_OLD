sKeypads.PaidDoors = {}


function sKeypads.PaidDoors.canAfford(door,ply)
    if not sKeypads.Config.paid_doors then return false end

    local meta = door:getMeta()
    return meta:getPrice() < sKeypads.Money.getPlayerMoney(ply)
end

function sKeypads.PaidDoors.isPaidDoor(door)
    return door:getMeta():getPaid()
end