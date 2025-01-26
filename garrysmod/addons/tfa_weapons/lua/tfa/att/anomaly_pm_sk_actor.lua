if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Наградной ПМ" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_pm_sk_actor.png"
ATTACHMENT.ShortName = "Наградной ПМ"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1] =	"models/flaymi/stalker/anomaly/skins/pm/wpn_pm_actor",
	}, 
	 MaterialTable_W = {
	[1] =	"models/flaymi/stalker/anomaly/skins/pm/wpn_pm_actor",
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

