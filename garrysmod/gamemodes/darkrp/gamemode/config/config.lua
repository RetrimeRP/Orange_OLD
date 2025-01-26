GM.Config.Language = "ru"
GM.Config.voice3D = false
GM.Config.AdminsCopWeapons = false
GM.Config.adminBypassJobRestrictions = false
GM.Config.allowjobswitch = false
GM.Config.allowrpnames = true
GM.Config.allowsprays = false
GM.Config.allowvehicleowning = true
GM.Config.allowvnocollide = false
GM.Config.alltalk = false
GM.Config.autovehiclelock = false
GM.Config.babygod = false
GM.Config.canforcedooropen = false
GM.Config.chiefjailpos = false
GM.Config.cit_propertytax = false
GM.Config.copscanunfreeze = false
GM.Config.copscanunweld = false
GM.Config.cpcanarrestcp = false
GM.Config.currencyLeft = false
GM.Config.customjobs = false
GM.Config.customspawns = true
GM.Config.deathblack = false
GM.Config.deadtalk = false
GM.Config.deadvoice = false
GM.Config.decalcleaner = false
GM.Config.disallowClientsideScripts = true
GM.Config.doorwarrants = true
GM.Config.dropmoneyondeath = false
GM.Config.dropweapondeath = false
GM.Config.dropspawnedweapons = false
GM.Config.dynamicvoice = true
GM.Config.enablebuypistol = true
GM.Config.enforceplayermodel = true
GM.Config.ironshoot = true
GM.Config.letters = false
GM.Config.license = false
GM.Config.lockdown = true
GM.Config.lockpickfading = false
GM.Config.logging = false
GM.Config.lottery = true
GM.Config.needwantedforarrest = false
GM.Config.noguns = false
GM.Config.norespawn = false
GM.Config.npcarrest = false
GM.Config.ooc = true
GM.Config.propertytax = false
GM.Config.proppaying = false
GM.Config.propspawning = true
GM.Config.removeclassitems = true
GM.Config.removeondisconnect = true
GM.Config.respawninjail = true
GM.Config.restrictallteams = false
GM.Config.restrictbuypistol = true
GM.Config.restrictdrop = false
GM.Config.revokeLicenseOnJobChange = true
GM.Config.shouldResetLaws = false
GM.Config.strictsuicide = false
GM.Config.telefromjail = true
GM.Config.teletojail = true
GM.Config.unlockdoorsonstart = false
GM.Config.voiceradius = true
GM.Config.wallettax = false
GM.Config.wantedsuicide = false
GM.Config.realisticfalldamage = true
GM.Config.weaponCheckerHideDefault = true
GM.Config.weaponCheckerHideNoLicense = true

GM.Config.adminnpcs = 2
GM.Config.adminsents = 2
GM.Config.adminvehicles = 2
GM.Config.adminweapons = 1
GM.Config.arrestspeed = 300
GM.Config.babygodtime = 5
GM.Config.deathfee = 500
GM.Config.decaltimer = 120
GM.Config.demotetime = 60
GM.Config.doorcost = 30
GM.Config.entremovedelay = 0
GM.Config.jailtimer = 300
GM.Config.lockdowndelay = 120
GM.Config.maxdoors = 20
GM.Config.maxfooditems = 20
GM.Config.maxlotterycost = 250
GM.Config.maxvehicles = 5
GM.Config.minlotterycost = 30
GM.Config.moneyRemoveTime = 600
GM.Config.normalsalary = 45
GM.Config.npckillpay = 10
GM.Config.paydelay = 300
GM.Config.pricecap = 500
GM.Config.pricemin = 50
GM.Config.propcost = 10
GM.Config.respawntime = 1
GM.Config.changejobtime = 10
GM.Config.runspeed = 275
GM.Config.runspeedcp = 250
GM.Config.searchtime = 300
GM.Config.ShipmentSpamTime = 4
GM.Config.shipmentspawntime = 2
GM.Config.startinghealth = 100
GM.Config.startingmoney = 15000
GM.Config.vehiclecost = 40
GM.Config.wallettaxmax = 5
GM.Config.wallettaxmin = 1
GM.Config.wallettaxtime = 600
GM.Config.wantedtime = 120
GM.Config.walkspeed = 100
GM.Config.falldamagedamper = 15
GM.Config.falldamageamount = 10
GM.Config.talkDistance = 250
GM.Config.whisperDistance = 90
GM.Config.yellDistance = 550
GM.Config.meDistance = 250
GM.Config.voiceDistance = 550

GM.Config.MoneyClass = "spawned_money"
GM.Config.moneyModel = "models/props/cs_assault/money.mdl"
GM.Config.lockdownsound = "npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav"
GM.Config.DarkRPSkin = "retrime_orange"
GM.Config.currency = " т"
GM.Config.chatCommandPrefix = "/"

