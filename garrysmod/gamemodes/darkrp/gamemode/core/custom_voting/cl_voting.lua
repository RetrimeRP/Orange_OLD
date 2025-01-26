local c303030 = Color(30, 30, 30)
local c230230230 = Color(230, 230, 230)
local c255255255 = Color(255, 255, 255)

local vote_check = Material("materials/retrime_orange/check.png")
local vote_close = Material("materials/retrime_orange/close.png")

local questions = {}
local votes = {}
local panels = 0

--[[------------------------------------------------------------

	Vote

------------------------------------------------------------]]--
usermessage.Hook("DoVote", function(msg)

	if not IsValid(LocalPlayer()) then return end

	local question = msg:ReadString()
	local voteid = msg:ReadShort()
	local expires = msg:ReadFloat()

	if expires == 0 then
		expires = 100
	end

	local oldtime = CurTime()

	LocalPlayer():EmitSound("buttons/combine_button2.wav", 100, 100)

	question = DarkRP.textWrap(question:gsub("\\n", "\n"), "font_19r", 212)

	local _, height = surface.GetTextSize(question)
	height = height - 3

	local pnl = vgui.Create("DFrame")
	pnl:SetSize(248, 66 + height)
	pnl:SetPos(20, 20 + panels)
	pnl:SetTitle("")
	pnl:ShowCloseButton(false)
	pnl:SetDraggable(false)
	pnl.Paint = function(self, w, h)
		local timeleft = expires - (CurTime() - oldtime)

		draw.RoundedBox(0, 0, 0, w, h, c303030)
		draw.RoundedBox(0, 0, 0, timeleft * (w / expires), 2, c230230230)

		draw.DrawText(question, "font_19r", w * 0.5, 16, c255255255, 1)
	end
	pnl.Close = function(self)
		panels = panels - self:GetTall() - 20
		votes[voteid] = nil

		local number = 20

		for _, v in SortedPairs(votes) do
			v:SetPos(20, number)
			number = number + v:GetTall() + 20
		end

		for _, v in SortedPairs(questions) do
			v:SetPos(20, number)
			number = number + v:GetTall() + 20
		end

		self:Remove()
	end
	pnl.Think = function(self)
		if expires - (CurTime() - oldtime) <= 0 then
			self:Close()
		end
	end

	pnl:SetKeyboardInputEnabled(false)
	pnl:SetMouseInputEnabled(true)
	pnl:SetVisible(true)

	local yeabtn = vgui.Create("DButton", pnl)
	yeabtn:SetPos(95, 35 + height)
	yeabtn:SetSize(16, 16)
	yeabtn:SetText("")
	yeabtn.Paint = function(self, w, h)
		draw.Icon(0, 0, 16, 16, c255255255, vote_check)
	end
	yeabtn.DoClick = function()
		LocalPlayer():ConCommand("vote " .. voteid .. " yea\n")
		pnl:Close()
	end

	local naybtn = vgui.Create("DButton", pnl)
	naybtn:SetPos(139, 35 + height)
	naybtn:SetSize(16, 16)
	naybtn:SetText("")
	naybtn.Paint = function(self, w, h)
		draw.Icon(0, 0, 16, 16, c255255255, vote_close)
	end
	naybtn.DoClick = function()
		LocalPlayer():ConCommand("vote " .. voteid .. " nay\n")
		pnl:Close()
	end

	panels = panels + pnl:GetTall() + 20
	votes[voteid] = pnl

end)

usermessage.Hook("KillVoteVGUI", function(msg)

	local voteid = msg:ReadShort()
	local vote = votes[voteid]

	if vote and IsValid(vote) then
		vote:Close()
	end

end)

--[[------------------------------------------------------------

	Question

------------------------------------------------------------]]--
usermessage.Hook("DoQuestion", function(msg)

	if not IsValid(LocalPlayer()) then return end

	local question = msg:ReadString()
	local questionid = msg:ReadString()
	local expires = msg:ReadFloat()

	if expires == 0 then
		expires = 100
	end

	local oldtime = CurTime()

	LocalPlayer():EmitSound("buttons/combine_button2.wav", 100, 100)

	question = DarkRP.textWrap(question:gsub("\\n", "\n"), "font_19r", 212)

	local _, height = surface.GetTextSize(question)
	height = height - 3

	local pnl = vgui.Create("DFrame")
	pnl:SetSize(248, 66 + height)
	pnl:SetPos(20, 20 + panels)
	pnl:SetTitle("")
	pnl:ShowCloseButton(false)
	pnl:SetDraggable(false)
	pnl.Paint = function(self, w, h)
		local timeleft = expires - (CurTime() - oldtime)

		draw.RoundedBox(0, 0, 0, w, h, c303030)
		draw.RoundedBox(0, 0, 0, timeleft * (w / expires), 2, c230230230)

		draw.DrawText(question, "font_19r", w * 0.5, 16, c255255255, 1)
	end
	pnl.Close = function(self)
		panels = panels - self:GetTall() - 20
		questions[questionid] = nil

		local number = 20

		for _, v in SortedPairs(votes) do
			v:SetPos(20, number)
			number = number + v:GetTall() + 20
		end

		for _, v in SortedPairs(questions) do
			v:SetPos(20, number)
			number = number + v:GetTall() + 20
		end

		self:Remove()
	end
	pnl.Think = function(self)
		if expires - (CurTime() - oldtime) <= 0 then
			self:Close()
		end
	end

	pnl:SetKeyboardInputEnabled(false)
	pnl:SetMouseInputEnabled(true)
	pnl:SetVisible(true)

	local yeabtn = vgui.Create("DButton", pnl)
	yeabtn:SetPos(95, 35 + height)
	yeabtn:SetSize(16, 16)
	yeabtn:SetText("")
	yeabtn.Paint = function(self, w, h)
		draw.Icon(0, 0, 16, 16, c255255255, vote_check)
	end
	yeabtn.DoClick = function()
		LocalPlayer():ConCommand("ans " .. questionid .. " 1\n")
		pnl:Close()
	end

	local naybtn = vgui.Create("DButton", pnl)
	naybtn:SetPos(139, 35 + height)
	naybtn:SetSize(16, 16)
	naybtn:SetText("")
	naybtn.Paint = function(self, w, h)
		draw.Icon(0, 0, 16, 16, c255255255, vote_close)
	end
	naybtn.DoClick = function()
		LocalPlayer():ConCommand("ans " .. questionid .. " 2\n")
		pnl:Close()
	end

	panels = panels + pnl:GetTall() + 20
	questions[questionid] = pnl

end)

usermessage.Hook("KillQuestionVGUI", function(msg)

	local questionid = msg:ReadString()
	local question = questions[questionid]

	if question and IsValid(question) then
		question:Close()
	end

end)

--[[------------------------------------------------------------

	Answer

------------------------------------------------------------]]--
concommand.Add("rp_vote", function(ply, cmd, args)

	if not args[1] then return end

	local vote = 0

	if tonumber(args[1]) == 1 or string.lower(args[1]) == "yes" or string.lower(args[1]) == "true" then
		vote = 1
	end

	for k, v in pairs(votes) do
		if IsValid(v) then
			local voteid = string.sub(k, 1, -5)

			votes[k]:Close()

			RunConsoleCommand("vote", voteid, vote)
			return
		end
	end

	for k, v in pairs(questions) do
		if IsValid(v) then
			local questionid = string.sub(k, 1, -5)

			questions[k]:Close()

			RunConsoleCommand("ans", questionid, vote)
			return
		end
	end

end)