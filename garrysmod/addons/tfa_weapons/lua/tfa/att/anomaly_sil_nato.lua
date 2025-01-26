if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Глушитель НАТО"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[Прибор для беззвучной и беспламенной стрельбы для штурмовых
винтовок стандарта НАТО калибра 5,56х45, а так же для пистолетов и пистолетов-пулемётов
калибра 11,43x23.

Глушение звука: высокое
]] }
ATTACHMENT.Icon = "entities/anomaly/addons/addon_sil_nato.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Глушитель НАТО"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["anomaly_sil_nato"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_sil_nato"] = {
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
