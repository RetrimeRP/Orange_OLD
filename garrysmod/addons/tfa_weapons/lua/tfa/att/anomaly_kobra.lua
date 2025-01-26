if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Прицел «Кобра» ЭКП-1С-03"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Прицел Кобра обеспечивает уверенное прицеливание в условиях 
естественной освещённости (яркий солнечный день, глубокие сумерки и лунная ночь) благодаря 
наличию 16-ти уровней ручной регулировки яркости прицельной марки. Расположение прицельной 
марки и цели в одной плоскости позволяет осуществлять прицеливание как одним, так и двумя 
глазами, что создаёт для стрелка ничем не ограниченное поле зрения, и вести эффективную 
скоростную стрельбу по быстро перемещающимся, малоразмерным и внезапно появляющимся на 
короткое время целям

Увеличение: отсутствует (коллиматор)
]]}
ATTACHMENT.Icon = "entities/anomaly/addons/addon_kobra.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Прицел «Кобра» ЭКП-1С-03"

ATTACHMENT.WeaponTable = {
	["RunSightsPos"] = function( wep, stat ) return stat + Vector(0, 0, -0.3) end,
	["RunSightsAng"] = function( wep, stat ) return stat + Vector(0, 0, 1) end,
	["VElements"] = {
		["anomaly_addon_rail"] = {
			["active"] = true
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = false,
		},
		["sight_anomaly_kobra"] = {
			["active"] = true,
		},
		["sight_anomaly_kobra_lense"] = {
			["active"] = true
		},
		["ironsight_anomaly_svu_on"] = {
			["active"] = false
		},
		["ironsight_anomaly_svu_off"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_addon_rail"] = {
			["active"] = true
		},
		["scope_anomaly_ak102_rail"] = {
			["active"] = false,
		},
		["sight_anomaly_kobra"] = {
			["active"] = true
		},
		["ironsight_anomaly_svu_on"] = {
			["active"] = false
		},
		["ironsight_anomaly_svu_off"] = {
			["active"] = true
		},
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_Kobra or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_Kobra or val end,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return wep.Secondary.IronFOV_Kobra or val * 0.95 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.05 end,
	["INS2_SightVElement"] = "sight_anomaly_kobra_lense",

	["StencilSight"] = true,

    ["StencilSight_UseMask"] = true,

    ["StencilSight_VElement"] = "sight_anomaly_kobra_lense",

    ["StencilSight_ReticleType"] = TFA.Enum.RETICLE_FLAT,

    ["StencilSight_ReticleMaterial"] = "models/flaymi/stalker/anomaly/attachments/wpn_addon_scope_ko",

    ["StencilSight_ReticleSize"] = 150,

    ["StencilSight_FollowRecoil"] = true,

    ["StencilSight_MinPercent"] = 0.7,
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
