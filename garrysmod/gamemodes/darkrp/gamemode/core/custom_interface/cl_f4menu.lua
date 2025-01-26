local pnl
local ent_pnl
local law_pnl

local activetab

local c303030 = Color(30, 30, 30)
local c230230230 = Color(230, 230, 230)
local c180180180 = Color(180, 180, 180)
local c25510251 = Color(255, 102, 51)
local c255255255 = Color(255, 255, 255)
local c454545 = Color(45, 45, 45)
local c109109109 = Color(109, 109, 109)
local c424242 = Color(42, 42, 42)
local c165165165 = Color(165, 165, 165)
local c909090 = Color(90, 90, 90)

local f4menu_menu = Material("materials/retrime_orange/f4menu/menu.png")
local f4menu_entities = Material("materials/retrime_orange/f4menu/entities.png")
local f4menu_laws = Material("materials/retrime_orange/f4menu/laws.png")
local f4menu_fsg = Material("materials/retrime_orange/f4menu/fsg.png")

local defaultlaws = {

	{
		"• Антиобщественная деятельность 2 уровня - двукратное перевоспитание;",
		"G.01 | Несоответствие нормам передвижения (бег, прыжки)",
		"G.02 | Несоответствие нормам поведения",
		"G.03 | Несоответствие нормам дресскода",
		"G.04 | Несоответствие нормам речи",
		"G.05 | Вторжение в личное пространство",
		"G.06 | Объединение в группы более трёх индивидов",
		"G.07 | Хранение необщедоступнных продуктов питания"
	},
	{
		"• Антиобщественная деятельность 1 уровня - двукратное перевоспитание; изоляция по усмотрению;",
		"F.01 | Множественные нарушения 2 уровня антиобщественной деятельности",
		"F.02 | Несоответствие нормам инспекционной фазы",
		"F.03 | Уклонение от инспекционной фазы",
		"F.04 | Уклонение от работы",
		"F.05 | Вредоносная разговорная деятельность",
		"F.06 | Непредставление сотруднику Гражданской обороны своих идентификационных данных",
		"F.07 | Хранение медицинских препаратов",
		"F.08 | Хранение музыкальных инструментов"
	},
	{
		"• Угроза обществу 5 уровня - трёхкратное перевоспитание; допрос по усмотрению; изоляция;",
		"E.01 | Угроза гражданскому индивиду",
		"E.02 | Угроза или помеха сотруднику Гражданской обороны",
		"E.03 | Неоднократное уклонение гражданского от работы",
		"E.04 | Подозрение в проникновении со взломом",
		"E.05 | Подозрение в краже",
		"E.06 | Подозрение в увечье",
		"E.07 | Хранение денежных принтеров"
	},
	{
		"• Угроза обществу 4 уровня - четырёхкратное перевоспитание; допрос; изоляция;",
		"D.01 | Кража",
		"D.02 | Проникновение со взломом",
		"D.03 | Нанесение увечий",
		"D.04 | Похищение",
		"D.05 | Сопротивление сотрудникам Гражданской обороны"
	},
	{
		"• Угроза обществу 3 уровня - высшая мера наказания по усмотрению; допрос; изоляция по усмотрению;",
		"C.01 | Попытка или проникновение в собственность Альянса",
		"C.02 | Нахождение гражданских на крышах домов",
		"C.03 | Порча имущества Альянса",
		"C.04 | Отказ в сотрудничестве с Альянсом",
		"C.05 | Предумышленное убийство гражданина",
		"C.06 | Ношение оружия",
		"C.07 | Нападение на сотрудника Гражданской обороны",
		"C.08 | Участие в антиобщественных выступлениях",
		"C.09 | Подозрение в помощи нарушителю"
	},
	{
		"• Угроза обществу 2 уровня - высшая мера наказания;",
		"B.01 | Геноцид",
		"B.02 | Убийство сотрудника Гражданской обороны",
		"B.03 | Террористическая деятельность",
		"B.04 | Сопротивленческая деятельность"
	},
	{
		"• Угроза обществу 1 уровня - отсечение на месте; огласка общественности по усмотрению;",
		"A.01 | Геноцид жилого блока",
		"A.02 | Убийство сотрудников Гражданской обороны",
		"A.03 | Гражданин является ключевым лицом в Сопротивлении",
		"A.04 | Множественные нарушения 3 или 2 уровней угрозы обществу"
	}

}

