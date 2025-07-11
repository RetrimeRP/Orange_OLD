if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Заказной SIG SG550" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_sig550_sk1.png"
ATTACHMENT.ShortName = "Заказной SIG SG550"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[3] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_sk1",
	[1] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_mag_sk1",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_sk1",
	[2] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_mag_sk1",
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

