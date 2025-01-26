if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Камуфлированный АН-94" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_abakan_sk1.png"
ATTACHMENT.ShortName = "Камуфлированный АН-94"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/abakan/wpn_an94_sk1",
	}, 
	 MaterialTable_W = {
	 [1] =	"models/flaymi/stalker/anomaly/skins/abakan/wpn_an94_sk1",
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

