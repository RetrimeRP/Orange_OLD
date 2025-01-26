sKeypads.Money = {}

function sKeypads.Money.getPlayerMoney(ply)
    return ply:getMoney()
end

function sKeypads.Money.addPlayerMoney(ply,amm)
    ply:addMoney(amm)
end

function sKeypads.Money.removePlayerMoney(ply, amm)
    sKeypads.Money.addPlayerMoney(ply,-amm)
end