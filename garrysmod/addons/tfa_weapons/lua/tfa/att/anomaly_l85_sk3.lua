if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "L85A1 (Альтернативная)" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_l85_sk3.png"
ATTACHMENT.ShortName = "L85A1 (Альтернативная)"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[5] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk3",
	[6] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk3",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk3",
	[2] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk3",
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

