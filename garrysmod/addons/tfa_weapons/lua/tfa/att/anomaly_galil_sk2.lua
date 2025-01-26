if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Модернизированный Galil AR" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_galil_sk2.png"
ATTACHMENT.ShortName = "Модернизированный Galil AR"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/galil/wpn_galil_sk2",
	}, 
	 MaterialTable_W = {
	[1] = "models/flaymi/stalker/anomaly/skins/galil/wpn_galil_sk2",
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

