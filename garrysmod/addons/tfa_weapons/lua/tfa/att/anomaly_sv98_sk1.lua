if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Заказная СВ-98" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_sv98_sk1.png"
ATTACHMENT.ShortName = "Заказная СВ-98"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/sv98/wpn_sv98_sk1",
	}, 
	 MaterialTable_W = {
	[3] =	"models/flaymi/stalker/anomaly/skins/sv98/wpn_sv98_sk1",
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

