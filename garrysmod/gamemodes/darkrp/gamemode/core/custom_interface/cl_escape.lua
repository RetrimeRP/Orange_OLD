local draw_RoundedBox = draw.RoundedBox
local draw_SimpleText = draw.SimpleText
local draw_DrawText = draw.DrawText

local pnl

local c303030230 = Color(30, 30, 30, 230)
local c25510251 = Color(255, 102, 51)
local c255255255 = Color(255, 255, 255)
local c170170170 = Color(170, 170, 170)
local c484848 = Color(48, 48, 48)
local c434343 = Color(43, 43, 43)

local escape_link = Material("materials/retrime_orange/link.png")
local escape_dot1 = Material("materials/retrime_orange/dot1.png")
local escape_dot2 = Material("materials/retrime_orange/dot2.png")

local carousels = {

	{
		title = "Ответим на\nваши вопросы",
		text = "Если у вас есть вопросы,\nто вы можете задать их\nнам через группу VK и мы\nвсегда будем готовы на\nних ответить",
		url = "http://vk.me/retrime"
	},
	{
		title = "Играете в\nWarframe?",
		text = "У нас есть собственный\nклан в этой игре и мы\nприглашаем вас туда для\nтого, чтобы поиграть\nвместе с нами",
		url = "https://redirect.retrime.com/warframe"
	},
	{
		title = "Специальное\nпредложение",
		text = "Серверу нужен HUD?\nТогда, мы предлагаем вам\nChifumas - DarkRP HUD\nи дарим купон на 30%\n\"retrime\"",
		url = "https://www.gmodstore.com/market/view/5954"
	}

}

--[[------------------------------------------------------------

	Escape

------------------------------------------------------------]]--
local function CloseMenu()

	if IsValid(pnl) then
		pnl:Close()
		pnl = nil
	end

end

local buttons = {

	{
		button = "Продолжить игру",
		action = function()
			CloseMenu()
		end
	},
	{
		button = "Оригинальное меню",
		action = function()
			CloseMenu()
			gui.ActivateGameUI()
		end
	},
	{
		button = "Настройки",
		action = function()
			gui.ActivateGameUI()
			RunConsoleCommand("gamemenucommand", "openoptionsdialog")
		end
	},
	{
		button = "Отключиться",
		action = function()
			RunConsoleCommand("gamemenucommand", "disconnect")
		end
	},
	{
		button = "Выйти",
		action = function()
			RunConsoleCommand("gamemenucommand", "quit")
		end
	}

}

