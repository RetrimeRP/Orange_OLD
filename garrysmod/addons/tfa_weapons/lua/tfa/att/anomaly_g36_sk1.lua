if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Камуфлированная G36" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_g36_sk1.png"
ATTACHMENT.ShortName = "Камуфлированная G36"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[2]	= "models/flaymi/stalker/anomaly/skins/g36/wpn_g36_sk1",
	[4]	= "models/flaymi/stalker/anomaly/skins/g36/wpn_g36_scope_sk1",
	}, 
	 MaterialTable_W = {
	[2]	= "models/flaymi/stalker/anomaly/skins/g36/wpn_g36_sk1",
	[1]	= "models/flaymi/stalker/anomaly/skins/g36/wpn_g36_scope_sk1",
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

