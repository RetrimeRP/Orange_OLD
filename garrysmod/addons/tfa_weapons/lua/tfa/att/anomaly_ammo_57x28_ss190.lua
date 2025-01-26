if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 5.7х28 мм SS190"
ATTACHMENT.ShortName = "Патроны 5.7х28 мм SS190" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Патрон 5.7x28 (SS190) разработан бельгийской фирмой Fabrique Nationale
специально для пистолета-пулемета FN P90 в середине 1980-х годов. Позже этот патрон был использован
в пистолете «Five SeveN». Патрон обладает большей пробивной мощностью, чем другие пистолетные патроны.
Пуля развивает дульную скорость до 716 м/с и способна пробить бронежилет. Останавливающее действие
пули в три раза выше, чем у патрона 9х19 мм.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_57x28_ss190.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.36 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_57x28_ss190"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
