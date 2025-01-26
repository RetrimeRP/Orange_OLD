if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Патроны 7,62x25 мм П"
ATTACHMENT.ShortName = "Патроны 7,62x25 мм П" --Abbreviation, 5 chars or less please
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Советский пистолетный патрон калибра 7,62 мм, известный сейчас как 7,62x25 мм
Токарев. Пуля имеет свинцовый сердечник и стальную оболочку, плакированную томпаком. Начальная скорость пули
составляет 420 м/c, энергия - 510 Дж. В целях более надёжного соединения пули с гильзой, изготавливавшейся
из латуни, пулю закрепляли в гильзе круговым обжимом дульца гильзы с последующим кренением. На складах военных
частей ВС Российской Федерации ещё имеется очень большое количество этих патронов.
]]}
ATTACHMENT.Icon = "entities/anomaly_ammo_762x25_p.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function( wep, stat ) return stat + stat * 0.7 end,
		["Spread"] = function( wep, stat ) return stat + stat * 0.66/3 end,
		["IronAccuracy"] = function( wep, stat ) return stat * 6.6/3 end,
		["Ammo"] = "ammo_762x25_p"
	}
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
