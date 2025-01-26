if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 12x76 мм «Bull»"
ATTACHMENT.ShortName = "Патроны 12x76 мм «Bull»" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Кустарный патрон, а точнее будет сказать пуля 12-го калибра
для охоты на динозавров, но сойдёт и против мутантов. Внутренняя часть пули изготовлена
из свинца, покрытого медью, внутри которого, в свою очередь, имеется стальная, похожая
на дротик, вставка. Пуля настолько впечатляет своими размерами и объёмом пороха, что
высока вероятность просто остаться без рук.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_12x76_bull.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 2.5 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.5 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 5/2 end,
		["NumShots"] = 1,
		["Ammo"] = "ammo_12x76_bull"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
