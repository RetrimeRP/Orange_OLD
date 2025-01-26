if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "AEK-971 с камуфляжем «Долга»" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_aek971_sk1.png"
ATTACHMENT.ShortName = "AEK-971 с камуфляжем «Долга»"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/aek971/wpn_aek971_sk1",
	}, 
	 MaterialTable_W = {
	 [1] =	"models/flaymi/stalker/anomaly/skins/aek971/wpn_aek971_sk1",
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