local function CreateMenu(showconsole)

	local client = LocalPlayer()
	local scrw = ScrW()
	local scrh = ScrH()
	local delayclose = CurTime() + 0.3
	local delay = false

	pnl = vgui.Create("DFrame")
	pnl:SetSize(scrw, scrh)
	pnl:Center()
	pnl:SetTitle("")
	pnl:ShowCloseButton(false)
	pnl:SetDraggable(false)
	pnl:MakePopup()
	pnl:SetPopupStayAtBack(true)
	pnl.Paint = function(self, w, h)
		-- close
		if (input.IsKeyDown(KEY_ESCAPE) or input.IsKeyDown(KEY_BACKQUOTE)) and delay then
			CloseMenu()
		end

		-- delay
		if not delay and delayclose < CurTime() then
			delay = true

			if showconsole then
				RunConsoleCommand("showconsole")
			end
		end

		-- view
		if client:Alive() then
			render.RenderView({origin = client:EyePos(), angles = client:EyeAngles()})
		end

		-- draw
		draw.Blur(0, 0, w, h, 5, 0.2)
		draw_RoundedBox(0, 0, 0, w, h, c303030230)
	end

	--
	-- buttons
	--
	local panelwidth = (scrw <= 1555 and 20) or 104

	local panel = vgui.Create("DPanel", pnl)
	panel:SetSize(300, #buttons * 50)
	panel:SetPos(panelwidth, scrh * 0.28)
	panel.Paint = function() end

	for k, v in ipairs(buttons) do
		local button = vgui.Create("DButton", panel)
		button:SetSize(panel:GetWide(), 30)
		button:SetPos(0, (k - 1) * 50)
		button:SetText("")
		button.Paint = function(self, w, h)
			if self:IsHovered() then
				draw_RoundedBox(0, 0, 8, 2, 14, c25510251)
				draw_SimpleText(v.button, "font_32b", 13, h * 0.5, c255255255, 0, 1)
			else
				draw_SimpleText(v.button, "font_32b", 13, h * 0.5, c170170170, 0, 1)
			end
		end
		button.DoClick = v.action
	end

	--
	-- cards
	--
	local cardswidth = (scrw <= 1555 and scrw - 900) or 675

	local cards = vgui.Create("DPanel", pnl)
	cards:SetSize(880, 316)
	cards:SetPos(cardswidth, scrh * 0.28 - 12)
	cards.Paint = function() end

	--
	-- carousel
	--
	local active = 1
	local carouseltable = carousels[active]

	local carousel = vgui.Create("DPanel", cards)
	carousel:SetSize(276, 316)
	carousel:SetPos(0, 0)
	carousel.Paint = function(self, w, h)
		draw_RoundedBox(6, 0, 9, 276, 266, c434343)
		draw_RoundedBox(6, 10, 0, 256, 284, c484848)
		draw_DrawText(carouseltable.title, "font_32b", w * 0.5, 20, c255255255, 1)
		draw_DrawText(carouseltable.text, "font_22r", w * 0.5, 93, c255255255, 1)
	end

	--
	-- link
	--
	local link = vgui.Create("DButton", carousel)
	link:SetSize(24, 24)
	link:SetPos(126, 234)
	link:SetText("")
	link.Paint = function(self, w, h)
		draw.Icon(0, 0, w, h, c25510251, escape_link)
	end
	link.DoClick = function(self)
		gui.OpenURL(carouseltable.url)
	end

	--
	-- slide
	--
	local width = (carousel:GetWide() * 0.5) - ((#carousels * 24) * 0.5) + 4

	for k, v in ipairs(carousels) do
		local slide = vgui.Create("DButton", carousel)
		slide:SetSize(16, 16)
		slide:SetPos(width, 300)
		slide:SetText("")
		slide.Paint = function(self, w, h)
			draw.Icon(0, 0, w, h, c484848, escape_dot1)

			if k == active then
				draw.Icon(4, 4, 8, 8, c255255255, escape_dot2)
			end
		end
		slide.DoClick = function(self)
			active = k
			carouseltable = carousels[active]
		end

		width = width + 24
	end

	--
	-- site
	--
	local site = vgui.Create("DButton", cards)
	site:SetSize(256, 128)
	site:SetPos(340, 0)
	site:SetText("")
	site.Paint = function(self, w, h)
		draw_RoundedBox(6, 0, 0, w, h, c484848)
		draw_SimpleText("Наш сайт", "font_32b", 23, 12, c255255255)
		draw_DrawText("Правила сервера и набор\nв администрацию", "font_22r", 23, 54, c255255255)
	end
	site.DoClick = function(self)
		-- gui.OpenURL("https://redirect.retrime.com/site")
	end

	--
	-- vk
	--
	local vk = vgui.Create("DButton", cards)
	vk:SetSize(256, 128)
	vk:SetPos(624, 0)
	vk:SetText("")
	vk.Paint = function(self, w, h)
		draw_RoundedBox(6, 0, 0, w, h, c484848)
		draw_SimpleText("Наш VK", "font_32b", 23, 12, c255255255)
		draw_DrawText("Мемы, видео на серверах\nпроекта и многое другое", "font_22r", 23, 54, c255255255)
	end
	vk.DoClick = function(self)
		-- gui.OpenURL("https://redirect.retrime.com/vk")
	end

	--
	-- steam
	--
	local steam = vgui.Create("DButton", cards)
	steam:SetSize(256, 128)
	steam:SetPos(340, 156)
	steam:SetText("")
	steam.Paint = function(self, w, h)
		draw_RoundedBox(6, 0, 0, w, h, c484848)
		draw_SimpleText("Наш Steam", "font_32b", 23, 12, c255255255)
		draw_DrawText("Последний элемент для\nполноценной коллекции", "font_22r", 23, 54, c255255255)
	end
	steam.DoClick = function(self)
		-- gui.OpenURL("https://redirect.retrime.com/steam")
	end

	--
	-- discord
	--
	local discord = vgui.Create("DButton", cards)
	discord:SetSize(256, 128)
	discord:SetPos(624, 156)
	discord:SetText("")
	discord.Paint = function(self, w, h)
		draw_RoundedBox(6, 0, 0, w, h, c484848)
		draw_SimpleText("Наш Discord", "font_32b", 23, 12, c255255255)
		draw_DrawText("Станьте частью нашего\nкрутого сообщества", "font_22r", 23, 54, c255255255)
	end
	discord.DoClick = function(self)
		gui.OpenURL("https://discord.gg/xpy8xPE5BM")
	end

end

local function OpenMenu(showconsole)

	gui.HideGameUI()

	if not IsValid(pnl) then
		CreateMenu(showconsole)
	end

end

hook.Add("PreRender", "DarkRP_Escape", function()

	if gui.IsGameUIVisible() then
		local escape = input.IsKeyDown(KEY_ESCAPE)
		local backquote = input.IsKeyDown(KEY_BACKQUOTE)

		if escape or backquote then
			OpenMenu(backquote)
			return true
		end
	end

end)