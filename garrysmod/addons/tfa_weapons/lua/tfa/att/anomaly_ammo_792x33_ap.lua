if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 7,92x57 мм ПС"
ATTACHMENT.ShortName = "Патроны 7,92x57 мм ПС" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[7,92x57 ПС - патрон, используемый вооруженными силами Великобритании
против бронированных целей. Он имеет упрочнённый стальной сердечник, который даёт ему высокую
пробивную способность. Используемый главным образом для стрельбы на большие расстояния, этот патрон
имеет более высокий качество, чем стандартный. Используется в некоторых снайперских винтовках.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_792x33_ap.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.5 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.85/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 8.5/3 end,
		["Ammo"] = "ammo_792x33_ap"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
