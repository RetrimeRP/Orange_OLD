if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Камуфлированный FN F2000" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_fn2000_sk1.png"
ATTACHMENT.ShortName = "Камуфлированный FN F2000"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[3]	= "models/flaymi/stalker/anomaly/skins/fn2000/wpn_fn2000_sk1",
	}, 
	 MaterialTable_W = {
	[2] = "models/flaymi/stalker/anomaly/skins/fn2000/wpn_fn2000_sk1",
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

