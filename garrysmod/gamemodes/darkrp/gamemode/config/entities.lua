local accessjobs = {

	dealers = {
		[TEAM_SMUGGLER] = true,
		[TEAM_GUILD8] = true
	},
	cwu3 = {
		[TEAM_CWU3] = true
	},
	cwu4 = {
		[TEAM_CWU4] = true
	},
	smuggler = {
		[TEAM_SMUGGLER] = true
	}

}

local noaccessjobs = {

	[TEAM_MPF1] = true,
	[TEAM_MPF2] = true,
	[TEAM_MPF3] = true,
	[TEAM_MPF4] = true,
	[TEAM_MPF5] = true,
	[TEAM_MPF6] = true,
	[TEAM_MPF7] = true,
	[TEAM_MPF8] = true,
	[TEAM_MPF9] = true,
	[TEAM_MPF10] = true,
	[TEAM_MPF11] = true,
	[TEAM_MPF12] = true,
	[TEAM_MPF13] = true,
	[TEAM_MPF14] = true,
	[TEAM_MPF15] = true,
	[TEAM_MPF16] = true,
	[TEAM_OTA1] = true,
	[TEAM_OTA2] = true,
	[TEAM_OTA3] = true,
	[TEAM_OTA4] = true,
	[TEAM_OTA5] = true,
	[TEAM_OTA6] = true,
	[TEAM_OTA7] = true,
	[TEAM_OTA8] = true,
	[TEAM_OTA9] = true,
	[TEAM_OTA10] = true,
	[TEAM_CWU5] = true,
	[TEAM_GMAN] = true,
	[TEAM_ARRIVAL] = true

}

local function SpawnFood(mdl, food, tr)

	local ent = ents.Create("darkrp_food")
	ent.Model = mdl
	ent.FoodAmount = food
	ent:SetPos(tr.HitPos + tr.HitNormal * 16)
	ent:Spawn()

	return ent

end

--[[------------------------------------------------------------

	--------
	PRINTERS
	--------

------------------------------------------------------------]]--
DarkRP.createEntity("Малый принтер", {

	ent = "darkrp_printer_01",
	model = "models/props_c17/consolebox03a.mdl",
	price = 2500,
	max = 2,
	cmd = "buyprinter01",

	customCheck = function(ply) return not noaccessjobs[ply:Team()] end,
	CustomCheckFailMsg = "Принтер недоступен для вашей работы",
	category = "Принтеры",
	sortOrder = 1

})

DarkRP.createEntity("Средний принтер", {

	ent = "darkrp_printer_02",
	model = "models/props_c17/consolebox01a.mdl",
	price = 7500,
	max = 1,
	cmd = "buyprinter02",

	customCheck = function(ply) return not noaccessjobs[ply:Team()] end,
	CustomCheckFailMsg = "Принтер недоступен для вашей работы",
	category = "Принтеры",
	sortOrder = 2

})

DarkRP.createEntity("Большой принтер", {

	ent = "darkrp_printer_03",
	model = "models/props_c17/consolebox01a.mdl",
	price = 15000,
	max = 1,
	cmd = "buyprinter03",

	customCheck = function(ply) return not noaccessjobs[ply:Team()] and ply:Donator("silver") end,
	CustomCheckFailMsg = function(ply) return noaccessjobs[ply:Team()] and "Принтер недоступен для вашей работы" or "Принтер доступен только для игроков Silver, Gold и Platinum" end,
	category = "Принтеры",
	sortOrder = 3

})

--[[------------------------------------------------------------

	----
	AMMO
	----

------------------------------------------------------------]]--
DarkRP.createEntity("Патроны 357", {

	ent = "tfa_ammo_357",
	model = "models/items/357ammobox.mdl",
	price = 250,
	max = 3,
	cmd = "buyammo01",

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Патроны",
	sortOrder = 1

})

DarkRP.createEntity("Патроны штурм. винтовок", {

	ent = "tfa_ammo_ar2",
	model = "models/items/boxmrounds.mdl",
	price = 250,
	max = 3,
	cmd = "buyammo02",

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Патроны",
	sortOrder = 2

})

DarkRP.createEntity("Патроны дробовиков", {

	ent = "tfa_ammo_buckshot",
	model = "models/items/boxbuckshot.mdl",
	price = 250,
	max = 3,
	cmd = "buyammo03",

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Патроны",
	sortOrder = 3

})

DarkRP.createEntity("Патроны для пистолетов", {

	ent = "tfa_ammo_pistol",
	model = "models/items/boxsrounds.mdl",
	price = 250,
	max = 3,
	cmd = "buyammo04",

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Патроны",
	sortOrder = 4

})

