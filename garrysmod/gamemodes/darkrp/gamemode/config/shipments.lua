local accessjobs = {

	dealers = {
		[TEAM_SMUGGLER] = true,
		[TEAM_GUILD8] = true
	},
	guild8 = {
		[TEAM_GUILD8] = true
	}

}

--[[------------------------------------------------------------

	-------
	PISTOLS
	-------

------------------------------------------------------------]]--
DarkRP.createShipment("GLOCK 18", {

	model = "models/orange/weapons/w_models/wpn_glock_w.mdl",
	entity = "tfa_glock",
	price = 14000,
	amount = 5,
	separate = true,
	pricesep = 2800,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Пистолеты",
	sortOrder = 1

})

DarkRP.createShipment("FNX-45 TACTICAL", {

	model = "models/orange/weapons/w_models/wpn_fnx45_w.mdl",
	entity = "tfa_fnx45",
	price = 16000,
	amount = 5,
	separate = true,
	pricesep = 3200,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Пистолеты",
	sortOrder = 2

})

DarkRP.createShipment("ПМ", {

	model = "models/flaymi/anomaly/weapons/w_models/wpn_pm_w.mdl",
	entity = "tfa_pm",
	price = 13000,
	amount = 5,
	separate = true,
	pricesep = 2600,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Пистолеты",
	sortOrder = 3

})

DarkRP.createShipment("DESERT EAGLE", {

	model = "models/orange/weapons/w_models/wpn_desert_eagle_w.mdl",
	entity = "tfa_desert_eagle",
	price = 21000,
	amount = 5,
	separate = true,
	pricesep = 4200,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Пистолеты",
	sortOrder = 4

})

DarkRP.createShipment("BERETTA 92F", {

	model = "models/orange/weapons/w_models/wpn_beretta92fs.mdl",
	entity = "tfa_beretta",
	price = 19000,
	amount = 5,
	separate = true,
	pricesep = 3800,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Пистолеты",
	sortOrder = 5

})

DarkRP.createShipment("COLT M1911", {

	model = "models/orange/weapons/w_models/wpn_colt1911_w.mdl",
	entity = "tfa_colt1911",
	price = 17000,
	amount = 5,
	separate = true,
	pricesep = 3400,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Пистолеты",
	sortOrder = 6

})

--[[------------------------------------------------------------

	---------- ----
	SUBMACHINE GUNS
	---------- ----

------------------------------------------------------------]]--
DarkRP.createShipment("SCORPION VZ.61", {

	model = "models/orange/weapons/w_models/wpn_vz61_w.mdl",
	entity = "tfa_vz61",
	price = 23000,
	amount = 5,
	separate = true,
	pricesep = 4600,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Пистолеты-пулемёты",
	sortOrder = 1

})

DarkRP.createShipment("H&K MP7", {

	model = "models/orange/weapons/w_models/wpn_mp7_w.mdl",
	entity = "tfa_mp7",
	price = 28000,
	amount = 5,
	separate = true,
	pricesep = 5600,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Пистолеты-пулемёты",
	sortOrder = 2

})

DarkRP.createShipment("MP5SD", {

	model = "models/orange/weapons/w_models/wpn_mp5sd_w.mdl",
	entity = "tfa_mp5sd",
	price = 25000,
	amount = 5,
	separate = true,
	pricesep = 5000,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Пистолеты-пулемёты",
	sortOrder = 3

})

DarkRP.createShipment("H&K UMP 45", {

	model = "models/orange/weapons/w_models/wpn_ump45_w.mdl",
	entity = "tfa_ump45",
	price = 27000,
	amount = 5,
	separate = true,
	pricesep = 5400,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Пистолеты-пулемёты",
	sortOrder = 4

})

DarkRP.createShipment("P90", {

	model = "models/orange/weapons/w_models/wpn_p90_w.mdl",
	entity = "tfa_p90",
	price = 30000,
	amount = 5,
	separate = true,
	pricesep = 6000,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Пистолеты-пулемёты",
	sortOrder = 5

})

