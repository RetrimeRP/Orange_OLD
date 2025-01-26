util.AddNetworkString("CityVoice")
util.AddNetworkString("RadioVoice")
util.AddNetworkString("StartLockdown")
util.AddNetworkString("StartYellowCode")
util.AddNetworkString("StartRedCode")
util.AddNetworkString("RadioToggle")

local citydelay
local radiodelay

--[[------------------------------------------------------------

	cityvoice

------------------------------------------------------------]]--
local notify = DarkRP.notify -- ИЗМЕНЕНО 06.02.2022
local ceil = math.ceil
DarkRP.defineChatCommand("cityvoice", function(ply, args)
	-- job
	if ply:Team() ~= TEAM_MPF16 then
		notify(ply, 0, 4, "Эта команда только для OWD")
		return ""
	end

	local curtime = CurTime()

	-- PhraseDelay
	if PhraseDelay and PhraseDelay > curtime then
		notify(ply, 0, 4, "Подождите " .. ceil(PhraseDelay - curtime) .. " секунд")
		return ""
	end

	-- citydelay
	if citydelay and citydelay > curtime then
		notify(ply, 0, 5, "Вы можете воспользоваться этим через " .. ceil(citydelay - curtime) .. " секунд")
		return ""
	end

	-- phrase
	local phrase = tonumber(args)

	if not phrase or not DarkRP.GetCityPhrases()[phrase] then
		notify(ply, 0, 4, "Вы должны написать номер сообщения")
		return ""
	end

	-- cityphrase
	PhraseDelay = curtime + 20
	citydelay = curtime + 300

	net.Start("CityVoice")
	-- net.WriteUInt(1, 3)
	net.WriteUInt(phrase, 5)
	net.Broadcast()

	return ""
end)

--[[------------------------------------------------------------

	radiovoice

------------------------------------------------------------]]--
DarkRP.defineChatCommand("radiovoice", function(ply, args)
	-- job
	if ply:Team() ~= TEAM_MPF16 then
		notify(ply, 0, 4, "Эта команда только для OWD")
		return ""
	end

	local curtime = CurTime()

	-- PhraseDelay
	if PhraseDelay and PhraseDelay > curtime then
		notify(ply, 0, 4, "Подождите " .. ceil(PhraseDelay - curtime) .. " секунд")
		return ""
	end

	-- radiodelay
	if radiodelay and radiodelay > curtime then
		notify(ply, 0, 5, "Вы можете воспользоваться этим через " .. ceil(radiodelay - curtime) .. " секунд")
		return ""
	end

	-- phrase
	local phrase = tonumber(args)

	if not phrase or not DarkRP.GetRadioPhrases()[phrase] then
		notify(ply, 0, 4, "Вы должны написать номер сообщения")
		return ""
	end

	-- radiophrase
	PhraseDelay = curtime + 20
	radiodelay = curtime + 40

	net.Start("RadioVoice")
	-- net.WriteUInt(2, 4)
	net.WriteUInt(phrase, 5)
	net.Broadcast()

	return ""
end)

--[[------------------------------------------------------------

	radiotoggle

------------------------------------------------------------]]--

local notify = DarkRP.notify
local ceil = math.ceil
local formatMoney = DarkRP.formatMoney
local findPlayer = DarkRP.findPlayer
DarkRP.defineChatCommand("radiotoggle", function(ply, args)
	-- jobs
	local jobs = ply:IsCombine()

	if not jobs then
		notify(ply, 0, 5, "Вы не можете выключить рацию")
		return ""
	end

	-- target
	local target = findPlayer(args)

	if not target then
		notify(ply, 0, 4, "Игрок не был найден")
		return ""
	end

	if not target:IsCombine() then
		notify(ply, 0, 4, "Вы не можете выдать премию человеку с этой работой")
		return ""
	end

	net.Start("RadioToggle")
	-- net.WriteUInt(2, 4)
	net.Send(target)
	return ""
end)

--[[------------------------------------------------------------

	radiotoggleall

------------------------------------------------------------]]--


DarkRP.defineChatCommand("radiotoggleall", function(ply, args)

    for k, v in ipairs(player.GetAll()) do

		if not v:IsCombine() then continue end

        net.Start("RadioToggle")
        net.Send(v)
	end

	return ""
end)