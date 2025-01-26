if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел ПУ"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[ПУ (Прицел Универсальный) - стандартный оптический прицел Красной Армии
времён Великой Отечественной войны. Предназначен для установки на винтовку Мосина и СВТ-40.
Конструкция оказалась настолько удачной и надёжной, что этот прицел до сих пор пользуется заслуженной
популярностью. Имеет фиксированную кратность 3.5x, что делает его хорошим выбором для ведения боя на
средних и дальних дистанциях.
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_mosin.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел ПУ"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_mosinscope"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["scope_anomaly_mosinscope"] = {
			["active"] = true
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 6 end
	},
	["INS2_SightVElement"] = "scope_anomaly_mosinscope",
	["INS2_SightSuffix"] = "MOSINSCOPE"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end