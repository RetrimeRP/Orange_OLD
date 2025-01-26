if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "L85A2 (Альтернативная)" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_l85_sk3.png"
ATTACHMENT.ShortName = "L85A2 (Альтернативная)"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[7] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk3",
	[1] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk3",
	}, 
	 MaterialTable_W = {
	[2] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_l85_sk3",
	[1] =	"models/flaymi/stalker/anomaly/skins/l85/wpn_addon_scope_susat_sk3",
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

