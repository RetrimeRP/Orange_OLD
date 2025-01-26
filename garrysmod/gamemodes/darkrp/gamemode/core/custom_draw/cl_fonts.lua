local function CreateFonts()

	--
	-- DarkRP fonts
	--
	local tahoma = system.IsLinux() and "DejaVu Sans" or "Tahoma"
	local tahomasize = system.IsLinux() and fp{fn.Flip(fn.Add), 1} or fn.Id

	surface.CreateFont("DarkRPHUD1", {size = tahomasize(16), weight = 600, antialias = true, shadow = false, font = tahoma})
	surface.CreateFont("Trebuchet24", {size = 24, weight = 500, antialias = true, shadow = false, font = "Trebuchet MS"})
	surface.CreateFont("TabLarge", {size = tahomasize(15), weight = 700, antialias = true, shadow = false, font = tahoma})
	surface.CreateFont("UiBold", {size = 16, weight = 800, antialias = true, shadow = false, font = "Verdana"})
	surface.CreateFont("HUDNumber5", {size = 30, weight = 800, antialias = true, shadow = false, font = "Verdana"})

	--
	-- Custom fonts
	--
	-- > 15 px
	surface.CreateFont("font_15r", {font = "Noto Sans", extended = true, size = 15, antialias = true})

	-- > 16 px
	surface.CreateFont("font_16r", {font = "Noto Sans", extended = true, size = 16, antialias = true})

	-- > 18 px
	surface.CreateFont("font_18r", {font = "Noto Sans", extended = true, size = 18, antialias = true})
	surface.CreateFont("font_18s", {font = "Noto Sans", extended = true, size = 18, blursize = 3, antialias = true})

	-- > 19 px
	surface.CreateFont("font_19r", {font = "Noto Sans", extended = true, size = 19, antialias = true})

	-- > 22 px
	surface.CreateFont("font_22r", {font = "Noto Sans", extended = true, size = 22, antialias = true})
	surface.CreateFont("font_22s", {font = "Noto Sans", extended = true, size = 22, blursize = 3, antialias = true})
	surface.CreateFont("font_22b", {font = "Noto Sans Bold", extended = true, size = 22, antialias = true})

	-- > 24 px
	surface.CreateFont("font_24r", {font = "Noto Sans", extended = true, size = 24, antialias = true})
	surface.CreateFont("font_24s", {font = "Noto Sans", extended = true, size = 24, blursize = 5, antialias = true})
	surface.CreateFont("font_24b", {font = "Noto Sans Bold", extended = true, size = 24, antialias = true})

	-- > 32 px
	surface.CreateFont("font_32r", {font = "Noto Sans", extended = true, size = 32, antialias = true})
	surface.CreateFont("font_32b", {font = "Noto Sans Bold", extended = true, size = 32, antialias = true})
	surface.CreateFont("font_32sb", {font = "Noto Sans Bold", extended = true, size = 32, blursize = 3, antialias = true})

	-- > 35 px
	surface.CreateFont("font_35b", {font = "Noto Sans Bold", extended = true, size = 35, antialias = true})

	-- > 40 px
	surface.CreateFont("font_40b", {font = "Noto Sans Bold", extended = true, size = 40, antialias = true})
	surface.CreateFont("font_40sb", {font = "Noto Sans Bold", extended = true, size = 40, blursize = 5, antialias = true})

	-- > 48 px
	surface.CreateFont("font_48b", {font = "Noto Sans Bold", extended = true, size = 48, antialias = true})
	surface.CreateFont("font_48sb", {font = "Noto Sans Bold", extended = true, size = 48, blursize = 5, antialias = true})

end

CreateFonts()