local extralaws = {

	"• Термины",
	"01. Изоляция - временное заключение человека в тюремном блоке Нексус Надзора",
	"02. Ампутация - нейтрализация объекта",
	"03. Отсечение - специальный код Надзора (аналогично ампутации)",
	"04. Перевоспитание - удар дубинкой по спине",
	"05. Цикл - игровая единица времени (минута реального времени)",
	"06. Высшая мера наказания - показательная казнь",
	"07. Геноцид - убийство большого количества граждан в одно время",
	"07. Коллаборационизм - добровольное сотрудничество с Альянсом",
	"08. Анти-коллаборационизм - отказ от сотрудничества с Альянсом",
	"09. Анти-Коллабрационист - человек, отказавшийся от сотрудчинества с Альянсом",
	"10. Запретный сектор - территория находящаяся за воротами около блока Б",
	"11. Аспект - какая либо часть города"

}

local function GetEntities()

	local categories = {}

	for k, v in pairs(DarkRP.getCategories().entities) do
		if #v.members > 0 and v.canSee(LocalPlayer()) then
			table.insert(categories, v)
		end
	end

	for k, v in pairs(DarkRP.getCategories().shipments) do
		if #v.members > 0 and v.canSee(LocalPlayer()) then
			table.insert(categories, v)
		end
	end

	return categories

end

