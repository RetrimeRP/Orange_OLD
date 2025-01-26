net.Receive("CityVoice", function()

	local phrase = DarkRP.GetCityPhrases()[net.ReadUInt(4)]

	if phrase then
		if LocalPlayer():GetPos():DistToSqr(Vector(-2176, -512, 0)) > 90000000 then return end

		LocalPlayer():EmitSound(phrase.sound)
		chat.AddText(Color(51, 204, 204), "[ДИСПЕТЧЕР] ", Color(255, 255, 255), phrase.text)
	end

end)

net.Receive("RadioVoice", function()

	local phrase = DarkRP.GetRadioPhrases()[net.ReadUInt(5)]

	if phrase then
		local duration = SoundDuration(phrase.sound) + 0.7

		if (phrase.mpf and LocalPlayer():IsMPF()) or (not phrase.mpf and LocalPlayer():IsCombine()) then
			-- step 1
			LocalPlayer():EmitSound("npc/metropolice/vo/on" .. math.random(1, 2) .. ".wav")

			-- step 2
			timer.Simple(0.35, function() if IsValid(LocalPlayer()) then LocalPlayer():EmitSound(phrase.sound) end end)

			-- step 3
			timer.Simple(duration, function() if IsValid(LocalPlayer()) then LocalPlayer():EmitSound("npc/metropolice/vo/off" .. math.random(1, 4) .. ".wav") end end)

			-- step 4
			chat.AddText(Color(51, 204, 204), "[ДИСПЕТЧЕР] ", Color(255, 255, 255), phrase.text)
		else
			for k, v in ipairs(player.GetAll()) do
				if not v:IsMPF() then continue end
				if LocalPlayer():GetPos():DistToSqr(v:GetPos()) > 65536 then continue end

				-- step 1
				v:EmitSound("npc/metropolice/vo/on" .. math.random(1, 2) .. ".wav")

				-- step 2
				timer.Simple(0.35, function() if IsValid(v) then v:EmitSound(phrase.sound) end end)

				-- step 3
				timer.Simple(duration, function() if IsValid(v) then v:EmitSound("npc/metropolice/vo/off" .. math.random(1, 4) .. ".wav") end end)

				-- step 4
				chat.AddText(Color(51, 204, 204), "[ДИСПЕТЧЕР] ", Color(230, 230, 230), phrase.text)
				break
			end
		end
	end

end)

net.Receive("StartLockdown", function()

	LocalPlayer():EmitSound("retrime/cityvoice/f_trainstation_assemble_spkr.wav")
	chat.AddText(Color(51, 204, 204), "[ДИСПЕТЧЕР] ", Color(255, 255, 255), "Вниманию гражданам! Производится проверка идентификации. Занять назначенные для инспекции места.")

end)

net.Receive("StartYellowCode", function()

	LocalPlayer():EmitSound("retrime/cityvoice/f_unrestprocedure1_spkr.wav")
	chat.AddText(Color(51, 204, 204), "[ДИСПЕТЧЕР] ", Color(255, 255, 255), "Граждане, введен код действия при беспорядках. Код: обезвредить, защитить, усмирить. Код: подавить, меч, стерилизовать.")

end)

net.Receive("StartRedCode", function()

	LocalPlayer():EmitSound("retrime/cityvoice/f_protectionresponse_5_spkr.wav")
	chat.AddText(Color(51, 204, 204), "[ДИСПЕТЧЕР] ", Color(255, 255, 255), "Вниманию всех наземных сил: судебное разбирательство отменено. Смертная казнь - по усмотрению.")

end)

net.Receive("RadioToggle", function()

	GetConVar("radio_enabled_voice"):SetInt(0)
	LocalPlayer():EmitSound("npc/metropolice/vo/off" .. math.random(1, 4) .. ".wav")

end)