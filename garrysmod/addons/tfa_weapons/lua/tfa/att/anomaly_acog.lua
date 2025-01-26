if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел ACOG"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Съёмный оптический прицел, предназначенный для винтовок
стран НАТО. ACOG расшифровывается как Advanced Combat Optical Gunsight и относится к
семейству оптических прицелов, выпускаемых компанией Trijicon. Прицелы этого типа
устанавливаются на планку «Пикатинни» и имеют тритиевую подсветку. Данный экземпляр
имеет особую прицельную сетку «Тrijicon» и фиксированную кратность 2.0х.

Увеличение: 2.0x
Тип прицельной сетки: trijicon
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_acog.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел ACOG"

ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_acog"] = {
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
		["scope_anomaly_acog"] = {
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
		["ironsight_anomaly_m4_on"] = {
			["active"] = false,
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
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_ACOG or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_ACOG or val end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return wep.Secondary.IronFOV_ACOG or val * 0.95 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.05 end,
	["INS2_SightVElement"] = "scope_anomaly_acog",
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
