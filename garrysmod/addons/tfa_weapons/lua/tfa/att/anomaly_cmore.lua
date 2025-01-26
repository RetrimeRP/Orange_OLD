if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел C-MORE Tactical Sight"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Коллиматорный прицел открытого типа «C-More Railway»,
который не перекрывает стрелку обзор, позволяя пользоваться периферическим зрением
и смотреть обоими глазами во время прицеливания. Прицельная марка является точкой
красного цвета. Можно мгновенно установить на планку Вивера или «Пикатинни».

Увеличение: отсутствует (коллиматор)
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_cmore.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел C-MORE Tactical Sight"

ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["sight_anomaly_cmore"] = {
			["active"] = true,
		},
		["sight_anomaly_cmore_lense"] = {
			["active"] = true,
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
		["anomaly_ironsight_remington870"] = {
			["active"] = false,
		},
		["ironsight_anomaly_mp7_on"] = {
			["active"] = false,
		},
		["ironsight_anomaly_mp7_off"] = {
			["active"] = true,
		},
		["anomaly_xm8_sight_on"] = {
			["active"] = false,
		},
		[ "anomaly_xm8_sight_off" ] = {
			["active"] = true,
		}
	},
	["WElements"] = {
		["sight_anomaly_cmore"] = {
			["active"] = true
		},
		["aug_a3_sight"] = {
			["active"] = false,
		},
		["anomaly_ironsight_remington870"] = {
			["active"] = false,
		},
		["ironsight_anomaly_mp7_on"] = {
			["active"] = false,
		},
		["anomaly_xm8_sight_on"] = {
			["active"] = false,
		},
		[ "anomaly_xm8_sight_off" ] = {
			["active"] = true,
		}
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_Cmore or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_Cmore or val end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return wep.Secondary.IronFOV_Cmore or val * 0.95 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_anomaly_cmore_lense",

	["StencilSight"] = true,

    ["StencilSight_UseMask"] = true,

    ["StencilSight_VElement"] = "sight_anomaly_cmore_lense",

    ["StencilSight_ReticleType"] = TFA.Enum.RETICLE_FLAT,

    ["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/wpn_addon_scope_c-more_crosshair_dot",

    ["StencilSight_ReticleSize"] = 100,

    ["StencilSight_FollowRecoil"] = true,

    ["StencilSight_MinPercent"] = 0.7,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
