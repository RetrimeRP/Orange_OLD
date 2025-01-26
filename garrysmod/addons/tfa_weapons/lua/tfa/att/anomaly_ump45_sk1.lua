if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Заказной UMP-45" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_ump45_sk1.png"
ATTACHMENT.ShortName = "Заказной UMP-45"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/ump45/wpn_ump45_sk1",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/ump45/wpn_ump45_sk1",
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

