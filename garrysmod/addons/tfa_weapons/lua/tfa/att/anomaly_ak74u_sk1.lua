if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Камуфлированный АКС-74У" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_ak74u_sk1.png"
ATTACHMENT.ShortName = "Камуфлированный АКС-74У"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak74u/wpn_aksu_sk1",
	[2]	= "models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk3",
	}, 
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak74u/wpn_aksu_sk1",
	[3]	= "models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk3",
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

