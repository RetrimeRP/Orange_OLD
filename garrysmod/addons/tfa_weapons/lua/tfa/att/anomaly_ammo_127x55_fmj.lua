if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 12,7x55 мм СЦ-130"
ATTACHMENT.ShortName = "Патроны 12,7x55 мм СЦ-130" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[12,7x55 мм СЦ-130 - российский винтовочный боеприпас с дозвуковой скоростью
пули, созданный в ЦКИБ СОО для малошумного и беспламенного поражения защищённых целей и живой силы в тяжёлых
бронежилетах на дальностях до 600 метров.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_127x55_fmj.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.8 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/2 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/2 end,
		["Ammo"] = "ammo_127x55_fmj"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
