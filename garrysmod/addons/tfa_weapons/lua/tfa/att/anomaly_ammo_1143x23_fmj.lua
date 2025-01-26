if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны .45 ACP"
ATTACHMENT.ShortName = "Патроны .45 ACP" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Патрон калибра .45 (11,43x23 мм) с цельнометаллической оболочечной пулей
остаётся популярным уже более сотни лет. Тяжёлая пуля при относительно слабом пороховом заряде летит
с не слишком большой скоростью, но обладает значительным останавливающим действием.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_1143x23_fmj.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.55 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_1143x23_fmj"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
