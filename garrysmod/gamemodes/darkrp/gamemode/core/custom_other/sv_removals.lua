local removals = {}

--[[------------------------------------------------------------

	removals

------------------------------------------------------------]]--
-- for k, v in ipairs(RPExtraTeams) do
-- 	if v.mpf or v.ota then
-- 		removals[k] = true
-- 	end
-- end

--[[------------------------------------------------------------

	OnPlayerChangedTeam

------------------------------------------------------------]]--
local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
hook.Add("OnPlayerChangedTeam", "retrime.Removals", function(ply, old, new)
	for k, v in ipairs(ents.FindByClass("darkrp_printer_*")) do
		if v:Getowning_ent() == ply then
			v:Remove()
		end
	end

	for k, v in ipairs(RPExtraTeams) do
		if ply:IsMPF() or ply:IsOTA() then
			removals[k] = true
		end
	end

	-- removals
	if removals[old] or removals[new] then
		ply:ConCommand("gmod_cleanup")
		ply:ConCommand("darkrp unownalldoors")
		notify(ply, 0, 4, "Вам сбросили ваши пропы, двери и энтити")
	end
end)

--[[------------------------------------------------------------

	PlayerDisconnected

------------------------------------------------------------]]--
hook.Add("PlayerDisconnected", "retrime.Removals", function(ply)
	for k, v in ipairs(ents.FindByClass("darkrp_printer_04")) do
		if v:Getowning_ent() == ply then
			v:Remove()
		end
	end

	for _, ent in ipairs(ents.FindByClass("darkrp_turret_*")) do
		if ent:CPPIGetOwner() == ply then
			ent:Remove()
		end
	end

	--cleanup.CC_Cleanup(ply, nil, {})

end)