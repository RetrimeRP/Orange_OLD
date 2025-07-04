hook.Add("InitPostEntity", "DarkRP_AssetHooks", function()

	concommand.Remove("gm_save")

	hook.Remove("HUDPaint", "drawHudVital")
	hook.Remove("RenderScreenspaceEffects", "RenderBloom")
	hook.Remove("RenderScreenspaceEffects", "RenderBokeh")
	hook.Remove("RenderScreenspaceEffects", "RenderMaterialOverlay")
	hook.Remove("RenderScreenspaceEffects", "RenderSharpen")
	hook.Remove("RenderScreenspaceEffects", "RenderSobel")
	hook.Remove("RenderScreenspaceEffects", "RenderStereoscopy")
	hook.Remove("RenderScreenspaceEffects", "RenderSunbeams")
	hook.Remove("RenderScreenspaceEffects", "RenderTexturize")
	hook.Remove("RenderScreenspaceEffects", "RenderToyTown")
	hook.Remove("RenderScene", "RenderSuperDoF")
	hook.Remove("RenderScene", "RenderStereoscopy")
	hook.Remove("PreRender", "PreRenderFlameBlend")
	hook.Remove("PostRender", "RenderFrameBlend")
	hook.Remove("GUIMousePressed", "SuperDOFMouseDown")
	hook.Remove("GUIMouseReleased", "SuperDOFMouseUp")
	hook.Remove("Think", "DOFThink")
	hook.Remove("PlayerTick", "TickWidgets")
	hook.Remove("PlayerBindPress", "PlayerOptionInput")
	hook.Remove("OnGamemodeLoaded", "CreateMenuBar")
	hook.Remove("PostPlayerDraw", "DarkRP_ChatIndicator")
	hook.Remove("CreateClientsideRagdoll", "DarkRP_ChatIndicator")
	hook.Remove("player_disconnect", "DarkRP_ChatIndicator")

end)