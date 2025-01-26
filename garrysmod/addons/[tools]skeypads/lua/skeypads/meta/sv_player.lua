
local meta = FindMetaTable("Player")

function meta:sKeypadsGetCount()
    return table.Count(self.sKeypadEnts or {})
end

function meta:sKeypadsAddKeypad(entIndex)
    sKeypads.Utils.checkType(entIndex, sKeypads.Types.TYPE_NUMBER )
    if not self.sKeypadEnts then self.sKeypadEnts = {} end
    self.sKeypadEnts[entIndex] = true
end

function meta:sKeypadsRemoveKeypad(entIndex)
    sKeypads.Utils.checkType(entIndex, sKeypads.Types.TYPE_NUMBER )
    if not self.sKeypadEnts then return end
    self.sKeypadEnts[entIndex] = nil
end

function meta:sKeypadsNotify(msg, type)
    sKeypads.Utils.checkType(msg, sKeypads.Types.TYPE_STRING )
    sKeypads.Utils.checkType(type, sKeypads.Types.TYPE_NUMBER )
    net.Start("sKeypads::Notify")
        net.WriteString(msg)
        net.WriteUInt(type, 3)
    net.Send(self)
end