GM.Config.DefaultPlayerGroups = {
}

GM.Config.DisabledCustomModules = {
}

GM.Config.DisallowDrop = {

	["weapon_physgun"] = true,
	["weapon_physcannon"] = true,
	["weapon_fists"] = true,
	["gmod_camera"] = true,
	["gmod_tool"] = true,
	["zck_snowballswep"] = true,
	["darkrp_build"] = true,
	["darkrp_cidcard"] = true,
	["darkrp_cpidcard"] = true,
	["darkrp_disguise"] = true,
	["darkrp_inventory"] = true,
	["darkrp_keys"] = true,
	["darkrp_ram"] = true,
	["darkrp_search"] = true,
	["darkrp_shield_01"] = true,
	["darkrp_shield_02"] = true,
	["darkrp_shield_03"] = true,
	["darkrp_stunstick"] = true,
	["darkrp_medkit"] = true,
	["darkrp_build"] = true,
	["tfa_pistol"] = true,
	["tfa_magnum"] = true,
	["tfa_smg1"] = true,
	["tfa_smg2"] = true,
	["tfa_mp5k"] = true,
	["tfa_ar2"] = true,
	["tfa_oicw"] = true,
	["tfa_shotgun"] = true,
	["tfa_psg"] = true,
	["tfa_sniper1"] = true,
	["tfa_sniper3"] = true,
	["weapon_cuff_elastic"] = true,
	["darkrp_taxes"] = true,
	["darkrp_ticket"] = true

}

GM.Config.DefaultWeapons = {

	"weapon_physcannon",
	"darkrp_keys"

}

GM.Config.CategoryOverride = {

	jobs = {},
	entities = {},
	shipments = {},
	weapons = {},
	vehicles = {},
	ammo = {}

}

GM.Config.AdminWeapons = {

	"weapon_physgun",
	"gmod_tool"

}

GM.Config.DefaultLaws = {

	"Администратор города может нарушать G.01, G.06, G.07 и E.07",
	"Глава ГСР может нарушать G.01, G.06, G.07 и E.07",
	"Лоялисты могут нарушать G.01, G.06, G.07 и E.07",
	"Медик ГСР может нарушать F.07"

}

GM.Config.noStripWeapons = {

	-- darkrp
	["darkrp_stunstick"] = true,
	["zck_snowballswep"] = true,

	["darkrp_cpidcard"] = true,
	["darkrp_search"] = true,
	["darkrp_shield_01"] = true,
	["darkrp_shield_02"] = true,
	["darkrp_shield_03"] = true,

	["darkrp_medkit"] = true,
	["darkrp_build"] = true,
	["darkrp_ram"] = true,

	-- tfa
	["tfa_pistol"] = true,
	["tfa_magnum"] = true,

	["tfa_smg1"] = true,
	["tfa_smg2"] = true,
	["tfa_mp5k"] = true,
	["tfa_ar2"] = true,
	["tfa_oicw"] = true,

	["tfa_shotgun"] = true,
	["tfa_psg"] = true,
	["tfa_sniper1"] = true,
	["tfa_sniper3"] = true

}

GM.Config.preventClassItemRemoval = {

	["spawned_shipment"] = false,
	["darkrp_printer_01"] = false,
	["darkrp_printer_02"] = false,
	["darkrp_printer_03"] = false,
	["darkrp_printer_04"] = false

}

GM.Config.allowedProperties = {

	remover = true,
	ignite = false,
	extinguish = false,
	keepupright = false,
	gravity = false,
	collision = false,
	skin = false,
	bodygroups = false

}

GM.NoLicense["weapon_physcannon"] = true
GM.NoLicense["weapon_physgun"] = true
GM.NoLicense["gmod_camera"] = true
GM.NoLicense["gmod_tool"] = true
GM.NoLicense["darkrp_build"] = true
GM.NoLicense["darkrp_cidcard"] = true
GM.NoLicense["darkrp_cpidcard"] = true
GM.NoLicense["darkrp_disguise"] = true
GM.NoLicense["darkrp_inventory"] = true
GM.NoLicense["darkrp_keys"] = true
GM.NoLicense["darkrp_ram"] = true
GM.NoLicense["zck_snowballswep"] = true
GM.NoLicense["darkrp_search"] = true
GM.NoLicense["darkrp_shield_01"] = true
GM.NoLicense["darkrp_shield_02"] = true
GM.NoLicense["darkrp_shield_03"] = true
GM.NoLicense["darkrp_stunstick"] = true
GM.NoLicense["darkrp_taxes"] = true
GM.NoLicense["darkrp_ticket"] = true
GM.NoLicense["weapon_cuff_elastic"] = true
GM.NoLicense["darkrp_medkit"] = true
GM.NoLicense["tfa_pistol"] = true
GM.NoLicense["tfa_mp5k"] = true
GM.NoLicense["tfa_smg2"] = true