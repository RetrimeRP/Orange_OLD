local firejobs

hook.Add("DarkRPFinishedLoading", "DarkRP_FireJobs", function()

	firejobs = {
		[TEAM_MPF15] = {
			[TEAM_MPF1] = true,
			[TEAM_MPF2] = true,
			[TEAM_MPF3] = true,
			[TEAM_MPF4] = true,
			[TEAM_MPF5] = true,
			[TEAM_MPF6] = true,
			[TEAM_MPF7] = true,
			[TEAM_MPF8] = true,
			[TEAM_MPF9] = true,
			[TEAM_MPF10] = true,
			[TEAM_MPF11] = true,
			[TEAM_MPF12] = true,
			[TEAM_MPF13] = true,
			[TEAM_MPF14] = true,
			[TEAM_MPF16] = true,
			[TEAM_OTA1] = true,
			[TEAM_OTA2] = true,
			[TEAM_OTA3] = true,
			[TEAM_OTA4] = true,
			[TEAM_OTA5] = true,
			[TEAM_OTA7] = true,
			[TEAM_OTA8] = true,
			[TEAM_OTA9] = true,
			[TEAM_OTA10] = true
		},
		[TEAM_MPF14] = {
			[TEAM_MPF1] = true,
			[TEAM_MPF2] = true,
			[TEAM_MPF3] = true,
			[TEAM_MPF4] = true,
			[TEAM_MPF5] = true,
			[TEAM_MPF6] = true,
			[TEAM_MPF7] = true,
			[TEAM_MPF8] = true,
			[TEAM_MPF9] = true,
			[TEAM_MPF10] = true,
			[TEAM_MPF11] = true,
			[TEAM_MPF12] = true,
			[TEAM_MPF13] = true,
			[TEAM_MPF16] = true,
			[TEAM_OTA1] = true,
			[TEAM_OTA2] = true,
			[TEAM_OTA3] = true,
			[TEAM_OTA4] = true,
			[TEAM_OTA5] = true,
			[TEAM_OTA7] = true,
			[TEAM_OTA8] = true,
			[TEAM_OTA9] = true,
			[TEAM_OTA10] = true
		},
		[TEAM_MPF13] = {
			[TEAM_MPF1] = true,
			[TEAM_MPF2] = true,
			[TEAM_MPF3] = true,
			[TEAM_MPF4] = true,
			[TEAM_MPF5] = true,
			[TEAM_MPF6] = true,
			[TEAM_MPF7] = true,
			[TEAM_MPF8] = true,
			[TEAM_MPF9] = true,
			[TEAM_MPF10] = true,
			[TEAM_MPF11] = true,
			[TEAM_MPF12] = true,
			[TEAM_MPF16] = true,
			[TEAM_OTA1] = true,
			[TEAM_OTA2] = true,
			[TEAM_OTA3] = true,
			[TEAM_OTA4] = true,
			[TEAM_OTA5] = true,
			[TEAM_OTA7] = true,
			[TEAM_OTA8] = true,
			[TEAM_OTA9] = true,
			[TEAM_OTA10] = true
		},
		[TEAM_MPF12] = {
			[TEAM_MPF1] = true,
			[TEAM_MPF2] = true,
			[TEAM_MPF3] = true,
			[TEAM_MPF4] = true,
			[TEAM_MPF5] = true,
			[TEAM_MPF6] = true,
			[TEAM_MPF7] = true,
			[TEAM_MPF8] = true,
			[TEAM_MPF9] = true,
			[TEAM_MPF10] = true,
			[TEAM_MPF11] = true
		},
		[TEAM_OTA6] = {
			[TEAM_MPF1] = true,
			[TEAM_MPF2] = true,
			[TEAM_MPF3] = true,
			[TEAM_MPF4] = true,
			[TEAM_MPF5] = true,
			[TEAM_MPF6] = true,
			[TEAM_MPF7] = true,
			[TEAM_MPF8] = true,
			[TEAM_MPF9] = true,
			[TEAM_MPF10] = true,
			[TEAM_MPF11] = true,
			[TEAM_MPF12] = true,
			[TEAM_MPF13] = true,
			[TEAM_MPF14] = true,
			[TEAM_MPF15] = true,
			[TEAM_MPF16] = true,
			[TEAM_OTA1] = true,
			[TEAM_OTA2] = true,
			[TEAM_OTA3] = true,
			[TEAM_OTA4] = true,
			[TEAM_OTA5] = true,
			[TEAM_OTA7] = true,
			[TEAM_OTA8] = true,
			[TEAM_OTA9] = true,
			[TEAM_OTA10] = true,
			[TEAM_ADMIN] = true
		},
		[TEAM_OTA10] = {
			[TEAM_OTA1] = true,
			[TEAM_OTA2] = true,
			[TEAM_OTA3] = true,
			[TEAM_OTA4] = true,
			[TEAM_OTA5] = true,
			[TEAM_OTA7] = true,
			[TEAM_OTA8] = true,
			[TEAM_OTA9] = true
		},
		[TEAM_RESISTANCE5] = {
			[TEAM_RESISTANCE1] = true,
			[TEAM_RESISTANCE2] = true,
			[TEAM_RESISTANCE3] = true,
			[TEAM_RESISTANCE4] = true,
			[TEAM_RESISTANCE6] = true,
			[TEAM_RESISTANCE7] = true,
			[TEAM_RESISTANCE8] = true,
			[TEAM_RESISTANCE9] = true
		},
		[TEAM_RESISTANCE4] = {
			[TEAM_RESISTANCE1] = true,
			[TEAM_RESISTANCE2] = true,
			[TEAM_RESISTANCE3] = true,
			[TEAM_RESISTANCE6] = true,
			[TEAM_RESISTANCE7] = true,
			[TEAM_RESISTANCE8] = true,
			[TEAM_RESISTANCE9] = true
		},
		[TEAM_HECU5] = {
			[TEAM_HECU1] = true,
			[TEAM_HECU2] = true,
			[TEAM_HECU3] = true,
			[TEAM_HECU4] = true,
			[TEAM_HECU6] = true,
			[TEAM_HECU7] = true
		},
		[TEAM_HECU4] = {
			[TEAM_HECU1] = true,
			[TEAM_HECU2] = true,
			[TEAM_HECU3] = true,
			[TEAM_HECU6] = true,
			[TEAM_HECU7] = true
		},
		[TEAM_HECU6] = {
			[TEAM_HECU1] = true,
			[TEAM_HECU2] = true,
			[TEAM_HECU3] = true,
			[TEAM_HECU7] = true
		},
		[TEAM_CWU6] = {
			[TEAM_CWU1] = true,
			[TEAM_CWU2] = true,
			[TEAM_CWU3] = true,
			[TEAM_CWU4] = true,
			[TEAM_CWU5] = true,
			[TEAM_CWU7] = true
		},
		[TEAM_LOYALIST3] = {
			[TEAM_LOYALIST1] = true,
			[TEAM_LOYALIST2] = true
		},
		[TEAM_ADMIN] = {
			[TEAM_CWU1] = true,
			[TEAM_CWU2] = true,
			[TEAM_CWU3] = true,
			[TEAM_CWU4] = true,
			[TEAM_CWU5] = true,
			[TEAM_CWU6] = true,
			[TEAM_LOYALIST3] = true,
			[TEAM_LOYALIST1] = true,
			[TEAM_LOYALIST2] = true
		}
	}

end)

function DarkRP.GetFireJobs()

	return firejobs

end