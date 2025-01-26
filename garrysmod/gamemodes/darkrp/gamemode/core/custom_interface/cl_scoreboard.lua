local pnl

local c230230230 = Color(255, 255, 255)
local c303030 = Color(30, 30, 30)
local c109109109 = Color(109, 109, 109)
local c454545 = Color(45, 45, 45)
local c333333 = Color(33, 33, 33)
local c25510251 = Color(255, 102, 51)
local c255255255 = Color(255, 255, 255)

local scoreboard_user = Material("materials/retrime_orange/scoreboard/user.png")
local scoreboard_role = Material("materials/retrime_orange/scoreboard/role.png")
local scoreboard_ping = Material("materials/retrime_orange/scoreboard/ping.png")

local groupicons = {}
groupicons["user"] = Material("materials/retrime_orange/scoreboard/user.png")
groupicons["silver"] = Material("materials/retrime_orange/scoreboard/role_silver.png")
groupicons["gold"] = Material("materials/retrime_orange/scoreboard/role_gold.png")
groupicons["platinum"] = Material("materials/retrime_orange/scoreboard/role_platinum.png")
groupicons["operator"] = Material("materials/retrime_orange/scoreboard/role_operator.png")
groupicons["moderator"] = Material("materials/retrime_orange/scoreboard/role_admin.png")
groupicons["admin"] = Material("materials/retrime_orange/scoreboard/role_admin.png")
groupicons["curator"] = Material("materials/retrime_orange/scoreboard/role_manager.png")
groupicons["manager"] = Material("materials/retrime_orange/scoreboard/role_manager.png")
groupicons["supervisor"] = Material("materials/retrime_orange/scoreboard/role_superadmin.png")
groupicons["superadmin"] = Material("materials/retrime_orange/scoreboard/role_superadmin.png")

local groupcolors = {}
groupcolors["user"] = c255255255
groupcolors["silver"] = c255255255
groupcolors["gold"] = c255255255
groupcolors["platinum"] = c255255255
groupcolors["operator"] = c25510251
groupcolors["moderator"] = c25510251
groupcolors["admin"] = c25510251
groupcolors["curator"] = c25510251
groupcolors["manager"] = c25510251
groupcolors["supervisor"] = c25510251
groupcolors["superadmin"] = c25510251

local function GetPlayers()

	local players = player.GetAll()

	table.sort(players, function(ply1, ply2)
		local job1 = ply1:GetDisguiseVar("id") or ply1:Team()
		local job2 = ply2:GetDisguiseVar("id") or ply2:Team()

		return job1 < job2
	end)

	return players

end

local function CloseMenu()

	if IsValid(pnl) then
		pnl:Close()
		pnl = nil
	end

end

local function OpenMenu()

	if IsValid(pnl) then pnl:Remove() end

	local scrw = math.max(864, ScrW() * 0.45)
	local scrh = math.max(720, ScrH() * 0.7)
	local players = GetPlayers()

	pnl = vgui.Create("DFrame")
	pnl:SetSize(scrw, scrh)
	pnl:Center()
	pnl:SetTitle("")
	pnl:ShowCloseButton(false)
	pnl:SetDraggable(false)
	pnl:MakePopup()
	pnl.Paint = function(self, w, h)
		local staff = 0
		for k, v in ipairs(players) do
			if v:Staff() then
				staff = staff + 1
			end
		end
		draw.RoundedBox(0, 0, 0, w, 40, c230230230)
		draw.RoundedBox(0, 0, 40, w, h - 40, c303030)
		draw.SimpleText("Retrime Orange", "font_22r", 17, 20, c303030, 0, 1)
		draw.SimpleText(#player.GetAll() .. "/" .. game.MaxPlayers(), "font_18r", w - 67, 20, c303030, 2, 1)
		draw.SimpleText(staff .. " FSG", "font_18r", w - 17, 20, c303030, 2, 1)
	end

	pnl.pnl = vgui.Create("DPanel", pnl)
	pnl.pnl:SetSize(pnl:GetWide() - 54, 32)
	pnl.pnl:SetPos(27, 58)
	pnl.pnl.Paint = function(self, w, h)
		draw.Icon(17, h * 0.5 - 8, 16, 16, c109109109, scoreboard_user)
		draw.SimpleText("ИМЯ", "font_19r", 59, h * 0.5, c109109109, 0, 1)
		draw.SimpleText("РАБОТА", "font_19r", w * 0.5 - 96, h * 0.5, c109109109, 0, 1)
		draw.Icon(w * 0.5 + 240, h * 0.5 - 8, 16, 16, c109109109, scoreboard_role)
		draw.Icon(w - 34, h * 0.5 - 8, 16, 16, c109109109, scoreboard_ping)
	end

	pnl.scrlpnl = vgui.Create("DScrollPanel", pnl)
	pnl.scrlpnl:SetSize(pnl:GetWide(), pnl:GetTall() - 116)
	pnl.scrlpnl:SetPos(0, 90)
	pnl.scrlpnl.Paint = function() end

	pnl.scrlbar = pnl.scrlpnl:GetVBar()

	pnl.scrlbar.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c454545)
	end

	pnl.scrlbar.btnUp.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c303030)
	end

	pnl.scrlbar.btnGrip.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c109109109)
	end

	pnl.scrlbar.btnDown.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c303030)
	end

	for k, v in pairs(players) do
		local nick = v:Nick()
		local job = v:getDarkRPVar("job")
		local usergroup = v:GetUserGroup()
		local groupicon = groupicons[usergroup] or groupicons["user"]
		local groupcolor = groupcolors[usergroup] or c255255255
		local ping = v:Ping()

		if #nick > 23 then
			nick = nick:Left(23) .. "..."
		end

		pnl.ply_pnl = pnl.scrlpnl:Add("DButton")
		pnl.ply_pnl:SetSize(pnl.scrlpnl:GetWide() - 54, 50)
		pnl.ply_pnl:SetPos(27, (k - 1) * 50)
		pnl.ply_pnl:SetText("")
		pnl.ply_pnl.Paint = function(self, w, h)
			if k % 2 == 0 then
				draw.RoundedBox(0, 0, 0, w, h, c333333)
			end

			if v == LocalPlayer() then
				draw.RoundedBox(0, 0, 16, 2, 18, c25510251)
			end

			draw.SimpleText(nick, "font_22r", 59, h * 0.5, c255255255, 0, 1)
			draw.SimpleText(job, "font_22r", w * 0.5 - 96, h * 0.5, c255255255, 0, 1)
			draw.Icon(w * 0.5 + 240, h * 0.5 - 8, 16, 16, groupcolor, groupicon)
			draw.SimpleText(ping, "font_22r", w - 18, h * 0.5, c255255255, 2, 1)
		end
		pnl.ply_pnl.DoClick = function()
			if not IsValid(v) then return end

			local menu = DermaMenu()
			StaffContextMenu(menu, v)
			menu:Open()
		end

		pnl.ply_avtr = pnl.ply_pnl:Add("AvatarImage")
		pnl.ply_avtr:SetSize(32, 32)
		pnl.ply_avtr:SetPos(9, 9)
		pnl.ply_avtr:SetPlayer(v)
	end

end

hook.Add("ScoreboardShow","ScoreBoardshow",function()
	OpenMenu()
	return false
end)

hook.Add("ScoreboardHide","ScoreBoardhide",function()
	CloseMenu()
end)