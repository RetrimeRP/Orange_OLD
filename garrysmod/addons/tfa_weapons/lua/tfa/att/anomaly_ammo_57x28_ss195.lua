if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 5.7x28 мм ЭП"
ATTACHMENT.ShortName = "Патроны 5.7x28 мм ЭП" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[5.7x28 мм  патрон, известный под индексом SS195LF, с экспансивной пулей
обладает меньшей пробивной способностью, чем SS190, но большим останавливающим действием и убойной силой.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_57x28_ss195.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 1 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_57x28_ss195"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
