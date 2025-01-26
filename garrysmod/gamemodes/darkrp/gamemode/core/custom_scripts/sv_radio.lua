local function compareFactions(ply1, ply2)
	if (ply1:IsMPF() and ply2:IsMPF()) or (ply1:IsOTA() and ply2:IsOTA()) or (ply1:IsResistance() and ply2:IsResistance()) or (ply1:IsGuild() and ply2:IsGuild()) then
		return true, false
	end
end

hook.Add('PlayerCanHearPlayersVoice', 'combine_only', function(lis, talker)
	local lis_radio = lis:GetInfo("radio_enabled", "1")
	local talker_voice = talker:GetInfo("radio_enabled_voice", "0")

	if (compareFactions(lis, talker) and (lis_radio == "1" and talker_voice == "1")) then -- or (lis:GetPos():DistToSqr(talker:GetPos()) < 250000)
		return true, false
	end
end)