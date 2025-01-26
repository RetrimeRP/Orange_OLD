local previous

timer.Create("DarkRP_ConsoleTime", .5, 0, function()

	local new = os.date(" %H  %M ")

	if new ~= previous then
		MsgC(Color(170, 170, 170), "----------------------------" .. new .. "----------------------------\n")
		previous = new
	end

end)

