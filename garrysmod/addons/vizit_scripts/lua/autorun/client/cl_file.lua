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
local net_WriteEntity = net.WriteEntity
local timer_Simple = timer.Simple
local IsValid = IsValid
local CurTime = CurTime
local math_Clamp = math.Clamp
local Lerp = Lerp
local math_random = math.random
local timer_Create = timer.Create
local timer_Remove = timer.Remove
local net_ReadInt = net.ReadInt
local concommand_Add = concommand.Add
local net_Receive = net.Receive
local vgui_Create = vgui.Create
local ui = ui
local net_Start = net.Start
local net_WriteString = net.WriteString
local net_WriteBool = net.WriteBool
local net_WriteInt = net.WriteInt
local net_SendToServer = net.SendToServer
local CreateFont = CreateFont
local Color = Color
local LocalPlayer = LocalPlayer
local VIZIT_SCRIPTS = VIZIT_SCRIPTS
local math_random = math.random
local timer_Simple = timer.Simple

net_Receive("SettingPoint", function()
    local frame = vgui_Create("DFrame")
    frame:SetSize(ui.h(400), ui.h(400))
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

    local tableNameEntry = vgui_Create("DTextEntry", frame)
    tableNameEntry:SetSize(entryW, entryH)
    tableNameEntry:SetPos((frame:GetWide() - entryW) / 2, ui.h(250))
    tableNameEntry:SetPlaceholderText("Имя таблицы для сохранения")

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
        net_WriteString(tableNameEntry:GetValue())
        net_SendToServer()
        frame:Close()
    end
end)

CreateFont("pointWord@Noto Sans@36")
local roundedBoxes = paint.roundedBoxes.roundedBox
local paintFunction = VIZIT_SCRIPTS.startPaint
local paintColor = VIZIT_SCRIPTS.paintColor
local uiV = {}
local backPanelColor = Color(22, 22, 22)
local function CreateCaptureMenu(time,ent)
    local lp = LocalPlayer()
    local words = lp:GetWords()
    local forwardPanelColor = VIZIT_SCRIPTS.GetGroupColor(lp)
    uiV.frame = vgui_Create("Panel")
    local endW, endH = ui.h(1920 * 0.5), ui.h(80)
    local startX, startY = (ui.w(1920) - ui.w(900)) * 0.5, ui.h(1200)
    local endX, endY = (ui.w(1920) - endW) * 0.5, (ui.w(1080) - endH) * 0.5
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
            net_WriteEntity(ent)
            net_SendToServer()
        end)
    end
    timer_Simple(time, function()
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
    if words then
        randomText:SetText(words[math_random(1, #words)])
    else
        randomText:SetText("Нет доступных слов")
    end
    timer_Create("randomText", time * 0.1, 0, function()
        lp:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_GIVE)

        randomText:SetText(words[math_random(1, #words)])
    end)
    function uiV.frame:OnRemove()
        timer_Remove("randomText")
        uiV.frame = nil
    end
end

local captureStart
local nameofPoint
net_Receive("CaptureStart", function()
    local time = net_ReadInt(8)
    captureStart = true
    CreateCaptureMenu(time)
end)
net_Receive("StopCapture",function()
    if IsValid(uiV.frame) then uiV.frame:AnimationRemoveForce() end
end)

concommand_Add("capturemenu", CreateCaptureMenu)
