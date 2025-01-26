if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Камуфлированный АК-103" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_ak103_sk1.png"
ATTACHMENT.ShortName = "Камуфлированный АК-103"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_mag_camog",
	[2]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_mag_a_camog",
	[3]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_grips_camog",
	[4]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_body_camog",
	}, 
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_body_camog",
	[2]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_grips_camog",
	[3]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_mag_camog",
	[4]	= "models/flaymi/stalker/anomaly/skins/ak103/wpn_ak103_mag_a_camog",
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

