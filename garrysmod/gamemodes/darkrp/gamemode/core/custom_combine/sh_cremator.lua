local cremator = {
	["models/retrime/orange/other/cremator_01.mdl"] = true
}

hook.Add("SetupMove", "retrime.Cremator", function(ply, mvd, cmd)
	if cremator[ply:GetModel()] then
		if mvd:KeyDown(IN_JUMP) then
			mvd:SetButtons(bit.band(mvd:GetButtons(), bit.bnot(IN_JUMP)))
		end

		if mvd:KeyDown(IN_DUCK) then
			mvd:SetButtons(bit.band(mvd:GetButtons(), bit.bnot(IN_DUCK)))
		end

		if mvd:GetSideSpeed() ~= 0 then
			mvd:SetSideSpeed(0)
		end

		if mvd:GetForwardSpeed() < 0 then
			mvd:SetForwardSpeed(0)
		end
	end
end)