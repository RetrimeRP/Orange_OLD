if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Модифицированный FN F2000" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_fn2000_sk2.png"
ATTACHMENT.ShortName = "Модифицированный FN F2000"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[3]	= "models/flaymi/stalker/anomaly/skins/fn2000/wpn_fn2000_sk2",
	}, 
	 MaterialTable_W = {
	[2] = "models/flaymi/stalker/anomaly/skins/fn2000/wpn_fn2000_sk2",
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

