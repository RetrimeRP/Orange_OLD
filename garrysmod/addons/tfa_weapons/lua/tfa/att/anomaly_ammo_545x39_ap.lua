if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 5,45x39 мм БП"
ATTACHMENT.ShortName = "Патроны 5,45x39 мм БП" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Армейский патрон 7Н22 калибра 5,45x39 мм с бронебойной пулей (БП)
используется в автоматических винтовках многих стран-участниц Варшавского договора. Внутри пули
находится бронебойный сердечник из инструментальной стали марки У12А. Эффективен против
бронежилетов.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_545x39_ap.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.65 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/2 end,
		["Ammo"] = "ammo_545x39_ap"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
