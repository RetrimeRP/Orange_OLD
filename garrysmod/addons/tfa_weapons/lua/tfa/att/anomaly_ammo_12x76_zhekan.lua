if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 12x76 мм Жекан"
ATTACHMENT.ShortName = "Патроны 12x76 мм Жекан" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Патрон 12-го калибра с безоболочечной пулей. Обычно используется
для охоты на крупных животных, но подходит и для других целей: его тяжёлая пуля не пробивает,
а фактически продавливает бронежилеты.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_12x76_zhekan.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 4 end,
		["Spread"] = function( wep, stat ) return stat/10 + stat * 0.5 end,
		["IronAccuracy"] = function( wep, stat ) return stat/15 * 5/2 end,
		["NumShots"] = 1,
		["Ammo"] = "ammo_12x76_zhekan"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
