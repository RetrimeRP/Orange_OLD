include('shared.lua')

function ENT:Initialize()
	
end

function ENT:Draw()
	self:DrawModel()

	if self:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
		local Ang = LocalPlayer():GetAngles()

		Ang:RotateAroundAxis( Ang:Forward(), 90)
		Ang:RotateAroundAxis( Ang:Right(), 90)


        cam.Start3D2D(self:GetPos()+self:GetUp()*60, Ang, 0.05)
            draw.SimpleText( "Терминал Альянса", "ui.35", -160, 25, color_white )
            draw.SimpleText( "Нажмите [E] для взаимодействия", "ui.35", -260, 55, Color(220,0,0) )
         --   draw.SimpleText( "Нажмите [E] для взаимодействия", "ui.25", 0, 0, color_white )
        cam.End3D2D()

    end
end

local function OpenCodes()
    oc = vgui.Create("DPanel", f)
    oc:Dock(FILL)
    oc.Paint = function(self, w, h) draw.DrawText("УПРАВЛЕНИЕ СТАТУСОМ СЕКТОРА", "ui.30", w/2, ui.h(60),  Color(255,255,255), TEXT_ALIGN_CENTER) end

    bl = vgui.Create("ui-sp", oc)
    bl:SetSize(ui.w(1920), ui.h(900))
    bl:SetPos(0, ui.h(561))
    bl.Paint = nil

    --[[Красный код]]

    local red = vgui.Create("ui-button", bl)
    red:SetParent(bl)
    red:SetText("")
    red:Dock(TOP)
    red:DockMargin(0, 0, 0, 0)
    red:SetSize(ui.w(1920), ui.h(50))
    if GetGlobalBool("yellowcode") == false and GetGlobalBool("workingphase") == false then
        red.DoClick = function()
            local netName = "terminal_redcode"
            net.Start(netName) net.SendToServer()
        end
    end

    red.Paint = function(self, w, h)
        if GetGlobalBool("yellowcode") == false and GetGlobalBool("workingphase") == false then
            if self:IsHovered() then
           -- -- draw.Drawmaterial("vgui/gradient-l", 0, 0, w, h, Color(255,255,255))
            end
            draw.SimpleText( GetGlobalBool("redcode") == true and "Отключить красный код" or math.Round(GetGlobalInt('CodeAbuse') - CurTime()) > 0 and "Недоступно еще " .. math.Round(GetGlobalInt('CodeAbuse') - CurTime()) .. " секунд" or "Объявить красный код", "font_32r", ui.w(10), ui.h(7), self:IsHovered() and Color(103, 58, 183) or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        else
            if self:IsHovered() then
             --   -- draw.Drawmaterial("vgui/gradient-l", 0, 0, w, h, color_white)
            end
            draw.SimpleText( "Недоступно", "font_32r", ui.w(10), ui.h(7), self:IsHovered() and Color(103, 58, 183) or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
    end

    local yellow = vgui.Create("ui-button", bl)
    yellow:SetParent(bl)
    yellow:SetText("")
    yellow:Dock(TOP)
    yellow:DockMargin(0, 0, 0, 0)
    yellow:SetSize(ui.w(1920), ui.h(50))
    if GetGlobalBool("redcode") == false and GetGlobalBool("workingphase") == false then
        yellow.DoClick = function()
            local netName = "terminal_yellowcode"
            net.Start(netName) net.SendToServer()
        end
    end

    yellow.Paint = function(self, w, h)
        if GetGlobalBool("redcode") == false and GetGlobalBool("workingphase") == false then
            if self:IsHovered() then
           -- -- draw.Drawmaterial("vgui/gradient-l", 0, 0, w, h, Color(255,255,255))
            end
            draw.SimpleText( GetGlobalBool("yellowcode") == true and "Отключить жёлтый код" or math.Round(GetGlobalInt('CodeAbuse') - CurTime()) > 0 and "Недоступно еще " .. math.Round(GetGlobalInt('CodeAbuse') - CurTime()) .. " секунд" or "Объявить жёлтый код", "font_32r", ui.w(10), ui.h(7), self:IsHovered() and Color(103, 58, 183) or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        else
            if self:IsHovered() then
              --  -- draw.Drawmaterial("vgui/gradient-l", 0, 0, w, h, color_white)
            end
            draw.SimpleText( "Недоступно", "font_32r", ui.w(10), ui.h(7), self:IsHovered() and Color(103, 58, 183) or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
    end

    local working = vgui.Create("ui-button", bl)
    working:SetParent(bl)
    working:SetText("")
    working:Dock(TOP)
    working:DockMargin(0, 0, 0, 0)
    working:SetSize(ui.w(1920), ui.h(50))
    if GetGlobalBool("redcode") == false and GetGlobalBool("yellowcode") == false then
        working.DoClick = function()
            local netName = "terminal_workingphase"
            net.Start(netName) net.SendToServer()
        end
    end

    working.Paint = function(self, w, h)

        if GetGlobalBool("redcode") == false and GetGlobalBool("yellowcode") == false then
            if self:IsHovered() then
          --  -- draw.Drawmaterial("vgui/gradient-l", 0, 0, w, h, Color(255,255,255))
            end
            draw.SimpleText( GetGlobalBool("workingphase") == true and "Отключить действие рабочей фазы" or math.Round(GetGlobalInt('CodeAbuse') - CurTime()) > 0 and "Недоступно еще " .. math.Round(GetGlobalInt('CodeAbuse') - CurTime()) .. " секунд" or "Объявить рабочую фазу", "font_32r", ui.w(10), ui.h(7), self:IsHovered() and Color(103, 58, 183) or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        else
            if self:IsHovered() then
                -- draw.Drawmaterial("vgui/gradient-l", 0, 0, w, h, color_white)
            end
            draw.SimpleText( "Недоступно", "font_32r", ui.w(10), ui.h(7), self:IsHovered() and Color(103, 58, 183) or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
    end


    --[[НАЗАД]]

    local back = vgui.Create("ui-button", oc)
    back:SetText("")
    back:SetPos(ui.w(20), ui.h(900))
    back:SetSize(ui.w(1920), ui.h(50))
    back.DoClick = function() oc:Remove() om:SetVisible(true) end
    back.Paint = function(self, w, h) draw.DrawText("< НАЗАД", "ui.30", 0, 0, color_white, TEXT_ALIGN_LEFT) end
end

local list = {
    [1] = {text = "Гражданин, вы обвиняетесь в тяжком несоответствии. Асоциальный статус подтвержден."},
	[2] = {text = "Вниманию жителей! Ваш квартал обвиняется в недоносительстве. Штраф - пять пищевых единиц."},
	[3] = {text = "Вниманию всех наземных сил: судебное разбирательство отменено. Смертная казнь - по усмотрению"},
	[4] = {text = "Отказ от сотрудничества - выселение в нежилое пространство"},
	[5] = {text = "Гражданин, Вы угроза обществу первого уровня. Подразделениям ГО, код пресечения: долг, меч, полночь."},
	[6] = {text = "Граждане, введен код действия при беспорядках. Код: обезвредить, защитить, усмирить. Код: подавить, меч, стерилизовать."},
	[7] = {text = "Граждане: бездействие преступно. О противоправном поведении немедленно доложить силам ГО."},
	[8] = {text = "Вниманию наземного отряда ГО, задействовано осуждение на месте. Приговор выносить по усмотрению. Код: отсечь, обнулить, подтвердить."},
	[9] = {text = "Гражданин, Вы угроза обществу первого уровня. Подразделениям ГО, код пресечения: долг, меч, полночь."},
	[10] = {text = "Гражданин, теперь Вы угроза обществу пятого уровня. Немедленно прекратить уклонение и выслушать приговор."},
	[11] = {text = "Гражданин, вы обвиняетесь во множественных нарушениях. Гражданство отозвано. Статус: злостный нарушитель."},
	[12] = {text = "Вниманию наземного отряда ГО, задействовано осуждение на месте. Приговор выносить по усмотрению. Код: отсечь, обнулить, подтвердить."},
	[13] = {text = "Внимание! Уклонистское поведение. Неподчинение обвиняемого. Наземным силам ГО, тревога! Код: изолировать, огласить, исполнить."},
	[14] = {text = "Тревога! Подразделениям гражданской обороны, обнаружены локальные беспорядки. Собрать, исполнить, усмирить."},
	[15] = {text = "Внимание! Неопознанное лицо. Немедленно подтвердить статус в отделе гражданской обороны."},
	[16] = {text = "Вниманию наземных сил! В сообществе найден нарушитель. Код: окружить, клеймить, усмирить."},
	[17] = {text = "Внимание! В квартале потенциальный источник вреда обществу. Донести, содействовать, собрать."},
	[18] = {text = "Вниманию отряда гражданской обороны, обнаружено уклонение от надзора. Отреагировать, изолировать, допросить."},
	[19] = {text = "Сотрудничество с отрядом ГО награждается полным пищ.рационом."},
	[20] = {text = "Вниманию гражданам! Производится проверка идентификации. Занять назначенные для инспекции места."},
	[21] = {text = "Внимание! Всем гражданам жилого квартала, занять места для инспекции."},
	[22] = {text = "Директива номер два: задействовать резерв. Сдерживать вторжение извне."},
	[23] = {text = "Внимание, отключены системы наблюдения и обнаружения. Оставшимся сотрудникам охраны доложить о вторжении."},
	[24] = {text = "Внимание наземным силам: провал миссии влечёт выселение в нежилое пространство. Напоминаю код: пожертвовать, остановить, устранить."},
	[25] = {text = "Тревога: обнаружено аномальная внешняя активность. Следовать процедуре сдерживания и докладывать."},
	[26] = {text = "Особое внимание: отключены ограничители периметра. Всем сотрудникам охраны, немедленно принять участие в сдерживании."},
}

local function OpenCityVoice()
    oc = vgui.Create("DPanel", f)
    oc:Dock(FILL)  
    oc.Paint = function(self, w, h) draw.DrawText("УПРАВЛЕНИЕ ОПОВЕЩЕНИЕМ СЕКТОРА", "ui.30", w/2, ui.h(60), Color(255,255,255), TEXT_ALIGN_CENTER) end

    bl = vgui.Create("ui-sp", oc)
    bl:SetSize(ui.w(1600), ui.h(735))
    bl:SetPos(ui.w(159), ui.h(182))
    bl.Paint = nil

    for i, k in pairs(list) do 
        local button = vgui.Create("ui-button", bl)
        button:SetParent(bl)
        button:SetText(k.text)
        button:SetFont("ui.25")
        --button.Height = 8
        button:Dock(TOP)
        button:DockMargin(0, 0, 0, 0)
        button:SetSize(ui.w(1920), ui.h(50))
        button.DoClick = function()
            net.Start("terminal_sound")
                net.WriteString(k.text)
            net.SendToServer()
        end
    end

    local back = vgui.Create("ui-button", oc)
    back:SetText("")
    back:SetPos(ui.w(20), ui.h(900))
    back:SetSize(ui.w(1920), ui.h(50))
    back.DoClick = function() oc:Remove() om:SetVisible(true) end
    back.Paint = function(self, w, h) draw.DrawText("< НАЗАД", "ui.30", 0, 0, color_white,TEXT_ALIGN_LEFT) end
end

local function OpenSostav()
    oc = vgui.Create("DPanel", f)
    oc:Dock(FILL)
    oc.Paint = function(self, w, h) draw.DrawText("УПРАВЛЕНИЕ СОСТАВОМ", "ui.30", w/2, ui.h(60), Color(255,255,255), TEXT_ALIGN_CENTER) end

    bl = vgui.Create("ui-sp", oc)
    bl:SetSize(ui.w(1600), ui.h(735))
    bl:SetPos(ui.w(159), ui.h(182))
    -- bl.Paint = nil

    for k, v in pairs(player.GetAll()) do
        if !v:isCP() then continue end

        playerpnl = vgui.Create("DPanel", bl)
        playerpnl:Dock(TOP)
        playerpnl:SetHeight(ui.h(60))
        playerpnl:DockMargin(0, ui.h(10), 0, 0)
        playerpnl.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(103, 58, 183))
            draw.DrawText(v:Name(), "ui.25", ui.w(60), ui.h(6), color_white, TEXT_ALIGN_LEFT)
            draw.DrawText(v:getDarkRPVar("job"), "ui.20", ui.w(60), ui.h(30), color_white, TEXT_ALIGN_LEFT)
            --draw.DrawText(v:getDarkRPVar("fakerpname"), "font_32r", ui.w(60), ui.h(30), color_white, TEXT_ALIGN_LEFT)
        end

        circleavatar2 = vgui.Create("AvatarImage", playerpnl)
        circleavatar2:SetSize(ui.w(48), ui.h(48))
        circleavatar2:SetPlayer(v, 48)
        circleavatar2:SetPos(ui.w(6), ui.h(6))

        playerpnl_uvalbutton = vgui.Create("ui-button", playerpnl)
        playerpnl_uvalbutton:SetText("Уволить")
        playerpnl_uvalbutton:Dock(RIGHT)
        playerpnl_uvalbutton:SetFont("ui.20")
        playerpnl_uvalbutton:SetWide(ui.w(160))
        --playerpnl_uvalbutton.Height = 6
        playerpnl_uvalbutton:DockMargin(ui.w(10), ui.h(10), ui.w(10), ui.h(10))
        playerpnl_uvalbutton.DoClick = function() -- v:getDarkRPVar("fakerpname")
            --Derma_StringRequest( "Увольнение", "Уволить ".. v:Name() .. " по причине:", "", function(text) net.Start("terminal_demote") net.WriteEntity(v) net.WriteString(text) net.SendToServer() end, function(text) end, "Уволить", "Отменить")
            Derma_StringRequest( "Увольнение", "Уволить ".. v:Name() .. " по причине:", "", function(text) net.Start("terminal_demote") net.WriteEntity(v) net.WriteString(text) net.SendToServer() end, function(text) end, "Уволить", "Отменить")
        end

        playerpnl_paybutton = vgui.Create("ui-button", playerpnl)
        playerpnl_paybutton:SetText("Выдать премию")
        playerpnl_paybutton:Dock(RIGHT)
        playerpnl_paybutton:SetFont("ui.20")
        playerpnl_paybutton:SetWide(ui.w(160))
        --playerpnl_paybutton.Height = 6
        playerpnl_paybutton:DockMargin(ui.w(10), ui.h(10), ui.w(10), ui.h(10))
        playerpnl_paybutton.DoClick = function()
            Derma_StringRequest( "Премия", "Выдать премию ".. v:Name() .. " в размере:", "", function(text) net.Start("terminal_pay") net.WriteEntity(v) net.WriteInt(text, 16) net.SendToServer() end, function(text) end, "Выдать", "Отменить")
        end
    end


    local back = vgui.Create("ui-button", oc)
    back:SetText("")
    back:SetPos(ui.w(20), ui.h(900))
    back:SetSize(ui.w(300), ui.h(50))
    back.DoClick = function() oc:Remove() om:SetVisible(true) end
    back.Paint = function(self, w, h) draw.DrawText("< НАЗАД", "ui.30", 0, 0, Color(255, 255, 255), TEXT_ALIGN_LEFT) end
end

local buttontbl = {
    {
        "Управление статусом сектора", function()
            om:SetVisible(false)
            OpenCodes()
        end
    },
    {
        "Система оповещения", function()
            om:SetVisible(false)
            OpenCityVoice()
        end
    },
    {
        "Управление составом", function() om:SetVisible(false) OpenSostav() end
    }
}

local function OpenMain()
    om = vgui.Create("DPanel", f)
    om:Dock(FILL)
    om:SetVisible(true)
    om.Paint = function(self, w, h) draw.DrawText("ГЛАВНОЕ МЕНЮ", "ui.50", w/2, ui.h(60), Color(255,255,255), TEXT_ALIGN_CENTER) end

    bl = vgui.Create("ui-sp", om)
    bl:SetSize(ui.w(1920), ui.h(900))
    bl:SetPos(0, ui.h(561))
    bl.Paint = nil

    for i, btn in ipairs(buttontbl) do
        local button = vgui.Create("ui-button", bl)
        button:SetParent(bl)
        button:SetText("")
        button:Dock(TOP)
        button:DockMargin(0, 0, 0, 0)
        button:SetSize(ui.w(1920), ui.h(50))
        button.DoClick = btn[2]

        button.Paint = function(self, w, h)

            if button:IsHovered() then
               -- draw.Drawmaterial("vgui/gradient-l", 0, 0, w, h, Color(255,255,255))
            end
            draw.SimpleText(btn[1], "ui.30", ui.w(10), ui.h(7), self:IsHovered() and Color(103, 58, 183) or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
    end
end

local function minitext()
    --
    timer.Simple(0.6, function()
        w.Paint = function(self, w,h)
          --123123  draw.RoundedBox(0, ui.w(641), ui.h(50), ui.w(640), ui.h(600), ColorAlpha(Color(0, 0, 0, 50)))
            surface.SetDrawColor(Color(255,255,255))
            surface.DrawOutlinedRect(ui.w(641), ui.h(50), ui.w(640), ui.h(600))
          --12312  surface.DrawMulticolorText(ui.w(653), ui.h(60), "font_32r", { "[", Color(255,255,255), "COMBINE TERMINAL", color_white, "]", color_white, " Загрузка интерфейса CTos"}, ui.w(600))
          draw.SimpleText( "[COMBINE TERMINAL] Загрузка интерфейса RetrimeOs", "ui.25", ui.w(653), ui.h(60), Color(0, 47, 194) )
        end
        timer.Simple(1, function()
            w.Paint = function(self, w,h)
               -- draw.RoundedBox(0, ui.w(641), ui.h(50), ui.w(640), ui.h(600), ColorAlpha(Color(0, 0, 0, 50)))
                surface.SetDrawColor(Color(255,255,255))
                surface.DrawOutlinedRect(ui.w(641), ui.h(50), ui.w(640), ui.h(600))
                draw.SimpleText( "[COMBINE TERMINAL] Загрузка интерфейса RetrimeOs", "ui.25", ui.w(653), ui.h(60), Color(0, 47, 194) )
                draw.SimpleText( "[COMBINE TERMINAL] Введите код доступа", "ui.25", ui.w(653), ui.h(90), Color(0, 47, 194) )
                --surface.DrawMulticolorText(ui.w(653), ui.h(60), "font_32r", { "[", Color(103, 58, 183), "COMBINE TERMINAL", color_white, "]", color_white, " Загрузка интерфейса CTos"}, ui.w(600))
                --surface.DrawMulticolorText(ui.w(653), ui.h(90), "font_32r", { "[", Color(103, 58, 183), "COMBINE TERMINAL", color_white, "]", color_white, " Введите код доступа"}, ui.w(600))
            end
        end)
    end)
end
local function dalle()
    au:SetVisible(false)
    w.Paint = function(self, w,h)
     --   draw.RoundedBox(0, ui.w(641), ui.h(50), ui.w(640), ui.h(600), ColorAlpha(Color(103, 58, 183, 50)))
        surface.SetDrawColor(Color(255,255,255))
        surface.DrawOutlinedRect(ui.w(641), ui.h(50), ui.w(640), ui.h(600))
        draw.SimpleText( "[COMBINE TERMINAL] Загрузка интерфейса RetrimeOs", "ui.25", ui.w(653), ui.h(60), Color(0, 47, 194) )
        draw.SimpleText( "[COMBINE TERMINAL] Введите код доступа", "ui.25", ui.w(653), ui.h(90), Color(0, 47, 194) )
        draw.SimpleText( "[COMBINE TERMINAL] Ввод кода: " ..  math.random(0, 999999999), "ui.25", ui.w(653), ui.h(120), Color(0, 47, 194) )
       -- surface.DrawMulticolorText(ui.w(653), ui.h(60), "font_32r", { "[", Color(255,255,255), "COMBINE TERMINAL", color_white, "]", color_white, " Загрузка интерфейса CTos"}, ui.w(600))
      --  surface.DrawMulticolorText(ui.w(653), ui.h(90), "font_32r", { "[", Color(255,255,255), "COMBINE TERMINAL", color_white, "]", color_white, " Введите код доступа"}, ui.w(600))
      --  surface.DrawMulticolorText(ui.w(653), ui.h(120), "font_32r", { "[", Color(255,255,255), "COMBINE TERMINAL", color_white, "]", color_white, " Ввод кода: " .. math.random(0, 999999999)}, ui.w(600))
    end
    timer.Simple(1.2, function() 
        w.Paint = function(self, w,h)
       --     draw.RoundedBox(0, ui.w(641), ui.h(50), ui.w(640), ui.h(600), ColorAlpha(Color(0, 47, 194, 50)))
            surface.SetDrawColor(Color(255,255,255))
            surface.DrawOutlinedRect(ui.w(641), ui.h(50), ui.w(640), ui.h(600))
           -- surface.DrawMulticolorText(ui.w(653), ui.h(60), "font_32r", { "[", Color(255,255,255), "COMBINE TERMINAL", color_white, "]", color_white, " Загрузка интерфейса CTos"}, ui.w(600))
          --  surface.DrawMulticolorText(ui.w(653), ui.h(90), "font_32r", { "[", Color(255,255,255), "COMBINE TERMINAL", color_white, "]", color_white, " Введите код доступа"}, ui.w(600))
          --  surface.DrawMulticolorText(ui.w(653), ui.h(120), "font_32r", { "[", Color(255,255,255), "COMBINE TERMINAL", color_white, "]", color_white, " Ввод кода: ************" }, ui.w(600))
          draw.SimpleText( "[COMBINE TERMINAL] Загрузка интерфейса RetrimeOs", "ui.25", ui.w(653), ui.h(60), Color(0, 47, 194) )
          draw.SimpleText( "[COMBINE TERMINAL] Введите код доступа", "ui.25", ui.w(653), ui.h(90), Color(0, 47, 194) )
          draw.SimpleText( "[COMBINE TERMINAL] Ввод кода: ************", "ui.25", ui.w(653), ui.h(120), Color(0, 47, 194) )
        end
    end)
    timer.Simple(2.4, function() 
        w.Paint = function(self, w,h)
          --  draw.RoundedBox(0, ui.w(641), ui.h(50), ui.w(640), ui.h(600), ColorAlpha(Color(0, 47, 194, 50)))
            surface.SetDrawColor(Color(255,255,255))
            surface.DrawOutlinedRect(ui.w(641), ui.h(50), ui.w(640), ui.h(600))
           -- surface.DrawMulticolorText(ui.w(653), ui.h(60), "font_32r", { "[", Color(255,255,255), "COMBINE TERMINAL", color_white, "]", color_white, " Загрузка интерфейса CTos"}, ui.w(600))
          --  surface.DrawMulticolorText(ui.w(653), ui.h(90), "font_32r", { "[", Color(255,255,255), "COMBINE TERMINAL", color_white, "]", color_white, " Введите код доступа"}, ui.w(600))
          --  surface.DrawMulticolorText(ui.w(653), ui.h(120), "font_32r", { "[", Color(255,255,255), "COMBINE TERMINAL", color_white, "]", color_white, " Ввод кода: ************" }, ui.w(600))
          --  surface.DrawMulticolorText(ui.w(653), ui.h(150), "font_32r", { "[", Color(255,255,255), "COMBINE TERMINAL", color_white, "]", color_white, " Успешная авторизация" }, ui.w(600))
            draw.SimpleText( "[COMBINE TERMINAL] Загрузка интерфейса RetrimeOs", "ui.25", ui.w(653), ui.h(60), Color(0, 47, 194) )
            draw.SimpleText( "[COMBINE TERMINAL] Введите код доступа", "ui.25", ui.w(653), ui.h(90), Color(0, 47, 194) )
            draw.SimpleText( "[COMBINE TERMINAL] Ввод кода: ************", "ui.25", ui.w(653), ui.h(120), Color(0, 47, 194) )
            draw.SimpleText( "[COMBINE TERMINAL] Успешная авторизация", "ui.25", ui.w(653), ui.h(150), Color(0, 47, 194) )
        end
    end)
    --]]
end
local function Welcome()
    w = vgui.Create("DPanel", f)
    w:Dock(FILL)
    w.Paint = function(self, w,h) 
      --  draw.RoundedBox(0, ui.w(641), ui.h(50), ui.w(640), ui.h(600), ColorAlpha(Color(0, 0, 0, 25)))
        surface.SetDrawColor(Color(255,255,255))
        surface.DrawOutlinedRect(ui.w(641), ui.h(50), ui.w(640), ui.h(600))
        minitext()
    end

    timer.Simple(2, function()
        if LocalPlayer():isCP() then
            au = vgui.Create("ui-button", w)
            au:SetSize(ui.w(220), ui.h(30))
            au:SetPos(ui.w(850), ui.h(130))
            au:SetText("ВВЕСТИ КОД ДОСТУПА")
            au.DoClick = function() dalle() timer.Simple(3.2, function() w:Remove() OpenMain() end) end
            --au.Paint = function(self, w, h) draw.RoundedBox(0,0,0,w,h,Color(255,255,255)) draw.DrawText("ВВЕСТИ КОД ДОСТУПА", "font_32r", w/2, ui.h(2), self:IsHovered() and ColorAlpha(color_black, 255) or ColorAlpha(color_black, 160), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP) end
        else
            au = vgui.Create("ui-button", w)
            au:SetSize(ui.w(220), ui.h(30))
            au:SetPos(ui.w(653), ui.h(130))
            au:SetText("")
            au.Paint = function(self, w, h) draw.RoundedBox(0,0,0,w,h,Color(255,0,0)) draw.DrawText("ДОСТУП ЗАПРЕЩЕН", "ui.20", w/2, ui.h(2), self:IsHovered() and  Color(255,0,0, 160), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP) end
        end
    end)
end
local function OpenMenu()
    gui.EnableScreenClicker(true)
    if IsValid(m) then return end
    m = vgui.Create("DPanel")
    m:SetSize(ui.w(1920), ui.h(1080))
    m:SetPos(0,0)
    m.Paint = function(self, w, h) 
     --   -- draw.Drawmaterial(auroria.material["overlay"], 0, 0, w, h, color_white) 
        draw.RoundedBox(0, 0, 0, w, h, Color(24,24,24,225))
     --   -- draw.Drawmaterial("vgui/gradient_up", 0, 0, w, h, ColorAlpha( Color(255,255,255), 0.9)) 
    end

    u = vgui.Create("DPanel", m)
    u:Dock(TOP)
    u:SetTall(ui.w(64))
    u.Paint = function(self, w, h) draw.RoundedBox(0, 0, h - 1, w, ui.h(1), Color(255,255,255)) draw.DrawText("ПОЛЬЗОВАТЕЛЬ: @" .. LocalPlayer():Name(), "ui.22", ui.w(20), ui.h(22), Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)  end

    c = vgui.Create("ui-button", u)
    c:Dock(RIGHT)
    c:SetWide(ui.w(300))
    c:SetText("")
    c.DoClick = function() m:Remove() gui.EnableScreenClicker(false) end
    c.Paint = function(self, w, h) draw.DrawText("X", "ui.38", w /1.1, ui.h(14), self:IsHovered() and Color(255, 0, 0) or Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP) end

    f = vgui.Create("DPanel", m)
    f:Dock(FILL)
    f.Paint = nil
    Welcome()

end
usermessage.Hook("OpenTerminal", OpenMenu)

net.Receive("redcodestarted",function()
	if timer.Exists("doredcodesound") == false then
		timer.Create("doredcodesound",0,0,function()
            EmitSound("disp/sirena.wav", LocalPlayer():GetPos(), -1, CHAN_AUTO, 0.1)
		end)
	end
end)

net.Receive("sounds", function()
	snd = net.ReadString()
	surface.PlaySound(snd)
end)

net.Receive("redcodestop",function(ply)
	LocalPlayer():ConCommand( "stopsound" )
	timer.Remove("doredcodesound")
end)

function lerp(start, ends, percent)
    return start+(ends-start)*percent
end

local number = 0
local increment = 10
local isIncreasing = true

timer.Create("IncreasingNumber", 0.1, 0, function()
    if isIncreasing and number < 150 then
        number = number + increment
    elseif not isIncreasing and number > 0 then
        number = number - increment
    elseif number == 150 then
        isIncreasing = false
    elseif number == 0 then 
        isIncreasing = true
    end
    
end)
hook.Add("HUDPaint","Auroria::Codes",function(ply)
    -- draw.DrawText("WORKING IN PROGRESS", "DINBold_35", ui.w(960), ui.h(540), ColorAlpha(color_white, 51),TEXT_ALIGN_CENTER)
   
	if ( GetGlobalBool( "redcode") == true ) then
    --draw.DrawText("КРАСНЫЙ КОД", "font_32r", ui.w(960), ui.h(30), ColorAlpha(auroria.color["red"], number ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	--draw.DrawText("КРАСНЫЙ КОД", "font_32r", ui.w(960), ui.h(30), auroria.color["red"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
   draw.RoundedBox( 0, ui.w(10), ui.h(5), ui.w(283), ui.h(40), Color(30, 30, 30, 250), false, true, false, false)
	draw.SimpleText(".:: Статус  :", "ui.27", ui.w(20), ui.h(10),  Color(255, 255, 255,200))
    draw.SimpleText(" Красный код ::. ", "ui.27", ui.w(130), ui.h(10),  Color(255,0,0))
    elseif ( GetGlobalBool("yellowcode") == true) then
        --draw.DrawText("ЖЁЛТЫЙ КОД", "font_32r", ui.w(960), ui.h(30), ColorAlpha(auroria.color["better_yellow"], number ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
		--draw.DrawText("ЖЁЛТЫЙ КОД", "font_32r", ui.w(960), ui.h(30), auroria.color["better_yellow"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	draw.RoundedBox( 0, ui.w(10), ui.h(5), ui.w(263), ui.h(40), Color(30, 30, 30, 250), false, true, false, false)
    draw.SimpleText(".:: Статус :", "ui.27", ui.w(15), ui.h(10),  Color(255, 255, 255,200))
    draw.SimpleText(" Желтый код ::.", "ui.27", ui.w(120), ui.h(10), Color(201, 150, 61))
    elseif ( GetGlobalBool( "workingphase") == true ) then
        --draw.DrawText("РАБОЧАЯ ФАЗА", "font_32r", ui.w(960), ui.h(30), ColorAlpha(auroria.color["blue_gradientl"], number ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
		--draw.DrawText("РАБОЧАЯ ФАЗА", "font_32r", ui.w(960), ui.h(30), auroria.color["blue_gradientl"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	draw.RoundedBox( 0, ui.w(10), ui.h(5), ui.w(247), ui.h(40), Color(30, 30, 30, 250), false, true, false, false)
    draw.SimpleText(".:: Статус :", "ui.27", ui.w(15), ui.h(10),  Color(255, 255, 255,200))
    draw.SimpleText("Синий Код ::.", "ui.27", ui.w(120), ui.h(10), Color(0, 55, 230))
    end
end)


-- hook.Add("RenderScreenspaceEffects","EdgeHUD:DoorsHUD",function(  )

--     --Find entities within sphere.
--     local entities = ents.FindInSphere(LocalPlayer():EyePos(),250)

--     --Loop through all entities.
--     for i = 1,#entities do

--         --Make a var for the current entity.
--         local curEnt = entities[i]

--         --Check so it's a door.
--         if curEnt:isDoor() and curEnt:GetClass() != "prop_dynamic" then
--             curEnt.TraceInfo = "<font=" .. "font_32r" .. "><color=26,255,110>" .. text .. " Tокенов" .. "</color></font>"
--         end


--     end

-- end)

net.Receive("PlayerDisplay", function()
    local args = net.ReadTable()

    if args then
        chat.AddText(unpack(args))
    end
end)