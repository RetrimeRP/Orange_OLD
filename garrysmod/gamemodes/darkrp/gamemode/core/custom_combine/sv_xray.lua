local xray

hook.Add("OnPlayerChangedTeam", "retrime.XRAY", function(ply, old, new)
	if old == TEAM_OTA3 then
		xray = nil
	end

	if new == TEAM_OTA3 then
		xray = ply
	end
end)

local timer = timer
local min = math.min
local random = math.random
local bass = Sound("common/bass.wav")
timer.Create("retrime.XRAY", 5, 0, function()
	if xray and IsValid(xray) and xray:Alive() and xray:Team() == TEAM_OTA3 then
		local healed = false

		-- xray
		for k, v in ipairs(ents.FindInSphere(xray:GetPos(), 128)) do
			if not IsValid(v) or not v:IsPlayer() or not v:Alive() or (not v:IsOTA() and not v:IsGuardian()) then continue end

			-- health, maxhealth
			local health = v:Health()
			local maxhealth = v:GetMaxHealth()

			-- health
			if health < maxhealth then
				v:SetHealth(min(maxhealth, health + random(5, 13)))

				-- healed
				if not healed then
					healed = true
				end
			end

			-- armor, maxarmor
			local armor = v:Armor()
			local maxarmor = v:GetMaxArmor()

			-- armor
			if armor < maxarmor then
				v:SetArmor(min(maxarmor, armor + random(5, 10)))

				-- healed
				if not healed then
					healed = true
				end
			end
		end

		-- healed
		if healed then
			xray:EmitSound(bass, 65)

			local effect = EffectData()
			effect:SetEntity(xray)
			effect:SetOrigin(xray:GetPos())

			util.Effect("VortDispel", effect)
		end
	end
end)

local xrayg

hook.Add("OnPlayerChangedTeam", "retrime.XRAYG", function(ply, old, new)
	if old == TEAM_GUARDIAN2 then
		xrayg = nil
	end

	if new == TEAM_GUARDIAN2 then
		xrayg = ply
	end
end)

timer.Create("retrime.XRAYG", 5, 0, function()
	if xrayg and IsValid(xrayg) and xrayg:Alive() and xrayg:Team() == TEAM_GUARDIAN2 then
		local healed = false

		-- xrayg
		for k, v in ipairs(ents.FindInSphere(xrayg:GetPos(), 128)) do
			if not IsValid(v) or not v:IsPlayer() or not v:Alive() or (not v:IsOTA() and not v:IsGuardian()) then continue end

			-- health, maxhealth
			local health = v:Health()
			local maxhealth = v:GetMaxHealth()

			-- health
			if health < maxhealth then
				v:SetHealth(min(maxhealth, health + random(5, 13)))

				-- healed
				if not healed then
					healed = true
				end
			end

			-- armor, maxarmor
			local armor = v:Armor()
			local maxarmor = v:GetMaxArmor()

			-- armor
			if armor < maxarmor then
				v:SetArmor(min(maxarmor, armor + random(5, 10)))

				-- healed
				if not healed then
					healed = true
				end
			end
		end

		-- healed
		if healed then
			xrayg:EmitSound(bass, 65)

			local effect = EffectData()
			effect:SetEntity(xrayg)
			effect:SetOrigin(xrayg:GetPos())

			util.Effect("VortDispel", effect)
		end
	end
end)