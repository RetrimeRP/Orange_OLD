local menuFrame

net.Receive("play_radio_to_player", function()
	local player_positions = net.ReadTable()
	for k,v in pairs(player_positions) do
		local station = v.entity
		local pos = v.pos

		if IsValid(station) then
			station:SetPos(pos)
			station:Play()
		end
	end
end)


function openMusicMenu()
    if IsValid(menuFrame) then
        menuFrame:Remove()
        menuFrame = nil
    end
    menuFrame = vgui.Create("ui-frame")
    menuFrame:SetSize(400, 200)
    menuFrame:SetTitle("Введите URL-адрес музыки")
    menuFrame:Center()
	
    local urlEntry = vgui.Create("DTextEntry", menuFrame)
    urlEntry:SetPos(10, 40)
    urlEntry:SetSize(380, 30)

    local playButton = vgui.Create("ui-button", menuFrame)
    playButton:SetPos(10, 110)
    playButton:SetSize(100, 30)
    playButton:SetText("Играть")
    playButton.DoClick = function()
		if urlEntry:GetValue() != "" then
			net.Start("music_url")
			net.WriteString(urlEntry:GetValue())
			net.SendToServer()
            menuFrame:Remove()
			menuFrame = nil
		end
    end
	
	menuFrame:Show()
end

concommand.Add("open_music_menu", function()
	openMusicMenu()
end)


net.Start("music_url")

net.Receive("music_url", function()
	local url = net.ReadString()
	local ent = net.ReadEntity()
    if IsValid(ent) then
		ent:StartMusic(url, LocalPlayer())
	end
end)