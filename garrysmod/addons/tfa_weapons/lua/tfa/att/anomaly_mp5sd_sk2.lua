if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Новый MP5SD6" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_mp5sd_sk2.png"
ATTACHMENT.ShortName = "Новый MP5SD6"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/mp5sd/wpn_mp5sd_sk2",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/mp5sd/wpn_mp5sd_sk2",
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

