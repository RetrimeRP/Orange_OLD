function GM:CanTool(ply, trace, mode, tool, button)
	local entity = trace.Entity

	if not entity:IsValid() then
		return true
	end

	local owner = entity:CPPIGetOwner() or entity.FPPOwner

	if IsValid(owner) then
		if entity:GetRenderMode() == RENDERMODE_TRANSALPHA then
			return false
		end

		if ply == owner then
			return true
		end

		if ply:Team() ~= TEAM_FSG then
			return false
		end

		-- if not retrime.CanPlayerTarget(client, owner) then
		-- 	return false
		-- end

		return true
	end

	return false
end