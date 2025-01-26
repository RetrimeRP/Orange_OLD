if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 9x39 мм СП-6"
ATTACHMENT.ShortName = "Патроны 9x39 мм СП-6" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Дозвуковой бронебойный «автоматный» патрон СП-6 оснащён
полуоболочечной пулей с частично открытым сердечником из закалённой стали. Требует
использования глушителя для обеспечения бесшумной стрельбы. Распространён в некоторых
странах-участницах Варшавского договора. Крайне эффективен против лёгких бронежилетов.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_9x39_ap.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.5 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_9x39_ap"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
