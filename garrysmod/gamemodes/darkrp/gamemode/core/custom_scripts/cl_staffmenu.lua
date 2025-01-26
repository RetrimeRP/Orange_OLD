local function StaffMenuRequest(command, nick, id)

	local title = nick .. " (" .. id .. ")"

	if command == "gag" then
		Derma_StringRequest(title, "Укажите время", "", function(length) Derma_StringRequest(title, "Укажите причину", "", function(reason) RunConsoleCommand("sam", command, id, length, reason) end, nil, "Gag", "Отмена") end, nil, "Дальше", "Отмена")
	end

	if command == "mute" then
		Derma_StringRequest(title, "Укажите время", "", function(length) Derma_StringRequest(title, "Укажите причину", "", function(reason) RunConsoleCommand("sam", command, id, length, reason) end, nil, "Mute", "Отмена") end, nil, "Дальше", "Отмена")
	end

	if command == "jailroom" then
		Derma_StringRequest(title, "Укажите время", "", function(length) Derma_StringRequest(title, "Укажите причину", "", function(reason) RunConsoleCommand("sam", command, id, length, reason) end, nil, "Jail", "Отмена") end, nil, "Дальше", "Отмена")
	end

	if command == "ban" then
		Derma_StringRequest(title, "Укажите время", "", function(length) Derma_StringRequest(title, "Укажите причину", "", function(reason) RunConsoleCommand("sam", command, id, length, reason) end, nil, "Ban", "Отмена") end, nil, "Дальше", "Отмена")
	end

	if command == "kick" then
		Derma_StringRequest(title, "Укажите причину", "", function(reason) RunConsoleCommand("sam", command, id, reason) end, nil, "Kick", "Отмена")
	end

end

local function StaffMenuCreate(menu, nick, id)

	local staff, staff_tab = menu:AddSubMenu("Админ")
	staff_tab:SetIcon("icon16/layers.png")

	staff.action_bring = staff:AddOption("bring", function() RunConsoleCommand("sam", "bring", id) end)
	staff.action_bring:SetIcon("icon16/bullet_green.png")

	staff.action_goto = staff:AddOption("goto", function() RunConsoleCommand("sam", "goto", id) end)
	staff.action_goto:SetIcon("icon16/bullet_green.png")

	staff.action_return = staff:AddOption("return", function() RunConsoleCommand("sam", "return", id) end)
	staff.action_return:SetIcon("icon16/bullet_green.png")

	staff:AddSpacer()

	staff.action_gag = staff:AddOption("voice gag", function() StaffMenuRequest("gag", nick, id) end)
	staff.action_gag:SetIcon("icon16/bullet_blue.png")

	staff.action_ungag = staff:AddOption("voice ungag", function() RunConsoleCommand("sam", "ungag", id) end)
	staff.action_ungag:SetIcon("icon16/bullet_blue.png")

	staff.action_mute = staff:AddOption("chat mute", function() StaffMenuRequest("mute", nick, id) end)
	staff.action_mute:SetIcon("icon16/bullet_blue.png")

	staff.action_unmute = staff:AddOption("chat unmute", function() RunConsoleCommand("sam", "unmute", id) end)
	staff.action_unmute:SetIcon("icon16/bullet_blue.png")

	staff:AddSpacer()

	staff.action_spectate = staff:AddOption("spectate", function() RunConsoleCommand("fspectate", id) end)
	staff.action_spectate:SetIcon("icon16/bullet_orange.png")

	staff.action_jail = staff:AddOption("jail", function() StaffMenuRequest("jailroom", nick, id) end)
	staff.action_jail:SetIcon("icon16/bullet_orange.png")

	staff.action_unjail = staff:AddOption("unjail", function() RunConsoleCommand("sam", "unjailroom", id) end)
	staff.action_unjail:SetIcon("icon16/bullet_orange.png")

	staff.action_respawn = staff:AddOption("respawn", function() RunConsoleCommand("sam", "respawn", id) end)
	staff.action_respawn:SetIcon("icon16/bullet_orange.png")

	staff:AddSpacer()

	staff.action_ban = staff:AddOption("ban", function() StaffMenuRequest("ban", nick, id) end)
	staff.action_ban:SetIcon("icon16/bullet_red.png")

	staff.action_kick = staff:AddOption("kick", function() StaffMenuRequest("kick", nick, id) end)
	staff.action_kick:SetIcon("icon16/bullet_red.png")

end

function StaffContextMenu(menu, target)

	if not IsValid(target) then return end

	local nick = target:Nick()
	local steamid = target:SteamID()
	local group = target:GetUserGroup()
	local steamname = target:SteamName()
	local playtime = sam.reverse_parse_length(tonumber(target:sam_get_play_time()) / 60)

	if target:IsBot() then
		steamid = nick
	end

	if LocalPlayer():Staff() then
		StaffMenuCreate(menu, nick, steamid)
	end

	local other, other_tab = menu:AddSubMenu(nick, function() SetClipboardText(nick) end)
	other_tab:SetIcon("icon16/pictures.png")

	other.showprofile = other:AddOption("Открыть профиль", function() target:ShowProfile() end)
	other.showprofile:SetIcon("icon16/world.png")

	if target:IsMuted() then
		other.unmute = other:AddOption("Включить микрофон", function() target:SetMuted(false) end)
		other.unmute:SetIcon("icon16/transmit_add.png")
	else
		other.mute = other:AddOption("Отключить микрофон", function() target:SetMuted(true) end)
		other.mute:SetIcon("icon16/transmit_delete.png")
	end

	other:AddSpacer()

	other.steamname = other:AddOption(steamname, function() SetClipboardText(steamname) end)
	other.steamname:SetIcon("icon16/user.png")

	other.steamid = other:AddOption(steamid, function() SetClipboardText(steamid) end)
	other.steamid:SetIcon("icon16/link_break.png")

	other.usergroup = other:AddOption(group, function() SetClipboardText(group) end)
	other.usergroup:SetIcon("icon16/group.png")

	other.playtime = other:AddOption(playtime, function() SetClipboardText(playtime) end)
	other.playtime:SetIcon("icon16/time.png")

end

properties.Add("retrime", {

	MenuLabel = "Retrime",
	MenuIcon = "icon16/bomb.png",

	Filter = function(self, ent)
		return IsValid(ent) and ent:IsPlayer()
	end,

	Action = function()
		return
	end,

	MenuOpen = function(self, option, ent)
		local menu = option:AddSubMenu()
		StaffContextMenu(menu, ent)
	end

})