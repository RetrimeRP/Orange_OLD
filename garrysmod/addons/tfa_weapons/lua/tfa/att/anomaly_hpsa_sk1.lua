if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Browning Hi-Power (Альтернативный)" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_hpsa_sk1.png"
ATTACHMENT.ShortName = "Browning Hi-Power (Альтернативный)"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/hpsa/wpn_hpsa_sk1",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/hpsa/wpn_hpsa_sk1",
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

