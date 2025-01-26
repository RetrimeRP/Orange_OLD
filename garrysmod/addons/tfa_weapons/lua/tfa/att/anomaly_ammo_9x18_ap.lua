if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 9x18 мм РГ028"
ATTACHMENT.ShortName = "Патроны 9x18 мм РГ028" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[РГ028 - патрон, используемый для пробивания лёгкой брони. Цель
создания РГ028 состояла в том, чтобы противостоять противникам в индивидуальных средствах
защиты; по этой причине патрон оснащён упрочнённым стальным сердечником. К сожалению, сам по
себе патрон не сильно превосходит стандартный 9х18, а только имеет увеличенную пробивную
способность.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_9x18_ap.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.55 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_9x18_ap"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
