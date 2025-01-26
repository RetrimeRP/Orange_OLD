credits = {
    { name = "ERMAK", role = "Владелец", sid =  "76561198368389609", margin = 75 },

    { name = "cvrsjz", role = "Разработчик", sid = "76561198364954060" },
    { name = "ItzTomber", role = "Разработчик-Костылер", sid = "76561198341626975", margin = 75 },
    { name = "Dzhamal Dagovskiy", role = "Разработчик", sid = "76561198857137659", margin = 75 },

    { name = "mifkach", role = "Крутой парень", sid = "76561198394773094" },
    { name = "Tobias de Hitok", role = "Не крутой парень", sid = "76561198802707813" },
    { name = "Vitalya Bragin", role = "Крутой парень", sid = "76561198295236157 " },
    { name = "Tom Watchinskiy", role = "Крутой парень", sid = "76561198255053736 " },
    { name = "Richard Kashin", role = "Крутой парень", sid = "76561198834184746 " },
    { name = "Alex Eliot", role = "Крутой парень", sid = "76561199077872023" },
    { name = "Borya Dubov", role = "Не крутой парень", sid = "76561198155786495" },
    { name = "Vanes Vanesov", role = "Крутой парень", sid = "76561198130870964", margin = 75},
}

local creditsSpeed = 3 -- Самая оптимальная это 3, имхо

function EM_StartTerminal()

    local function playsuka()
        if not IsValid(background) then return end
        sound.PlayFile( "sound/retrime/terminal/computerloop.wav", "noplay noblock", function( station, errCode, errStr )
            if ( IsValid( station ) ) then
                -- station:EnableLooping(true)
                station:Play()
                timer.Simple(station:GetLength(), function()
                    playsuka()
                end)
            end
        end )
    end

    playsuka()
    background = vgui.Create('EditablePanel')
    background:SetPos(0,0)
    background:SetSize(ScrW(), ScrH())
    background:MakePopup()
    background.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, color_black)
    end

    scrollmessages = vgui.Create('DScrollPanel', background)
    scrollmessages:Dock(FILL)
    scrollmessages.Paint = nil

    function AddMessage(pl, text)
        local message = vgui.Create('DPanel', scrollmessages)
        message:Dock(TOP)
        message:SetTall(18)
        message.Paint = function(s, w, h)
            if pl == nil then
                draw.SimpleText(text, 'EM:ChatText', 0, h * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(pl .. "@city17.uu: " .. text, 'EM:ChatText', 0, h * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end
        end
    end


    AddMessage(nil, "░█████╗░███╗░░░███╗██████╗░")
    AddMessage(nil, "██╔══██╗████╗░████║██╔══██╗")
    AddMessage(nil, "██║░░╚═╝██╔████╔██║██████╦╝")
    AddMessage(nil, "██║░░██╗██║╚██╔╝██║██╔══██╗")
    AddMessage(nil, "╚█████╔╝██║░╚═╝░██║██████╦╝")
    AddMessage(nil, "░╚════╝░╚═╝░░░░░╚═╝╚═════╝░")
    AddMessage(nil, "")
    AddMessage(nil, "AUTOMATED INFORMATION SYSTEM")
    AddMessage(nil, "")
    AddMessage(nil, "Материал #-2 из расследования #82-A-29/08/2024")
    AddMessage(nil, "")
    AddMessage(nil, 'Напишите "disconnect", чтобы выключить систему.')
    AddMessage(nil, "")
    AddMessage(nil, "----------------------------------------------")

    local sendmessage = vgui.Create('DTextEntry', background)
    sendmessage:Dock(BOTTOM)
    sendmessage:SetTall(48)
    sendmessage:SetPlaceholderText( "> Type your text" )
    sendmessage:SetFont('EM:ChatText')
    sendmessage.OnEnter = function( self )
        surface.PlaySound("ambient/machines/keyboard7_clicks_enter.wav")
        if self:GetValue() == "disconnect" then
            RunConsoleCommand("disconnect")
        end
        net.Start('SendMessageTerminal')
            net.WriteString(self:GetValue())
        net.SendToServer()
        self:SetText("")
    end
    local butsound = {
        "ambient/machines/keyboard1_clicks.wav",
        "ambient/machines/keyboard2_clicks.wav",
        "ambient/machines/keyboard3_clicks.wav",
        "ambient/machines/keyboard4_clicks.wav",
        "ambient/machines/keyboard5_clicks.wav",
        "ambient/machines/keyboard6_clicks.wav",
    }
    sendmessage.OnKeyCode = function()
        surface.PlaySound(table.Random(butsound))
    end

end
print(string.rep(" ", 1000-7))
function EM_StartEnd()
    if IsValid(CreditsFrame) then CreditsFrame:Remove() end
    surface.PlaySound('retrime/death_theme_01.mp3')

    CreditsFrame = vgui.Create("EditablePanel")
    CreditsFrame:SetSize(ScrW(), ScrH())
    CreditsFrame:MakePopup()

    CreditsFrame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(21, 21, 21))
    end

    local addMargin = 0

    for k, v in ipairs(credits) do
        if v.margin then addMargin = addMargin + v.margin end
    end

    local Panels = vgui.Create("Panel", CreditsFrame)
    Panels:SetSize(ScrW(), #credits * 90 + addMargin)
    Panels:SetPos(0, ScrH())

    local yPos = 0

    for _, credit in ipairs(credits) do
        local panel = vgui.Create("DPanel", Panels)
        panel:SetSize(450, 80)
        panel:SetPos(0, yPos)
        panel:CenterHorizontal()
        panel.Paint = function(self, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(28, 28, 28))
            surface.SetDrawColor(126, 126, 126, 28)
            surface.DrawOutlinedRect(0, 0, w, h)

            local x, y = draw.SimpleText(credit.name, 'EM:Credits_Large', 10+60+20, 5, Color(132, 132, 132), 0, 0)
            draw.SimpleText(credit.role, 'EM:Credits_Small', 10+60+20,  y + 5, Color(132, 132, 132), 0, 0)

        end

        local avatar = vgui.Create("AvatarImage", panel)
        avatar:SetSize(60, 60)
        avatar:SetPos(10, 10)
        avatar:SetSteamID(credit.sid, 84)
        avatar:SetCursor("hand")
        avatar.OnMousePressed = function(self)
            gui.OpenURL("http://steamcommunity.com/profiles/" .. credit.sid)
        end

        yPos = yPos + 90 + (credit.margin or 0)
    end

    Panels:MoveTo(0, -yPos, creditsSpeed * #credits, 1, 1, function()
        timer.Simple(1, function() CreditsFrame:Remove() EM_StartTerminal() end)
    end)
end
