if SERVER then

	hook.Add("PlayerSay", "retrime.SpacesFix", function(ply, msg)
		if string.find(msg, "   ") then
			return ""
		end
	end)

end

if CLIENT then

	hook.Add("OnPlayerChat", "retrime.SpacesFix", function(ply, msg)
		if string.find(msg, "!eprotect") then
			return true
		end
	end)

end