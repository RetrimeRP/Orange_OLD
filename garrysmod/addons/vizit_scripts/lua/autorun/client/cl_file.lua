local net_Receive = net.Receive
local vgui_Create = vgui.Create
local ui = ui
local net_Start = net.Start
local net_WriteString = net.WriteString
local net_WriteBool = net.WriteBool
local net_SendToServer = net.SendToServer
local CreateFont = CreateFont
local Color = Color
local LocalPlayer = LocalPlayer
local VIZIT_SCRIPTS = VIZIT_SCRIPTS
local IsValid = IsValid
local CurTime = CurTime
local math_Clamp = math.Clamp
local Lerp = Lerp
local math_random = math.random
local timer_Create = timer.Create
local timer_Remove = timer.Remove
local concommand_Add = concommand.Add
local ui = ui
local CreateFont = CreateFont
local sub = utf8.sub
local Color = Color
local LocalPlayer = LocalPlayer
local VIZIT_SCRIPTS = VIZIT_SCRIPTS
local net_WriteInt = net.WriteInt
local math_approach = math.Approach
CreateClientConVar("ret_points_show_borders","0",true)
net_Receive("SettingPoint", function()
    local frame = vgui_Create("DFrame")
    frame:SetSize(ui.h(400), ui.h(450))
    frame:Center()
    frame:MakePopup()
    frame:SetTitle("Настройки точки")

    local entryPanel = vgui_Create("DTextEntry", frame)
    local entryW, entryH = ui.h(200), ui.h(30)
    entryPanel:SetSize(entryW, entryH)
    entryPanel:SetPos((frame:GetWide() - entryW) / 2, ui.h(50))
    entryPanel:SetPlaceholderText("Уникальное имя точки")

    local checkBox = vgui_Create("DCheckBoxLabel", frame)
    checkBox:SetPos(ui.h(50), ui.h(100))
    checkBox:SetText("Вторичная точка")
    checkBox:SetValue(0)
    checkBox:SizeToContents()

    local mainPointEntry = vgui_Create("DTextEntry", frame)
    mainPointEntry:SetSize(entryW, entryH)
    mainPointEntry:SetPos((frame:GetWide() - entryW) / 2, ui.h(150))
    mainPointEntry:SetPlaceholderText("Имя главной точки")
    mainPointEntry:SetDisabled(true)

    function checkBox:OnChange(val)
        mainPointEntry:SetDisabled(not val)
    end

    local captureTimeEntry = vgui_Create("DTextEntry", frame)
    captureTimeEntry:SetSize(entryW, entryH)
    captureTimeEntry:SetPos((frame:GetWide() - entryW) / 2, ui.h(200))
    captureTimeEntry:SetPlaceholderText("Время захвата (сек)")

    local banditCheckBox = vgui_Create("DCheckBoxLabel", frame)
    banditCheckBox:SetPos(ui.h(50), ui.h(300))
    banditCheckBox:SetText("Точка принадлежит бандитам")
    banditCheckBox:SetValue(0)
    banditCheckBox:SizeToContents()

    local submitButton = vgui_Create("DButton", frame)
    submitButton:Dock(BOTTOM)
    submitButton:SetText("Сохранить настройки")
    submitButton:SetTall(ui.h(50))

    function submitButton:DoClick()
        net_Start("SettingPoint")
        net_WriteString(entryPanel:GetValue())
        net_WriteBool(checkBox:GetChecked())
        net_WriteString(mainPointEntry:GetValue() or "")
        net_WriteInt(tonumber(captureTimeEntry:GetValue()), 8)
        net_WriteBool(banditCheckBox:GetChecked())
        net_SendToServer()
        frame:Close()
    end
end)
CreateFont("pointWord@Noto Sans@36")
CreateFont("WhoWinnig@Noto Sans@22")
CreateFont("WhoWinnigName@Noto Sans@32")
CreateFont("CloseDogovor@Noto Sans@36")
CreateFont("TextDogovor@Noto Sans@28")
-- CreateFont("Kakaskhe@Noto Sans64")
local roundedBoxes = paint.roundedBoxes.roundedBox
local paintFunction = VIZIT_SCRIPTS.startPaint
local paintColor = VIZIT_SCRIPTS.paintColor
local uiV = {}
local backPanelColor = Color(22, 22, 22)
local curT = CurTime
local panelMeta = FindMetaTable("Panel")
function panelMeta:updateRandomText(text, speed, words)
    local index = 0
    local nextUpdate = curT()
    
    local function update()
        if curT() >= nextUpdate then
            index = index + 1
            self:SetText(sub(text, 1, index))
            nextUpdate = curT() + engine.TickInterval() * speed
            if index > #text then
                index = 0
                text = words[math_random(#words)]
            end
        end
    end
    function self:Think()
        update()
    end
end
local endW, endH = ui.h(1920 * 0.5), ui.h(80)
local startX, startY = (ui.w(1920) - ui.w(900)) * 0.5, ui.h(1200)
local endX, endY = (ui.w(1920) - endW) * 0.5, (ui.w(1080) - endH) * 0.5
local function CreateCaptureMenu(time,ent)
    local lp = LocalPlayer()
    local words = lp:GetWords()
    local forwardPanelColor = VIZIT_SCRIPTS.GetGroupColor(lp)
    uiV.frame = vgui_Create("Panel")
    uiV.frame:SetSize(endW, endH)
    uiV.frame:SetPos(startX, startY)
    uiV.frame:SetAlpha(0)
    uiV.frame:AlphaTo(255, 0.8)
    uiV.frame:MoveTo(endX, endY - ui.h(30), 0.4, 0, -1, function()
        uiV.frame:MoveTo(endX, endY, 0.2, 0, -1)
    end)

    function uiV.frame:Paint(ww, hh)
        paintFunction(function()
            roundedBoxes(0, 0, 0, ww, hh, paintColor(backPanelColor))
        end)
    end
    function uiV.frame:AnimationRemoveForce()
        self:AlphaTo(0,0.3,0,function()
            self:Remove()
        end)
    end
    function uiV.frame:AnimationRemove()
        self:AlphaTo(0,0.3,0,function()
            self:Remove()
            net_Start("CaptureStart")
            net.WriteEntity(ent)
            net_SendToServer()
        end)
    end
    timer_Create("RemoveOnTime",time,1,function()
        if IsValid(uiV.frame) then
            uiV.frame:AnimationRemove()
        end
    end)
    local forwardPanel = vgui_Create("Panel",uiV.frame)
    forwardPanel:Dock(FILL)
    forwardPanel:DockMargin(ui.h(5),ui.h(5),ui.h(5),ui.h(5))
    local startTime = CurTime()
    function forwardPanel:Paint(ww, hh)
        local elapsedTime = CurTime() - startTime
        local progress = math_Clamp(elapsedTime / time, 0, 1)
        local currentWidth = Lerp(progress, 10, ww)
        paintFunction(function()
            roundedBoxes(0, 0, 0, currentWidth, hh, paintColor(forwardPanelColor))
        end)
    end

    local randomText = vgui_Create("DLabel",forwardPanel)
    randomText:SetContentAlignment(5)
    randomText:SetFont("pointWord")
    randomText:Dock(FILL)
    randomText:SetTextColor(color_white)
    local text = words[math_random(#words)]
    randomText:SetText("Начинаем захватывать точку...")
    randomText:updateRandomText(text,2,words)
    function uiV.frame:OnRemove()
        timer_Remove("randomText")
        timer_Remove("RemoveOnTime")
        uiV.frame = nil
    end
end
-- local wordTable = {
--     ["Альянс"] = {
--         "Альянс доминирует на поле боя!",
--         "Мы почти захватили точку!",
--         "Скоро территория будет под нашим контролем!",
--         "Наши войска уверенно продвигаются!",
--         "Альянс берет верх в этом сражении!",
--         "Ещё немного, и победа будет за нами!",
--         "Мы тесним врага и берём точку!",
--         "Скоро враг не сможет сопротивляться!",
--         "Альянс прочно удерживает позиции!",
--         "Контроль над территорией у нас в руках!"
--     },
--     ["Сопротивление"] = {
--         "Сопротивление захватывает точку!",
--         "Ещё немного, и мы победим!",
--         "Мы контролируем ситуацию!",
--         "Враг не сможет нас остановить!",
--         "Мы наступаем и берём контроль!",
--         "Свобода за нами, мы не сдадимся!",
--         "Один рывок, и точка наша!",
--         "Мы не оставим врагу ни шанса!",
--         "Победа близка, остаётся чуть-чуть!",
--         "Сопротивление идёт вперёд без страха!"
--     },
--     ["NS - DOD"] = {
--         "NS - DOD захватывают территорию!",
--         "Наши силы продвигаются вперёд!",
--         "Мы забираем эту точку!",
--         "Территория почти под нашим контролем!",
--         "Мы успешно продвигаемся вперёд!",
--         "Скоро точка будет нашей, продолжаем натиск!",
--         "Враг отступает, NS - DOD побеждает!",
--         "Мы доминируем в этом секторе!",
--         "Точка скоро перейдёт под наш контроль!",
--         "NS - DOD показывает свою мощь!"
--     },
--     ["Бандиты"] = {
--         "Бандиты прибирают точку к рукам!",
--         "Скоро эта территория станет нашей!",
--         "Мы контролируем бой!",
--         "Забираем всё, что плохо лежит!",
--         "Скоро тут не останется никого, кроме нас!",
--         "Пока они боятся, мы захватываем точку!",
--         "Мы давим на противника, и он дрожит!",
--         "Никто нас не остановит, эта территория уже наша!",
--         "Мы забираем всё, что хотим!",
--         "Враг в панике, Бандиты побеждают!"
--     },
--     ["Силы Коалиции и Самообороны"] = {
--         "Силы Коалиции продвигаются!",
--         "Мы забираем эту точку!",
--         "Скоро мы закрепим свою победу!",
--         "Дисциплина и порядок приведут нас к победе!",
--         "Мы превосходим противника, продолжаем наступление!",
--         "Точка почти под нашим контролем, вперёд!",
--         "Не останавливаться, у нас есть преимущество!",
--         "Мы удерживаем инициативу, продолжайте натиск!",
--         "Территория скоро будет под нашим контролем!",
--         "Силы Коалиции не оставят врагу ни единого шанса!"
--     }
-- }
local wide = ui.h(430)
local height = ui.h(100)
local LerpColor = VIZIT_SCRIPTS.lerpClr
local fontText = "WhoWinnig"
function CreateCapturePoint(time, ent)
    local lp = LocalPlayer()
    local topPanel = vgui.Create("EditablePanel")
    topPanel:SetSize(wide, height)
    topPanel:SetPos(ui.w(40),-ui.h(30))
    topPanel:MoveTo(ui.w(40),ui.h(30),0.3,0,-1,function()
        topPanel:MoveTo(ui.w(40),ui.h(20),0.2,0,-1)
    end)
    topPanel:SetAlpha(0)
    topPanel:AlphaTo(255,0.6)
    local startColor = backPanelColor
    local endColor = VIZIT_SCRIPTS.COLOR_VGUI[2]
    local currentColor = startColor
    local lerpFraction = 0
    if VIZIT_SCRIPTS.SOUNDFORALLIANCE and LocalPlayer():ReturnFaction() == "Альянс" then
        surface.PlaySound(VIZIT_SCRIPTS.SOUNDFORALLIANCE)
    end
    function topPanel:Paint(ww, hh)
        local ft = FrameTime()
        local win = ent:GetWhoWin()
        if lp:ReturnFaction() ~= win then
            lerpFraction = math_approach(lerpFraction, 1, ft * 4)
        else
            lerpFraction = math_approach(lerpFraction, 0, ft * 4)
        end
        currentColor = LerpColor(lerpFraction, startColor, endColor)
        paintFunction(function()
            roundedBoxes(0, 0, 0, ww, hh, paintColor(currentColor))
        end)
    end
    local panelName = vgui.Create("DLabel",topPanel)
    panelName:Dock(TOP)
    panelName:SetTall(ui.h(30))
    panelName:DockMargin(0, ui.h(5), 0, 0)
    panelName:SetFont("WhoWinnigName")
    panelName:SetContentAlignment(5)
    panelName:SetText(ent:GetPointName())
    local labelPanel = vgui.Create("DLabel", topPanel)
    labelPanel:Dock(TOP)
    labelPanel:SetTall(ui.h(30))
    labelPanel:DockMargin(0, 0, 0, 0)
    labelPanel:SetFont(fontText)
    labelPanel:SetContentAlignment(8)
    labelPanel:SetText("")
    local labelPanelWhoWin = vgui.Create("DLabel", topPanel)
    labelPanelWhoWin:Dock(FILL)
    labelPanelWhoWin:SetTall(ui.h(30))
    labelPanelWhoWin:SetFont(fontText)
    labelPanelWhoWin:DockMargin(0, ui.h(-5), 0, 0)
    labelPanelWhoWin:SetContentAlignment(8)
    -- labelPanelWhoWin:SetWrap(true)
    labelPanelWhoWin:SetText("")
    labelPanelWhoWin.papa = labelPanel
    function labelPanelWhoWin:Think()
        local win = ent:GetWhoWin()
        print(win)
        if lp:ReturnFaction() ~= win and win ~= "Никем" then
            self:SetText(Format("Сейчас побеждает: %s!", win))
            self.papa:SetText("Мы проигрываем!")
        elseif win == "Никем" then
            self:SetText("Ничья")
            self.papa:SetText("Мы проигрываем!")
        else
            self.papa:SetText("Мы побеждаем!")
            self:SetText("Сейчас побеждаем мы!")
        end
    end
    timer.Simple(time,function()
        if IsValid(topPanel) then
            topPanel:AlphaTo(0,0.3,0,function()
                topPanel:Remove()
            end)
        end
    end)

    local progressBar = vgui.Create("Panel", topPanel)
    progressBar:SetTall(ui.h(5))
    progressBar:Dock(BOTTOM)
    local startTime = CurTime()
    function progressBar:Paint(ww, hh)
        local elapsedTime = CurTime() - startTime
        local progress = math_Clamp(elapsedTime / time, 0, 1)
        local currentWidth = Lerp(progress, ww, 0)
        paintFunction(function()
            roundedBoxes(0, 0, 0, currentWidth, hh, paintColor(VIZIT_SCRIPTS.COLOR_VGUI[1]))
        end)
    end
end




concommand.Add("test",function()
     CreateCapturePoint(20,Entity(1857))
end)
concommand.Add("dogovornyak",function()
    net.Start("dogovornyak")
    net.WriteBool(true)
    net.SendToServer()
end)
net_Receive("CaptureStart", function()
    local time = net.ReadInt(32)
    local ent = net.ReadEntity()
    local bool = net.ReadBool()
    if not bool then
        CreateCaptureMenu(time,ent)
    else
        CreateCapturePoint(time,ent)
    end
end)
net_Receive("StopCapture",function()
    if IsValid(uiV.frame) then uiV.frame:AnimationRemoveForce() end
end)
hook.Add("HUDPaint", "DrawLookedAtEntity", function()
    local ply = LocalPlayer()
    if ply:SteamID() ~= "STEAM_1:0:27471714" then return end
    if not IsValid(ply) then return end

    local trace = ply:GetEyeTrace()
    local ent = trace.Entity

    if IsValid(ent) and ent ~= ply then
        local text = "Вы смотрите на: " .. tostring(ent)
        local x, y = ScrW() / 2, ScrH() / 2 + 30

        draw.SimpleText(text, "Trebuchet24", x, y, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end
end)

concommand_Add("capturemenu", CreateCaptureMenu)
local function CreateDogovorMenu(resistance,ns_dod,max,dogovor)
    local panel = vgui.Create("EditablePanel")
    panel:SetSize(ui.h(600),ui.h(300))
    panel:Center()
    panel:SetAlpha(0)
    panel:MakePopup()
    panel:AlphaTo(255,0.4)
    function panel:Paint(ww,hh)
        paintFunction(function()
            roundedBoxes(0, 0, 0, ww, hh, paintColor(VIZIT_SCRIPTS.COLOR_VGUI[4]))
        end)
    end
    local closeButton = vgui.Create("DButton",panel)
    closeButton:SetSize(ui.h(36),ui.h(36))
    closeButton:SetPos(panel:GetWide() - ui.h(42),ui.h(5))
    closeButton:SetText("✕")
    closeButton:SetFont("CloseDogovor")
    function closeButton:Paint(ww,hh)
        paintFunction(function()
            roundedBoxes(0, 0, 0, ww, hh, paintColor(VIZIT_SCRIPTS.COLOR_VGUI[5]))
        end)
    end
    function closeButton:DoClick()
        panel:AlphaTo(0,0.4,0,function()
            panel:Remove()
        end)
    end
    local titleText = vgui.Create("DLabel",panel)
    titleText:SetText("Договор между сопротивлением и NS-DOD")
    titleText:Dock(TOP)
    titleText:SetTall(ui.h(60))
    titleText:DockMargin(0,ui.h(30),0,0)
    titleText:SetContentAlignment(5)
    titleText:SetFont("TextDogovor")
    local textWhoRes = vgui.Create("DLabel",panel) -- Текст голосов сопротивления
    textWhoRes:SetText("Сопротивление за: " .. resistance)
    textWhoRes:SetFont("TextDogovor")
    textWhoRes:Dock(TOP)
    textWhoRes:SetTall(ui.h(50))
    textWhoRes:SetContentAlignment(5)
    local textWhoGuild = vgui.Create("DLabel",panel) -- Текст голосов NS - DOD
    textWhoGuild:SetText("NS - DOD за: " .. ns_dod)
    textWhoGuild:SetFont("TextDogovor")
    textWhoGuild:Dock(TOP)
    textWhoGuild:SetTall(ui.h(50))
    textWhoGuild:SetContentAlignment(5)
    local applyButton = vgui.Create("DButton",panel)
    applyButton:Dock(TOP)
    applyButton:DockMargin(ui.h(90),ui.h(10),ui.h(90),0)
    applyButton:SetTall(ui.h(50))
    applyButton:SetText(VIZIT_SCRIPTS.DOGOVOR and "Разорвать договор" or "Заключить договор")
    applyButton:SetFont("CloseDogovor")
    function applyButton:Paint(ww,hh)
        paintFunction(function()
            roundedBoxes(0, 0, 0, ww, hh, paintColor(VIZIT_SCRIPTS.COLOR_VGUI[5]))
        end)
    end
    function applyButton:DoClick()
        net.Start("dogovornyak")
        net.SendToServer()
        panel:AlphaTo(0,0.4,0,function()
            panel:Remove()
        end)
    end
end

net.Receive("dogovornyak",function()
    local res = net.ReadInt(8)
    local ns_dod = net.ReadInt(8)
    local max = net.ReadInt(8)
    local dogovor  = net.ReadBool()
    CreateDogovorMenu(res,ns_dod,max,dogovor)
end)

net.Receive("getDogovor",function()
    local bool = net.ReadBool()
    VIZIT_SCRIPTS.DOGOVOR = bool
end)