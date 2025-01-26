
sKeypads.DoorHalos = {}

function sKeypads.DoorHalos.sendDoors(ply, ent)
    if ent:GetClass() != "skeypad" then return end

    local doors = ent:GetMeta():getFadingDoors()
    local doorCount = table.Count(doors)

    net.Start("sKeypads::SendConnectedDoors")
     net.WriteUInt(doorCount + 1, 8)
     for k,v in pairs(doors) do
         net.WriteEntity(v)
     end
     net.WriteEntity(ent)
    net.Send(ply)
end

function sKeypads.DoorHalos.resetDoors(ply)
    net.Start("sKeypads::SendConnectedDoors")
     net.WriteUInt(0, 8)
    net.Send(ply)
end
