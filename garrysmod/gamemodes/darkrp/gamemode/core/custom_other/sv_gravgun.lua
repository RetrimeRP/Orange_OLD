local blacklist = {
	["prop_combine_ball"] = true,
	["aw2_manhack"] = true
}

hook.Add("GravGunPickupAllowed", "retrime.GravGun", function(ply, ent)
	if blacklist[ent:GetClass()] then
		return false
	end
end)