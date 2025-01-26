if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны .45 ACP Hydra-shock"
ATTACHMENT.ShortName = "Патроны .45 ACP Hydra-shock" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Нестандартный тип патрона для калибра .45 ACP (11,43x23 мм) - полуоболочечная пуля
с экспансивной выемкой и стальным сердечником. Этой комбинации полуоболочечной экспансивной и бронебойной пули
свойственны как достоинства, так и недостатки обоих типов патронов.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_1143x23_hydro.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.7 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["KickUp"] = function( wep, stat ) return stat + stat * 1/2 end,
		["KickDown"] = function( wep, stat ) return stat + stat * 1/2 end,
		["Ammo"] = "ammo_1143x23_hydro"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