DarkRP.createEntity("Патроны пист.-пулемётов", {

	ent = "tfa_ammo_smg",
	model = "models/items/boxsrounds.mdl",
	price = 250,
	max = 3,
	cmd = "buyammo05",

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Патроны",
	sortOrder = 5

})

DarkRP.createEntity("Патроны снайп. винтовок", {

	ent = "tfa_ammo_sniper_rounds",
	model = "models/items/sniper_round_box.mdl",
	price = 250,
	max = 3,
	cmd = "buyammo06",

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Патроны",
	sortOrder = 6

})

DarkRP.createEntity("Патроны винчестеров", {

	ent = "tfa_ammo_winchester",
	model = "models/items/sniper_round_box.mdl",
	price = 250,
	max = 3,
	cmd = "buyammo07",

	allowed = {TEAM_SMUGGLER, TEAM_GUILD8},
	category = "Патроны",
	sortOrder = 7

})

--[[------------------------------------------------------------

	LEGAL FOOD

------------------------------------------------------------]]--
DarkRP.createEntity("Апельсин", {
	ent = "darkrp_food_01",
	model = "models/bioshockinfinite/hext_orange.mdl",
	price = 200,
	max = 1,
	cmd = "buyfood01",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Легальная еда",
	sortOrder = 1
})

DarkRP.createEntity("Банан", {
	ent = "darkrp_food_02",
	model = "models/bioshockinfinite/hext_banana.mdl",
	price = 200,
	max = 1,
	cmd = "buyfood02",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Легальная еда",
	sortOrder = 2
})

DarkRP.createEntity("Груша", {
	ent = "darkrp_food_03",
	model = "models/bioshockinfinite/hext_pear.mdl",
	price = 200,
	max = 1,
	cmd = "buyfood03",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Легальная еда",
	sortOrder = 3
})

DarkRP.createEntity("Джин", {
	ent = "darkrp_food_04",
	model = "models/bioshockinfinite/jin_bottle.mdl",
	price = 200,
	max = 1,
	cmd = "buyfood04",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Легальная еда",
	sortOrder = 4
})

DarkRP.createEntity("Пиво", {
	ent = "darkrp_food_05",
	model = "models/bioshockinfinite/hext_bottle_lager.mdl",
	price = 200,
	max = 1,
	cmd = "buyfood05",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Легальная еда",
	sortOrder = 5
})

DarkRP.createEntity("Яблоко", {
	ent = "darkrp_food_06",
	model = "models/bioshockinfinite/hext_apple.mdl",
	price = 200,
	max = 1,
	cmd = "buyfood06",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Легальная еда",
	sortOrder = 6
})

DarkRP.createCategory{
	name = "Легальная еда",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function(ply) return ply:Team() == TEAM_CWU3 end,
	sortOrder = 3
}

--[[------------------------------------------------------------

	ILLEGAL RATION

------------------------------------------------------------]]--
DarkRP.createEntity("Краденый рацион 082-1a", {
	ent = "darkrp_ration_01",
	model = "models/mres/consumables/tag_mre.mdl",
	price = 1000,
	max = 1,
	cmd = "buyration01",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Нелегальные рационы",
	sortOrder = 1
})

DarkRP.createEntity("Краденый рацион 082-1b", {
	ent = "darkrp_ration_02",
	model = "models/mres/consumables/pag_mre.mdl",
	price = 1250,
	max = 1,
	cmd = "buyration02",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Нелегальные рационы",
	sortOrder = 2
})

DarkRP.createEntity("Краденый рацион 082-1c", {
	ent = "darkrp_ration_03",
	model = "models/mres/consumables/zag_mre.mdl",
	price = 1500,
	max = 1,
	cmd = "buyration03",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Нелегальные рационы",
	sortOrder = 3
})

DarkRP.createEntity("Краденый рацион 082-2a", {
	ent = "darkrp_ration_04",
	model = "models/pg_plops/pg_food/pg_tortellinar.mdl",
	price = 2000,
	max = 1,
	cmd = "buyration04",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Нелегальные рационы",
	sortOrder = 4
})

DarkRP.createEntity("Краденый рацион 082-2b", {
	ent = "darkrp_ration_05",
	model = "models/pg_plops/pg_food/pg_tortellinap.mdl",
	price = 3000,
	max = 1,
	cmd = "buyration05",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Нелегальные рационы",
	sortOrder = 5
})

DarkRP.createEntity("Краденый рацион 082-2c", {
	ent = "darkrp_ration_06",
	model = "models/pg_plops/pg_food/pg_tortellinac.mdl",
	price = 4000,
	max = 1,
	cmd = "buyration06",

	-- darkrp
	allowed = TEAM_CWU3,
	category = "Нелегальные рационы",
	sortOrder = 6
})

