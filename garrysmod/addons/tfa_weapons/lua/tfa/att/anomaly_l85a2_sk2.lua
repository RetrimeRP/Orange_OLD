if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Модернизированная L85A2" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_l85_sk2.png"
ATTACHMENT.ShortName = "Модернизированная L85A2"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[7] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk2",
	[1] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk2",
	}, 
	 MaterialTable_W = {
	[2] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk2",
	[1] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk2",
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

