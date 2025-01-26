local pnl

local c303030 = Color(30, 30, 30)
local c255255255 = Color(255, 255, 255)
local c454545 = Color(45, 45, 45)
local c109109109 = Color(109, 109, 109)
local c424242 = Color(42, 42, 42)
local c165165165 = Color(165, 165, 165)
local c25510251 = Color(255, 102, 51)

local music = {

	["На хайпе"] = {
		{"Ur The Moon VIPERR remix ( Viber )", "music/urthemoon.mp3"},
		{"Kai Angel - what's uppppppxddDDD ( WhatsApp )", "music/whatsuppppppxddDDD2.mp3"},
		{"The Pixies - where is my mind ( если заебали ватсапы и вайберы )", "music/whereismymind.mp3"},
		{"Серега Пират - зомби апокалипсис ( Telegram )", "music/zombiapokalipsis.mp3"},
		{"dabbackwood — cypher ( old track + Discord )", "music/cypher.mp3"}
	}

}

local function CloseMenu()

	if IsValid(pnl) then
		pnl:Close()
		pnl = nil
	end

end

net.Receive("MusicMenu", function()

	if IsValid(pnl) then pnl:Remove() end

	local scrw = math.max(1152, ScrW() * 0.6)
	local scrh = math.max(720, ScrH() * 0.7)
	local curtime = CurTime()
	local supplier = net.ReadEntity()

	pnl = vgui.Create("DFrame")
	pnl:SetSize(scrw, scrh)
	pnl:Center()
	pnl:SetTitle("")
	pnl:ShowCloseButton(false)
	pnl:SetDraggable(false)
	pnl:MakePopup()
	pnl.Paint = function(self, w, h)
		if input.IsKeyDown(15) then
			if self.delay then CloseMenu() return end
		else
			if CurTime() - curtime > 0.3 then self.delay = true end
		end

		draw.RoundedBox(0, 0, 0, w, h, c303030)
		draw.SimpleText("Радио", "font_35b", 40, 24, c255255255)
	end

	pnl.scrlpnl = vgui.Create("DScrollPanel", pnl)
	pnl.scrlpnl:SetSize(pnl:GetWide(), pnl:GetTall() - 133)
	pnl.scrlpnl:SetPos(0, 91)
	pnl.scrlpnl.Paint = function() end

	pnl.scrlbar = pnl.scrlpnl:GetVBar()

	pnl.scrlbar.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c454545)
	end

	pnl.scrlbar.btnUp.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c303030)
	end

	pnl.scrlbar.btnGrip.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c109109109)
	end

	pnl.scrlbar.btnDown.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c303030)
	end

	pnl.lt1 = vgui.Create("DIconLayout", pnl.scrlpnl)
	pnl.lt1:SetSize(pnl.scrlpnl:GetWide(), pnl.scrlpnl:GetTall())
	pnl.lt1:SetPos(42, 0)
	pnl.lt1:SetSpaceY(32)
	pnl.lt1:SetSpaceX(32)
	pnl.lt1.Paint = function() end

	for key, val in pairs(music) do

		pnl.wep = pnl.lt1:Add("DPanel")

		pnl.wep:SetSize(pnl.scrlpnl:GetWide() - 80, 80 + (#val * 58))
		pnl.wep.Paint = function(self, w, h)
			draw.RoundedBoxEx(3, 0, 0, w, 58, c454545, true, true, false, false)
			draw.RoundedBoxEx(3, 0, 58, w, h - 58, c424242, false, false, true, true)
			draw.SimpleText(key, "font_22r", 24, 18, c255255255)
		end

		for k, v in ipairs(val) do
			pnl.wep_pnl = vgui.Create("DPanel", pnl.wep)
			pnl.wep_pnl:SetSize(pnl.wep:GetWide(), 58)
			pnl.wep_pnl:SetPos(0, 69 + (k - 1) * 58)
			pnl.wep_pnl.Paint = function(self, w, h)
				draw.SimpleText(v[1], "font_22r", 25, 17, c255255255)
			end

			pnl.wep_btn = vgui.Create("DButton", pnl.wep_pnl)
			pnl.wep_btn:SetSize(75, 26)
			pnl.wep_btn:SetPos(pnl.wep_pnl:GetWide() - 100, 16)
			pnl.wep_btn:SetText("")
			pnl.wep_btn.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, c25510251)
				draw.SimpleText("ВКЛЮЧИТЬ", "font_15r", w * 0.5, h * 0.5 - 1, c255255255, 1, 1)
			end
			pnl.wep_btn.DoClick = function()
				local name = v[1]
				local music = v[2]
				net.Start("MusicOn")
				net.WriteString(name)
				net.WriteString(music)
				net.SendToServer()
			end
		end
	end

end)