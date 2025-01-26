if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел ПСО-1М2-1"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Специальная версия прицела ПСО-1М с прицельной сеткой,
разработанный специально для упрощения стрельбы с использованием низкоскоростных, 
утяжелённых дозвуковых патронов типа 9x39. Разметка сетки и особый масштаб дальномера
облегчает вычисление компенсирующих факторов окружающей среды. Предусмотрена подсветка
сетки в условиях плохой освещённости. Данный набор свойств позволил использовать такие
прицелы в войсках специального назначения. Также является стандартным прицелом на
бесшумной снайперской винтовке ВСС «Винторез»..

Увеличение: 4.0x
Тип прицельной сетки: ПСО-1-1
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_pso1m21.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел ПСО-1М"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_pso1m21"] = {
			["active"] = true,
		},
		["anomaly_addon_rail"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["scope_anomaly_pso1m21"] = {
			["active"] = true
		},
		["anomaly_addon_rail"] = {
			["active"] = true
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 8 end
	},
	["INS2_SightVElement"] = "scope_anomaly_pso1m21",
	["INS2_SightSuffix"] = "PSO1M21"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end