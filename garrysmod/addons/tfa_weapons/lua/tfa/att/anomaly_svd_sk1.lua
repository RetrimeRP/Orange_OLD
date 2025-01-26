if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Модифицированная СВД" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_svd_sk1.png"
ATTACHMENT.ShortName = "Модифицированная СВД"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/svd/wpn_svd_mag_sk1",
	[2]	= "models/flaymi/stalker/anomaly/skins/svd/wpn_svd_body_sk1",
	[3]	= "models/flaymi/stalker/anomaly/skins/svd/wpn_svd_grips_sk1",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/svd/wpn_svd_grips_sk1",
	[2]	= "models/flaymi/stalker/anomaly/skins/svd/wpn_svd_body_sk1",
	[3]	= "models/flaymi/stalker/anomaly/skins/svd/wpn_svd_mag_sk1",
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

