if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 5,45x39 мм ПП"
ATTACHMENT.ShortName = "Патроны 5,45x39 мм ПП" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Армейский патрон 7Н10 калибра 5,45x39 мм с пулей повышенной пробиваемости (ПП)
используется в автоматических винтовках многих стран-участниц Варшавского договора. Пуля со стальным
термоупрочненным сердечником обеспечивает лучшее пробитие цели.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_545x39_ep.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.55 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_545x39_ep"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
