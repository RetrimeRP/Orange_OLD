if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Заказная L85A2" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_l85_sk1.png"
ATTACHMENT.ShortName = "Заказная L85A2"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[7] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk1",
	[1] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk1",
	}, 
	 MaterialTable_W = {
	[2] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk1",
	[1] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk1",
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

