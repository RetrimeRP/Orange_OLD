local hostname = true
local servername = "RETRIME HL2RP | "

local phrases = {
	"БОРЬБА ЗА ВЫЖИВАНИЕ",
	"ОПТИМИЗАЦИЯ",
	"СВОЯ КАРТА С НУЛЯ",
	"БЫСТРАЯ ЗАГРУЗКА",
	"СВОЯ АТМОСФЕРА",
	"НАБОР В АДМИНЫ",
	"УНИКАЛЬНЫЕ МЕХАНИКИ",
	"САМОПИСНЫЕ СИСТЕМЫ",
	"ШПИОНАЖ"
}
local random = math.random
local timer = timer
local RunConsoleCommand = RunConsoleCommand
hook.Add("PlayerInitialSpawn", "retrime.Hostname", function()
	if hostname then
		hostname = false

		if GetHostName() == "RETRIME HL2RP | ТЕХ. РАБОТЫ" then --★ RETRIME HL2RP ★ ТЕХ. РАБОТЫ ИЗМЕНЕНО 04.02.2022 -- Тут был трабл с кодировкой звёздочек, я тебе писал об этом
			print("No hostname changes")
			return
		end

		timer.Create("Hostname", 60, 0, function()
			local hostname = phrases[random(#phrases)]
			hostname = servername .. hostname

			RunConsoleCommand("hostname", hostname)
		end)
	else
		hook.Remove("PlayerInitialSpawn", "retrime.Hostname")
	end
end)