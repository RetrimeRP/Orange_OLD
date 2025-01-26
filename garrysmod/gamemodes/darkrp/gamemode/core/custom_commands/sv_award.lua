local delay = {}

local notify = DarkRP.notify
local ceil = math.ceil
local formatMoney = DarkRP.formatMoney
local findPlayer = DarkRP.findPlayer
DarkRP.defineChatCommand("award", function(ply, args)
	-- jobs
	local jobs = DarkRP.GetCashbonusJobs()[ply:Team()]

	if not jobs then
		notify(ply, 0, 5, "Вы не можете выдавать премии")
		return ""
	end

	-- target
	local target = findPlayer(args)

	if not target then
		notify(ply, 0, 4, "Игрок не был найден")
		return ""
	end

	-- disguise
	local disguise = target:getDarkRPVar("disguise")

	if disguise and jobs[disguise] then
		notify(target, 0, 5, "Вам попытались дать премию и ваша маскировка была раскрыта")
		notify(ply, 0, 4, "Ошибка... ЭТО ЖЕ ШПИОН!")
		return ""
	end

	-- job
	local job = target:Team()

	if not jobs[job] then
		notify(ply, 0, 4, "Вы не можете выдать премию человеку с этой работой")
		return ""
	end

	-- nextaward
	local steamid = target:SteamID()
	local nextaward = delay[steamid]
	local curtime = CurTime()

	if nextaward and nextaward > curtime then
		notify(ply, 0, 5, "Игрок сможет получить премию только через " .. ceil(nextaward - curtime) .. " секунд")
		return ""
	end

	delay[steamid] = curtime + 600

	-- award
	local money = (ply:IsCWU() and 10000) or 5000

	target:addMoney(money)

	notify(ply, 0, 6, "Вы выдали премию " .. target:Nick() .. " в размере " .. formatMoney(money))
	notify(target, 0, 6, "Вам выдал премию " .. ply:Nick() .. " в размере " .. formatMoney(money))
	return ""
end)

DarkRP.defineChatCommand("awardall", function(ply, args)
	-- jobs
	local jobs = DarkRP.GetCashbonusJobs()[ply:Team()]

	if not jobs then
		notify(ply, 0, 5, "Вы не можете выдавать премии")
		return ""
	end

	local totalplayers = 0
	local totalmoney = 0

	local curtime = CurTime()

	for k, v in ipairs(player.GetAll()) do
		local job = v:Team()

		if not jobs[job] then continue end

		-- nextaward
		local steamid = v:SteamID()
		local nextaward = delay[steamid]

		if nextaward and nextaward > curtime then continue end

		delay[steamid] = curtime + 600

		-- awardall
		local money = (ply:IsCWU() and 10000) or 5000

		v:addMoney(money)

		totalplayers = totalplayers + 1
		totalmoney = totalmoney + money

		notify(v, 0, 4, "Вам выдал премию " .. ply:Nick() .. " в размере " .. formatMoney(money))
	end

	notify(ply, 0, 5, (totalplayers > 0 and "Вы выдали премию " .. totalplayers .. " игрокам в размере " .. formatMoney(totalmoney) or "Вы никому не выдали премию"))
	return ""
end)