if SAM_LOADED then return end

local sam, command, language = sam, sam.command, sam.language

command.set_category("Fun")

do
	local jailroom_pos = {
		Vector(938, 9923, 1570),
		Vector(938, 9873, 1570),
		Vector(938, 10023, 1570),
		Vector(888, 9923, 1570),
		Vector(888, 9873, 1570),
		Vector(888, 10023, 1570),
		Vector(838, 9923, 1570),
		Vector(838, 9873, 1570),
		Vector(838, 10023, 1570)
	}

	local unjailroom = function(ply)
		if not IsValid(ply) then return end
		if not ply:sam_get_nwvar("jailroom") then return end

		ply.sam_jailroom = nil

		ply:sam_set_nwvar("jailroom", nil)
		ply:sam_set_exclusive(nil)

		ply:Spawn()

		timer.Remove("SAM.Unjailroom." .. ply:SteamID())
		timer.Remove("SAM.Jailroom.Watch." .. ply:SteamID())
	end

	local jailroom = function(ply, time)
		if not IsValid(ply) then return end
		if not isnumber(time) or time < 0 then
			time = 0
		end

		if ply:sam_get_nwvar("frozen") then
			RunConsoleCommand("sam", "unfreeze", "#" .. ply:EntIndex())
		end

		if not ply:sam_get_nwvar("jailroom") then
			ply:ExitVehicle()
			ply:SetMoveType(MOVETYPE_WALK)
			ply:SetPos(jailroom_pos[math.random(#jailroom_pos)])

			ply.sam_jailroom = true

			if ply:Team() ~= GAMEMODE.DefaultTeam then
				ply:changeTeam(GAMEMODE.DefaultTeam, true, true)
			end

			ply:sam_set_nwvar("jailroom", true)
			ply:sam_set_exclusive("in jailroom")
		end

		local steamid = ply:SteamID()

		if time == 0 then
			timer.Remove("SAM.Unjailroom." .. steamid)
		else
			timer.Create("SAM.Unjailroom." .. steamid, time, 1, function()
				if IsValid(ply) then
					unjailroom(ply)
				end
			end)
		end

		timer.Create("SAM.Jailroom.Watch." .. steamid, 0.5, 0, function()
			if not IsValid(ply) then
				return timer.Remove("SAM.Jailroom.Watch." .. steamid)
			end

			if ply:GetPos():DistToSqr(Vector(888, 9923, 1570)) > 1048576 then
				ply:SetPos(jailroom_pos[math.random(#jailroom_pos)])
			end
		end)
	end

	command.new("jailroom")
		:SetPermission("jailroom", "admin")

		:AddArg("player")
		:AddArg("length", {optional = true, default = 0, min = 0})
		:AddArg("text", {hint = "reason", optional = true, default = sam.language.get("default_reason")})

		:GetRestArgs()

		:Help(language.get("jail_help"))

		:OnExecute(function(ply, targets, length, reason)
			for i = 1, #targets do
				jailroom(targets[i], length * 60)
			end

			if sam.is_command_silent then return end
			sam.player.send_message(nil, "jail", {
				A = ply, T = targets, V = sam.format_length(length), V_2 = reason
			})
		end)
	:End()

	command.new("unjailroom")
		:SetPermission("unjailroom", "admin")

		:AddArg("player")

		:Help(language.get("unjail_help"))

		:OnExecute(function(ply, targets)
			for i = 1, #targets do
				unjailroom(targets[i])
			end

			if sam.is_command_silent then return end
			sam.player.send_message(nil, "unjail", {
				A = ply, T = targets
			})
		end)
	:End()

	if SERVER then
		hook.Add("PlayerSpawn", "SAM.Jailroom", function(ply)
			if ply:sam_get_nwvar("jailroom") or ply:sam_get_pdata("jailroom") then
				if ply.sam_jailroom then
					ply:SetPos(jailroom_pos[math.random(#jailroom_pos)])
				else
					ply:SetPos(jailroom_pos[math.random(#jailroom_pos)])
					jailroom(ply, ply:sam_get_pdata("jailroom_time_left"))

					ply:sam_set_pdata("jailroom", nil)
					ply:sam_set_pdata("jailroom_time_left", nil)
				end
			end
		end)

		hook.Add("PlayerEnteredVehicle", "SAM.Jailroom", function(ply)
			if ply:sam_get_nwvar("jailroom") then
				ply:ExitVehicle()
			end
		end)

		hook.Add("PlayerDisconnected", "SAM.Jailroom", function(ply)
			if ply:sam_get_nwvar("jailroom") then
				ply:sam_set_pdata("jailroom", true)
				ply:sam_set_pdata("jailroom_time_left", timer.TimeLeft("SAM.Unjailroom." .. ply:SteamID()) or 0)

				timer.Remove("SAM.Unjailroom." .. ply:SteamID())
				timer.Remove("SAM.Jailroom.Watch." .. ply:SteamID())
			end
		end)
	end

	local disallow = function(ply)
		if ply:sam_get_nwvar("jailroom") then
			return false
		end
	end

	for _, v in ipairs({"PlayerNoClip", "SAM.CanPlayerSpawn", "CanPlayerEnterVehicle", "CanPlayerSuicide", "CanTool"}) do
		hook.Add(v, "SAM.Jail", disallow)
	end
end