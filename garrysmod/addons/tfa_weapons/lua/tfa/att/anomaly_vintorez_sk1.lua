if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "ВСС «Винторез» (Альтернативный)" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_vintorez_sk1.png"
ATTACHMENT.ShortName = "ВСС «Винторез» (Альтернативный)"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/vintorez/wpn_vss_sk1",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/vintorez/wpn_vss_sk1",
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

