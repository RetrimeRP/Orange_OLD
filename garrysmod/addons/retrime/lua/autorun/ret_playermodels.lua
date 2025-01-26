local function AddPlayerModel(name, model, hands, hands_skin, hands_bodygroups)

	list.Set("PlayerOptionsModel", name, model)
	player_manager.AddValidModel(name, model)

	if hands then
		player_manager.AddValidHands(name, hands, hands_skin, hands_bodygroups)
	end

end

AddPlayerModel("apex", "models/retrime/metropolice/apex.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")
AddPlayerModel("dvl", "models/retrime/metropolice/dvl.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")
AddPlayerModel("epu", "models/retrime/metropolice/epu.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")
AddPlayerModel("grid", "models/retrime/metropolice/grid.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")
AddPlayerModel("helix", "models/retrime/metropolice/helix.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")
AddPlayerModel("jury", "models/retrime/metropolice/jury.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")
AddPlayerModel("maid", "models/retrime/metropolice/maid.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")
AddPlayerModel("ofc", "models/retrime/metropolice/ofc.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")
AddPlayerModel("owd", "models/retrime/metropolice/owd.mdl", "models/retrime/metropolice/hands/v_owd.mdl", 0, "000000")
AddPlayerModel("rct", "models/retrime/metropolice/rct.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")
AddPlayerModel("sec", "models/retrime/metropolice/sec.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")
AddPlayerModel("union", "models/retrime/metropolice/union.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")

