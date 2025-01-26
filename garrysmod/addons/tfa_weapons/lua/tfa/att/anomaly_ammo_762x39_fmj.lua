if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 7,62x39 мм FMJ"
ATTACHMENT.ShortName = "Патроны 7,62x39 мм FMJ" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Патрон калибра 7,62х39 мм с цельнометаллической оболочкой является одним
из наиболее популярных используемых боеприпасов, особенно в Африке и на Ближнем Востоке. Многие называют
его «Пулей Революции» в связи с его частым применением как террористами, так и преступными организациями.
Из-за огромной пробивной способности этого патрона военным всех стран пришлось усиливать бронезащиту
своих подразделений, поскольку вероятность встречи с данным боеприпасом в боевых ситуация весьма высока.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_762x39_fmj.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.66 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.75/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 7.5/3 end,
		["Ammo"] = "ammo_762x39_fmj"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
