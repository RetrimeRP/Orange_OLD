if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Модернизированный АК-74" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_ak74_sk2.png"
ATTACHMENT.ShortName = "Модернизированный АК-74"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk2",
	}, 
	 MaterialTable_W = {
	 [1] =	"models/flaymi/stalker/anomaly/skins/ak74/wpn_ak74_sk2",
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

