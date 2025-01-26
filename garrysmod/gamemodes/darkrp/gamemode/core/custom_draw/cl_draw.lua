local function safeText(text)

	return string.match(text, "^#([a-zA-Z_]+)$") and text .. " " or text

end

DarkRP.deLocalise = safeText

function draw.DrawNonParsedText(text, font, x, y, color, xAlign)

	return draw.DrawText(safeText(text), font, x, y, color, xAlign)

end

function draw.DrawNonParsedSimpleText(text, font, x, y, color, xAlign, yAlign)

	return draw.SimpleText(safeText(text), font, x, y, color, xAlign, yAlign)

end

function draw.DrawNonParsedSimpleTextOutlined(text, font, x, y, color, xAlign, yAlign, outlineWidth, outlineColor)

	return draw.SimpleTextOutlined(safeText(text), font, x, y, color, xAlign, yAlign, outlineWidth, outlineColor)

end

function surface.DrawNonParsedText(text)

	return surface.DrawText(safeText(text))

end

function chat.AddNonParsedText(...)

	local tbl = {...}

	for i = 2, #tbl, 2 do
		tbl[i] = safeText(tbl[i])
	end

	return chat.AddText(unpack(tbl))

end

--
-- Custom
--
local blur = Material("pp/blurscreen")

function draw.Icon(x, y, w, h, color, icon)

	surface.SetMaterial(icon)
	surface.SetDrawColor(color)
	surface.DrawTexturedRect(x, y, w, h)

end

function draw.Blur(x, y, w, h, amount, passes)

	local x2, y2 = x / ScrW(), y / ScrH()
	local w2, h2 = (x + w) / ScrW(), (y + h) / ScrH()

	amount = amount or 5

	surface.SetMaterial(blur)
	surface.SetDrawColor(255, 255, 255)

	for i = -(passes or 0.2), 1, 0.2 do
		blur:SetFloat("$blur", i * amount)
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRectUV(x, y, w, h, x2, y2, w2, h2)
	end

end

function draw.OutlinedBox(x, y, w, h, thick, color)

	surface.SetDrawColor(color)

	for i = 0, thick - 1 do
		surface.DrawOutlinedRect(x + i, y + i, w - i * 2, h - i * 2)
	end

end

--[[
function draw.Circle(x, y, segments, angle, radius, color)

	local circle = {}

	table.insert(circle, {x = x, y = y, u = 0.5, v = 0.5})

	for i = 0, segments do
		local a = math.rad((i / segments) * -angle)

		table.insert(circle, {x = x + math.sin(a) * radius, y = y + math.cos(a) * radius, u = math.sin(a) * 0.5 + 0.5, v = math.cos(a) * 0.5 + 0.5})
	end

	surface.SetDrawColor(color)
	draw.NoTexture()
	surface.DrawPoly(circle)

end
]]

function draw.SubSection(x, y, r, r2, startAng, endAng, step, cache)

	local positions = {}
	local inner = {}
	local outer = {}

	r2 = r + r2
	startAng = startAng or 0
	endAng = endAng or 0

	for i = startAng - 90, endAng - 90, step do
		table.insert(inner, {x = math.ceil(x + math.cos(math.rad(i)) * r2), y = math.ceil(y + math.sin(math.rad(i)) * r2)})
	end

	for i = startAng - 90, endAng - 90, step do
		table.insert(outer, {x = math.ceil(x + math.cos(math.rad(i)) * r), y = math.ceil(y + math.sin(math.rad(i)) * r)})
	end

	for i = 1, #inner * 2 do
		local outPoints = outer[math.floor(i / 2) + 1]
		local inPoints = inner[math.floor((i + 1) / 2) + 1]
		local otherPoints

		if i % 2 == 0 then
			otherPoints = outer[math.floor((i + 1) / 2)]
		else
			otherPoints = inner[math.floor((i + 1) / 2)]
		end

		table.insert(positions, {outPoints, otherPoints, inPoints})
	end

	if cache then
		return positions
	else
		for k, v in pairs(positions) do
			surface.DrawPoly(v)
		end
	end

end