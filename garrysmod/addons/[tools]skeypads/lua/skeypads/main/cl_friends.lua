
sKeypads.Friends = {}

local friendsTable = {}

function sKeypads.Friends.getAll()
    return friendsTable
end

function sKeypads.Friends.isFriend(steamid64)
    return table.HasValue(friendsTable, steamid64)
end

function sKeypads.Friends.add(steamid64)
    table.insert(friendsTable, steamid64)

    sKeypads.Friends.sendFriend(steamid64)
    sKeypads.Friends.save()

    return friendsTable
end

function sKeypads.Friends.remove(steamid64)
    table.RemoveByValue(friendsTable, steamid64)

    sKeypads.Friends.sendRemovedFriend(steamid64)
    sKeypads.Friends.save()

    return friendsTable
end

function sKeypads.Friends.load()
    friendsTable = util.JSONToTable(cookie.GetString("sKeypads.Friends", "{}")) or {}
end

function sKeypads.Friends.save()
    cookie.Set("sKeypads.Friends", util.TableToJSON(friendsTable))
end

sKeypads.Friends.load()


function sKeypads.Friends.sendAll()
    net.Start("sKeypads::SendFriends")
     for k,v in pairs(friendsTable) do
         net.WriteString(v)
     end
    net.SendToServer()
end

function sKeypads.Friends.sendFriend(steamid64)
    net.Start("sKeypads::SendFriends")
     net.WriteString(steamid64)
    net.SendToServer()
end

function sKeypads.Friends.sendRemovedFriend(steamid64)
    net.Start("sKeypads::RemoveFriends")
     net.WriteString(steamid64)
    net.SendToServer()
end

hook.Add("Think", "sKeypads::SendFriendsOnReady", function()
    sKeypads.Friends.sendAll()
    hook.Remove("Think", "sKeypads::SendFriendsOnReady")
end)
