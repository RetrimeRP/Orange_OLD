if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел ПСО-1М"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Прицел ПСО-1М (Прицел Снайперский Оптический) - серия 
советских оптических прицелов, производимых Новосибирским Приборостроительным Заводом. 
Был разработан в 1964 году как стандартный прицел для винтовки СВД. Позже начал широко 
использоваться на: 9А-91, АЕК-971, АЕК-973, АК-74, АКС-74, АКС-74У, АКМ, АКМС, АК «сотой 
серии», АН-94, модификациях АС «Вал», РПК-74, СВУ и СР-3М. Получил своё признание за 
долговечность, универсальность и очень хороший продуманный тип прицельной сетки с удобным 
дальномером. Данный экземпляр - фиксированной 4.0x кратности, что делает его пригодным в 
основном для использования на дальних дистанциях. Распространён в странах Варшавского 
договора, использует крепление «ласточкин хвост».

Увеличение: 4.0x
Тип прицельной сетки: ПСО-1
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_pso.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел ПСО-1М"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_pso1"] = {
			["active"] = true,
		},
		["anomaly_addon_rail"] = {
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
	["WElements"] = {
		["scope_anomaly_pso1"] = {
			["active"] = true
		},
		["anomaly_addon_rail"] = {
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
	["INS2_SightVElement"] = "scope_anomaly_pso1",
	["INS2_SightSuffix"] = "PSO1"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end