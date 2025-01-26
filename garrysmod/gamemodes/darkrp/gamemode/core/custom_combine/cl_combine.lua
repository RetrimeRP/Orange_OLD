hook.Add("OnPlayerChat", "DarkRP_CombineChat", function(ply, text, team, alive, prefix, color1, color2)

	if not ply:IsPlayer() then return end

	if ply:IsCombine() or ply:GetDisguiseVar("combine") then
		if ply:getDarkRPVar("disguise") then
			color1 = ply:GetDisguiseVar("color")
		end
		chat.AddText(color1, string.Replace(prefix, ply:Nick(), ply:getDarkRPVar("job")), color2, ": " .. text)
		return true
	end

end)