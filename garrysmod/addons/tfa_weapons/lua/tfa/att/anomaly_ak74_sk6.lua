if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "АК-74" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_ak74_sk6.png"
ATTACHMENT.ShortName = "АК-74"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk6",
	}, 
	 MaterialTable_W = {
	 [1] =	"models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk6",
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

