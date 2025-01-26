if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Изношенный АН-94" 
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_abakan_sk2.png"
ATTACHMENT.ShortName = "Изношенный АН-94"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/abakan/wpn_an94_sk2",
	},
	 MaterialTable_W = {
	 [1] =	"models/flaymi/stalker/anomaly/skins/abakan/wpn_an94_sk2",
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