local function EntitiesTab()

	local entities = GetEntities()

	ent_pnl = vgui.Create("DPanel", pnl)
	ent_pnl:SetSize(pnl:GetWide() - 80, pnl:GetTall())
	ent_pnl:SetPos(80, 0)
	ent_pnl.Paint = function(self, w, h)
		draw.SimpleText("Энтити", "font_35b", 40, 24, c255255255)
	end

	local scrollpanel = vgui.Create("DScrollPanel", ent_pnl)
	scrollpanel:SetSize(ent_pnl:GetWide(), ent_pnl:GetTall() - 133)
	scrollpanel:SetPos(0, 91)
	scrollpanel.Paint = function() end

	local scrollbar = scrollpanel:GetVBar()

	scrollbar.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c454545)
	end

	scrollbar.btnUp.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c303030)
	end

	scrollbar.btnGrip.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c109109109)
	end

	scrollbar.btnDown.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c303030)
	end

	local layout1 = vgui.Create("DIconLayout", scrollpanel)
	layout1:SetSize(467, scrollpanel:GetTall())
	layout1:SetPos(42, 0)
	layout1:SetSpaceY(32)
	layout1:SetSpaceX(32)
	layout1.Paint = function() end

	local layout2 = vgui.Create("DIconLayout", scrollpanel)
	layout2:SetSize(467, scrollpanel:GetTall())
	layout2:SetPos(509, 0)
	layout2:SetSpaceY(32)
	layout2:SetSpaceX(32)
	layout2.Paint = function() end

	local members1 = 0
	local members2 = 0

	for key, val in pairs(entities) do
		local entity

		if (members1 == 0) or (members1 < members2) then
			entity = layout1:Add("DPanel")
			members1 = members1 + #val.members
		else
			entity = layout2:Add("DPanel")
			members2 = members2 + #val.members
		end

		entity:SetSize(435, 80 + (#val.members * 58))
		entity.Paint = function(self, w, h)
			draw.RoundedBoxEx(3, 0, 0, w, 58, c454545, true, true, false, false)
			draw.RoundedBoxEx(3, 0, 58, w, h - 58, c424242, false, false, true, true)
			draw.SimpleText(val.name, "font_22r", 24, 18, c255255255)
		end

		for k, v in pairs(val.members) do
			local price = DarkRP.formatMoney(v.price)

			local buttoncolor = c25510251

			if v.customCheck and not v.customCheck(LocalPlayer()) then
				buttoncolor = c909090
			end

			local ent_pnl = vgui.Create("DPanel", entity)
			ent_pnl:SetSize(entity:GetWide(), 58)
			ent_pnl:SetPos(0, 69 + (k - 1) * 58)
			ent_pnl.Paint = function(self, w, h)
				draw.SimpleText(v.name, "font_22r", 74, 9, c255255255)
				draw.SimpleText("цена: " .. price, "font_19r", 74, 29, c165165165)
			end

			local ent_mdl = vgui.Create("SpawnIcon", ent_pnl)
			ent_mdl:SetSize(32, 32)
			ent_mdl:SetPos(25, 13)
			ent_mdl:SetModel(v.model)
			ent_mdl:SetMouseInputEnabled(false)

			local ent_btn = vgui.Create("DButton", ent_pnl)
			ent_btn:SetSize(75, 26)
			ent_btn:SetPos(ent_pnl:GetWide() - 100, 16)
			ent_btn:SetText("")
			ent_btn.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, buttoncolor)
				draw.SimpleText("КУПИТЬ", "font_15r", w * 0.5, h * 0.5 - 1, c255255255, 1, 1)
			end
			ent_btn.DoClick = function()
				if v.cmd ~= nil then
					RunConsoleCommand("darkrp", v.cmd)
				else
					if v.separate then
						local menu = DermaMenu()
						menu:AddOption("Количество: 1 (" .. DarkRP.formatMoney(v.pricesep) .. ")", function() RunConsoleCommand("darkrp", "buy", v.name) end)
						menu:AddOption("Количество: 5 (" .. DarkRP.formatMoney(v.price) .. ")", function() RunConsoleCommand("darkrp", "buyshipment", v.name) end)
						menu:Open()
					else
						RunConsoleCommand("darkrp", "buyshipment", v.name)
					end
				end
			end
		end
	end

end

local function LawsTab()

	local laws = DarkRP.getLaws()

	law_pnl = vgui.Create("DPanel", pnl)
	law_pnl:SetSize(pnl:GetWide() - 80, pnl:GetTall())
	law_pnl:SetPos(80, 0)
	law_pnl.Paint = function(self, w, h)
		draw.SimpleText("Законы", "font_35b", 40, 24, c255255255)
	end

	local scrollpanel = vgui.Create("DScrollPanel", law_pnl)
	scrollpanel:SetSize(law_pnl:GetWide(), law_pnl:GetTall() - 133)
	scrollpanel:SetPos(0, 91)
	scrollpanel.Paint = function() end

	local scrollbar = scrollpanel:GetVBar()

	scrollbar.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c454545)
	end

	scrollbar.btnUp.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c303030)
	end

	scrollbar.btnGrip.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c109109109)
	end

	scrollbar.btnDown.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c303030)
	end

	local totalheight = 0

	local lawheader = vgui.Create("DLabel", scrollpanel)
	lawheader:SetFont("font_22r")
	lawheader:SetText("• Дополнительно")
	lawheader:SizeToContents()
	lawheader:SetPos(42, totalheight)

	totalheight = totalheight + lawheader:GetTall() + 2

	for k, v in pairs(laws) do
		local law = vgui.Create("DLabel", scrollpanel)
		law:SetFont("font_22r")
		law:SetText(k .. ". " .. v)
		law:SizeToContents()
		law:SetPos(42, totalheight)

		totalheight = totalheight + law:GetTall() + 2
	end

	totalheight = totalheight + 30

	for key, val in pairs(defaultlaws) do
		for k, v in pairs(val) do
			local law = vgui.Create("DLabel", scrollpanel)
			law:SetFont("font_22r")
			law:SetText(v)
			law:SizeToContents()
			law:SetPos(42, totalheight)

			totalheight = totalheight + law:GetTall() + 2
		end

		totalheight = totalheight + 30
	end

	if LocalPlayer():IsMPF() or LocalPlayer():IsOTA() then
		for k, v in pairs(extralaws) do
			local law = vgui.Create("DLabel", scrollpanel)
			law:SetFont("font_22r")
			law:SetText(v)
			law:SizeToContents()
			law:SetPos(42, totalheight)

			totalheight = totalheight + law:GetTall() + 2
		end
	end

