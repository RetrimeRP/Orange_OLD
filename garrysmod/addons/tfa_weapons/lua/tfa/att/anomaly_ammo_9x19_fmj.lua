if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 9x19 мм FMJ"
ATTACHMENT.ShortName = "Патроны 9x19 мм FMJ" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Стандартный патрон калибра 9х19 мм с оболочечной пулей. Обладает
хорошими баллистическими характеристиками и при этом недорог в изготовлении. Особо популярен
в связи с тем, что международная конвенция запрещает применение экспансивных пуль в бою.
Малоэффективен против бронежилетов.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_9x19_fmj.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.44 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_9x19_fmj"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
