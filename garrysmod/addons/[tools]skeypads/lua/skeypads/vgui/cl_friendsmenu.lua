local friendsPanel = nil

local function generateFriendsMenu()
    -- Если панель уже существует, удаляем ее
    if IsValid(friendsPanel) then
        friendsPanel:Remove()
    end

    -- Создаем новую панель
    friendsPanel = vgui.Create("DFrame")
    friendsPanel:SetTitle(sKeypads.Lang.friendsMenuName)
    friendsPanel:SetSize(600, 550) -- Увеличен размер окна
    friendsPanel:Center()
    friendsPanel:SetVisible(true)
   friendsPanel:SetDraggable(true)
    friendsPanel:MakePopup()

    local panel = vgui.Create("DPanel", friendsPanel)
    panel:SetPos(10, 30)
    panel:SetSize(friendsPanel:GetWide() - 20, friendsPanel:GetTall() - 40)
    panel.Paint = function() end -- Отключаем отрисовку фона

    local currentFriends = sKeypads.Friends.getAll()
    local lang = sKeypads.Lang

    local helpLabel = vgui.Create("DLabel", panel)
    helpLabel:SetText(lang.friendsMenuTopHint)
    helpLabel:SetPos(0, 7)
    helpLabel:SizeToContents()

    local friendsListTitleLabel = vgui.Create("DLabel", panel)
    friendsListTitleLabel:SetText(lang.friendsListTitle)
    friendsListTitleLabel:SetPos(0, helpLabel:GetTall() + 5)
    friendsListTitleLabel:SizeToContents()

    local friendsList = vgui.Create("DListView", panel)
    friendsList:SetPos(0, friendsListTitleLabel:GetY() + friendsListTitleLabel:GetTall() + 5)
    friendsList:SetSize(panel:GetWide() - 0, 200)
    friendsList:AddColumn(lang.friendsPlayerSteamID)
    friendsList:AddColumn(lang.friendsPlayerName)
    friendsList:SetMultiSelect(false)


    for k, v in ipairs(currentFriends) do
        steamworks.RequestPlayerInfo(v, function(name)
            friendsList:AddLine(v, name or "ERROR")
        end)
    end

    friendsList:SelectFirstItem()

    local removeButton = vgui.Create("DButton", panel)
    removeButton:SetText(lang.friendsRemove)
    removeButton:SetPos(0, friendsList:GetY() + friendsList:GetTall() + 5)
    removeButton:SetSize(150, 25)
    removeButton.DoClick = function()
        local lineID = friendsList:GetSelectedLine()
        local line = friendsList:GetLine(lineID)
        if not line then return end

        local friend = line:GetColumnText(1)

        sKeypads.Friends.remove(friend)

        friendsList:RemoveLine(lineID)
        generateFriendsMenu()
    end

    local addSteamButton = vgui.Create("DButton", panel)
    addSteamButton:SetText(lang.friendsAddSteamID)
    addSteamButton:SetPos(removeButton:GetX() + removeButton:GetWide() + 5, removeButton:GetY())
    addSteamButton:SetSize(150, 25)
    addSteamButton.DoClick = function()
        Derma_StringRequest(
            lang.friendsAddTitle,
            lang.friendsAddInputString,
            "",
            function(steamid64)
                if not sKeypads.Utils.isValidSteamID(steamid64) then return end

                sKeypads.Friends.add(steamid64)

                steamworks.RequestPlayerInfo(steamid64, function(name)
                    friendsList:AddLine(steamid64, name or "ERROR")
                end)
            end,
            nil,
            lang.friendsAddButton,
            lang.friendsAddCancelButton
        )
    end

    local addOnlinePlayersLabel = vgui.Create("DLabel", panel)
    addOnlinePlayersLabel:SetText(lang.friendsAddOnlinePlayer)
    addOnlinePlayersLabel:SetPos(0, removeButton:GetY() + removeButton:GetTall() + 10)
    addOnlinePlayersLabel:SizeToContents()

    local localPly = LocalPlayer()
    local onlinePlys = false
    local yOffset = addOnlinePlayersLabel:GetY() + addOnlinePlayersLabel:GetTall() + 5;

    for _, v in SortedPairs(player.GetHumans(), function(a, b) return a:Nick() > b:Nick() end) do
        if not IsValid(v) then continue end
        if v == localPly then continue end

        local skip = false
        for k, id in pairs(currentFriends) do
            if id == v:SteamID64() then skip = true; break end
        end
        if skip then continue end

        local addPlayerButton = vgui.Create("DButton", panel)
        addPlayerButton:SetText(v:Nick())
        addPlayerButton:SetPos(0, yOffset)
        addPlayerButton:SetSize(150,25)
        addPlayerButton.DoClick = function()
            local steamid64 = v:SteamID64()

            sKeypads.Friends.add(steamid64)

             steamworks.RequestPlayerInfo(steamid64, function(name)
                friendsList:AddLine(steamid64, name or "ERROR")
            end)

             addPlayerButton:Remove()
        end
        yOffset = yOffset + addPlayerButton:GetTall() + 5 -- Увеличен отступ между кнопками
        onlinePlys = true
    end

    if not onlinePlys then
        local noPlayersLabel = vgui.Create("DLabel", panel)
        noPlayersLabel:SetText(lang.friendsNoPlayersAvail)
        noPlayersLabel:SetPos(0, yOffset)
        noPlayersLabel:SizeToContents()
    end


    local refreshButton = vgui.Create("DButton", panel)
    refreshButton:SetText(lang.friendsRefresh)
	refreshButton:SetPos(0, panel:GetTall() - 30)
	refreshButton:SetSize(100, 25)
    refreshButton.DoClick = function()
        generateFriendsMenu()
    end
    panel:InvalidateLayout(true)
end


concommand.Add("friends", generateFriendsMenu)