local pnl

local c25510251 = Color(255, 102, 51)
local c255255255 = Color(255, 255, 255)
local c150150150 = Color(150, 150, 150)
local c909090 = Color(90, 90, 90)
local c230230230 = Color(230, 230, 230)
local c303030 = Color(30, 30, 30)
local c454545 = Color(45, 45, 45)
local c109109109 = Color(109, 109, 109)
local c333333 = Color(33, 33, 33)
local c525252 = Color(52, 52, 52)
local c424242 = Color(42, 42, 42)


local icon_close = Material("materials/retrime_orange/close.png")

--[[------------------------------------------------------------

	GetMenuWeight

------------------------------------------------------------]]--
local function GetMenuWeight()
	local scrw = ScrW()

	if scrw < 886 then
		return 640
	end

	return 886
end

--[[------------------------------------------------------------

	GetMenuHeight

------------------------------------------------------------]]--
local function GetMenuHeight()
	local scrh = ScrH()

	if scrh < 778 then
		return 480
	end

	return 778
end

--[[------------------------------------------------------------

	GetJobs

------------------------------------------------------------]]--
local function GetJobs(data)
	local jobs = {}
	local jobscount = 1

	-- arrival
	jobs[jobscount] = RPExtraTeams[TEAM_ARRIVAL]

	-- jobs
	for k, v in ipairs(RPExtraTeams) do
		local type = data[k]

		if not type then continue end

		-- jobs
		jobscount = jobscount + 1
		jobs[jobscount] = v
		jobs[jobscount].type = type
	end

	return jobs
end

--[[------------------------------------------------------------

	CloseMenu

------------------------------------------------------------]]--
local function CloseMenu()
	if jobsystem:IsValid() then
		jobsystem:Close()
	end
end

--[[------------------------------------------------------------

	DrawButton

------------------------------------------------------------]]--
local function DrawButton(info)
	-- size_w
	local size_w = info.parent:GetWide()

	-- button
	local button = vgui.Create("DButton", info.parent)
	button:SetSize(125, 29)
	button:SetPos(size_w - 153, 22)
	button:SetText("")
	button.Paint = function(self, w, h)
		local hovered = info.net and self:IsHovered()

		if hovered then
			draw.RoundedBox(4, 0, 0, w, h, c525252)
		else
			draw.RoundedBox(4, 0, 0, w, h, c424242)
		end

		draw.RoundedBox(4, 1, 1, w - 2, h - 2, c303030)
		draw.SimpleText(info.text1, "font_19r", w * 0.5, h * 0.5 - 1, info.color, 1, 1)
	end
	button.DoClick = function(self)
		if not info.net then return end

		-- close
		CloseMenu()

		-- net
		net.Start(info.net)
		net.WriteEntity(info.ent)
		net.WriteUInt(info.job, 8)
		net.SendToServer()
	end

	-- label
	local label = vgui.Create("DLabel", info.parent)
	label:SetFont("font_16r")
	label:SetColor(c150150150)
	label:SetText(info.text2)
	label:SizeToContents()
	label:SetPos(size_w - 91 - (label:GetWide() * 0.5), 59)
end

--[[------------------------------------------------------------

	CreateButton

------------------------------------------------------------]]--
local function CreateButton(pnl, ent, job)
	local type = job.type or 6

	-- blocked
	if type == 1 then
		-- info
		local info = {}
		info.parent = pnl
		info.text1 = "Занять работу"
		info.color = c150150150
		info.text2 = "недоступно"

		-- draw
		DrawButton(info)
		return
	end

	-- blocked
	if type == 2 then
		-- info
		local info = {}
		info.parent = pnl
		info.text1 = "Купить работу"
		info.color = c150150150
		info.text2 = "чёрный список"

		-- draw
		DrawButton(info)
		return
	end

	-- blocked
	if type == 3 then
		-- info
		local info = {}
		info.parent = pnl
		info.text1 = "Купить работу"
		info.color = c150150150
		info.text2 = "цена: " .. DarkRP.formatMoney(job.price)

		-- draw
		DrawButton(info)
		return
	end

	-- purchase
	if type == 4 then
		-- info
		local info = {}
		info.parent = pnl
		info.text1 = "Купить работу"
		info.color = c230230230
		info.text2 = "цена: " .. DarkRP.formatMoney(job.price)
		info.net = "retrime.JobSystem.Purchase"
		info.ent = ent
		info.job = job.team

		-- draw
		DrawButton(info)
		return
	end

	-- blocked
	if type == 5 then
		-- info
		local info = {}
		info.parent = pnl
		info.text1 = "Занять работу"
		info.color = c150150150
		info.text2 = "недоступно"

		-- draw
		DrawButton(info)
		return
	end

	-- choose
	if type == 6 then
		-- info
		local info = {}
		info.parent = pnl
		info.text1 = "Занять работу"
		info.color = c230230230
		info.text2 = team.NumPlayers(job.team) .. " из " .. (job.max > 0 and job.max or "∞") .. " доступных"
		info.net = "retrime.JobSystem.Choose"
		info.ent = ent
		info.job = job.team

		-- draw
		DrawButton(info)
		return
	end
