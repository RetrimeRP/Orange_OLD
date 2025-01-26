local blacklist = {

	["models/wireframe"] = true,
	["debug/env_cubemap_model"] = true,
	["models/shadertest/shader3"] = true,
	["models/shadertest/shader4"] = true,
	["models/shadertest/shader5"] = true,
	["models/debug/debugwhite"] = true,
	["Models/effects/comball_sphere"] = true,
	["Models/effects/comball_tape"] = true,
	["Models/effects/splodearc_sheet"] = true,
	["Models/effects/vol_light001"] = true,
	["models/props_combine/stasisshield_sheet"] = true,
	["models/props_combine/portalball001_sheet"] = true,
	["models/props_combine/com_shield001a"] = true,
	["models/props_c17/frostedglass_01a"] = true,
	["models/props_lab/Tank_Glass001"] = true,
	["models/props_combine/tprings_globe"] = true,
	["models/rendertarget"] = true,
	["models/screenspace"] = true,
	["models/flesh"] = true,
	["phoenix_storms/wire/pcb_green"] = true,
	["phoenix_storms/wire/pcb_red"] = true,
	["phoenix_storms/wire/pcb_blue"] = true,
	["models/XQM/LightLinesRed_tool"] = true

}

hook.Add("InitPostEntity", "DarkRP_MaterialTool", function()

	local materials = list.GetForEdit("OverrideMaterials")

	for k, v in pairs(blacklist) do
		table.RemoveByValue(materials, k)
	end

end)