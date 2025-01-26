if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел EOTech"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[EO Tech - это мировой лидер и эксклюзивный производитель
голографических прицельных систем для стрелкового оружия. Прицелы EOTech работают на
основе голографического построения прицельной марки, благодаря чему не имеют параллакса,
прицельная сетка собирается из тысяч маленьких пикселей, не перекрывает мишень.

Увеличение: отсутствует (коллиматор)
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_eotech.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел EOTech"

ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["sight_anomaly_eotech"] = {
			["active"] = true,
		},
		["sight_anomaly_eotech_lense"] = {
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
		["anomaly_ironsight_remington870"] = {
			["active"] = false,
		},
	},
	["Animations"] = {
		["reload"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val["value"] = "anm_reload_eotech"
			return val, true, true
		end,
		["reload_empty"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val["value"] = "anm_reload_eotech"
			return val, true, true
		end,
	},
	["WElements"] = {
		["sight_anomaly_eotech"] = {
			["active"] = true
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
		["anomaly_ironsight_remington870"] = {
			["active"] = false,
		},
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_Eotech or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_Eotech or val end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return wep.Secondary.IronFOV_Eotech or val * 0.95 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_anomaly_eotech",

	["StencilSight"] = true,

    ["StencilSight_UseMask"] = true,

    ["StencilSight_VElement"] = "sight_anomaly_eotech_lense",

    ["StencilSight_ReticleType"] = TFA.Enum.RETICLE_FLAT,

    ["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/wpn_addon_scope_eot_sight",

    ["StencilSight_ReticleSize"] = 75,

    ["StencilSight_FollowRecoil"] = true,

    ["StencilSight_MinPercent"] = 0.7,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
