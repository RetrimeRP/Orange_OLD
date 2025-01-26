if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны .357 HP"
ATTACHMENT.ShortName = "Патроны .357 HP" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[.357 НР - патрон с экспансивной пулей. Предназначение таких патронов состоит в
том, чтобы при попадании пуля замедлялась, уменьшая проникновение, но при этом вызывала большие внутренние
повреждения тканей.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_357_hp_mag.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.75 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.5/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_357_hp_mag"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
