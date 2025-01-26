if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Beretta 92F (Альтернативная)" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_beretta_sk3.png"
ATTACHMENT.ShortName = "Beretta 92F (Альтернативная)"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/beretta/wpn_beretta_sk3",
	}, 
	 MaterialTable_W = {
	[1] = "models/flaymi/stalker/anomaly/skins/beretta/wpn_beretta_sk3",
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

