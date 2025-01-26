if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 7,62x51 мм НАТО FMJ"
ATTACHMENT.ShortName = "Патроны 7,62x51 мм НАТО FMJ" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[7,62x51 НАТО - армейский вариант патрона .308, который использовался
силами НАТО в качестве стандартного, пока в 70-х годах во время войны во Вьетнаме не были введены
боеприпасы калибра 5,56 мм. В настоящее время эти патроны чаще всего применяются наёмниками во всём мире.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_762x51_fmj.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.66 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.5/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 5/3 end,
		["Ammo"] = "ammo_762x51_fmj"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
