local radio_enabled = CreateClientConVar("radio_enabled", "1", false, true)
local radio_enabled_voice = CreateClientConVar("radio_enabled_voice", "0", false, true)

hook.Add("PlayerStartVoice", "DarkRP_StartRadio", function(ply)

	if LocalPlayer() ~= ply then return end
	if radio_enabled_voice:GetInt() == 0 then return end

	if ply:IsMPF() then
		ply:EmitSound("npc/metropolice/vo/on" .. math.random(1, 2) .. ".wav")
	elseif ply:IsOTA() then
		ply:EmitSound("npc/combine_soldier/vo/on" .. math.random(1, 2) .. ".wav")
	elseif ply:IsResistance() or ply:IsGuild() then
		ply:EmitSound("npc/metropolice/vo/on" .. math.random(1, 2) .. ".wav")
	end

end)

hook.Add("PlayerEndVoice", "DarkRP_EndRadio", function(ply)

	if LocalPlayer() ~= ply then return end
	if radio_enabled_voice:GetInt() == 0 then return end

	if ply:IsMPF() then
		ply:EmitSound("npc/metropolice/vo/off" .. math.random(1, 4) .. ".wav")
	elseif ply:IsOTA() then
		ply:EmitSound("npc/combine_soldier/vo/off" .. math.random(1, 3) .. ".wav")
	elseif ply:IsResistance() or ply:IsGuild() then
		ply:EmitSound("npc/metropolice/vo/off" .. math.random(1, 4) .. ".wav")
	end

end)