surface.CreateFont( 'EM:FontTimer', {
	font = 'Roboto Mono',
	extended = true,
	size = 200,
	weight = 800,
} )

surface.CreateFont( 'EM:WrapText', {
	font = 'Roboto Mono',
	extended = true,
	size = 24,
	weight = 100,
} )

surface.CreateFont( 'EM:Credits_Large', {
	font = 'Roboto Mono',
	extended = true,
	size = 36,
	weight = 500,
} )

surface.CreateFont( 'EM:Credits_Small', {
	font = 'Roboto Mono',
	extended = true,
	size = 28,
	weight = 400,
} )


surface.CreateFont( 'EM:ChatText', {
	font = 'DOS2000 (RU/EN)',
	extended = true,
	size = 18,
	weight = 100,
} )

restricted_jobs = {}
death_jobs = {}

local logo = Material( 'materials/retrime_orange/arrival/site.png', 'noclamp smooth' )

local function drawMaterial(material, x, y, w, h, color)
    surface.SetDrawColor(color or color_white)
    surface.SetMaterial(material or logo)
    surface.DrawTexturedRect(x, y, w, h)
end

local templates = {
    ['Начало'] = { callback = function()
            net.Start('Retrime::EM::StartTimer')
                net.WriteFloat(tonumber(20))
            net.SendToServer()

            timer.Simple(20, function()
                net.Start('Retrime::EM::StartCumScene')
                net.SendToServer()
                RunConsoleCommand('suka_jobs')
            end)
        end
    },
    ['Заблочить все профы'] = { callback = function()
        RunConsoleCommand('block_jobs')
        for _, v in ipairs(RPExtraTeams) do
            restricted_jobs[#restricted_jobs + 1] = v.name
        end
    end},
    ['Разблочить все профы'] = { callback = function()
        RunConsoleCommand('unblock_jobs')
        restricted_jobs = {}

    end},
    ['Захуйнуть музыку всем'] = { callback = function()
        Mantle.ui.text_box('Запуск звука [File]', 'Введите путь до файла', function(s)
            if s == '' then
                return
            end

            local categories = {}
            for _, tbl in ipairs(DarkRP.getCategories().jobs) do
                categories[#categories + 1] = tbl.name
            end

            net.Start('Retrime::EM::Sound')
                net.WriteTable(categories)
                net.WriteString(s)
            net.SendToServer()
        end)
    end},
    ['Коноцвка'] = { callback = function()
        net.Start('Retrime::EM::StartCumEndScene')
        net.SendToServer()
    end},
}

net.Receive('StartCumFirst', function(_, ply)
    EM_StartSlides(scene_start)
end)

net.Receive('StartCumLast', function(_, ply)
    EM_StartSlides(scene_end)
    surface.PlaySound("retrime/end_scene_01.mp3")
end)


--[[
    Event Manager :: Nets Timer
]]

net.Receive('Retrime::EM::CL::Timer', function(_, ply)
    local seconds = net.ReadFloat()
    timer.Create('Retrime::EM::Timer', seconds, 1, function() if IsValid(screen_timer) then screen_timer:AlphaTo(255, 1, 0, function() screen_timer:Remove() end) end end)

    if screen_timer then screen_timer:Remove() end
    screen_timer = vgui.Create('DPanel')
    screen_timer:SetSize(ScrW(), ScrH())
    screen_timer:SetAlpha(0)
    screen_timer:AlphaTo(255, 1)
    screen_timer.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, EM.Colors['retrime_dark'])
        local time_left = timer.TimeLeft('Retrime::EM::Timer')

        -- drawMaterial(logo, w * .5 - 332 * .5, 68, 332, 27)
        draw.SimpleText("RETRIME LEGACY STORY ...25", 'EM:WrapText', w * .5, 68, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(string.ToMinutesSeconds( time_left ), 'EM:FontTimer', w * .5, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

end)

net.Receive('Retrime::EM::CL::TimerAdd', function(_, ply)
    
    local seconds = net.ReadFloat()
    timer.Adjust('Retrime::EM::Timer', tonumber(seconds) + timer.TimeLeft('Retrime::EM::Timer'), 1, function() end )

end)

net.Receive('Retrime::EM::CL::TimerRemove', function(_, ply)

    timer.Remove('Retrime::EM::Timer')
    if IsValid(screen_timer) then screen_timer:AlphaTo(0, 1, 0, function() screen_timer:Remove() end) end

end)

net.Receive('Retrime::EM::CL::TimerRemovePlayer', function(_, ply)

    if IsValid(screen_timer) then screen_timer:AlphaTo(0, 1, 0, function() screen_timer:Remove() end) end

end)

--[[
    Event Manager :: Nets Sounds
]]

net.Receive('Retrime::EM::CL::SendSound', function(_, ply)
    local soundpath = net.ReadString()

    print(soundpath)

    surface.PlaySound(soundpath)

end)

--[[
    Event Manager :: Menu
]]

local function EM_Open()
    local menu = vgui.Create('DFrame')
    Mantle.ui.frame(menu, 'Event Manager', 960, 600, true)
    menu:Center()
    menu:MakePopup()
    menu:SetKeyBoardInputEnabled(false)
    menu.center_title = ''

    menu.tabs = Mantle.ui.panel_tabs(menu)

    --[[
        Event Manager :: Menu :: Timer Panel
    ]]

    local panel_timer = vgui.Create('DPanel')
    panel_timer.Paint = nil

    panel_timer.sp = vgui.Create('DScrollPanel', panel_timer)
    panel_timer.sp:Dock(FILL)

    timer_panel = vgui.Create('DButton', panel_timer.sp)
    Mantle.ui.btn(timer_panel, nil, nil, timer.Exists( 'Retrime::EM::Timer' ) and EM.Colors['green'] or EM.Colors['red'], nil, nil, timer.Exists( 'Retrime::EM::Timer' ) and EM.Colors['green'] or EM.Colors['red'])
    timer_panel:Dock(TOP)
    timer_panel:DockMargin(0, 0, 0, 4)
    timer_panel:SetTall(60)
    timer_panel:SetText('')
    timer_panel.Paint = function(self, w, h) 
        local color = timer.Exists( 'Retrime::EM::Timer' ) and EM.Colors['green'] or EM.Colors['red']
        local text = 'Таймер ' .. (timer.Exists( 'Retrime::EM::Timer' ) and 'активен [' .. string.ToMinutesSeconds(  timer.TimeLeft('Retrime::EM::Timer') ) .. ']' or 'неактивен')
        draw.RoundedBox(6, 0, 0, w, h, color )

        draw.SimpleText(text, 'Fated.18', w * .5, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local function CreateBtn(sp, name, func)
        local btn = vgui.Create('DButton', sp)
        Mantle.ui.btn(btn)
        btn:Dock(TOP)
        btn:DockMargin(0, 0, 0, 4)
        btn:SetText(name)
        btn.DoClick = function()
            Mantle.func.sound()

            func()
        end
        
        return btn
    end

    CreateBtn(panel_timer.sp, 'Запустить таймер', function()
        Mantle.ui.text_box('Время', 'Введите количество секунд', function(s)
            if s == '' then
                return
            end

            net.Start('Retrime::EM::StartTimer')
                net.WriteFloat(tonumber(s))
            net.SendToServer()
        end)
    end)

    CreateBtn(panel_timer.sp, 'Добавить время', function()
        Mantle.ui.text_box('Время', 'Введите количество секунд', function(s)
            if s == '' then
                return
            end

            net.Start('Retrime::EM::AddTime')
                net.WriteFloat(tonumber(s))
            net.SendToServer()
        end)
    end)

    CreateBtn(panel_timer.sp, 'Удалить таймер', function()
        net.Start('Retrime::EM::StopTimer')
        net.SendToServer()
    end)

    CreateBtn(panel_timer.sp, 'Вытащить из лимбо', function()
        Mantle.ui.player_selector(function(pl)
            net.Start('Retrime::EM::PlayerRemoveTimer')
                net.WriteEntity(pl)
            net.SendToServer()
        end)
    end)

    menu.tabs:AddTab('Управление Таймером', panel_timer, 'icon16/status_offline.png')
    menu.tabs:ActiveTab('Управление Таймером')
   
    --[[
        Event Manager :: Menu :: User Panel
   ]]
        
    local panel_sound = vgui.Create('DPanel')
    panel_sound.Paint = nil

    panel_sound.up = vgui.Create('DScrollPanel', panel_sound)
    panel_sound.up:Dock(TOP)
    panel_sound.up:SetTall(200)


    panel_sound.sp = vgui.Create('DScrollPanel', panel_sound)
    panel_sound.sp:Dock(TOP)
    panel_sound.sp:SetTall(200)

    local categories = {}
    for _, tbl in ipairs(DarkRP.getCategories().jobs) do
        local category, category_convar = Mantle.ui.checkbox(panel_sound.up, tbl.name)
        category:DockMargin(0, 0, 0, 6)
        category_convar.DoClick = function(self)
            self.enabled = not self.enabled 
            if self.enabled then
                categories[#categories + 1] = tbl.name
            else
                table.RemoveByValue(categories, tbl.name)
            end
        end

    end

    CreateBtn(panel_sound, 'Запустить звук', function()
        Mantle.ui.text_box('Запуск звука [File]', 'Введите путь до файла', function(s)
            if s == '' then
                return
            end

            net.Start('Retrime::EM::Sound')
                net.WriteTable(categories)
                net.WriteString(s)
            net.SendToServer()
        end)
    end)

    CreateBtn(panel_sound, 'Остановить звук', function()
        RunConsoleCommand('sam', 'stopsound')
    end)

    


    for _, v in player.Iterator() do
        local btn = vgui.Create('DButton', panel_sound.sp)
        Mantle.ui.btn(btn)
        btn:Dock(TOP)
        btn:DockMargin(0, 0, 0, 4)
        btn:SetText('')
        btn.Paint = function(self, w, h) 
            local color = v:ListenStatus() and EM.Colors['green'] or EM.Colors['red']
            draw.RoundedBox(6, 0, 0, w, h, color )

            draw.SimpleText(v:Name() .. ' [' .. v:getJobTable().category .. ']', 'Fated.18', w * .5, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end



    menu.tabs:AddTab('Управление Звуком', panel_sound, 'icon16/status_offline.png')

    local panel_jobs = vgui.Create('DPanel')
    panel_jobs.Paint = nil

    panel_jobs.sp = vgui.Create('DScrollPanel', panel_jobs)
    panel_jobs.sp:Dock(FILL)

    for _, tbl in ipairs(RPExtraTeams) do
        local job, job_convar = Mantle.ui.checkbox(panel_jobs.sp, tbl.name)
        job:Dock(TOP)
        job:DockMargin(0, 0, 0, 6)
        job_convar.enabled = table.HasValue(restricted_jobs, tbl.name)
        job_convar.DoClick = function(self)
            self.enabled = not self.enabled 
            if self.enabled then
                restricted_jobs[#restricted_jobs + 1] = tbl.name
            else
                table.RemoveByValue(restricted_jobs, tbl.name)
            end
        end
    end

    CreateBtn(panel_jobs, 'Обновить таблицу', function()
        net.Start('Retrime::EM::BlockJobs')
            net.WriteTable(restricted_jobs)
        net.SendToServer()
    end)

    menu.tabs:AddTab('Управление Профессиями', panel_jobs, 'icon16/status_offline.png')

    local panel_template = vgui.Create('DPanel')
    panel_template.Paint = nil

    panel_template.sp = vgui.Create('DScrollPanel', panel_template)
    panel_template.sp:Dock(FILL)

    for k, v in pairs(templates) do
        CreateBtn(panel_template.sp, k, v.callback)
    end

    menu.tabs:AddTab('Шаблоны', panel_template, 'icon16/status_offline.png')

    local panel_death = vgui.Create('DPanel')
    panel_death.Paint = nil

    panel_death.sp = vgui.Create('DScrollPanel', panel_death)
    panel_death.sp:Dock(FILL)

    local function CreatePanel(pnl, text, category)
        local DPanel = vgui.Create('DPanel', pnl)
        DPanel:Dock(TOP)
        DPanel:SetTall(40)
        DPanel.Paint = function(self, w, h) draw.SimpleText(text, 'Fated.18', 10, h * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER) end

        local option = vgui.Create('DComboBox', DPanel)
        option:Dock(RIGHT)
        option:SetWide(140)
        option:SetValue( death_jobs[category] or 'Ничего' )
        option:AddChoice( 'Ничего' )
        for _, v in ipairs(RPExtraTeams) do
            option:AddChoice( v.name )
        end
        option.OnSelect = function( _, _, value )
            if value ~= 'Ничего' then
                death_jobs[category] = value
            else
                table.RemoveByValue(death_jobs, category)
            end
        end
    end

    for k, v in ipairs(DarkRP.getCategories().jobs) do
        CreatePanel(panel_death.sp, v.name, v.name)
    end

    CreateBtn(panel_death, 'Обновить таблицу', function()
        net.Start('UpdateTables')
            net.WriteTable(death_jobs)
        net.SendToServer()

        PrintTable(death_jobs)
    end)

    menu.tabs:AddTab('Смэрть', panel_death, 'icon16/status_offline.png')


end

concommand.Add('em_open', EM_Open)
