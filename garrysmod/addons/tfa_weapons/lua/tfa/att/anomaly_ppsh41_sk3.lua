if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Камуфлированный ППШ-41" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_ppsh41_sk3.png"
ATTACHMENT.ShortName = "Камуфлированный ППШ-41"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/ppsh41/wpn_ppsh41_sk3",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/ppsh41/wpn_ppsh41_sk3",
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

