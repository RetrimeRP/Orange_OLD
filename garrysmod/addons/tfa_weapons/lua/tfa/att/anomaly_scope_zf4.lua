if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел ZF-4"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Прицел ZF-4 (ZF-43) был создан в Германии в 1943 году на основе
советского оптического прицела ПУ. Он предназначался для вооружения регулярных войск, чтобы
дать им возможность сражаться на дальних дистанциях. Однако, в связи с недостаточным
количеством произведённых прицелов, ими были в первую очередь обеспечены немецкие снайперы и
элитные подразделения. На сегодняшний день ZF-4 остаётся довольно популярным в Зоне,
поскольку оружие времён Второй мировой, для которого он был разработан, всё ещё применяется
здесь.

Увеличение: 2.0x
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_zf4.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел ZF-4"
ATTACHMENT.Base = "ins2_scope_base"
ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["scope_anomaly_zf4"] = {
			["active"] = true,
		},
	},
	["WElements"] = {
		["scope_anomaly_zf4"] = {
			["active"] = true
		},
	},
	["Secondary"] = {
		["ScopeZoom"] = function(wep, val) return 4 end
	},
	["INS2_SightVElement"] = "scope_anomaly_zf4",
	["INS2_SightSuffix"] = "ZF4"
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end