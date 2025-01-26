if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Украшенный ТОЗ-34" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_toz34_sk1.png"
ATTACHMENT.ShortName = "Украшенный ТОЗ-34"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[2]	= "models/flaymi/stalker/anomaly/skins/toz34/wpn_toz-34_sk1",
	}, 
	 MaterialTable_W = {
	[1] = "models/flaymi/stalker/anomaly/skins/toz34/wpn_toz-34_sk1",
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

