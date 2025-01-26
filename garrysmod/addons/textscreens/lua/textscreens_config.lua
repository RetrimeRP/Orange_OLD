textscreenFonts = {}

local function addFont(font, t)
	if CLIENT then
		t.size = 100
		surface.CreateFont(font, t)
		t.size = 50
		surface.CreateFont(font .. "_MENU", t)
	end

	table.insert(textscreenFonts, font)
end

-- Arial
addFont("Screens_Arial outlined", {
	font = "Arial",
	extended = true,
	weight = 600,
	antialias = true,
	outline = true
})

addFont("Screens_Arial", {
	font = "Arial",
	extended = true,
	weight = 600,
	antialias = true,
	outline = false
})

-- Roboto Bk
addFont("Screens_Roboto outlined", {
	font = "Roboto Bk",
	extended = true,
	weight = 400,
	antialias = true,
	outline = true
})

addFont("Screens_Roboto", {
	font = "Roboto Bk",
	extended = true,
	weight = 400,
	antialias = true,
	outline = false
})

-- Noto Sans
addFont("Screens_Noto Sans outlined", {
	font = "Noto Sans",
	extended = true,
	weight = 400,
	antialias = true,
	outline = true
})

addFont("Screens_Noto Sans", {
	font = "Noto Sans",
	extended = true,
	weight = 400,
	antialias = true,
	outline = false
})

-- Noto Sans Bold
addFont("Screens_Noto Sans Bold outlined", {
	font = "Noto Sans Bold",
	extended = true,
	weight = 400,
	antialias = true,
	outline = true
})

addFont("Screens_Noto Sans Bold", {
	font = "Noto Sans Bold",
	extended = true,
	weight = 400,
	antialias = true,
	outline = false
})

if CLIENT then
	local function addFonts(path)
		local files, folders = file.Find("resource/fonts/" .. path .. "*", "MOD")

		for k, v in ipairs(files) do
			if string.GetExtensionFromFilename(v) == "ttf" then
				local font = string.StripExtension(v)
				if table.HasValue(textscreenFonts, "Screens_" .. font) then continue end
			end
		end

		for k, v in ipairs(folders) do
			addFonts(path .. v .. "/")
		end
	end

	concommand.Add("get_fonts", function(ply)
		addFonts("")
	end)
end