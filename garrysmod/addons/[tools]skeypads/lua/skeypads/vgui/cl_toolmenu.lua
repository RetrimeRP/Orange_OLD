
local function buildFadingDoorOptions(panel)
    local lang = sKeypads.Lang

    panel:NumSlider(lang.menuFadeTime, "skeypads_output_time", sKeypads.Config.min_keypad_open_time, sKeypads.Config.max_keypad_open_time, 2)
    panel:ControlHelp(lang.menuFadeTimeHint)
    panel:Help("")

    if sKeypads.Config.fading_door_allow_custom_materials then
        panel:MatSelect("skeypads_fade_material", sKeypads.Config.fading_door_allowed_materials, true, 0.33, 0.33)
        panel:ControlHelp(lang.menuFadeMaterialHint)
        panel:Help("")
    end
end


local function buildKeybindOptions(panel)
    local lang = sKeypads.Lang
    local binders = vgui.Create("CtrlNumPad", CPanel)
        binders:SetConVar1("skeypads_key_success")
        binders:SetConVar2("skeypads_key_fail")
        binders:SetLabel1(lang.menuSuccessKey)
        binders:SetLabel2(lang.menuFailKey)
    panel:AddPanel(binders)

    panel:Help("")

    panel:NumSlider(lang.menuFadeTime, "skeypads_output_time",sKeypads.Config.min_keypad_open_time, sKeypads.Config.max_keypad_open_time, 2)
    panel:ControlHelp(lang.menuFadeTimeHint)
end

local function buildMapDoorOptions(panel)
    local lang = sKeypads.Lang

    panel:Help(lang.menuMapDoorHint)

    panel:NumSlider(lang.menuFadeTime, "skeypads_output_time", sKeypads.Config.min_keypad_open_time, sKeypads.Config.max_keypad_open_time, 2)
    panel:ControlHelp(lang.menuFadeTimeHint)

    panel:CheckBox(lang.menuAutoLock, "skeypads_auto_lock")
    panel:ControlHelp(lang.menuAutoLockHint)
    panel:Help("")
end

local function buildWiremodOptions(panel)
    local lang = sKeypads.Lang

    panel:NumSlider(lang.menuWireOutputOn, "skeypads_wire_on", -10, 10, 2)
    panel:ControlHelp(lang.menuFadeTimeHint)
    panel:Help("")

    panel:NumSlider(lang.menuWireOutputOff, "skeypads_wire_off", -10, 10, 2)
    panel:ControlHelp(lang.menuFadeTimeHint)
    panel:Help("")

    panel:NumSlider(lang.menuFadeTime, "skeypads_output_time", sKeypads.Config.min_keypad_open_time, sKeypads.Config.max_keypad_open_time, 2)
    panel:ControlHelp(lang.menuFadeTimeHint)
end

function sKeypads.BuildToolMenu(panel)
    local lang = sKeypads.Lang

    local entry = panel:TextEntry(lang.menuPassword, "skeypads_password")
    entry:SetNumeric(true)

    panel:ControlHelp(lang.menuPasswordHint)
    panel:Help("")

    panel:CheckBox(lang.menuSecureMode, "skeypads_securemode")
    panel:ControlHelp(lang.menuSecureModeHint)
    panel:Help("")

    local entry = panel:TextEntry(lang.menuPriceToEntry, "skeypads_price")
    entry:SetNumeric(true)
    panel:CheckBox(lang.menuSecureMode, "skeypads_paid_entry")
    panel:ControlHelp(lang.menuSecureModeHint)
    panel:Help("")
    local outputPanel = vgui.Create("ControlPanel")

    local outputTypeCVar = GetConVar("skeypads_output_type") --Doesn't update through form dk why

    local typeCombo = panel:ComboBox(lang.menuOutputType, "skeypads_output_type")

    local outputSettings = sKeypads.Config.output_types
    if outputSettings["fadingdoor"] then
        typeCombo:AddChoice(lang.menuTypeFadingDoor, "fadingdoor")
    end

    if outputSettings["keybind"] then
        typeCombo:AddChoice(lang.menuTypeKeybind, "keybind")
    end

    if outputSettings["mapdoor"] and DarkRP then
        typeCombo:AddChoice(lang.menuTypeDoor, "mapdoor")
    end

    if outputSettings["wiremod"] and WireLib then
        typeCombo:AddChoice(lang.menuTypeWiremod, "wiremod")
    end

    function typeCombo:OnSelect(i, text, data)
        outputPanel:Clear()

        if data == "fadingdoor" then
            buildFadingDoorOptions(outputPanel)
        elseif data == "keybind" then
            buildKeybindOptions(outputPanel)
        elseif data == "mapdoor" then
            buildMapDoorOptions(outputPanel)
        elseif data == "wiremod" then
            buildWiremodOptions(outputPanel)
        end

        outputPanel:SetName(text)

        outputTypeCVar:SetString(data)
    end

    typeCombo:ChooseOptionID(1)
    typeCombo:SetTall(30)

    panel:AddItem(outputPanel)
end
