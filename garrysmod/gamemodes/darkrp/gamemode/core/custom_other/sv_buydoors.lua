hook.Add("playerBuyDoor", "retrime.BuyDoors", function(ply)
	local job = ply:Team()

	if job == TEAM_ARRIVAL then
		return false, "Прибывший не может покупать двери"
	end

	if ply:IsCombine() then
		return false, "Альянс не может покупать двери"
	end
end)