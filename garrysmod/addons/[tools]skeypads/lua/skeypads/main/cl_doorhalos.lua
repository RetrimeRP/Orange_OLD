
local displayDoors = {}

net.Receive("sKeypads::SendConnectedDoors", function()
    local doorCount = net.ReadUInt(8)

    table.Empty(displayDoors)

    if doorCount <= 0 then
        hook.Remove("PreDrawHalos", "sKeypads::HaloConnectedDoors")
        return
    end

    for i = 1, doorCount do
        displayDoors[i] = net.ReadEntity()
    end

    hook.Add("PreDrawHalos", "sKeypads::HaloConnectedDoors", function()
        halo.Add(displayDoors, sKeypads.Config.door_halo_color, 5, 5, 2)
    end)
end)
