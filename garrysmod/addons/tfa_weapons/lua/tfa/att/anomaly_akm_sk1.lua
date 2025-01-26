if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Изношенный АКМ" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_ak103_sk1.png"
ATTACHMENT.ShortName = "Изношенный АКМ"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/akm/wpn_akm_sk1",
	[2]	= "models/flaymi/stalker/anomaly/skins/akm/wpn_akm_gadget_sk1",
	}, 
	 MaterialTable_W = {
	[1]	= "models/flaymi/stalker/anomaly/skins/akm/wpn_akm_gadget_sk1",
	[2]	= "models/flaymi/stalker/anomaly/skins/akm/wpn_akm_sk1",
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

