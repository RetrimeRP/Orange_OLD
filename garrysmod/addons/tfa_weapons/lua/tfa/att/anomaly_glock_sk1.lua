if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Заказной Glock 19" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_glock_sk1.png"
ATTACHMENT.ShortName = "Заказной Glock 19"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/glock/wpn_glock19_sk1",
	}, 
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/glock/wpn_glock19_sk1",
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