--[[------------------------------------------------------------

	------- ------
	ASSAULT RIFLES
	------- ------

------------------------------------------------------------]]--
DarkRP.createShipment("GALIL", {

	model = "models/weapons/w_rif_galil.mdl",
	entity = "tfa_galil",
	price = 41000,
	amount = 5,
	separate = true,
	pricesep = 8200,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Штурмовые винтовки",
	sortOrder = 1

})

DarkRP.createShipment("FN SCAR-H", {

	model = "models/orange/weapons/w_models/wpn_scar_w.mdl",
	entity = "tfa_scar",
	price = 45000,
	amount = 5,
	separate = true,
	pricesep = 9000,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Штурмовые винтовки",
	sortOrder = 2

})

DarkRP.createShipment("AKМ", {

	model = "models/orange/weapons/w_models/wpn_akm.mdl",
	entity = "tfa_akm",
	price = 54000,
	amount = 5,
	separate = true,
	pricesep = 10800,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Штурмовые винтовки",
	sortOrder = 3

})

DarkRP.createShipment("M4A1", {

	model = "models/orange/weapons/w_models/wpn_m4a1_w.mdl",
	entity = "tfa_m4a1",
	price = 58000,
	amount = 5,
	separate = true,
	pricesep = 11600,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Штурмовые винтовки",
	sortOrder = 4

})

DarkRP.createShipment("SIG SG552 COMMANDO", {

	model = "models/orange/weapons/w_models/wpn_sig552_w.mdl",
	entity = "tfa_sig552",
	price = 61000,
	amount = 5,
	separate = true,
	pricesep = 12200,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Штурмовые винтовки",
	sortOrder = 5

})

DarkRP.createShipment("STEYR AUG A1", {

	model = "models/orange/weapons/w_models/w_aug_a1.mdl",
	entity = "tfa_aug_a1",
	price = 63000,
	amount = 5,
	separate = true,
	pricesep = 12600,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Штурмовые винтовки",
	sortOrder = 6

})

--[[------------------------------------------------------------

	-------- --- ------- ----
	SHOTGUNS AND MACHINE GUNS
	-------- --- ------- ----

------------------------------------------------------------]]--
DarkRP.createShipment("REMINGTON 870", {

	model = "models/orange/weapons/w_models/wpn_remington870_w.mdl",
	entity = "tfa_remington870",
	price = 35000,
	amount = 5,
	separate = true,
	pricesep = 7000,

	allowed = TEAM_GUILD8,
	category = "Дробовики и пулемёты",
	sortOrder = 1

})

DarkRP.createShipment("MP-153", {

	model = "models/orange/weapons/w_models/wpn_mp153_w.mdl",
	entity = "tfa_mp153",
	price = 50000,
	amount = 5,
	separate = true,
	pricesep = 10000,

	allowed = TEAM_GUILD8,
	category = "Дробовики и пулемёты",
	sortOrder = 2

})

DarkRP.createShipment("ПКМ", {

	model = "models/orange/weapons/w_models/wpn_pkm_w.mdl",
	entity = "tfa_pkm",
	price = 65000,
	amount = 5,
	separate = true,
	pricesep = 13000,

	allowed = TEAM_GUILD8,
	category = "Дробовики и пулемёты",
	sortOrder = 3

})

--[[------------------------------------------------------------

	------ ------
	SNIPER RIFLES
	------ ------

------------------------------------------------------------]]--
DarkRP.createShipment("ВИНТОВКА МОСИНА", {

	model = "models/orange/weapons/w_models/wpn_mosin_w.mdl",
	entity = "tfa_mosin",
	price = 85000,
	amount = 5,
	separate = true,
	pricesep = 17000,

	allowed = TEAM_GUILD8,
	category = "Снайперские винтовки",
	sortOrder = 1

})

DarkRP.createShipment("СВ-98", {

	model = "models/orange/weapons/w_models/wpn_sv98_w.mdl",
	entity = "tfa_sv98",
	price = 100000,
	amount = 5,
	separate = true,
	pricesep = 20000,

	allowed = TEAM_GUILD8,
	category = "Снайперские винтовки",
	sortOrder = 2

})

