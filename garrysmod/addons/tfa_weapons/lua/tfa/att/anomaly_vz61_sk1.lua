if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Skorpion vz.61 с камуфляжем «Свободы»" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_vz61_sk1.png"
ATTACHMENT.ShortName = "Skorpion vz.61 с камуфляжем «Свободы»"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/vz61/wpn_vz61_sk1",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/vz61/wpn_vz61_sk1",
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

