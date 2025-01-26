CITYWORKER = CITYWORKER or {}

/*
    Action Display
    HUD that displays the progress of the player's current action.
*/

local MAT_WRENCH = Material( "icon16/exclamination.png" )

local ActionHUD = {}

net.Receive("CITYWORKER.StartAction", function()
	local desc = net.ReadString()
	local time = net.ReadUInt(8)

    if ActionHUD.active then
        ActionHUD.Stop()
    end

	local startTime = CurTime()
	local targetTime = CurTime() + time
	local deltaTime = targetTime - startTime

	ActionHUD.startTime = startTime
	ActionHUD.targetTime = targetTime
	ActionHUD.deltaTime = deltaTime
    ActionHUD.desc = desc
	ActionHUD.active = true

    ActionHUD:Start()
end)

net.Receive("CITYWORKER.StopAction", function()
    ActionHUD:Stop()
end)

function ActionHUD:Start()
    hook.Add("HUDPaint", "CITYWORKER.Action.HUDPaint", self.Paint)
end

function ActionHUD:Stop()
    hook.Remove("HUDPaint", "CITYWORKER.Action.HUDPaint")
    self.active = false
    self.progress = 0
	if timer.Exists("CITYWORKER.Action.Timer") then
		timer.Remove("CITYWORKER.Action.Timer")
    end
end

function ActionHUD:Paint()
    if not ActionHUD.active then return end
    local progress = math.Clamp( (CurTime() - ActionHUD.startTime) / ActionHUD.deltaTime , 0, 1)
	local x, y, w, h = ScrW() / 2 - ScrW() / 6, ScrH() / 4, ScrW() / 3, 70 * ( ScrH() / 1080 )
    local cornerRadius = 10 * ( ScrH() / 1080 )
    local borderSize = 3 * ( ScrH() / 1080 )

    -- // Фон с тенью
    surface.SetDrawColor( 0, 0, 0, 200 )
	surface.SetMaterial( Material( "vgui/gradient-d" ) )
    render.SetScissorRect( x - borderSize, y - borderSize, x + w + borderSize, y + h + borderSize, true )
	surface.DrawRect( x - borderSize, y - borderSize, w + (borderSize * 2), h + (borderSize * 2))
	render.SetScissorRect(0,0,0,0, false)

	-- // Фон прогресс-бара со скругленными углами
	surface.SetDrawColor( 0, 0, 0, 150 )
	draw.RoundedBox( cornerRadius, x, y, w, h, Color(0, 0, 0, 180) )

    -- // Заполнение прогресс-бара с градиентом
	surface.SetDrawColor( 254, 190, 0 )
	surface.SetMaterial( Material( "vgui/gradient-l" ) )
    draw.RoundedBox( cornerRadius, x + 5, y + 5, ( w - 10 ) * progress, h - 10, Color( 254, 190, 0 ) )

    -- // Описание и иконка
	local textWidth = w - 70 * ( ScrH() / 1080 )
	draw.SimpleText( ActionHUD.desc, "ui.30", x + 55 * ( ScrH() / 1080 ), y + ( h / 2 ) - 10, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    
	local icon = Material("icon16/time.png") -- Иконка времени, можно поменять
	surface.SetMaterial(icon)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(x + 10 * ( ScrH() / 1080 ), y + ( h / 2 ) - 20 * ( ScrH() / 1080 ), 40 * ( ScrH() / 1080 ), 40 * ( ScrH() / 1080 ))

    -- // Текст отмены в rounded box
    local cancelText = "Нажмите F2 чтобы отменить действие"
    local cancelBoxH = 30 * ( ScrH() / 1080 )
	local cancelBoxY = y + h + 10 * ( ScrH() / 1080 )
    draw.RoundedBox( cornerRadius / 2, x, cancelBoxY, w, cancelBoxH, Color(0, 0, 0, 150) )
    draw.SimpleText( cancelText, "ui.25", x + ( w / 2 ), cancelBoxY + ( cancelBoxH / 2 ), Color(200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

timer.Create("CITYWORKER.Action.Update", 0.01, 0, function()
    if ActionHUD.active then
        ActionHUD.progress = math.Clamp( (CurTime() - ActionHUD.startTime) / ActionHUD.deltaTime, 0, 1 )
		if ActionHUD.progress >= 1 then
			ActionHUD:Stop()
		end
    end
end)

/*
    Task Notification
    HUD that displays the position of their next task.
*/

net.Receive( "CITYWORKER.NotifyTask", function()
    local pos = net.ReadVector()

    hook.Add( "HUDPaint", "CITYWORKER.Task.HUDPaint", function()
        local screenPos = pos:ToScreen()

        surface.SetDrawColor( 255, 255, 255 )
        surface.SetMaterial( MAT_WRENCH )
        surface.DrawTexturedRect( screenPos.x - 16, screenPos.y - 16, 32, 32 )

        draw.SimpleTextOutlined( math.ceil( ( LocalPlayer():GetPos():Distance( pos ) / 16 ) / 3.28084 ).."m", "ui.25", screenPos.x, screenPos.y + 16, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0 ) )
    end )
end )

net.Receive( "CITYWORKER.RemoveTask", function()
    hook.Remove( "HUDPaint", "CITYWORKER.Task.HUDPaint" )
end )