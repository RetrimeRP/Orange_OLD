if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "M4A1 с камуфляжем «Свободы»" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_m4a1_sk1.png"
ATTACHMENT.ShortName = "M4A1 с камуфляжем «Свободы»"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/m4a1/wpn_m4a1_sk1",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/m4a1/wpn_m4a1_sk1",
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

