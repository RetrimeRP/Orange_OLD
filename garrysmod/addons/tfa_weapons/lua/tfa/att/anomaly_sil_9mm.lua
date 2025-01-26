if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Глушитель 9мм"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { [[
Глушитель для оружия калибра 9 мм. Архаичный по конструкции и вместе
с тем достаточно эффективный. Содержит внутри плотно упакованный рулон
латунной сетки. В передней части прибора расположен набор резиновых
диафрагм с отверстиями для прохода пули. Глушитель используется в
ближнем бою против легко бронированных противников и для тихих убийств.

Глушение звука: очень высокое
]] }
ATTACHMENT.Icon = "entities/anomaly/addons/addon_sil_9mm.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Глушитель 9мм"

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["anomaly_sil_9mm"] = {
			["active"] = true
		},
	},
	["WElements"] = {
		["anomaly_sil_9mm"] = {
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
