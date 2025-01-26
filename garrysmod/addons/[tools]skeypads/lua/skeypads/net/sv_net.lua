util.AddNetworkString("sKeypads::SendFriends")
util.AddNetworkString("sKeypads::RemoveFriends")
util.AddNetworkString("sKeypads::SendConnectedDoors")
util.AddNetworkString("sKeypads::Notify")
util.AddNetworkString("sKeypads::PressKey")
util.AddNetworkString("sKeypads::AddTeam")
util.AddNetworkString("sKeypads::RemoveTeam")


net.Receive("sKeypads::RemoveFriends", function(len,ply)
    local sid = net.ReadString()
    if not sid then return end
    if not sKeypads.Utils.isValidSteamID(sid) then return end
    sKeypads.Data.deleteFriends(ply, sid)
end)

net.Receive("sKeypads::SendFriends", function(len,ply)

    for i = 1, sKeypads.Config.max_friends do
        local sid = net.ReadString()
        if not sid then return end

        if not sKeypads.Utils.isValidSteamID(sid) then continue end

        sKeypads.Data.addFriend(ply, sid)
    end

    local nextString = net.ReadString()

    if nextString and isstring(nextString) and #nextString > 0 then
        DarkRP.notify(ply,1,4, sKeypads.Lang.friendsTooMany) -- Place holder wtf do we do here.
    end
end)
