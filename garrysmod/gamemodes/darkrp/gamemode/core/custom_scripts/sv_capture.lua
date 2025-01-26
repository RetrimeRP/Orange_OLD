local timer = timer -- ИЗМЕНЕНО 05.02.2022
hook.Add("OnPlayerChangedTeam", "retrime.Supplies", function(ply)
	if timer.Exists("SuppliesCapture") then
		ply:ConCommand("stopsound")
	end
end)