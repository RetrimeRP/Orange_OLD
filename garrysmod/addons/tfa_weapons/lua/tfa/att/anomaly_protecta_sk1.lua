if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Камуфлированная Armsel Protecta" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_protecta_sk1.png"
ATTACHMENT.ShortName = "Камуфлированная Armsel Protecta"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[2] =	"models/flaymi/stalker/anomaly/skins/protecta/wpn_protecta_sk1",
	}, 
	 MaterialTable_W = {
	[3] =	"models/flaymi/stalker/anomaly/skins/protecta/wpn_protecta_sk1",
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

