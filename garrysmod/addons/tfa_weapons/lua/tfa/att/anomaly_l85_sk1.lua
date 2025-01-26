if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Заказная L85A1" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_l85_sk1.png"
ATTACHMENT.ShortName = "Заказная L85A1"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[5] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk1",
	[6] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk1",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk1",
	[2] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk1",
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

