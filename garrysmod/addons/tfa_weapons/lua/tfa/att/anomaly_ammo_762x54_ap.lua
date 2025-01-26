if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 7,62x54 мм ПП"
ATTACHMENT.ShortName = "Патроны 7,62x54 мм ПП" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Недорогой бронебойный пулемётный патрон 7Н13 калибра 7,62х54 мм. В силу
конструктивных особенностей непригоден для стрельбы из снайперских винтовок, поэтому используется в
качестве боепитания пулемёта ПКМ. Этот патрон обладает повышенной мощностью и, благодаря стальному
сердечнику, обладает очень хорошей пробивающей способностью. Мощный патрон для мощного оружия.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_762x54_ap.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.45 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.9/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 9/3 end,
		["Ammo"] = "ammo_762x54_ap"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
