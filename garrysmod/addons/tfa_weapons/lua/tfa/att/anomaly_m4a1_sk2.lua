if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Камуфлированная M4A1" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_m4a1_sk2.png"
ATTACHMENT.ShortName = "Камуфлированная M4A1"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/m4a1/wpn_m4a1_sk2",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/m4a1/wpn_m4a1_sk2",
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

