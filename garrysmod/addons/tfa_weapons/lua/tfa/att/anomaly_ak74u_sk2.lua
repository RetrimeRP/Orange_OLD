if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Заказной АКС-74У" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_ak74u_sk2.png"
ATTACHMENT.ShortName = "Заказной АКС-74У"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak74u/wpn_aksu_sk2",
	[2]	= "models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk2",
	}, 
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak74u/wpn_aksu_sk2",
	[3]	= "models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk2",
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

