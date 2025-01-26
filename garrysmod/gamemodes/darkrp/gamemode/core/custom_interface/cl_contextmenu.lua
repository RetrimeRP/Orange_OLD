local contextmenu
local ycode
local rcode

local showwhere_marks = {
	-- Офис ГСР
	{
		name = "Офис ГСР",
		time = 90,
		pos = Vector(-3140, -1528, 0),
		icon = "icon16/tag_blue.png"
	},

	-- Нексус Надзора
	{
		name = "Нексус Надзора",
		time = 90,
		pos = Vector(32, 224, 0),
		icon = "icon16/tag_blue.png"
	},

	-- Блок "A"
	{
		name = "Блок \"A\"",
		time = 60,
		pos = Vector(-448, -512, 0),
		icon = "icon16/tag_red.png"
	},

	-- Блок "B"
	{
		name = "Блок \"B\"",
		time = 60,
		pos = Vector(-2176, -512, 0),
		icon = "icon16/tag_red.png"
	},

	-- Пункт выдачи рационов
	{
		name = "Пункт выдачи рационов",
		time = 90,
		pos = Vector(-188, -2056, 32),
		icon = "icon16/tag_blue.png"
	},

	-- Завод изготовления рационов
	{
		name = "Завод изготовления рационов",
		time = 120,
		pos = Vector(246, -2784, 48),
		icon = "icon16/tag_blue.png"
	},

	-- Склады ГСР
	{
		name = "Склады ГСР",
		time = 100,
		pos = Vector(1638, -2296, 48),
		icon = "icon16/tag_blue.png"
	},

	-- Вокзал
	{
		name = "Вокзал",
		time = 60,
		pos = Vector(-3824, 1280, 40),
		icon = "icon16/tag_blue.png"
	}
}

hook.Add("DarkRPFinishedLoading", "DarkRP_ContextMenu", function()

	ycode = {}
	ycode[TEAM_MPF14] = true
	ycode[TEAM_MPF15] = true
	ycode[TEAM_OTA6] = true

	rcode = {}
	rcode[TEAM_MPF15] = true
	rcode[TEAM_OTA6] = true

end)

local function ContextMenuSingleRequest(title, subtitle, command)

	Derma_StringRequest(title, subtitle, "", function(arg) RunConsoleCommand("darkrp", command, arg) end, nil, "Готово", "Отмена")

end

local function ContextMenuSteamIDRequest(title, subtitle, command, steamid)

	Derma_StringRequest(title, subtitle, "", function(arg) RunConsoleCommand("darkrp", command, steamid, arg) end, nil, "Готово", "Отмена")

end

local function GetPlayers()

	local players = player.GetAll()

	table.sort(players, function(ply1, ply2)
		local job1 = ply1:GetDisguiseVar("id") or ply1:Team()
		local job2 = ply2:GetDisguiseVar("id") or ply2:Team()

		return job1 < job2
	end)

	return players

end

local function CloseContextMenu()

	if IsValid(contextmenu) then
		contextmenu:Remove()
		contextmenu = nil
	end

end

