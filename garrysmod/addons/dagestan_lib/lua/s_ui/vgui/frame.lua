local color_header_el = Color(30,30,30,210)
local mat_header_close = Material('ui/close.png')
local mat_header_settings = Material('materials/setting.png')
local mat_header_fullscreen = Material('materials/frame_fullscreen.png')
local ELEMENT = {}

function ELEMENT:Init()
	self:DockPadding(6, 46, 6, 6)
	self.title = ''
	self.settings = false
	self.fullscreen = false
	self.closebut = true

	self.Background = vgui.Create('DPanel', self)
	self.Background.Paint = function(slf, w, h)
		ui.Blur(slf)

		draw.RoundedBox(0, 0, 0, w, h, col.bg)
		--surface.SetDrawColor(col.outline)
		--surface.DrawOutlinedRect(0, -1, w, h - 5)
	end

	self.Header = vgui.Create('DPanel', self)
	self.Header.Paint = function(_, w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, col.header, true, true)
		draw.RoundedBoxEx(0, self:GetWide() * 0.001, 0, ui.w(10), ui.h(h), col.basec, false, true, false, true)
		ui.ShadowGradient(0, h * 0.3, w, h * 0.7, 1)
	end

	self.Header.Close = vgui.Create('DButton', self.Header)
	self.Header.Close:Dock(RIGHT)
	self.Header.Close:DockMargin(0, 4, 4, 4)
	self.Header.Close:SetWide(32)
	self.Header.Close:SetText('')
	self.Header.Close.DoClick = function()
		ui.Sound()

		self:Close()
	end
local DrawAlpha = 0
self.Header.Close.Paint = function(self, w, h)
        DrawAlpha = math.Approach(DrawAlpha, self:IsHovered() and 255 or 15, FrameTime()*650)
        surface.SetMaterial(mat_header_close)
        surface.SetDrawColor(self:IsHovered() and ColorAlpha(Color(255, 48, 48), DrawAlpha) or color_white)
        surface.DrawTexturedRect(0, 0, w, h)
    end

	self.Header.Settings = vgui.Create('DButton', self.Header)
	self.Header.Settings:Dock(RIGHT)
	self.Header.Settings:DockMargin(0, 4, 4, 4)
	self.Header.Settings:SetWide(32)
	self.Header.Settings:SetText('')
	self.Header.Settings.DoClick = function()
		ui.Sound()

		ui.OpenSettings()
	end
	self.Header.Settings.Paint = function(_, w, h)
		surface.SetMaterial(mat_header_settings)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	self.Header.Fullscreen = vgui.Create('DButton', self.Header)
	self.Header.Fullscreen:Dock(RIGHT)
	self.Header.Fullscreen:DockMargin(0, 4, 4, 4)
	self.Header.Fullscreen:SetWide(32)
	self.Header.Fullscreen:SetText('')
	self.Header.Fullscreen.DoClick = function()
		ui.Sound()

		if ScrW() != self:GetWide() and ScrH() != self:GetTall() then
			self.last_wide, self.last_tall = self:GetWide(), self:GetTall()

			self:SetSize(ScrW(), ScrH())
		else
			self:SetSize(self.last_wide, self.last_tall)
		end

		self:Center()
	end
	self.Header.Fullscreen.Paint = function(_, w, h)
		surface.SetMaterial(mat_header_fullscreen)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	self.Title = vgui.Create('DPanel', self)
	self.Title.Paint = function(_, w, h)
		--draw.SimpleText(self.title, 'ui.25',self:GetWide() * 0.02 + ui.w(35), h * 0.5 - 2, color_header_el, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) --  self:GetWide() * 0.2
		draw.SimpleText(self.title, 'ui.26', self:GetWide() * 0.5, h * 0.5 - 2, Color(225,225,225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if IsValid(self.Header.Settings) then
			if !self.settings then
				self.Header.Settings:Remove()
			end
		end

		if IsValid(self.Header.Close) then
			if !self.closebut then
				self.Header.Close:Remove()
			end
		end

		if IsValid(self.Header.Fullscreen) then
			if !self.fullscreen then
				self.Header.Fullscreen:Remove()
			end
		end
	end
end

function ELEMENT:Paint(w, h)
end

function ELEMENT:PerformLayout(w, h)
	self.Background:SetSize(w, h - 28)
	self.Background:SetPos(0, 34)

	self.Header:SetSize(w, 40)

	self.Title:SetSize(self:GetWide() - 108, 40)
end

function ELEMENT:Close()
	self:Remove()
end

function ELEMENT:closebut()
	self.closebut = bool
end

function ELEMENT:SetTitle(text)
	self.title = text
end

function ELEMENT:SetSettings(bool)
	self.settings = bool
end

function ELEMENT:SetFullscreen(bool)
	self.fullscreen = bool
end

vgui.Register('ui-frame', ELEMENT, 'EditablePanel')
