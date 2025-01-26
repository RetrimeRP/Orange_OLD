if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 7,62x54 мм 7Н14"
ATTACHMENT.ShortName = "Патроны 7,62x54 мм 7Н14" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Специально разработанный модернизированный снайперский патрон 7,62х54 мм с
бронебойной пулей СНБ. Пуля оснащена комбинированным сердечником из свинца и закалённой стали марки У12А,
способной пробивать бронежилеты и небольшие преграды. В сравнении со стандартным патроном того же калибра
имеет облегчённую хвостовую часть, что обеспечивает большую точность и улучшенные баллистические
характеристики.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_762x54_7h14.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.74 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_762x54_7h14"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
