if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Модифицированная Steyr AUG A1" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_aug_a1_sk2.png"
ATTACHMENT.ShortName = "Модифицированная Steyr AUG A1"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[2]	= "models/flaymi/stalker/anomaly/skins/aug_a1/wpn_aug_sk2",
	}, 
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/aug_a1/wpn_aug_sk2",
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

