if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел УСП-1 «Тюльпан»"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Унифицированный стрелковый прицел УСП-1 предназначен для
ведения прицельной стрельбы из: 9А-91, АЕК-971, АЕК-973, АК «сотой серии», АК-74, АКМ,
АКМС, АКС-74У, АН-94, АС «Вал», ВСК-94, ВСС «Винторез», РПК-74, СВД, СВУ и СР-3М в 
светлое время суток и ночью по светящимся и подсвечиваемым целям. 1П29 - индекс прицела
УСП-1 Главного артиллерийского управления МО СССР. Создан в рамках ОКР «Тюльпан»,
откуда и получил своё название.

Увеличение: 4.0x
Тип прицельной сетки: УСП-1
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_1p29.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел УСП-1 «Тюльпан»"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_1p29"] = {
			["active"] = true,
		},
		["ironsight_anomaly_svu_on"] = {
			["active"] = false
		},
		["ironsight_anomaly_svu_off"] = {
			["active"] = true
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = false,
		},
	},
	["WElements"] = {
		["scope_anomaly_1p29"] = {
			["active"] = true
		},
		["ironsight_anomaly_svu_on"] = {
			["active"] = false
		},
		["ironsight_anomaly_svu_off"] = {
			["active"] = true
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = false,
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 8 end
	},
	["INS2_SightVElement"] = "scope_anomaly_1p29",
	["INS2_SightSuffix"] = "1P29"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end