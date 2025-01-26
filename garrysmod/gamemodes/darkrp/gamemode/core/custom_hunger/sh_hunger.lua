local hungerjobs

hook.Add("DarkRPFinishedLoading", "DarkRP_HungerJobs", function()

	hungerjobs = {}
	hungerjobs[TEAM_MPF6] = true
	hungerjobs[TEAM_MPF7] = true
	hungerjobs[TEAM_MPF8] = true
	hungerjobs[TEAM_MPF9] = true
	hungerjobs[TEAM_MPF10] = true
	hungerjobs[TEAM_MPF11] = true
	hungerjobs[TEAM_MPF12] = true
	hungerjobs[TEAM_MPF13] = true
	hungerjobs[TEAM_MPF14] = true
	hungerjobs[TEAM_MPF15] = true
	hungerjobs[TEAM_ITZTOMBER] = true
	hungerjobs[TEAM_OTA1] = true
	hungerjobs[TEAM_OTA2] = true
	hungerjobs[TEAM_OTA3] = true
	hungerjobs[TEAM_OTA4] = true
	hungerjobs[TEAM_OTA5] = true
	hungerjobs[TEAM_OTA6] = true
	hungerjobs[TEAM_OTA7] = true
	hungerjobs[TEAM_OTA8] = true
	hungerjobs[TEAM_OTA9] = true
	hungerjobs[TEAM_OTA10] = true
	hungerjobs[TEAM_SYNTH1] = true
	hungerjobs[TEAM_RESISTANCE5] = true
	hungerjobs[TEAM_RESISTANCE9] = true
	hungerjobs[TEAM_HECU5] = true
	hungerjobs[TEAM_HECU6] = true
	hungerjobs[TEAM_GMAN] = true
	hungerjobs[TEAM_ARRIVAL] = true
	hungerjobs[TEAM_GUARDIAN1] = true
	hungerjobs[TEAM_GUARDIAN2] = true
	hungerjobs[TEAM_GUARDIAN3] = true
	hungerjobs[TEAM_GUARDIAN4] = true
	hungerjobs[TEAM_GUARDIAN5] = true
	hungerjobs[TEAM_GUARDIAN6] = true
	hungerjobs[TEAM_FSG] = true

end)

function DarkRP.GetHungerJobs()

	return hungerjobs

end

DarkRP.DARKRP_LOADING = true

DarkRP.registerDarkRPVar("Hunger", net.WriteFloat, net.ReadFloat)

DarkRP.DARKRP_LOADING = nil