AddPlayerModel("secutor", "models/retrime/metropolice/secutor.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0, "000000")

AddPlayerModel("assassin", "models/retrime/overwatch/assassin.mdl", "models/retrime/overwatch/hands/v_assassin.mdl", 0 , "000000")
AddPlayerModel("echo", "models/retrime/overwatch/echo.mdl", "models/weapons/c_arms_combine.mdl", 0 , "000000")
AddPlayerModel("heavy", "models/retrime/overwatch/heavy.mdl", "models/retrime/overwatch/hands/v_heavy.mdl", 0 , "000000")
AddPlayerModel("king", "models/retrime/overwatch/king.mdl", "models/retrime/overwatch/hands/v_king.mdl", 0 , "000000")
AddPlayerModel("knight", "models/retrime/overwatch/knight.mdl", "models/retrime/overwatch/hands/v_knight.mdl", 0 , "000000")
AddPlayerModel("mace", "models/retrime/overwatch/mace.mdl", "models/retrime/overwatch/hands/v_mace.mdl", 0 , "000000")
AddPlayerModel("riot", "models/retrime/overwatch/riot.mdl", "models/retrime/overwatch/hands/v_riot.mdl", 0 , "000000")
AddPlayerModel("sow", "models/retrime/overwatch/sow.mdl", "models/retrime/overwatch/hands/v_sow.mdl", 0 , "000000")
AddPlayerModel("xray", "models/retrime/overwatch/xray.mdl", "models/retrime/overwatch/hands/v_xray.mdl", 0 , "000000")
AddPlayerModel("ordinal", "models/retrime/overwatch/ordinal.mdl", "models/retrime/metropolice/hands/v_metropolice.mdl", 0 , "000000")

AddPlayerModel("hevsuit", "models/retrime/hevsuit.mdl", "models/retrime/hands/v_hevsuit.mdl", 0, "000000")
AddPlayerModel("vortigaunt", "models/retrime/vortigaunt.mdl", "models/retrime/hands/v_vortigaunt.mdl", 0, "000000")

AddPlayerModel("hecu_01", "models/retrime/hecu/hecu_01.mdl", "models/weapons/c_arms_cstrike.mdl", 0 , "000000")
AddPlayerModel("hecu_02", "models/retrime/hecu/hecu_02.mdl", "models/weapons/c_arms_cstrike.mdl", 0 , "000000")
AddPlayerModel("hecu_03", "models/retrime/hecu/hecu_03.mdl", "models/weapons/c_arms_cstrike.mdl", 0 , "000000")
AddPlayerModel("hecu_04", "models/retrime/hecu/hecu_04.mdl", "models/weapons/c_arms_cstrike.mdl", 0 , "000000")
AddPlayerModel("hecu_05", "models/retrime/hecu/hecu_05.mdl", "models/weapons/c_arms_cstrike.mdl", 0 , "000000")
AddPlayerModel("hecu_06", "models/retrime/hecu/hecu_06.mdl", "models/weapons/c_arms_cstrike.mdl", 0 , "000000")

AddPlayerModel("worker_01", "models/retrime/worker_01.mdl")
AddPlayerModel("worker_02", "models/retrime/worker_02.mdl")

AddPlayerModel("administrator", "models/retrime/administrator.mdl")
AddPlayerModel("loyalist_01", "models/retrime/group01l/male_01.mdl")
AddPlayerModel("loyalist_02", "models/retrime/group01l/male_02.mdl")
AddPlayerModel("loyalist_03", "models/retrime/group01l/male_03.mdl")
AddPlayerModel("loyalist_04", "models/retrime/group01l/male_04.mdl")
AddPlayerModel("loyalist_05", "models/retrime/group01l/male_05.mdl")
AddPlayerModel("loyalist_06", "models/retrime/group01l/male_06.mdl")
AddPlayerModel("loyalist_07", "models/retrime/group01l/male_07.mdl")
AddPlayerModel("loyalist_08", "models/retrime/group01l/male_08.mdl")
AddPlayerModel("loyalist_09", "models/retrime/group01l/male_09.mdl")

AddPlayerModel("bandit_01", "models/retrime/group02b/male_01.mdl")
AddPlayerModel("bandit_02", "models/retrime/group02b/male_02.mdl")
AddPlayerModel("bandit_03", "models/retrime/group02b/male_03.mdl")
AddPlayerModel("bandit_04", "models/retrime/group02b/male_04.mdl")
AddPlayerModel("bandit_05", "models/retrime/group02b/male_05.mdl")

AddPlayerModel("guild_01", "models/retrime/guild/guild_01.mdl", "models/retrime/guild/hands/v_guild.mdl", 0, "000000")
AddPlayerModel("guild_02", "models/retrime/guild/guild_02.mdl", "models/retrime/guild/hands/v_guild.mdl", 0, "000000")
AddPlayerModel("guild_03", "models/retrime/guild/guild_03.mdl", "models/retrime/guild/hands/v_guild.mdl", 0, "000000")
AddPlayerModel("guild_04", "models/retrime/guild/guild_04.mdl", "models/retrime/guild/hands/v_guild.mdl", 0, "000000")
AddPlayerModel("guild_05", "models/retrime/guild/guild_05.mdl", "models/retrime/guild/hands/v_guild.mdl", 0, "000000")
AddPlayerModel("guild_06", "models/retrime/guild/guild_06.mdl", "models/retrime/guild/hands/v_leader.mdl", 0, "000000")
AddPlayerModel("guild_07", "models/retrime/guild/guild_07.mdl", "models/retrime/guild/hands/v_assasin.mdl", 0, "000000")
AddPlayerModel("guild_08", "models/retrime/guild/guild_08.mdl", "models/retrime/guild/hands/v_tradesman.mdl", 0, "000000")
AddPlayerModel("guild_09", "models/retrime/guild/guild_09.mdl", "models/retrime/guild/hands/v_overseer.mdl", 0, "000000")
AddPlayerModel("guild_10", "models/retrime/guild/guild_10.mdl", "models/retrime/guild/hands/v_huntsman.mdl", 0, "000000")

AddPlayerModel("guardian_01", "models/com_night_elite.mdl")
AddPlayerModel("guardian_02", "models/player/com_night_elite_prisonguard.mdl")
AddPlayerModel("guardian_03", "models/com_night_elite.mdl")
AddPlayerModel("guardian_04", "models/com_super_night_elite.mdl")

AddPlayerModel("dod_01", "models/retrime/dod/dod_01.mdl")
AddPlayerModel("dod_02", "models/retrime/dod/dod_02.mdl")
AddPlayerModel("dod_03", "models/retrime/dod/dod_03.mdl")
AddPlayerModel("dod_04", "models/retrime/dod/dod_04.mdl")
AddPlayerModel("dod_sniper", "models/retrime/dod/dod_sniper.mdl")
AddPlayerModel("dod_girl", "models/retrime/dod/dod_girl.mdl")

AddPlayerModel("staff", "models/retrime/staff.mdl")