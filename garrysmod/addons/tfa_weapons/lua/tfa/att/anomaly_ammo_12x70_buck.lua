if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 12x70 мм Дробь"
ATTACHMENT.ShortName = "Патроны 12x70 мм Дробь" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Обычный патрон 12-го калибра, снаряжённый дробью диаметром 6 мм.
На близких дистанциях обладает огромным убойным и останавливающим действием. Предназначен для
стрельбы из гладкоствольного оружия и дробовиков.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_12x70_buck.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Range"] = function( wep, stat ) return stat - stat * 0.75 end,
		["Damage"] = function( wep, stat ) return stat + stat * 2 end,
		["Spread"] = function( wep, stat ) return stat + stat * 4.6 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 4.6/2 end,
		["NumShots"] = 9,
		["Ammo"] = "ammo_12x70_buck"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
