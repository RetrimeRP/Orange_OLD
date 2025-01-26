if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 5,56x45 мм EPR"
ATTACHMENT.ShortName = "Патроны 5,56x45 мм EPR" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Известный под индексом M855A1, этот патрон калибра 5.56х45 мм повышенной
эффективности (Enhanced Performance Round) является новейшим патроном, используемым армией США. Пуля
состоит из медной полуоболочки со стальным наконечником, развивает большую скорость и имеет лучшее
бронепробитие по сравнению с пулей патрона SS109/M855. Обладает повышенной эффективностью поражения
как брони противника, так и мягких тканей.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_556x45_ap.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.54 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["KickUp"] = function( wep, stat ) return stat + stat * 1/2 end,
		["KickDown"] = function( wep, stat ) return stat + stat * 1/2 end,
		["Ammo"] = "ammo_556x45_ap"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
