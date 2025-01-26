if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 5,56x45 мм FMJ"
ATTACHMENT.ShortName = "Патроны 5,56x45 мм FMJ" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Стандартный патрон войск стран НАТО, известный под индексом M193,
калибра 5,56х45 мм со стальным сердечником. Разработан для ведения прицельного огня очередями
на основе охотничьих патронов. Хорошо известен использованием армией США во время войны во
Вьетнаме. Патрон хоть и обладает малой пробивной силой, но в то же время обеспечивает отличное
повреждение тканей.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_556x45_fmj.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.58 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_556x45_fmj"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
