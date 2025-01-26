--[[------------------------------------------------------------

	KillReward

------------------------------------------------------------]]--
local math = math
hook.Add("PlayerDeath", "retrime.KillReward", function(ply, wep, ent)
	if ent:IsPlayer() then
		local job1 = ply:Team()
		local job2 = ent:Team()

		if ply:IsCombine() and ent:IsResistance() then
			local money = math.random(300, 1500)

			ent:addMoney(money)
			DarkRP.notify(ent, 0, 4, "Вы получили " .. DarkRP.formatMoney(money) .. " за убийство противника")
		elseif ent:IsCombine() and ply:IsResistance() then
			local money = math.random(300, 1000)

			ent:addMoney(money)
			DarkRP.notify(ent, 0, 4, "Вы получили " .. DarkRP.formatMoney(money) .. " за убийство противника")
		elseif ent:IsCombine() and ply:IsGuild() then
			local money = math.random(300, 1000)

			ent:addMoney(money)
			DarkRP.notify(ent, 0, 4, "Вы получили " .. DarkRP.formatMoney(money) .. " за убийство противника")
		elseif ply:IsCombine() and ent:IsGuild() then
			local money = math.random(300, 1000)

			ent:addMoney(money)
			DarkRP.notify(ent, 0, 4, "Вы получили " .. DarkRP.formatMoney(money) .. " за убийство противника")
		end
	end
end)