end

--[[------------------------------------------------------------

	Menu

------------------------------------------------------------]]--
net.Receive("retrime.JobSystem.Menu", function()
	local curtime = CurTime()
	if 20 > curtime then return end

	local ent = net.ReadEntity()
	local length = net.ReadUInt(12)
	local scrw = math.max(864, ScrW() * 0.45)
	local scrh = math.max(720, ScrH() * 0.7)

	local data = net.ReadData(length)
	data = util.Decompress(data)
	data = util.JSONToTable(data)

	local size_w = GetMenuWeight()
	local size_h = GetMenuHeight()
	local category = ent:GetCategory()
	local fullmode = size_w >= 886

	-- jobsystem
	jobsystem = vgui.Create("DFrame")
	jobsystem:SetSize(scrw, scrh)
	jobsystem:Center()
	jobsystem:SetTitle("")
	jobsystem:ShowCloseButton(false)
	jobsystem:SetDraggable(false)
	jobsystem:MakePopup()
	jobsystem.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, 40, c230230230)
		draw.RoundedBox(0, 0, 40, w, h - 40, c303030)
		draw.SimpleText(category, "font_22r", 17, 9, c303030)
	end

	-- close
	local close = vgui.Create("DButton", jobsystem)
	close:SetSize(16, 16)
	close:SetPos(jobsystem:GetWide() - 32, 12)
	close:SetText("")
	close.Paint = function(self, w, h)
		draw.Icon(0, 0, w, h, c303030, icon_close)
	end
	close.DoClick = function()
		CloseMenu()
	end

	-- scrollpanel
	local scrollpanel = vgui.Create("DScrollPanel", jobsystem)
	scrollpanel:SetSize(jobsystem:GetWide(), jobsystem:GetTall() - 92)
	scrollpanel:SetPos(0, 57)
	scrollpanel.Paint = function() end

	-- scrollbar
	local scrollbar = scrollpanel:GetVBar()
	scrollbar:SetHideButtons(true)

	scrollbar.Paint = function(self, w, h)
		draw.RoundedBox(0, 11, 0, 4, h, c454545)
	end

	scrollbar.btnGrip.Paint = function(self, w, h)
		draw.RoundedBox(0, 11, 0, 4, h, c109109109)
	end

	-- height, offset
	local height = 0
	local offset = fullmode and 57 or 42

	-- jobs
	for k, v in ipairs(GetJobs(data)) do
		-- salary
		local salary = "зарплата: " .. DarkRP.formatMoney(v.salary)

		-- job
		local job = vgui.Create("DPanel", scrollpanel)
		job:SetSize(size_w - 54, 97)
		job:SetPos(27, height)
		job.Paint = function(self, w, h)
			-- name
			draw.SimpleText(v.name, "font_22r", 97, 19, c230230230)

			-- description
			if fullmode then
				draw.SimpleText(v.description, "font_16r", 97, 42, c150150150)
			end

			-- salary
			draw.SimpleText(salary, "font_16r", 97, offset, c150150150)

			-- line
			draw.RoundedBox(0, 0, h - 1, w, 1, c333333)
		end

		-- icon
		local icon = vgui.Create("SpawnIcon", job)
		icon:SetSize(64, 64)
		icon:SetPos(16, 16)
		icon:SetModel((istable(v.model) and v.model[1]) or v.model)
		icon:SetMouseInputEnabled(false)

		-- button
		CreateButton(job, ent, v)

		-- height
		height = height + 97
	end
end)