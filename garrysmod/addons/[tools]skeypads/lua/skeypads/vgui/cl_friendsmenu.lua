
local friendsPanel

local function generateFriendsMenu(panel)
    friendsPanel = IsValid(friendsPanel) and friendsPanel or panel

    panel:ClearControls()
    friendsPanel:Clear()

    local currentFriends = sKeypads.Friends.getAll()
    local lang = sKeypads.Lang

    friendsPanel:Help(lang.friendsMenuTopHint)
    friendsPanel:Help("")

    friendsPanel:Help(lang.friendsListTitle)

    local friendsList = vgui.Create("DListView")
    friendsList:AddColumn(lang.friendsPlayerSteamID)
    friendsList:AddColumn(lang.friendsPlayerName)
    friendsList:SetTall(200)
    friendsList:SetMultiSelect(false)

    for k, v in ipairs(currentFriends) do
        steamworks.RequestPlayerInfo(v, function(name)
            friendsList:AddLine(v, name or "ERROR")
        end)
    end

    friendsList:SelectFirstItem()
    friendsPanel:AddItem(friendsList)

    local remove = vgui.Create("DButton")
    remove:SetText(lang.friendsRemove)
    remove.DoClick = function()
        local lineID = friendsList:GetSelectedLine()
        local line = friendsList:GetLine(lineID)
        if not line then return end

        local friend = line:GetColumnText(1)

        sKeypads.Friends.remove(friend)

        friendsList:RemoveLine(lineID)
        generateFriendsMenu(friendsPanel)
    end
    friendsPanel:AddItem(remove)

    local addSteam = vgui.Create("DButton")
    addSteam:SetText(lang.friendsAddSteamID)
    addSteam.DoClick = function()
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
    friendsPanel:AddItem(addSteam)

    friendsPanel:Help("")
    friendsPanel:Help(lang.friendsAddOnlinePlayer)

    local localPly = LocalPlayer()
    local onlinePlys = false

    for _, v in SortedPairs(player.GetHumans(), function(a, b) return a:Nick() > b:Nick() end) do
        if not IsValid(v) then continue end
        if v == localPly then continue end

        for k, id in pairs(currentFriends) do
            if id == v:SteamID64() then goto skip end
        end

        local addPlayer = vgui.Create("DButton")
        addPlayer:SetText(v:Nick())
        addPlayer.DoClick = function(s)
            local steamid64 = v:SteamID64()

            sKeypads.Friends.add(steamid64)

            steamworks.RequestPlayerInfo(steamid64, function(name)
                friendsList:AddLine(steamid64, name or "ERROR")
            end)

            s:Remove()
        end
        friendsPanel:AddItem(addPlayer)

        onlinePlys = true

        ::skip::
    end

    if not onlinePlys then
        friendsPanel:ControlHelp(lang.friendsNoPlayersAvail)
    end

    friendsPanel:Help("")

    local refresh = vgui.Create("DButton")
    refresh:SetText(lang.friendsRefresh)
    refresh.DoClick = function(s)
        generateFriendsMenu(friendsPanel)
    end
    friendsPanel:AddItem(refresh)
end

hook.Add("PopulateToolMenu", "sKeypads::PopulateToolMenu", function()
    spawnmenu.AddToolMenuOption("Utilities", sKeypads.Lang.systemName, sKeypads.Lang.friendsMenuName, sKeypads.Lang.friendsMenuName, "", "", generateFriendsMenu)
end)

hook.Add("SpawnMenuOpen", "sKeypads::UpdateFriendsMenu", function()
    if not IsValid(friendsPanel) then return end
    generateFriendsMenu(friendsPanel)
end)
