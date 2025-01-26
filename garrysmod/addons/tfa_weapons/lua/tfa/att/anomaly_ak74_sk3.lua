if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "АК-74 (Альтернативный)" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_ak74_sk3.png"
ATTACHMENT.ShortName = "АК-74 (Альтернативный)"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk3",
	}, 
	 MaterialTable_W = {
	 [1] =	"models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk3",
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

