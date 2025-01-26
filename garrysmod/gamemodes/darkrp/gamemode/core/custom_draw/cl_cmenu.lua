local PANEL = {}

AccessorFunc(PANEL, "m_bHangOpen", "HangOpen")

function PANEL:Init()

	self:SetWorldClicker(true)

	self.Canvas = vgui.Create("DCategoryList", self)
	self.m_bHangOpen = false

end

function PANEL:Open()

	self:SetHangOpen(false)

	if (IsValid(g_SpawnMenu) and g_SpawnMenu:IsVisible()) then
		g_SpawnMenu:Close(true)
	end

	if (self:IsVisible()) then return end

	CloseDermaMenus()

	self:MakePopup()
	self:SetVisible(true)
	self:SetKeyboardInputEnabled(false)
	self:SetMouseInputEnabled(true)

	RestoreCursorPosition()

	local bShouldShow = true

	if (bShouldShow and IsValid(spawnmenu.ActiveControlPanel())) then
		self.OldParent = spawnmenu.ActiveControlPanel():GetParent()
		self.OldPosX, self.OldPosY = spawnmenu.ActiveControlPanel():GetPos()
		spawnmenu.ActiveControlPanel():SetParent(self)
		self.Canvas:Clear()
		self.Canvas:AddItem(spawnmenu.ActiveControlPanel())
		self.Canvas:Rebuild()
		self.Canvas:SetVisible(true)
	else
		self.Canvas:SetVisible(false)
	end

	self:InvalidateLayout(true)

end

function PANEL:Close(bSkipAnim)

	if (self:GetHangOpen()) then
		self:SetHangOpen(false)
		return
	end

	RememberCursorPosition()

	CloseDermaMenus()

	self:SetKeyboardInputEnabled(false)
	self:SetMouseInputEnabled(false)

	self:SetAlpha(255)
	self:SetVisible(false)
	self:RestoreControlPanel()

end

function PANEL:PerformLayout()

	self:SetPos(0, -30)
	self:SetSize(ScrW(), ScrH())

	if (IsValid(spawnmenu.ActiveControlPanel())) then
		spawnmenu.ActiveControlPanel():InvalidateLayout(true)

		local Tall = math.min(spawnmenu.ActiveControlPanel():GetTall() + 10, ScrH() * 0.8)

		if (self.Canvas:GetTall() ~= Tall) then self.Canvas:SetTall(Tall) end
		if (self.Canvas:GetWide() ~= 320) then self.Canvas:SetWide(320) end

		self.Canvas:SetPos(ScrW() - self.Canvas:GetWide() - 50, ScrH() - 50 - Tall)
		self.Canvas:InvalidateLayout(true)
	end

end

function PANEL:StartKeyFocus(pPanel)

	self:SetKeyboardInputEnabled(true)
	self:SetHangOpen(true)

end

function PANEL:EndKeyFocus(pPanel)

	self:SetKeyboardInputEnabled(false)

end

function PANEL:RestoreControlPanel()

	if (not spawnmenu.ActiveControlPanel()) then return end
	if (not self.OldParent) then return end

	spawnmenu.ActiveControlPanel():SetParent(self.OldParent)
	spawnmenu.ActiveControlPanel():SetPos(self.OldPosX, self.OldPosY)

	self.OldParent = nil

end

vgui.Register("ContextMenu", PANEL, "EditablePanel")

function CreateContextMenu()

	if (not hook.Run("ContextMenuEnabled")) then return end

	if (IsValid(g_ContextMenu)) then
		g_ContextMenu:Remove()
		g_ContextMenu = nil
	end

	g_ContextMenu = vgui.Create("ContextMenu")

	if (not IsValid(g_ContextMenu)) then return end

	g_ContextMenu:SetVisible(false)

	g_ContextMenu.OnMousePressed = function(p, code)
		hook.Run("GUIMousePressed", code, gui.ScreenToVector(gui.MousePos()))
	end

	g_ContextMenu.OnMouseReleased = function(p, code)
		hook.Run("GUIMouseReleased", code, gui.ScreenToVector(gui.MousePos()))
	end

	hook.Run("ContextMenuCreated", g_ContextMenu)

	local IconLayout = g_ContextMenu:Add("DIconLayout")
	IconLayout:SetBorder(8)
	IconLayout:SetSpaceX(8)
	IconLayout:SetSpaceY(8)
	IconLayout:SetLayoutDir(LEFT)
	IconLayout:SetWorldClicker(true)
	IconLayout:SetStretchWidth(true)
	IconLayout:SetStretchHeight(false)
	IconLayout:Dock(LEFT)
	IconLayout.OnMousePressed = function(s, ...) s:GetParent():OnMousePressed(...) end

	for k, v in pairs(list.Get("DesktopWindows")) do
		local icon = IconLayout:Add("DButton")
		icon:SetText("")
		icon:SetSize(80, 82)
		icon.Paint = function() end

		local image = icon:Add("DImage")
		image:SetImage(v.icon)
		image:SetSize(64, 64)
		image:Dock(TOP)
		image:DockMargin(8, 0, 8, 0)

		local label = icon:Add("DLabel")
		label:Dock(BOTTOM)
		label:SetText(v.title)
		label:SetContentAlignment(5)
		label:SetTextColor(Color(255, 255, 255, 255))
		label:SetExpensiveShadow(1, Color(0, 0, 0, 200))

		icon.DoClick = function()
			local newv = list.Get("DesktopWindows")[k]

			if (v.onewindow) then
				if (IsValid(icon.Window)) then icon.Window:Center() return end
			end

			icon.Window = g_ContextMenu:Add("DFrame")
			icon.Window:SetSize(newv.width, newv.height)
			icon.Window:SetTitle(newv.title)
			icon.Window:Center()

			newv.init(icon, icon.Window)
		end
	end

end

function GM:OnContextMenuOpen()

	if (not hook.Call("ContextMenuOpen", self)) then return end

	if (IsValid(g_ContextMenu) and not g_ContextMenu:IsVisible()) then
		g_ContextMenu:Open()
		menubar.ParentTo(g_ContextMenu)
	end

	hook.Call("ContextMenuOpened", self)

end

function GM:OnContextMenuClose()

	if (IsValid(g_ContextMenu)) then g_ContextMenu:Close() end
	hook.Call("ContextMenuClosed", self)

end