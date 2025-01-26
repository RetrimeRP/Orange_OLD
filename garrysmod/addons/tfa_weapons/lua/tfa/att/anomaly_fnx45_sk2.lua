if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "FNX-45 Tactical (Альтернативный)" -- skin name
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_fnx45_sk2.png"
ATTACHMENT.ShortName = "FNX-45 Tactical (Альтернативный)"
ATTACHMENT.WeaponTable = { 
	 MaterialTable_V = {
	[1]	= "models/flaymi/stalker/anomaly/skins/fnp45/wpn_fnx45_sk2",
	}, 
	 MaterialTable_W = {
	[1] = "models/flaymi/stalker/anomaly/skins/fnp45/wpn_fnx45_sk2",
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