end

local function RememberTab()

	activetab = activetab or 2

	if activetab == 1 then
		EntitiesTab()
	elseif activetab == 2 then
		LawsTab()
	end

end

local function CloseTabs()

	if IsValid(ent_pnl) then
		ent_pnl:Remove()
		ent_pnl = nil
	end

	if IsValid(law_pnl) then
		law_pnl:Remove()
		law_pnl = nil
	end

end

local function CloseMenu()

	if IsValid(pnl) then
		pnl:Close()
		pnl = nil
	end

	CloseTabs()

end

local function OpenMenu()

	CloseMenu()

	local scrw = math.max(1152, ScrW() * 0.6)
	local scrh = math.max(720, ScrH() * 0.7)
	local curtime = CurTime()

	pnl = vgui.Create("DFrame")
	pnl:SetSize(scrw, scrh)
	pnl:Center()
	pnl:SetTitle("")
	pnl:ShowCloseButton(false)
	pnl:SetDraggable(false)
	pnl:MakePopup()
	pnl.Paint = function(self, w, h)
		if input.IsKeyDown(95) then
			if self.delay then CloseMenu() return end
		else
			if CurTime() - curtime > 0.3 then self.delay = true end
		end

		draw.RoundedBox(0, 80, 0, w - 80, h, c303030)
	end

	local tabs = vgui.Create("DPanel", pnl)
	tabs:SetSize(80, pnl:GetTall())
	tabs:SetPos(0, 0)
	tabs.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, 80, h, c230230230)
	end

	local menu = vgui.Create("DPanel", tabs)
	menu:SetSize(tabs:GetWide(), 56)
	menu:SetPos(0, 10)
	menu.Paint = function(self, w, h)
		draw.Icon(28, 16, 24, 24, c180180180, f4menu_menu)
	end

	-- entities
	local entities = vgui.Create("DButton", tabs)
	entities:SetText("")
	entities:SetSize(tabs:GetWide(), 56)
	entities:SetPos(0, 66)
	entities.Paint = function(self, w, h)
		if activetab == 1 then
			draw.RoundedBox(0, 0, 11, 2, 34, c25510251)
		end

		draw.Icon(28, 16, 24, 24, c303030, f4menu_entities)
	end
	entities.DoClick = function()
		CloseTabs()
		EntitiesTab()
		activetab = 1
	end

	-- laws
	local laws = vgui.Create("DButton", tabs)
	laws:SetText("")
	laws:SetSize(tabs:GetWide(), 56)
	laws:SetPos(0, 122)
	laws.Paint = function(self, w, h)
		if activetab == 2 then
			draw.RoundedBox(0, 0, 11, 2, 34, c25510251)
		end

		draw.Icon(28, 16, 24, 24, c303030, f4menu_laws)
	end
	laws.DoClick = function()
		CloseTabs()
		LawsTab()
		activetab = 2
	end

	if LocalPlayer():Staff() then
		local fsg = vgui.Create("DButton", tabs)
		fsg:SetText("")
		fsg:SetSize(tabs:GetWide(), 56)
		fsg:SetPos(0, tabs:GetTall() - 70)
		fsg.Paint = function(self, w, h)
			draw.Icon(28, 16, 24, 24, c303030, f4menu_fsg)
		end
		fsg.DoClick = function()
			CloseMenu()

			if LocalPlayer():Team() == TEAM_FSG then
				RunConsoleCommand("sam", "setjob", "^", "citizen")
			else
				RunConsoleCommand("darkrp", "fsg")
			end
		end
	end

	RememberTab()

end

function F4MenuToggle()

	if IsValid(pnl) then
		CloseMenu()
	else
		OpenMenu()
	end

end