if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Камуфлированный SIG SG550" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_sig550_sk4.png"
ATTACHMENT.ShortName = "Камуфлированный SIG SG550"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[3] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_sk2",
	[1] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_mag_sk2",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_sk2",
	[2] =	"models/flaymi/stalker/anomaly/skins/sig550/wpn_sig550_mag_sk2",
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

