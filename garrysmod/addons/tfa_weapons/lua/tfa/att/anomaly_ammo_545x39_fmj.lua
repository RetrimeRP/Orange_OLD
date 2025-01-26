if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 5,45x39 мм ПС"
ATTACHMENT.ShortName = "Патроны 5,45x39 мм ПС" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Армейский патрон 7Н6 калибра 5,45x39 мм с обыкновенной пулей (ПС)
со стальным сердечником, предназначенный для поражения живых целей, расположенных открыто или
за преградами, пробиваемыми пулей, огневых средств и небронированной техники. Обеспечивает
лучшую точность по сравнению с калибром 7,62 мм благодаря пониженной отдаче, а также увеличению
эффективности ведения огня на 100 метров.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_545x39_fmj.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.6 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_545x39_fmj"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
