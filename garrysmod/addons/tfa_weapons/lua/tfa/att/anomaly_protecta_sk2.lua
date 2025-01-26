if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Модифицированная Armsel Protecta" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_protecta_sk2.png"
ATTACHMENT.ShortName = "Модифицированная Armsel Protecta"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[2] =	"models/flaymi/stalker/anomaly/skins/protecta/wpn_protecta_sk2",
	}, 
	 MaterialTable_W = {
	[3] =	"models/flaymi/stalker/anomaly/skins/protecta/wpn_protecta_sk2",
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

