if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Глушитель ПБС-1"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[
Прибор для беззвучной и беспламенной стрельбы из автомата Калашникова калибра
7,62 мм. При установке глушителя стрельба ведётся патронами УС с дозвуковой
скоростью пули.

Глушение звука: среднее
]] }
ATTACHMENT.Icon = "entities/anomaly/addons/addon_sil_pbs1.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Глушитель ПБС-1"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["anomaly_sil_pbs1"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_sil_pbs1"] = {
			["active"] = true
		},
	},
	["Primary"] = {
		["Damage"] = function(wep,stat) return stat * 0.98 end,
		["Spread"] = function(wep,stat) return stat * 1.05 end,
		["IronAccuracy"] = function(wep,stat) return stat * 1.1 end,
		["Sound"] = function(wep,stat) return wep.Primary.SilencedSound or stat end
	},
	["MuzzleFlashEffect"] = "tfa_muzzleflash_silenced",
	["MuzzleAttachmentMod"] = function(wep,stat) return wep.MuzzleAttachmentSilenced or stat end,
	["Silenced"] = true,
}

function ATTACHMENT:Attach(wep)
	wep.Silenced = true
	wep:SetSilenced(wep.Silenced)
end

function ATTACHMENT:Detach(wep)
	wep.Silenced = false
	wep:SetSilenced(wep.Silenced)
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
