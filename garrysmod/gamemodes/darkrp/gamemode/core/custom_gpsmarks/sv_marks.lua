util.AddNetworkString("CreateMark")
util.AddNetworkString("RemoveMark")

function CreateMark(target, type, length, text, id, vector)
	net.Start("CreateMark")
	net.WriteUInt(type, 2)
	net.WriteUInt(length, 8)
	net.WriteString(text)
	net.WriteString(id)
	net.WriteVector(vector)
	net.Send(target)
end

function RemoveMark(target, id)
	net.Start("RemoveMark")
	net.WriteString(id)
	net.Send(target)
end