local function OpenContextMenu()

	if IsValid(contextmenu) then contextmenu:Remove() end

	contextmenu = vgui.Create("DMenu")

	local combine = LocalPlayer():IsCombine()
	local resistance = LocalPlayer():IsResistance()
	local job = LocalPlayer():Team()
	local players = GetPlayers()

	do
		-- dropmoney
		local dropmoney = contextmenu:AddOption("Выбросить деньги на землю", function() ContextMenuSingleRequest("Выбросить деньги", "Сколько выбросить", "dropmoney") end)
		dropmoney:SetIcon("icon16/money_delete.png")

		-- givemoney
		local givemoney = contextmenu:AddOption("Передать деньги игроку", function() ContextMenuSingleRequest("Передать деньги", "Сколько передать", "givemoney") end)
		givemoney:SetIcon("icon16/money_add.png")

		contextmenu:AddSpacer()

		-- dropweapon
		local dropweapon = contextmenu:AddOption("Выбросить текущее оружие", function() RunConsoleCommand("darkrp", "dropweapon") end)
		dropweapon:SetIcon("icon16/gun.png")

		-- name
		local name = contextmenu:AddOption("Изменить своё имя", function() ContextMenuSingleRequest("Изменить имя", "Новое имя", "name") end)
		name:SetIcon("icon16/user_edit.png")

		-- unownalldoors
		local unownalldoors = contextmenu:AddOption("Продать свои двери", function() RunConsoleCommand("darkrp", "unownalldoors") end)
		unownalldoors:SetIcon("icon16/door.png")

		-- thirdperson
		local thirdperson = contextmenu:AddOption("Переключить вид от 3-го лица", function() RunConsoleCommand("thirdperson_toggle") end)
		thirdperson:SetIcon("icon16/bricks.png")
	end

	do
		-- other
		local other, other_tab = contextmenu:AddSubMenu("Помощь и остальное")
		other_tab:SetIcon("icon16/rainbow.png")

		if LocalPlayer():Staff() then
			-- logging
			local logging = other:AddOption("Открыть логи", function() RunConsoleCommand("gmodadminsuite", "logging") end)
			logging:SetIcon("icon16/shield.png")

			if BRANCH == "x86-64" then
				-- youtube
				local youtube = other:AddOption("Ютубчик", function() RunConsoleCommand("youtube") end)
				youtube:SetIcon("icon16/xhtml.png")
			end
		end

		-- fpsbooster
		local fpsbooster = other:AddOption("Увеличение FPS", function() RunConsoleCommand("gmodadminsuite", "fpsbooster") end)
		fpsbooster:SetIcon("icon16/cog.png")

		-- -- donatelink
		-- local donatelink = other:AddOption("Автодонат ссылка", function() gui.OpenURL("https://gm-donate.ru/donate/3871") end)
		-- donatelink:SetIcon("icon16/information.png")

		-- stopsound
		local stopsound = other:AddOption("Выключить все звуки", function() RunConsoleCommand("stopsound") end)
		stopsound:SetIcon("icon16/wrench.png")

		local marks = GetMarks()

		if table.IsEmpty(marks) then
			-- cleargpsmarks
			local cleargpsmarks = other:AddOption("Удалить все метки", function() ClearMarks() surface.PlaySound("buttons/lightswitch2.wav") end)
			cleargpsmarks:SetIcon("icon16/wrench.png")
		else
			local clearmarks, clearmarks_tab = other:AddSubMenu("Очистить все метки", function() ClearMarks() end)
			clearmarks_tab:SetIcon("icon16/wrench.png")
	
			for k, v in pairs(marks) do
				local option = clearmarks:AddOption(v.text:gsub("\n", " "), function() RemoveMark(k) end)
				option:SetIcon("icon16/bullet_white.png")
			end
		end

		other:AddSpacer()

		-- online
		local online, online_tab = other:AddSubMenu("Пользователи онлайн")
		online_tab:SetIcon("icon16/group.png")

		local playercount = 0
		local combinecount = 0
		local resistancecount = 0
		local guildcount = 0
		local guardiancount = 0

		for k, v in ipairs(players) do
			playercount = playercount + 1

			if v:IsGuardian() then
				guardiancount = guardiancount + 1
			elseif v:IsGuild() then
				guildcount = guildcount + 1
			elseif v:IsResistance() then
				resistancecount = resistancecount + 1
			elseif v:IsCombine() then
				combinecount = combinecount + 1
			end
		end

		local playertext = "Всего - " .. playercount .. " онлайн"
		local combinetext = "Альянс - " .. combinecount .. " онлайн"
		local resistancetext = "Сопротивление - " .. resistancecount .. " онлайн"
		local guildtext = "Гильдия NS/DOD - " .. guildcount .. " онлайн"
		local guardiantext = "Отряд Guardian - " .. guardiancount .. " онлайн"

		online:AddOption(playertext, function() SetClipboardText(playertext) end)
		online:AddOption(combinetext, function() SetClipboardText(combinetext) end)
		online:AddOption(resistancetext, function() SetClipboardText(resistancetext) end)
		online:AddOption(guildtext, function() SetClipboardText(guildtext) end)
		online:AddOption(guardiantext, function() SetClipboardText(guardiantext) end)

		-- showwhere
		local showwhere, showwhere_tab = other:AddSubMenu("Показать местонахождение")
		showwhere_tab:SetIcon("icon16/world.png")

		for k, v in ipairs(showwhere_marks) do
			local option = showwhere:AddOption(v.name, function() CreateMark(2, v.time, v.name, "ShowWhere", v.pos) surface.PlaySound("buttons/lightswitch2.wav") end)
			option:SetIcon(v.icon)
		end

		-- links
		local links, links_tab = other:AddSubMenu("Полезные ссылки")
		links_tab:SetIcon("icon16/book.png")

		links:AddOption("Наш сайт", function() gui.OpenURL("https://redirect.retrime.com/site") end)
		links:AddOption("Наш VK", function() gui.OpenURL("https://redirect.retrime.com/vk") end)
		links:AddOption("Наш Steam", function() gui.OpenURL("https://redirect.retrime.com/steam") end)
		links:AddOption("Наш Discord", function() gui.OpenURL("https://discord.gg/eEdJspz") end)
		links:AddSpacer()
		links:AddOption("Правила", function() gui.OpenURL("https://wiki.retrime.com/ru/legacy/rules") end)

		-- jobs
		links:AddOption("Работы", function() gui.OpenURL("https://wiki.retrime.com/ru/legacy/jobs") end)
	end

	--
	-- chatsounds
	--
	local chatsoundslist = DarkRP.GetChatSounds()

	if chatsoundslist then
		local chatsounds, chatsounds_tab = contextmenu:AddSubMenu("Голосовые команды")
		chatsounds_tab:SetIcon("icon16/comment.png")

		for key, val in pairs(chatsoundslist) do
			if istable(val) then
				local group = chatsounds:AddSubMenu(key)

				for k, v in pairs(val) do
					if v == "$spacer" then group:AddSpacer() continue end
					group:AddOption(v, function() RunConsoleCommand("say", v) end)
				end
			else
				if val == "$spacer" then chatsounds:AddSpacer() continue end
				chatsounds:AddOption(val, function() RunConsoleCommand("say", val) end)
			end
		end
	end

	--
	-- fire
	--
	local firejobs = DarkRP.GetFireJobs()[job]

	if firejobs then
		local fire, fire_tab = contextmenu:AddSubMenu("Уволить игрока")
		fire_tab:SetIcon("icon16/user.png")

		for k, v in ipairs(players) do
			local firejob = v:GetDisguiseVar("id") or v:Team()

			if firejobs[firejob] then
				fire:AddOption(v:getDarkRPVar("job") .. " | " .. v:Nick(), function() ContextMenuSteamIDRequest("Уволить " .. v:Nick(), "Укажите причину", "fire", v:SteamID()) end)
			end
		end
	end

	--
	-- cashbonus
	--
	local cashbonusjobs = DarkRP.GetCashbonusJobs()[job]

	if cashbonusjobs then
		local cashbonus, cashbonus_tab = contextmenu:AddSubMenu("Выдать премию")
		cashbonus_tab:SetIcon("icon16/money.png")

		cashbonus:AddOption("Выдать премию всем", function() RunConsoleCommand("darkrp", "awardall") end)

		cashbonus:AddSpacer()

		for k, v in ipairs(players) do
			local cashbonusjob = v:GetDisguiseVar("id") or v:Team()

			if cashbonusjobs[cashbonusjob] then
				cashbonus:AddOption(v:getDarkRPVar("job") .. " | " .. v:Nick(), function() RunConsoleCommand("darkrp", "award", v:SteamID()) end)
			end
		end
	end

	--
	-- radio
	--
	if combine or resistance or LocalPlayer():IsGuild() then
		local radio = GetConVar("radio_enabled")
		local voice = GetConVar("radio_enabled_voice")

		contextmenu:AddSpacer()

		if radio:GetInt() == 0 then
			local radio_on = contextmenu:AddOption("Включить рацию", function() radio:SetInt(1) LocalPlayer():EmitSound("npc/metropolice/vo/on" .. math.random(1, 2) .. ".wav") end)
			radio_on:SetIcon("icon16/phone_sound.png")
		else
			local radio_off = contextmenu:AddOption("Выключить рацию", function() radio:SetInt(0) LocalPlayer():EmitSound("npc/metropolice/vo/off" .. math.random(1, 4) .. ".wav") if voice:GetInt() == 1 then voice:SetInt(0) end end)
			radio_off:SetIcon("icon16/phone.png")

			if voice:GetInt() == 0 then
				local voice_on = contextmenu:AddOption("Включить голос в рацию", function() voice:SetInt(1) LocalPlayer():EmitSound("npc/metropolice/vo/on" .. math.random(1, 2) .. ".wav") end)
				voice_on:SetIcon("icon16/phone_add.png")
			else
				local voice_off = contextmenu:AddOption("Выключить голос в рацию", function() voice:SetInt(0) LocalPlayer():EmitSound("npc/metropolice/vo/off" .. math.random(1, 4) .. ".wav") end)
				voice_off:SetIcon("icon16/phone_delete.png")
			end
		end
	end

	--
	-- combine
	--
	if combine then
		contextmenu:AddSpacer()

		-- wanted
		local wanted, wanted_tab = contextmenu:AddSubMenu("Выдать розыск")
		wanted_tab:SetIcon("icon16/add.png")

		local wantedreasons = {
			"Угроза обществу 1 уровня",
			"Угроза обществу 2 уровня",
			"Угроза обществу 3 уровня",
			"Угроза обществу 4 уровня",
			"Угроза обществу 5 уровня",
			"Антиобщественная деятельность 1 уровня",
			"Антиобщественная деятельность 2 уровня"
		}

		for k, v in ipairs(players) do
			if not v:IsCombine() and not v:IsResistance() and not v:IsGuild() and v:Team() ~= TEAM_FSG then
				local plywanted = wanted:AddSubMenu(v:Nick(), function() ContextMenuSteamIDRequest("Выдать розыск " .. v:Nick(), "Укажите причину", "wanted", v:SteamID()) end)

				for key, reason in ipairs(wantedreasons) do
					plywanted:AddOption(reason, function() RunConsoleCommand("darkrp", "wanted", v:SteamID(), reason) end)
				end
			end
		end

		-- unwanted
		local unwanted, unwanted_tab = contextmenu:AddSubMenu("Снять розыск")
		unwanted_tab:SetIcon("icon16/delete.png")

		for k, v in ipairs(players) do
			if v:isWanted() then
				unwanted:AddOption(v:Nick(), function() RunConsoleCommand("darkrp", "unwanted", v:SteamID()) end)
			end
		end

		-- warrant
		local warrant, warrant_tab = contextmenu:AddSubMenu("Запросить обыск")
		warrant_tab:SetIcon("icon16/briefcase.png")

		local warrantreasons = {
			"Инспекция имущества",
			"Штурм имущества",
			"Хранение контрабанды",
			"Подозрение в хранении контрабанды",
			"Уклонение от Гражданской обороны"
		}

		for k, v in ipairs(players) do
			if not v:IsCombine() and not v:GetDisguiseVar("combine") and v:Team() ~= TEAM_FSG then
				local plywarrant = warrant:AddSubMenu(v:Nick(), function() ContextMenuSteamIDRequest("Запросить обыск " .. v:Nick(), "Укажите причину", "warrant", v:SteamID()) end)

				for key, reason in ipairs(warrantreasons) do
					plywarrant:AddOption(reason, function() RunConsoleCommand("darkrp", "warrant", v:SteamID(), reason) end)
				end
			end
		end
	end

	--
	-- ycode
	--
	if ycode[job] then
		contextmenu:AddSpacer()

		local ycode_tab = contextmenu:AddOption("Включить желтый код", function() RunConsoleCommand("darkrp", "yellowcode") end)
		ycode_tab:SetIcon("icon16/error.png")

		local undoycode = contextmenu:AddOption("Выключить желтый код", function() RunConsoleCommand("darkrp", "unyellowcode") end)
		undoycode:SetIcon("icon16/error.png")
	end

	--
	-- rcode
	--
	if rcode[job] then
		contextmenu:AddSpacer()

		local rcode_tab = contextmenu:AddOption("Включить красный код", function() RunConsoleCommand("darkrp", "redcode") end)
		rcode_tab:SetIcon("icon16/pill.png")

		local undorcode = contextmenu:AddOption("Выключить красный код", function() RunConsoleCommand("darkrp", "unredcode") end)
		undorcode:SetIcon("icon16/pill.png")
	end

	--
	-- SEC
	--
	if job == TEAM_MPF15 then
		contextmenu:AddSpacer()

		-- recruiting
		local recruiting = contextmenu:AddOption("Включить системный набор", function() RunConsoleCommand("darkrp", "recruiting") end)
		recruiting:SetIcon("icon16/status_online.png")

		-- undorecruiting
		local undorecruiting = contextmenu:AddOption("Выключить системный набор", function() RunConsoleCommand("darkrp", "unrecruiting") end)
		undorecruiting:SetIcon("icon16/status_busy.png")

		-- recruit
		local recruit = contextmenu:AddOption("Предложить вступить игроку", function() RunConsoleCommand("darkrp", "recruit") end)
		recruit:SetIcon("icon16/status_offline.png")
	end

	--
	-- OWD
	--
	if job == TEAM_MPF16 then
		local cityphrases = DarkRP.GetCityPhrases()
		local radiophrases = DarkRP.GetRadioPhrases()

		contextmenu:AddSpacer()

		-- cityvoice
		local cityvoice, cityvoice_tab = contextmenu:AddSubMenu("Диспетчерские фразы - город")
		cityvoice_tab:SetIcon("icon16/comments.png")

		for k, v in ipairs(cityphrases) do
			cityvoice:AddOption(v.text, function() RunConsoleCommand("darkrp", "cityvoice", k) end)
		end

		-- radiovoice
		local radiovoice, radiovoice_tab = contextmenu:AddSubMenu("Диспетчерские фразы - рации")
		radiovoice_tab:SetIcon("icon16/comments.png")

		for k, v in ipairs(radiophrases) do
			radiovoice:AddOption(v.text, function() RunConsoleCommand("darkrp", "radiovoice", k) end)
		end

		-- radiotoggle
		local radiotoggle, radiotoggle_tab = contextmenu:AddSubMenu("Выключить голос в рацию")
		radiotoggle_tab:SetIcon("icon16/connect.png")

		radiotoggle:AddOption("Выключить голос в рацию всем", function() RunConsoleCommand("darkrp", "radiotoggleall") end)

		radiotoggle:AddSpacer()

		for k, v in ipairs(players) do
			if v:IsCombine() or v:GetDisguiseVar("combine") then
				radiotoggle:AddOption(v:getDarkRPVar("job") .. " | " .. v:Nick(), function() RunConsoleCommand("darkrp", "radiotoggle", v:SteamID()) end)
			end
		end
	end

	--
	-- Admin
	--
	if job == TEAM_ADMIN then
		contextmenu:AddSpacer()

		-- lockdown
		local lockdown = contextmenu:AddOption("Начать комендантский час", function() RunConsoleCommand("darkrp", "lockdown") end)
		lockdown:SetIcon("icon16/tick.png")

		-- unlockdown
		local unlockdown = contextmenu:AddOption("Закончить комендантский час", function() RunConsoleCommand("darkrp", "unlockdown") end)
		unlockdown:SetIcon("icon16/cross.png")

		contextmenu:AddSpacer()

		-- addlaw
		local addlaw = contextmenu:AddOption("Добавить закон", function() ContextMenuSingleRequest("Добавить закон", "Текст закона", "addLaw") end)
		addlaw:SetIcon("icon16/application_form_add.png")

		-- removelaw
		local removelaw = contextmenu:AddOption("Убрать закон", function() ContextMenuSingleRequest("Убрать закон", "Номер закона", "removeLaw") end)
		removelaw:SetIcon("icon16/application_form_delete.png")

		-- resetlaws
		local resetlaws = contextmenu:AddOption("Сбросить законы", function() RunConsoleCommand("darkrp", "resetLaws") end)
		resetlaws:SetIcon("icon16/application_form.png")
	end

	contextmenu:MoveTo(20, (ScrH() * 0.5) - ((contextmenu:ChildCount() * 24) * 0.5 - 48), 0, 0)
	contextmenu:Open()

end

concommand.Add("closecontextmenu", function()

	CloseContextMenu()

end)

concommand.Add("opencontextmenu", function()

	OpenContextMenu()

end)

hook.Add("OnContextMenuClose", "DarkRP_CloseContextMenu", function()

	LocalPlayer():ConCommand("closecontextmenu")

end)

hook.Add("OnContextMenuOpen", "DarkRP_OpenContextMenu", function()

	LocalPlayer():ConCommand("opencontextmenu")

end)