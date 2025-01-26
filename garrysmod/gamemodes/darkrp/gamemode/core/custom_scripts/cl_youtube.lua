concommand.Add("youtube", function()
	local c303030 = Color(30, 30, 30)
	local c424242 = Color(42, 42, 42)
	local c230230230 = Color(230, 230, 230)
	local icon_close = Material("materials/retrime_orange/close.png")

	-- panel
	local panel = vgui.Create("DFrame")
	panel:SetSize(math.max(1564, ScrW() * 0.45), 941)
	panel:Center()
	panel:SetTitle("")
	panel:ShowCloseButton(false)
	panel:SetDraggable(false)
	panel:MakePopup()
	panel.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, 40, c230230230)
		draw.RoundedBox(0, 0, 40, w, h - 40, c303030)
		draw.SimpleText("Ютабе шортасэс", "font_22r", 17, 9, c303030)
	end

	-- close
	local close = vgui.Create("DButton", panel)
	close:SetSize(16, 16)
	close:SetPos(panel:GetWide() - 32, 12)
	close:SetText("")
	close.Paint = function(self, w, h)
		draw.Icon(0, 0, w, h, c303030, icon_close)
	end
	close.DoClick = function()
		panel:Close()
	end

	-- html
	local html = vgui.Create("HTML", panel)
	html:SetSize(math.max(1564, ScrW() * 0.45), 900)
	html:SetPos(0, 41)
	html:OpenURL("https://www.youtube.com/")
end)