--[[------------------------------------------------------------

	PreRegisterSENT

------------------------------------------------------------]]--
hook.Add("PreRegisterSENT", "retrime.IGS", function(tbl, ent)
	if ent == "npc_igs" then
		local c000 = Color(0, 0, 0)
		local c255255255 = Color(255, 255, 255)

		tbl.Draw = function(self)
			self:DrawModel()
		end

		tbl.DrawCustom3D2D = function(self)
			local pos = self:LocalToWorld(Vector(0, 0, 80))

			local ang = LocalPlayer():GetAngles()
			ang:RotateAroundAxis(ang:Forward(), 90)
			ang:RotateAroundAxis(ang:Right(), 90)

			cam.Start3D2D(pos, ang, 0.15)
				draw.SimpleText("Автодонат", "font_40sb", 0, 0, c000, 1, 1)
				draw.SimpleText("Автодонат", "font_40b", 0, 0, c255255255, 1, 1)
			cam.End3D2D()
		end
	end
end)

--[[------------------------------------------------------------

	IGS.Loaded

------------------------------------------------------------]]--
hook.Add("IGS.Loaded", "retrime.IGS", function()
	IGS.S.COLORS.FRAME_HEADER = Color(30, 30, 30)
	IGS.S.COLORS.ACTIVITY_BG = Color(30, 30, 30)
	IGS.S.COLORS.TAB_BAR = Color(30, 30, 30)

	IGS.S.COLORS.PASSIVE_SELECTIONS = Color(30, 30, 30)
	IGS.S.COLORS.INNER_SELECTIONS = Color(30, 30, 30)

	IGS.S.COLORS.SOFT_LINE = Color(42, 42, 42)
	IGS.S.COLORS.HARD_LINE = Color(42, 42, 42)

	IGS.S.COLORS.HIGHLIGHTING = Color(110, 110, 110)
	IGS.S.COLORS.HIGHLIGHT_INACTIVE = Color(52, 52, 52)

	IGS.S.COLORS.TEXT_HARD = Color(230, 230, 230)
	IGS.S.COLORS.TEXT_SOFT = Color(230, 230, 230)
	IGS.S.COLORS.TEXT_ON_HIGHLIGHT = Color(30, 30, 30)

	IGS.S.COLORS.LOG_SUCCESS = Color(76, 217, 100)
	IGS.S.COLORS.LOG_ERROR = Color(220, 30, 70)
	IGS.S.COLORS.LOG_NORMAL = Color(230, 230, 230)

	IGS.S.COLORS.ICON = Color(255, 255, 255)
end)