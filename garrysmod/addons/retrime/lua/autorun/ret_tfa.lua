hook.Add("InitPostEntity", "retrime.TFA", function()

	if CLIENT then
		hook.Remove("HUDPaint", "TFA_CheckEnv")
	else
		hook.Remove("InitPostEntity", "TFA_CheckEnv")
	end

end)