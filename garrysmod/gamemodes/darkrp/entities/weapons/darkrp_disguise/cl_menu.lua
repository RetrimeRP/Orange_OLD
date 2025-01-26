local pnl

local c454545 = Color(45, 45, 45)
local c424242 = Color(42, 42, 42)
local c255255255 = Color(255, 255, 255)
local c303030 = Color(30, 30, 30)
local c109109109 = Color(109, 109, 109)

local disguise_close = Material("materials/retrime_orange/close.png")

local function CloseMenu()

	if IsValid(pnl) then
		pnl:Close()
		pnl = nil
	end

	gui.EnableScreenClicker(false)

end

local function BubbleContainer(x, y, name, parent)

	surface.SetFont("font_18r")
	local width = surface.GetTextSize(name)

	local bubble = vgui.Create("DPanel")
	bubble:SetSize(width + 10, 20)
	bubble:SetPos(pnl:LocalToScreen((x + 24) - (bubble:GetWide() * 0.5), y - 30))
	bubble:SetMouseInputEnabled(false)
	bubble.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, c303030)
		draw.SimpleText(name, "font_18r", w * 0.5, 0, c255255255, 1)
	end
	bubble.Think = function(self)
		if not parent:IsHovered() then
			self:Remove()
		end
	end

end

net.Receive("OpenDisguiseMenu", function()

	CloseMenu()

	local disguiselist = DarkRP.GetDisguiseList()
	local disguise = LocalPlayer():getDarkRPVar("disguise")
	local list = 1
	local height = 82

	gui.EnableScreenClicker(true)

	pnl = vgui.Create("DFrame")
	pnl:SetSize(388, 210)
	pnl:Center()
	pnl:SetTitle("")
	pnl:ShowCloseButton(false)
	pnl:SetDraggable(false)
	pnl:SetPopupStayAtBack()
	pnl.Paint = function(self, w, h)
		draw.RoundedBoxEx(3, 0, 0, w, 58, c454545, true, true, false, false)
		draw.RoundedBoxEx(3, 0, 58, w, h - 58, c424242, false, false, true, true)
		draw.SimpleText("Маскировка", "font_22b", 24, 18, c255255255)

		for i = 1, 6 do
			draw.RoundedBox(4, i * 56 - 26, 82, 48, 48, c303030)
			draw.RoundedBox(4, i * 56 - 26, 138, 48, 48, c303030)
		end
	end

	local close = vgui.Create("DButton", pnl)
	close:SetSize(16, 16)
	close:SetPos(pnl:GetWide() - 38, 21)
	close:SetText("")
	close.Paint = function(self, w, h)
		draw.Icon(0, 0, w, h, c255255255, disguise_close)
	end
	close.DoClick = function()
		CloseMenu()
	end

	for k, v in SortedPairsByMemberValue(disguiselist, "id") do
		if k == "0" and not disguise then continue end
		if v.allowed and not v.allowed(LocalPlayer()) then continue end

		if list > 6 then
			list = 1
			height = 138
		end

		local model

		if k == "0" then
			local jobmodel = LocalPlayer():getJobTable().model

			model = istable(jobmodel) and jobmodel[1] or jobmodel
		else
			model = istable(v.model) and v.model[1] or v.model
		end

		local icon = vgui.Create("SpawnIcon", pnl)
		icon:SetSize(48, 48)
		icon:SetPos(list * 56 - 26, height)
		icon:SetModel(model)
		icon:SetMouseInputEnabled(false)

		local button = vgui.Create("DButton", pnl)
		button:SetSize(48, 48)
		button:SetPos(list * 56 - 26, height)
		button:SetText("")
		button.Paint = function() end
		button.DoClick = function()
			CloseMenu()

			net.Start("DisguiseUse")
			net.WriteString(model)
			net.WriteString(k)
			net.SendToServer()
		end
		button.OnCursorEntered = function(self)
			local x, y = self:GetPos()

			timer.Simple(0.34, function()
				if self:IsHovered() then
					BubbleContainer(x, y, v.name, self)
				end
			end)
		end

		list = list + 1
	end

end)