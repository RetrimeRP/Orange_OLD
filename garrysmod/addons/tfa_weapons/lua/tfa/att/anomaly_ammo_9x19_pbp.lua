if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 9x19 мм Дум-дум"
ATTACHMENT.ShortName = "Патроны 9x19 мм Дум-дум" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Полуоболочечная пуля с экспансивной выемкой имеет высокое
останавливающее действие и не склонна к рикошетам. Используется в основном как «полицейский»
боеприпас и в гражданском оружии индивидуальной защиты. Малоэффективен против бронежилетов
из-за своего низкого проникающего потенциала.]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_9x19_pbp.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.33 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["KickUp"] = function( wep, stat ) return stat + stat * 1.1/2 end,
		["KickDown"] = function( wep, stat ) return stat + stat * 1.1/2 end,
		["Ammo"] = "ammo_9x19_pbp"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
