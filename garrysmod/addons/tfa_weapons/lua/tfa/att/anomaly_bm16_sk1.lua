if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Улучшенный Обрез ТОЗ-66" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_bm16_sk1.png"
ATTACHMENT.ShortName = "Улучшенный Обрез ТОЗ-66"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/bm16/wpn_toz66_sk1",
	}, 
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/bm16/wpn_toz66_sk1",
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