DarkRP.createCategory{
	name = "Нелегальные рационы",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function(ply) return ply:Team() == TEAM_CWU3 end,
	sortOrder = 4
}

--[[------------------------------------------------------------

	-----------
	MEDICAMENTS
	-----------

------------------------------------------------------------]]--
DarkRP.createEntity("Большая аптечка", {

	ent = "darkrp_healthkit",
	model = "models/items/healthkit.mdl",
	price = 1000,
	max = 2,
	cmd = "buyhealthkit",

	allowed = TEAM_CWU4,
	category = "Медикаменты",
	sortOrder = 1

})

DarkRP.createEntity("Маленькая аптечка", {

	ent = "darkrp_healthvial",
	model = "models/healthvial.mdl",
	price = 500,
	max = 2,
	cmd = "buyhealthvial",

	allowed = TEAM_CWU4,
	category = "Медикаменты",
	sortOrder = 2

})

--[[------------------------------------------------------------

	-----
	ARMOR
	-----

------------------------------------------------------------]]--
DarkRP.createEntity("Броня", {

	ent = "darkrp_suitbattery",
	model = "models/items/battery.mdl",
	price = 200,
	max = 3,
	cmd = "buysuitbattery",

	allowed = TEAM_SMUGGLER,
	category = "Броня",
	sortOrder = 1

})

--[[------------------------------------------------------------

	--------
	UNIFORMS
	--------

------------------------------------------------------------]]--
DarkRP.createEntity("Униформа гражданского", {

	ent = "darkrp_uniform",
	model = "models/props_junk/cardboard_box002a.mdl",
	price = 1000,
	max = 2,
	cmd = "buyuniform",

	allowed = TEAM_SMUGGLER,
	category = "Униформы",
	sortOrder = 1

})

--[[------------------------------------------------------------

	KEYPADS

------------------------------------------------------------]]--
DarkRP.createEntity("Батарея кейпада", {
	ent = "bkeypads_repair",
	model = "models/items/battery.mdl",
	price = 100,
	max = 2,
	cmd = "buykeypadbattery",

	-- darkrp
	customCheck = function(ply) return ply:HasWeapon("weapon_physgun") end,
	CustomCheckFailMsg = "Батарея кейпада не доступна для вашей работы",
	category = "Кейпады",
	sortOrder = 1
})

DarkRP.createEntity("Щит кейпада", {
	ent = "bkeypads_shield",
	model = "models/items/battery.mdl",
	price = 200,
	max = 2,
	cmd = "buykeypadshield",

	-- darkrp
	customCheck = function(ply) return ply:HasWeapon("weapon_physgun") end,
	CustomCheckFailMsg = "Щит кейпада не доступна для вашей работы",
	category = "Кейпады",
	sortOrder = 2
})

--
-- Categories
--
DarkRP.createCategory{

	name = "Принтеры",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function(ply) return not noaccessjobs[ply:Team()] end,
	sortOrder = 1

}

DarkRP.createCategory{

	name = "Патроны",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function(ply) return accessjobs.dealers[ply:Team()] end,
	sortOrder = 2

}

DarkRP.createCategory{

	name = "Легальная продукция",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function(ply) return accessjobs.cwu3[ply:Team()] end,
	sortOrder = 3

}

DarkRP.createCategory{

	name = "Нелегальная продукция",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function(ply) return accessjobs.cwu3[ply:Team()] end,
	sortOrder = 4

}

DarkRP.createCategory{

	name = "Медикаменты",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function(ply) return accessjobs.cwu4[ply:Team()] end,
	sortOrder = 5

}

DarkRP.createCategory{

	name = "Броня",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function(ply) return accessjobs.smuggler[ply:Team()] end,
	sortOrder = 6

}

DarkRP.createCategory{

	name = "Униформы",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function(ply) return accessjobs.smuggler[ply:Team()] end,
	sortOrder = 7

}

DarkRP.createCategory{

	name = "Кейпады",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function(ply) return ply:HasWeapon("weapon_physgun") end,
	sortOrder = 8

}

DarkRP.createCategory{

	name = "Other",
	categorises = "ammo",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function() return true end,
	sortOrder = 255

}

DarkRP.createCategory{

	name = "Other",
	categorises = "entities",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function() return true end,
	sortOrder = 255

}

DarkRP.createCategory{

	name = "Other",
	categorises = "vehicles",
	startExpanded = true,
	color = Color(0, 107, 0),
	canSee = function() return true end,
	sortOrder = 255

}

DarkRP.createCategory{
    name = "Trashman",
    categorises = "entities",
    startExpanded = true,
    color = Color(255, 107, 0, 255),
    canSee = function(ply) return true end,
    sortOrder = 104
}