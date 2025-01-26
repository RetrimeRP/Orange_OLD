hook.Add("InitPostEntity", "DarkRP_Arrival", function()

	local c255255255 = Color(255, 255, 255)
	local c230230230 = Color(230, 230, 230)

	local arrival_play = Material("materials/retrime_orange/arrival/play.png")
	local arrival_site = Material("materials/retrime_orange/arrival/site.png")
	local arrival_discord = Material("materials/retrime_orange/arrival/discord.png")
	local arrival_vk = Material("materials/retrime_orange/arrival/vk.png")
	local arrival_steam = Material("materials/retrime_orange/arrival/steam.png")

	local views = {
		{
			origin = Vector(-4850.5, 1358.5, 104),
			angles = Angle(0, 90, 0),
			drawviewmodel = false,
			fov = 106
		},
		{
			origin = Vector(-4383.3, 1230.4, 96.4),
			angles = Angle(-6.6, 137.3, 0),
			drawviewmodel = false,
			fov = 90
		}
	}

	local songs = {
		"music/hl2_song7.mp3",
		"music/hl2_song10.mp3",
		"music/hl2_song13.mp3",
		"music/ravenholm_1.mp3"
	}

	local fpsbooster = false
	local view = views[math.random(#views)]
	local song = songs[math.random(#songs)]

	local panel = vgui.Create("DFrame")
	panel:SetSize(ScrW(), ScrH())
	panel:Center()
	panel:SetTitle("")
	panel:ShowCloseButton(false)
	panel:SetDraggable(false)
	panel:MakePopup()
	panel.Paint = function()
		render.RenderView(view)
	end
	panel.Think = function()
		if GAS and GAS.FPSBooster and IsValid(GAS.FPSBooster.Menu) then
			GAS.FPSBooster.Menu:Close()
			fpsbooster = true
		end
	end

	local width, height = panel:GetSize()
	width, height = width * 0.5, height * 0.5

	local play = vgui.Create("DButton", panel)
	play:SetSize(568, 120)
	play:SetPos(width - (play:GetWide() * 0.5), height - (play:GetTall() * 0.5))
	play:SetText("")
	play.Paint = function(self, w, h)
		draw.Icon(0, 0, w, h, c255255255, arrival_play)
	end
	play.DoClick = function()
		panel:Close()
		-- LocalPlayer():EmitSound(song, 100, 100, 0.15)

		if fpsbooster then
			GAS.FPSBooster:OpenMenu(true)
		end
	end

	local site = vgui.Create("DButton", panel)
	site:SetSize(24, 24)
	site:SetPos(width - 75, height + 89)
	site:SetText("")
	site.Paint = function(self, w, h)
		draw.Icon(0, 0, w, h, c230230230, arrival_site)
	end
	site.DoClick = function()
		gui.OpenURL("https://redirect.retrime.com/site")
	end

	local discord = vgui.Create("DButton", panel)
	discord:SetSize(24, 24)
	discord:SetPos(width - 33, height + 89)
	discord:SetText("")
	discord.Paint = function(self, w, h)
		draw.Icon(0, 0, w, h, c230230230, arrival_discord)
	end
	discord.DoClick = function()
		gui.OpenURL("https://redirect.retrime.com/discord")
	end

	local vk = vgui.Create("DButton", panel)
	vk:SetSize(24, 24)
	vk:SetPos(width + 9, height + 89)
	vk:SetText("")
	vk.Paint = function(self, w, h)
		draw.Icon(0, 0, w, h, c230230230, arrival_vk)
	end
	vk.DoClick = function()
		gui.OpenURL("https://redirect.retrime.com/vk")
	end

	local steam = vgui.Create("DButton", panel)
	steam:SetSize(24, 24)
	steam:SetPos(width + 51, height + 89)
	steam:SetText("")
	steam.Paint = function(self, w, h)
		draw.Icon(0, 0, w, h, c230230230, arrival_steam)
	end
	steam.DoClick = function()
		gui.OpenURL("https://redirect.retrime.com/steam")
	end

end)