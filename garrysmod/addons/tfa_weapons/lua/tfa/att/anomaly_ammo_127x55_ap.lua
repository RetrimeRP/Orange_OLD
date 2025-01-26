if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 12,7x55 мм СЦ-130 ВПС"
ATTACHMENT.ShortName = "Патроны 12,7x55 мм СЦ-130 ВПС" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Крупнокалиберный снайперский патрон СЦ-130 ВПС (высокой пробивной способности)
предназначен для поражения бесшумным выстрелом живой силы противника, защищенной тяжёлыми СИБ (5-6 уровня
защиты по ГОСТ Р50744-95) на дальностях до 200 метров или находящейся за различными преградами (обшивка
автомобиля, дверь, стекло, забор и т.д.) на дальности до 600 метров, а также для поражения легкобронированных
и небронированных транспортных средств.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_127x55_ap.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.8 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/2 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/2 end,
		["Ammo"] = "ammo_127x55_ap"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
