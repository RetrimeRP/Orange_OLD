if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Заказной SPAS-12" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_spas12_sk1.png"
ATTACHMENT.ShortName = "Заказной SPAS-12"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[2] =	"models/flaymi/stalker/anomaly/skins/spas12/wpn_spas12_sk1",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/spas12/wpn_spas12_sk1",
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

