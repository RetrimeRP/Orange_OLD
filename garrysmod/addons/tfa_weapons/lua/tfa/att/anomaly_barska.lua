if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел Barska ELECTRO SIGHT AC10632"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Коллиматорный прицел ELECTRO SIGHT 1x22x33 для быстрого
прицеливания. Ударопрочный, подходит под все виды оружия с планкой «Пикатинни». Выбор
уровня яркости подсветки прицельной марки (7 ступеней) позволяет использовать прицел
при различных уровнях освещённости.

Увеличение: отсутствует (коллиматор)
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_ac10632.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел Barska ELECTRO SIGHT AC10632"

ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["sight_anomaly_barska"] = {
			["active"] = true,
		},
		["sight_anomaly_barska_lense"] = {
			["active"] = true,
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
	},
	["WElements"] = {
		["sight_anomaly_barska"] = {
			["active"] = true
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_Barska or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_Barska or val end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return wep.Secondary.IronFOV_Barska or val * 0.95 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_anomaly_barska_lense",

	["StencilSight"] = true,

    ["StencilSight_UseMask"] = true,

    ["StencilSight_VElement"] = "sight_anomaly_barska_lense",

    ["StencilSight_ReticleType"] = TFA.Enum.RETICLE_FLAT,

    ["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/wpn_addon_scope_barska_crosshair_dot",

    ["StencilSight_ReticleSize"] = 100,

    ["StencilSight_FollowRecoil"] = true,

    ["StencilSight_MinPercent"] = 0.7,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
