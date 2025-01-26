if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "L96 AWSM" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_l96_sk2.png"
ATTACHMENT.ShortName = "L96 AWSM"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/l96/wpn_l96_sk2",
	[2]	= "models/flaymi/stalker/anomaly/skins/l96/wpn_addon_scope_l96_sk2",
	}, 
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/l96/wpn_l96_sk2",
	[2]	= "models/flaymi/stalker/anomaly/skins/l96/wpn_addon_scope_l96_sk2",
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

