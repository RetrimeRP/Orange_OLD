// Colors

local convar_header = CreateClientConVar('fated_ui_color_header', 'blue', true)
local convar_background = CreateClientConVar('fated_ui_color_background', 'dark', true)

ui.col = {}

-- Header
ui.col.header_table = {
	['blue'] = Color(56,129,193),
	['red'] = Color(205,57,57),
	['green-blue'] = Color(65,176,163),
	['purple'] = Color(127,73,214),
	['orange'] = Color(220,123,67),
	['pink'] = Color(199,75,141),
	['gray'] = Color(155,158,164),
	['green'] = Color(72,174,72),
}
ui.col.header = function()
	local header_color = ui.col.header_table[convar_header:GetString()]

	return header_color and header_color or ui.col.header_table['blue']
end

-- Background
ui.col.background_table = {
--	['dark'] = Color(0,0,0,120),
--	['light'] = Color(255,255,255,50),	
	['dark'] = Color(24,24,24,225),
	['light'] = Color(225,225,225,50),
}

ui.col.ValidTheme = {
	'dark',
	'light',
}

ui.col.background = function()
	local con = convar_background:GetString()

	return ui.col.background_table[table.HasValue(ui.col.ValidTheme, con) and con or 'dark']
end

-- Outline
ui.col.outline = Color(0,0,0,140)

-- Panel
ui.col.panel_table = {
	['dark'] = {
		Color(255,255,255,25),
		Color(0,0,0,120),
	},
	['light'] = {
		Color(0,0,0,115),
		Color(255,255,255,30),
	},
}
ui.col.panel = function()
	local con = convar_background:GetString()

	return ui.col.panel_table[table.HasValue(ui.col.ValidTheme, con) and con or 'dark']
end

-- Button
ui.col.button_table = {
	--['dark'] = Color(116,116,116),
	['dark'] = Color(55,55,55),
	['light'] = Color(60,60,60),
}
ui.col.button = function()
	local con = convar_background:GetString()

	return ui.col.button_table[table.HasValue(ui.col.ValidTheme, con) and con or 'dark']
end

-- Text
ui.col.text_table = {
	['dark'] = Color(245,245,245),
	['light'] = Color(23,23,23),
}

ui.col.text = function()
	local con = convar_background:GetString()

	return ui.col.text_table[table.HasValue(ui.col.ValidTheme, con) and con or 'dark']
end
