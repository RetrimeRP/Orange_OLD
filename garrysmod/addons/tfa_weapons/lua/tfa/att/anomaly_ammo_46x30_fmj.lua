if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 4.6x30 мм FMJ"
ATTACHMENT.ShortName = "Патроны 4.6x30 мм FMJ" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Патрон с цельнометаллической пулей калибра 4.6x30 мм, главным образом,
использующийся пистолетом-пулемётом Heckler &amp; Koch MP7. Разработан с целью минимизировать вес и
отдачу во время стрельбы, сохраняя при этом способность пробивать бронежилеты.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_46x30_fmj.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.36 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_46x30_fmj"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
