local material = Material("effects/combine_binocoverlay.vmt")

local combine
local yelloweyes
local redeyes

hook.Add("DarkRPFinishedLoading", "DarkRP_CombineOverlay", function()

	combine = {}
	combine[TEAM_MPF1] = true
	combine[TEAM_MPF2] = true
	combine[TEAM_MPF3] = true
	combine[TEAM_MPF4] = true
	combine[TEAM_MPF5] = true
	combine[TEAM_MPF6] = true
	combine[TEAM_MPF7] = true
	combine[TEAM_MPF8] = true
	combine[TEAM_MPF9] = true
	combine[TEAM_MPF10] = true
	combine[TEAM_MPF11] = true
	combine[TEAM_MPF12] = true
	combine[TEAM_MPF13] = true
	combine[TEAM_MPF14] = true
	combine[TEAM_MPF15] = true
	combine[TEAM_OTA1] = true
	combine[TEAM_OTA2] = true
	combine[TEAM_OTA3] = true
	combine[TEAM_OTA4] = true
	combine[TEAM_OTA5] = true
	combine[TEAM_OTA6] = true
	combine[TEAM_OTA7] = true
	combine[TEAM_OTA8] = true
	combine[TEAM_OTA9] = true
	combine[TEAM_OTA10] = true
	combine[TEAM_GUARDIAN1] = true
	combine[TEAM_GUARDIAN2] = true
	combine[TEAM_GUARDIAN3] = true
	combine[TEAM_GUARDIAN4] = true
	combine[TEAM_GUARDIAN5] = true
	combine[TEAM_GUARDIAN6] = true

	yelloweyes = {}
	yelloweyes[TEAM_MPF3] = true
	yelloweyes[TEAM_OTA9] = true

	redeyes = {}
	redeyes[TEAM_MPF13] = true
	redeyes[TEAM_MPF14] = true
	redeyes[TEAM_MPF15] = true
	redeyes[TEAM_OTA4] = true
	redeyes[TEAM_OTA5] = true
	redeyes[TEAM_OTA6] = true
	redeyes[TEAM_OTA7] = true
	redeyes[TEAM_GUARDIAN1] = true
	redeyes[TEAM_GUARDIAN2] = true
	redeyes[TEAM_GUARDIAN3] = true
	redeyes[TEAM_GUARDIAN4] = true
	redeyes[TEAM_GUARDIAN5] = true
	redeyes[TEAM_GUARDIAN6] = true

end)

local function OverlayColor(job)

	material:SetFloat("$alpha", 0.44)
	material:SetVector("$color2", Vector(0.84, 0.84, 0.84))

	if yelloweyes[job] then
		material:SetFloat("$alpha", 0.3)
		material:SetVector("$color2", Vector(0.84, 0.64, 0.04))
	end

	if redeyes[job] then
		material:SetFloat("$alpha", 0.3)
		material:SetVector("$color2", Vector(1, 0.2, 0.2))
	end

end

hook.Add("OnPlayerChangedTeam", "DarkRP_CombineOverlay", function(ply, old, new)

	if combine[old] then
		hook.Remove("RenderScreenspaceEffects", "DarkRP_CombineOverlay")
	end

	if combine[new] then
		OverlayColor(new)

		hook.Add("RenderScreenspaceEffects", "DarkRP_CombineOverlay", function()
			render.SetMaterial(material)
			render.DrawScreenQuad()
		end)
	end

end)