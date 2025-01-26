if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 7,62x39 мм M43"
ATTACHMENT.ShortName = "Патроны 7,62x39 мм M43" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Патрон 7,62x39 М43, произведённый в Китае, с пулей повышенной пробивной способности,
который часто обозначают как «7,62x39 CN». Обладает мягким стальным сердечником, который увеличивает пробивную
способность. Этот китайский боеприпас (в принципе, как и все прочие патроны М43) в настоящее время запрещён для
импорта в США, так как федеральный закон классифицирует его как бронебойный. Эта классификация основана на
материалах и дизайне пули, а не на её способности пробивать броню.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_762x39_ap.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.6 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.75/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 7.5/3 end,
		["Ammo"] = "ammo_762x39_ap"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
