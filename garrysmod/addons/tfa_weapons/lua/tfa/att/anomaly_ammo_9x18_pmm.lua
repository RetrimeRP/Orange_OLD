if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 9x18 мм +P+"
ATTACHMENT.ShortName = "Патроны 9x18 мм +P+" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Патрон с пулей повышенного останавливающего действия 7Н16.
Европейская маркировка +Р+ обозначает «очень высокое давление в стволе». По сравнению с
обычным патроном скорость пули увеличена на 30%. Малоэффективен против бронежилетов.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_9x18_pmm.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.7 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["KickUp"] = function( wep, stat ) return stat + stat * 1.1/2 end,
		["KickDown"] = function( wep, stat ) return stat + stat * 1.1/2 end,
		["Ammo"] = "ammo_9x18_pmm"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
