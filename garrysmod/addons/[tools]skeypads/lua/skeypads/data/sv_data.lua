sKeypads.Data = sKeypads.Data or {}
sKeypads.Friends = sKeypads.Friends or {}

function sKeypads.Data.areFriends(ply, target)
    sKeypads.Utils.checkType(ply, sKeypads.Types.TYPE_PLAYER )
    sKeypads.Utils.checkType(target, sKeypads.Types.TYPE_PLAYER )

    if not sKeypads.Friends[ply:SteamID64()] then return false end
    return sKeypads.Friends[ply:SteamID64()][target:SteamID64()] or false
end

function sKeypads.Data.addFriend(ply, steamid64)
    sKeypads.Utils.checkType(ply, sKeypads.Types.TYPE_PLAYER )
    sKeypads.Utils.checkType(steamid64, sKeypads.Types.TYPE_STRING )

    local target = player.GetBySteamID64(steamid64)
    if not IsValid(target) then return end

    if not sKeypads.Friends[ply:SteamID64()] then sKeypads.Friends[ply:SteamID64()] = {} end

    sKeypads.Friends[ply:SteamID64()][steamid64] = true
end

function sKeypads.Data.deleteFriends(ply, steamid64)
    sKeypads.Utils.checkType(ply, sKeypads.Types.TYPE_PLAYER )
    sKeypads.Utils.checkType(steamid64, sKeypads.Types.TYPE_STRING )

    local target = player.GetBySteamID64(steamid64)
    if not IsValid(target) then return end

    if not sKeypads.Friends[ply:SteamID64()] then sKeypads.Friends[ply:SteamID64()] = {} end

    sKeypads.Friends[ply:SteamID64()][steamid64] = nil
end
