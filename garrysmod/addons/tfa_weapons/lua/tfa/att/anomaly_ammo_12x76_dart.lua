if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 12x76 мм Дротик"
ATTACHMENT.ShortName = "Патроны 12x76 мм Дротик" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Патрон 12-го калибра с тяжёлой безоболочечной пулей. Обычно используется
для охоты на крупных животных, но подходит и для других целей. Массивное стальное тело пули способно
пробить лёгкий бронежилет.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_12x76_dart.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * (1.75*2) end,
		["Spread"] = function( wep, stat ) return stat/10 + stat * 0.33 end,
		["IronAccuracy"] = function( wep, stat ) return stat/12 * 3.3/2 end,
		["NumShots"] = 1,
		["Ammo"] = "ammo_12x76_dart"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
