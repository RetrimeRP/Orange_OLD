if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 7,62x51 мм НАТО AP"
ATTACHMENT.ShortName = "Патроны 7,62x51 мм НАТО AP" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Армейский патрон M61с бронебойной пулей с закалённым стальным сердечником.
Сохраняет показатели урона, обладая в то же время улучшенными показателями пробития бронежилетов.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_762x51_ap.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.5 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.5/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 5/3 end,
		["Ammo"] = "ammo_762x51_ap"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
