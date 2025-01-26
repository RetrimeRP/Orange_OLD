if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны .50 BMG"
ATTACHMENT.ShortName = "Патроны .50 BMG" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[.50 BMG (12,7x99 мм) - это крупнокалиберный патрон, созданный в 1920-х
годах в качестве боеприпаса для крупнокалиберного пулемёта Browning M1921 (M2HB). Во время Второй
мировой войны патрон состоял на снабжении всех стран союзнического альянса и использовался главным
образом в авиационных пулемётах. В боекомплекте к ленд-лизовской бронетехнике и самолетам патрон
поставлялся и в СССР. После Второй мировой войны патрон .50 BMG распространился по всему миру
(кроме стран Варшавского договора) как стандартный крупнокалиберный боеприпас НАТО для пехотного
пулемёта, и сегодня выпускается более чем 30 производителями по американским стандартам. Патрон
также имеет различные модификации: обычный М2, бронебойный М2, бронебойно-зажигательный M8,
зажигательный M1, трассирующий M1. Патроны, использующиеся для стрельбы продолжительным очередями,
заключаются в патронные ленты.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_50_bmg.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.45 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.9/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 9/3 end,
		["Ammo"] = "ammo_50_bmg"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
