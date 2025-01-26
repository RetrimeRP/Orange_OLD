
net.Receive("sKeypads::Notify", function(len)
    local msg = net.ReadString()
    local type = net.ReadUInt(3)

    notification.AddLegacy(msg, type, 3)
    surface.PlaySound("buttons/lightswitch2.wav")
end)