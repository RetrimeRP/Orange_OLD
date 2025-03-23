include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

-- local paintColor = VIZIT_SCRIPTS.paintColor
-- local startPaint = VIZIT_SCRIPTS.startPaint
-- local roundedBoxes = paint.roundedBoxes.roundedBox
-- local paintRect = paint.rects.drawRect
-- local uio = {}
-- local line = paint.lines.drawLine

-- CreateFont("TextNotepad@Noto Sans@26")
-- CreateFont("TextButton@Noto Sans@26")


-- local function CreateMenu()
--     if uio.panel then
--         uio.panel:Remove()
--         uio.panel = nil
--         return
--     end

--     uio.panel = vgui.Create("EditablePanel")
--     uio.panel:Dock(FILL)
--     uio.panel:SetAlpha(0)
--     uio.panel:AlphaTo(230, 0.6)
--     uio.panel:MakePopup()

--     function uio.panel:Paint(ww, hh)
--         startPaint(function()
--             local blurMat = paint.blur.getBlurMaterial(nil, nil, 0.1, 0.1, false)
--             paintRect(0, 0, ww, hh, VIZIT_SCRIPTS.COLOR_VGUI[1], blurMat)
--             roundedBoxes(0, 0, 0, ww, hh, paintColor(VIZIT_SCRIPTS.COLOR_VGUI[6]))
--         end)
--     end

--     local but = vgui.Create("DButton", uio.panel)
--     but:Dock(RIGHT)
--     but:SetText("Закрыть")
--     function but:DoClick()
--         uio.panel:Remove()
--     end

--     local panel = vgui.Create("EditablePanel", uio.panel)
--     -- panel:SetSize(ui.w(600), ui.h(300))
--     panel:Dock(FILL)

--     local notepadPanel = vgui.Create("EditablePanel", panel)
--     notepadPanel:SetSize(ScreenScaleH(280), ScreenScaleH(320))
--     notepadPanel:SetPos((ScrW() - notepadPanel:GetWide()) * 0.45, (ScrH() - notepadPanel:GetTall()) / 2)
--     function notepadPanel:Paint(ww, hh)
--         startPaint(function()
--             paintRect(0, 0, ww, hh, paintColor(VIZIT_SCRIPTS.COLOR_VGUI[1]))
--         end)
--     end

--     local textEntry = vgui.Create("DTextEntry", notepadPanel)
--     textEntry:RequestFocus()
--     textEntry:Dock(FILL)
--     textEntry:DockMargin(ui.w(5), ui.h(28), ui.w(5), 0)
--     textEntry:SetMultiline(true)
--     textEntry:SetFont("TextNotepad")
--     textEntry:SetText(" ")
--     textEntry:SetTextColor(Color(7,7,7))
--     textEntry:SetPaintBackground(false)
--     textEntry:SetPaintBorderEnabled(false)
--     textEntry:SetDrawLanguageID(false)
--     textEntry:SetContentAlignment(7)

--     function textEntry:OnTextChanged()
--         local text = self:GetText()
--         local lines = select(2, text:gsub("\n", "")) + 1
--         if #text > 855 or lines > 24 then
--             local newText = text
--             if #text > 855 then
--                 newText = utf8.sub(newText, 1, 855)
--             end
--             local lineCount = 0
--             newText = newText:gsub("(.-)\n", function(line)
--                 lineCount = lineCount + 1
--                 if lineCount < 24 then
--                     return line .. "\n"
--                 else
--                     return ""
--                 end
--             end)
--             self:SetText(newText)
--             self:SetCaretPos(string.len(newText))
--         end
--     end
    
--     local colorButton = vgui.Create("DButton", uio.panel)
--     colorButton:SetText("Выбрать цвет")
--     colorButton:SetFont("TextButton")
--     colorButton:SetPos(ui.w(607), ui.h(1080 - 100 - 15))
--     colorButton:SetSize(ui.w(300), ui.h(100))

--     function colorButton:Paint(ww, hh)
--         startPaint(function()
--             paintRect(0, 0, ww, hh, paintColor(VIZIT_SCRIPTS.COLOR_VGUI[4]))
--         end)
--     end

--     function colorButton:DoClick()
--         if uio.colorPickerPanel then
--             uio.colorPickerPanel:AlphaTo(0, 0.4, 0, function()
--                 uio.colorPickerPanel:Remove()
--             end)
--         else
--             uio.colorPickerPanel = vgui.Create("EditablePanel", uio.panel)
--             uio.colorPickerPanel:SetPos(ui.w(1260), ui.h(750))
--             uio.colorPickerPanel:SetSize(ui.w(300), ui.h(100))
--             uio.colorPickerPanel:SetAlpha(0)
--             uio.colorPickerPanel:AlphaTo(255, 0.4)
--             function uio.colorPickerPanel:Paint(ww, hh)
--                 startPaint(function()
--                     paintRect(0, 0, ww, hh, paintColor(VIZIT_SCRIPTS.COLOR_VGUI[4]))
--                 end)
--             end
            
--             local colorPicker = vgui.Create("DColorMixer", uio.colorPickerPanel)
--             colorPicker:Dock(FILL)
--             colorPicker:DockMargin(ui.w(5), ui.h(5), ui.w(5), ui.h(5))
--             colorPicker:SetPalette(true)
--             colorPicker:SetAlphaBar(true)
            
--             function uio.colorPickerPanel:OnRemove()
--                 uio.colorPickerPanel = nil
--             end
            
--             function colorPicker:ValueChanged(color)
--                 textEntry:SetTextColor(color)
--             end
--         end
--     end
-- end

-- net.Receive("OpenCheque", CreateMenu)
