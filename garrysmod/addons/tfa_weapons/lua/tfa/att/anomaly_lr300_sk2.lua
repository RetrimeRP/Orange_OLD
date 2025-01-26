if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Заказная LR-300ML" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_lr300_sk2.png"
ATTACHMENT.ShortName = "Заказная LR-300ML"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/lr300/wpn_lr300_sk2",
	}, 
	["VElements"] = {
		["lr300_sight"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/lr300/wpn_lr300_sk2"
		},
	},
	 MaterialTable_W = {
	[2] =	"models/flaymi/stalker/anomaly/skins/lr300/wpn_lr300_sk2",
	},
	["WElements"] = {
		["lr300_sight"] = {
			["material"] = "models/flaymi/stalker/anomaly/skins/lr300/wpn_lr300_sk2"
		},
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

