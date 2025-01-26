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
	},
	["Animations"] = {
		["reload"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val["value"] = "anm_reload_acog"
			return val, true, true
		end,
		["reload_empty"] = function(wep,val)
			val = table.Copy(val)
			val["type"] = TFA.Enum.ANIMATION_SEQ --Sequence or act
				val["value"] = "anm_reload_acog"
			return val, true, true
		end,
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
