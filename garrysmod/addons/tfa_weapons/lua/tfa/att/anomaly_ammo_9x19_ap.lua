if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 9x19 мм БП"
ATTACHMENT.ShortName = "Патроны 9x19 мм БП" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Бронебойный патрон калибра 9x19 мм с пулей со стальным сердечником.
Разработан для улучшения пробивной способности пистолетов и пистолетов-пулемётов. Используется,
главным образом, антитеррористическими и специальными полицейскими подразделениями, когда они
сталкиваются с противниками, защищёнными бронежилетами.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_9x19_ap.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.45 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["KickUp"] = function( wep, stat ) return stat + stat * 1.1/2 end,
		["KickDown"] = function( wep, stat ) return stat + stat * 1.1/2 end,
		["Ammo"] = "ammo_9x19_ap"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
