if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел Barska ELECTRO SIGHT AC10632"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Коллиматорный прицел ELECTRO SIGHT 1x22x33 для быстрого прицеливания. Ударопрочный,
подходит под все виды оружия с планкой «Пикатинни». Выбор уровня яркости подсветки прицельной марки (7 ступеней)
позволяет использовать прицел при различных уровнях освещённости.
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_ac10632.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел Barska ELECTRO SIGHT AC10632"

ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["sight_anomaly_ac10632"] = {
			["active"] = true,
		},
		["sight_anomaly_ac10632_lense"] = {
			["active"] = true,
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = true,
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
		["g3sg_anomaly_rail"] = {
			["active"] = true,
		},
		["anomaly_hk416_sights"] = {
			["active"] = false,
		},
		["lr300_sight"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m4_on"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m4_off"] = {
			["active"] = true,
		},
		["ironsight_anomaly_m4a1"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m16"] = {
			["active"] = false,
		},
		["anomaly_mp5_mount"] = {
			["active"] = true,
		},
		["ironsight_anomaly_mp7_on"] = {
			["active"] = false,
		},
		["ironsight_anomaly_mp7_off"] = {
			["active"] = true,
		},
		["sight_anomaly_p90_sight"] = {
			["active"] = false,
		},
		[ "anomaly_scar_sight" ] = {
			["active"] = false,
		},
		["anomaly_xm8_sight_on"] = {
			["active"] = false,
		},
		[ "anomaly_xm8_sight_off" ] = {
			["active"] = true,
		}
	},
	["WElements"] = {
		["sight_anomaly_ac10632"] = {
			["active"] = true
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = true,
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
		["g3sg_anomaly_rail"] = {
			["active"] = true,
		},
		["anomaly_hk416_sights"] = {
			["active"] = false,
		},
		["lr300_sight"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m4_on"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m4_off"] = {
			["active"] = true,
		},
		["ironsight_anomaly_m4a1"] = {
			["active"] = false,
		},
		["ironsight_anomaly_m16"] = {
			["active"] = false,
		},
		["anomaly_mp5_mount"] = {
			["active"] = true,
		},
		["ironsight_anomaly_mp7_on"] = {
			["active"] = false,
		},
		["sight_anomaly_p90_sight"] = {
			["active"] = false,
		},
		[ "anomaly_scar_sight" ] = {
			["active"] = false,
		},
		["anomaly_xm8_sight_on"] = {
			["active"] = false,
		},
		[ "anomaly_xm8_sight_off" ] = {
			["active"] = true,
		}
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_AC10632 or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_AC10632 or val end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return wep.Secondary.IronFOV_AC10632 or val * 0.95 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_anomaly_ac10632",

	["StencilSight"] = true,

    ["StencilSight_UseMask"] = true,

    ["StencilSight_VElement"] = "sight_anomaly_ac10632_lense",

    ["StencilSight_ReticleType"] = TFA.Enum.RETICLE_FLAT,

    ["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/ac10_sight",

    ["StencilSight_ReticleSize"] = 100,

    ["StencilSight_FollowRecoil"] = true,

    ["StencilSight_MinPercent"] = 0.7,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
