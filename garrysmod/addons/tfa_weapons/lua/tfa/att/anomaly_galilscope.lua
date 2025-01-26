if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел Galil 4.0x"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Оптический прицел, разработанный специально Galil AR. Характерной
особенностью является пилон-образная прицельная сетка, которая делает прицел пригодным в основном
для малых и средних дистанций, так как на дальних перекрывает цель. Данный экземпляр имеет
фиксированную кратность 4.0x и может использоваться для ведения прицельного огня на средние и
дальние дистанции.

Увеличение: 4.0x
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_galilscope.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел Galil 4.0x"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_galilscope"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["scope_anomaly_galilscope"] = {
			["active"] = true
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 8 end
	},
	["INS2_SightVElement"] = "scope_anomaly_galilscope",
	["INS2_SightSuffix"] = "GALILSCOPE"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end