hook.Add("OnPlayerChat", "DarkRP_Disguise", function(ply, text, team, alive, prefix, color1, color2)

	if not ply:IsPlayer() then return end

	local disguise = ply:getDarkRPVar("disguise")

	if disguise then
		if prefix == DarkRP.getPhrase("group") .. " " .. ply:Nick() then return end

		local disguiselist = DarkRP.GetDisguiseList()[disguise]

		if not disguiselist then return end

		if disguiselist.combine then
			prefix = string.Replace(prefix, ply:Nick(), ply:getDarkRPVar("job"))
		end

		if disguiselist.color then
			color1 = disguiselist.color or color1
		end

		chat.AddText(color1, prefix, color2, ": " .. text)
		return true
	end

end)