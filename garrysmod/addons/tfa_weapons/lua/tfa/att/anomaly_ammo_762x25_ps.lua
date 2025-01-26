if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 7,62x25 мм Пст"
ATTACHMENT.ShortName = "Патроны 7,62x25 мм Пст" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[7,62-мм пистолетный патрон с пулей со стальным сердечником (7,62 ПС), вес
5.6 грамм. Принят на вооружение в 1953 году. Патрон имеет биметаллическую или латунную гильзу.
Останавливающее действие пули удалось максимально приблизить к показателям пули 9х19 мм Парабеллу.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_762x25_ps.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.5 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_762x25_ps"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
