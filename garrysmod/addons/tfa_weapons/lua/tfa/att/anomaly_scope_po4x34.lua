if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел ПО4х34"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Прицел оптический постоянного и переменного увеличения устанавливаются
на нарезное оружие и предназначены для прицельной наводки его при стрельбе. На оружие прицел
монтируется при помощи специальных кронштейнов.

Увеличение: 4.0x
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_po4x34.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел ПО4х34"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["scope_anomaly_po4x34"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["scope_anomaly_po4x34"] = {
			["active"] = true
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 8 end
	},
	["INS2_SightVElement"] = "scope_anomaly_po4x34",
	["INS2_SightSuffix"] = "PO4X34"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end