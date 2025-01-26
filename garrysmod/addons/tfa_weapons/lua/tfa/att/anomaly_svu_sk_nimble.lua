if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "ОЦ-03 СВУ-A" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_svu_sk_nimble.png"
ATTACHMENT.ShortName = "ОЦ-03 СВУ-A"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble",
	},
	["VElements"] = {
		["ironsight_anomaly_svu_on"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble"
		},
		["ironsight_anomaly_svu_off"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble"
		},
	},
	["WElements"] = {
		["ironsight_anomaly_svu_on"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble"
		},
		["ironsight_anomaly_svu_off"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/svu/wpn_svu-a_nimble"
		},
	},
}


local function resetMatCache(att, wep)
	wep.MaterialCached = false
end

ATTACHMENT.Attach = resetMatCache
ATTACHMENT.Detach = resetMatCache

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end

