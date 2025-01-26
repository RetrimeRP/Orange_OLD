if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "SIG P220 «Альпиец»" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_sig220_sk4.png"
ATTACHMENT.ShortName = "SIG P220 «Альпиец»"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/sig220/wpn_sig-p220_sk4",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/sig220/wpn_sig-p220_sk4",
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

