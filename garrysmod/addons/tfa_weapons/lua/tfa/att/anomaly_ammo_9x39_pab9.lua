if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 9x39 мм СП-5"
ATTACHMENT.ShortName = "Патроны 9x39 мм СП-5" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Дозвуковой «снайперский» патрон СП-5 оснащён пулей с биметаллической
оболочкой. Полость позади стального сердечника заполнена свинцом. Требует использования глушителя
для обеспечения бесшумной стрельбы. Распространён в некоторых странах-участницах Варшавского
договора. Эффективен против бронежилетов.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_9x39_pab9.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.55 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.5/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 5/3 end,
		["Ammo"] = "ammo_9x39_pab9"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
