if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 7,92x57 мм Mauser"
ATTACHMENT.ShortName = "Патроны 7,92x57 мм Mauser" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Патрон 7,92x57 Mauser был принят на вооружение ещё в первой половине прошлого
столетия Германской Империей, а затем Третьим Рейхом. Это был один из самых популярных патронов в период
двух мировых войн. Однако, в наше время патрон прежде всего используется для охоты и спортивных состязаний.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_792x33_fmj.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.7 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.85/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 8.5/3 end,
		["Ammo"] = "ammo_792x33_fmj"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
