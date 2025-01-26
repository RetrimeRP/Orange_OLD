if CLIENT then

	hook.Add("InitPostEntity", "DarkRP_ColorTool", function()
		local colortool = false

		for k1, v1 in pairs(spawnmenu.GetTools()) do
			if colortool then break end
			if v1.Label ~= "#spawnmenu.tools_tab" then continue end

			for k2, v2 in pairs(v1.Items) do
				if colortool then break end
				if v2.Text ~= "#spawnmenu.tools.render" then continue end

				for k3, v3 in pairs(v2) do
					if colortool then break end

					if istable(v3) and v3.ItemName == "colour" then
						colortool = v3
					end
				end
			end
		end

		if colortool then
			colortool.CPanelFunction = function(cpanel)
				cpanel:AddControl("Header", {Description = "#tool.colour.desc"})
				cpanel:AddControl("Color", {Label = "#tool.colour.color", Red = "colour_r", Green = "colour_g", Blue = "colour_b", Alpha = "colour_a"})
			end
		end

		RunConsoleCommand("colour_mode", "0")
		RunConsoleCommand("colour_fx", "0")
	end)

end

hook.Add("CanTool", "DarkRP_ColorTool", function(ply, tr, tool)

	if tool == "colour" then
		local colortool = ply:GetTool("colour")

		if colortool:GetClientNumber("mode") ~= 0 then
			return false
		end

		if colortool:GetClientNumber("fx") ~= 0 then
			return false
		end
	end

end)