DarkRP.createShipment("G3 SG1", {

	model = "models/orange/weapons/w_models/wpn_g3sg1_w.mdl",
	entity = "tfa_g3sg1",
	price = 125000,
	amount = 5,
	separate = true,
	pricesep = 25000,

	allowed = TEAM_GUILD8,
	category = "Снайперские винтовки",
	sortOrder = 3

})

DarkRP.createShipment("SR-25", {

	model = "models/orange/weapons/w_models/wpn_sr25_w.mdl",
	entity = "tfa_sr25",
	price = 120000,
	amount = 5,
	separate = true,
	pricesep = 24000,

	allowed = TEAM_GUILD8,
	category = "Снайперские винтовки",
	sortOrder = 4

})

--[[------------------------------------------------------------

	-----
	OTHER
	-----

------------------------------------------------------------]]--
DarkRP.createShipment("Отмычки", {

	model = "models/weapons/w_crowbar.mdl",
	entity = "darkrp_lockpick",
	price = 7500,
	amount = 5,
	separate = true,
	pricesep = 1500,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Остальное",
	sortOrder = 1

})

DarkRP.createShipment("Взломщики кейпадов", {

	model = "models/weapons/w_c4.mdl",
	entity = "base_keypadcracker",
	price = 10000,
	amount = 5,
	separate = true,
	pricesep = 2000,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Остальное",
	sortOrder = 2

})

DarkRP.createShipment("Гитара", {

	model = "models/props_phx/misc/fender.mdl",
	entity = "weapon_guitar",
	price = 10000,
	amount = 5,
	separate = true,
	pricesep = 2000,

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Остальное",
	sortOrder = 3

})

DarkRP.createShipment("Нож", {

	model = "models/weapons/w_knife_t.mdl",
	entity = "tfa_knife",
	price = 3750,
	amount = 5,
	separate = true,
	pricesep = 750,

	allowed = TEAM_SMUGGLER,
	category = "Остальное",
	sortOrder = 4

})

--
-- Categories
--
DarkRP.createCategory{

	name = "Пистолеты",
	categorises = "shipments",
	startExpanded = true,
	color = Color(0,107,0),
	canSee = function(ply) return accessjobs.dealers[ply:Team()] end,
	sortOrder = 1

}

DarkRP.createCategory{

	name = "Пистолеты-пулемёты",
	categorises = "shipments",
	startExpanded = true,
	color = Color(0,107,0),
	canSee = function(ply) return accessjobs.dealers[ply:Team()] end,
	sortOrder = 2

}

DarkRP.createCategory{

	name = "Штурмовые винтовки",
	categorises = "shipments",
	startExpanded = true,
	color = Color(0,107,0),
	canSee = function(ply) return accessjobs.dealers[ply:Team()] end,
	sortOrder = 3

}

DarkRP.createCategory{

	name = "Дробовики и пулемёты",
	categorises = "shipments",
	startExpanded = true,
	color = Color(0,107,0),
	canSee = function(ply) return accessjobs.guild8[ply:Team()] end,
	sortOrder = 4

}

DarkRP.createCategory{

	name = "Снайперские винтовки",
	categorises = "shipments",
	startExpanded = true,
	color = Color(0,107,0),
	canSee = function(ply) return accessjobs.guild8[ply:Team()] end,
	sortOrder = 5

}

DarkRP.createCategory{

	name = "Остальное",
	categorises = "shipments",
	startExpanded = true,
	color = Color(0,107,0),
	canSee = function(ply) return accessjobs.dealers[ply:Team()] end,
	sortOrder = 6

}

DarkRP.createCategory{

	name = "Other",
	categorises = "shipments",
	startExpanded = true,
	color = Color(0,107,0),
	canSee = function() return true end,
	sortOrder = 255

}

DarkRP.createCategory{

	name = "Other",
	categorises = "weapons",
	startExpanded = true,
	color = Color(0,107,0),
	canSee = function() return true end,
	sortOrder = 255

}