local ELEMENT = {}

function ELEMENT:Init()
	self.color_id = 1
	self.rad = 6
end

function ELEMENT:Paint(w, h)
--	local con = GetConVar( 'fated_ui_color_background'):GetString()
	
	draw.RoundedBox(self.rad, 0, 0, w, h, col.bg) -- ui.col.panel_table[table.HasValue(ui.col.ValidTheme, con) and con or 'dark'][self.color_id]
	draw.RoundedBoxEx(self.rad, 0, 0, w, ui.h(10), col.basec, true,true,false,false)
end

function ELEMENT:Color(id)
	self.color_id = id
end

function ELEMENT:Radius(rad)
	self.rad = rad
end

vgui.Register('ui-panel', ELEMENT, 'DPanel')
