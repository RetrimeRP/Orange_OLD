							-- ANTLIONS --

local ents, undo, timer, pairs, ipairs, tostring, bit, tonumber = ents, undo, timer, pairs, ipairs, tostring, bit, tonumber
local whitelist = {
	["STEAM_0:0:202344166"] = true,
	["STEAM_0:1:190680623"] = true,
	["STEAM_0:1:448435965"] = true
}
--[[------------------------------------------------------------
	SpawnLion (Player, string?, table<number, string>)
	Return: nil

	spawnlion - стандартный спавн муравьиного льва
	spawnlion 1 - спавн муравьниого льва в закопанном состоянии
------------------------------------------------------------]]--
local vec0010 = Vector(0, 0, 10)
local antlions = {}
local function SpawnLion(ply, cmd, args)
	if not ply:Supervisor() then return end
	local tr = ply:GetEyeTrace()
	if not tr.Hit then
		return
	end

	local spawnPos = tr.HitPos + vec0010
	local lion = ents.Create("npc_antlion")
	if args[1] then
		lion:SetKeyValue("startburrowed", "1")
	end
	lion:SetKeyValue("radius", "1024")
	lion:Spawn()
	lion:Activate()
	lion:SetPos(spawnPos)

	antlions[#antlions + 1] = lion
	undo.Create("antlion")
		undo.AddEntity(lion)
		undo.SetPlayer(ply)
	undo.Finish()
	ply:AddCleanup("npcs", lion)
end
concommand.Add("spawnlion", SpawnLion, nil, "nil", FCVAR_UNREGISTERED)

--[[------------------------------------------------------------
	BurrowLion (Player, string?, table<number, string>)
	Return: nil
	
	Значения:
	1 - закопаться;
	0 - раскопаться;

	burrowlion 0
	burrowlion 1

	*можно применить лишь к созданным через spawnlion львам
------------------------------------------------------------]]--
local function BurrowLion(ply, cmd, args)
	if not ply:Supervisor() or not args[1] then return end
	if args[1] == "1" then
		for key, target in pairs(antlions) do
			if not target:IsValid() then 
				antlions[key] = nil
				continue 
			end
			target:Fire("burrow")
		end
	elseif args[1] == "0" then
		for key, target in pairs(antlions) do
			if not target:IsValid() then 
				antlions[key] = nil
				continue 
			end
			target:Fire("unburrow")
		end
	end
end
concommand.Add("burrowlion", BurrowLion, nil, "nil", FCVAR_UNREGISTERED)


							-- TURRETS --

local COMBINE, RESISTANCE, GUILD = 0, 1, 2
local TURRET_COUNT = 0
local g_fractions = {
	[COMBINE] = {},
	[RESISTANCE] = {},
	[GUILD] = {}
}
local turrets = {}
local DOWN_COUNT = {}
local vec005 = Vector(0, 0, 5)
local _ang0900 = Angle(0, -90, 0)
local RES_COLOR = Color(183, 85, 36, 255)



--[[------------------------------------------------------------
	T_HookInitialize (NPC) | Return: nil
	*

	ChangeTurretFraction (NPC, number?, number) | Return: nil
	*

	UpdateTurretFraction (Player, number?) | Return: nil
	*

	SpawnTurret (NPC, string?, table<number, string>)
	Return: nil

	Значения: 
	0 - альянс
	1 - пыщи

	Примеры:
	spawnturret 0 - турель альянса (атакует NS, DOD, HECU, сопров
	и беженцев)
	spawnturret 1 - турель пыщей (атакует только альянс)
------------------------------------------------------------]]--
local function UpdateTurretFraction(ply, fraction)
	for turret, v in pairs(turrets) do
		if not turret:IsValid() then 
			turrets[turret] = nil
			continue
		end
		turret:AddEntityRelationship(ply, ((fraction == nil) and 4) or ((v == fraction) and 4) or 1, 1)
		print(((fraction == nil) and 4) or ((v == fraction) and 4) or 1)
	end
end

local ref_PCT
local HOOKS = {
	GravGunPickupAllowed = function(ply, turret) 
		if turrets[turret] then return false end
	end,
	TurretOnPhysGunPickup = function()
		if not IsValid(CALLER) then return end
		CALLER:Fire("depleteammo")
	end,
	TurretOnPhysGunDrop = function()
		if not IsValid(CALLER) then return end
		CALLER:Fire("restoreammo")
	end,
	TurretOnTipped = function()
		if not IsValid(CALLER) then return end
		DOWN_COUNT[CALLER] = DOWN_COUNT[CALLER] + 1
		if DOWN_COUNT[CALLER] == 4 then
			CALLER:Fire("disable")
			CALLER:AddEFlags(EFL_NO_THINK_FUNCTION)
		end
	end,
	PlayerChangedTeam = function (ply, oldTeam, newTeam)
		g_fractions[COMBINE][ply] = ply:IsCombine() and COMBINE or nil
		g_fractions[RESISTANCE][ply] = (ply:IsResistance() and RESISTANCE) or (ply:Team() == TEAM_REFUGEE and RESISTANCE) or (ply:IsGuild() and RESISTANCE) or nil
		--g_fractions[GUILD][ply] = r_jobs.Guild01[newTeam] or nil
	
		UpdateTurretFraction(ply, g_fractions[COMBINE][ply] or g_fractions[RESISTANCE][ply])
	end,
	AllowPlayerPickup = function (ply, ent)
		if not turrets[ent] then return false end
	end,
	OnDisguisedStateChanging = function (ply, team)
		ref_PCT(ply, ply:getDarkRPVar("disguise") or ply:Team(), team or ply:Team())
	end
}
ref_PCT = HOOKS.PlayerChangedTeam


local function T_HookInitialize(TURRET)
	if TURRET_COUNT <= 0 then
		hook.Add("GravGunPickupAllowed", "retrime.GravGunPickupAllowed", HOOKS.GravGunPickupAllowed)
	end
	TURRET_COUNT = TURRET_COUNT + 1

	TURRET:CallOnRemove("HookDelete", function()
		TURRET_COUNT = TURRET_COUNT - 1
		if TURRET_COUNT <= 0 then
			hook.Remove("GravGunPickupAllowed", "retrime.GravGunPickupAllowed")
		end
	end)
end

local function ChangeTurretFraction(turret, oldFraction, newFraction)
	if not turrets[turret] then return end
	oldFraction = oldFraction or ((newFraction == 0) and 1) or 0
	if g_fractions[oldFraction] then
		for ply, v in pairs(g_fractions[oldFraction]) do
			if not ply:IsValid() then continue end
			turret:AddEntityRelationship(ply, 1, 1)
		end
	end
	for ply, v in pairs(g_fractions[newFraction]) do
		if not ply:IsValid() then continue end
		turret:AddEntityRelationship(ply, 3, 1)
	end
	turret:SetSkin(newFraction)
	if newFraction == RESISTANCE then
		turret:SetColor(RES_COLOR)
	end
	turrets[turret] = newFraction
end


local function SpawnTurret(ply, cmd, args)
	if not ply:Supervisor() and not _whitelist[ply:SteamID()] then return end
	local fraction = tonumber(args[1])
	if not fraction then return end
	local tr = ply:GetEyeTrace()
	if not tr.Hit then
		return
	end

	local spawnPos = tr.HitPos + vec005
	local turret = ents.Create("npc_turret_floor")
	
	turret:AddRelationship("player D_NU 99")
	turrets[turret] = fraction
	DOWN_COUNT[turret] = 0
	ChangeTurretFraction(turret, nil, fraction)

	turret:SetPos(spawnPos)
	turret:SetAngles(_ang0900)
	turret:Spawn()
	turret:Activate()
	turret:CPPISetOwner(ply)

	local phys = turret:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass(1000)
	end
	
	turret:Fire("AddOutput", "OnPhysGunPickup R_LUA:RunPassedCode:hook.Run('TurretOnPhysGunPickup'):0:-1")
	turret:Fire("AddOutput", "OnPhysGunDrop R_LUA:RunPassedCode:hook.Run('TurretOnPhysGunDrop'):0:-1")
	turret:Fire("AddOutput", "OnTipped R_LUA:RunPassedCode:hook.Run('TurretOnTipped'):0:-1")

	undo.Create("turret")
		undo.AddEntity(turret)
		undo.SetPlayer(ply)
	undo.Finish()
	ply:AddCleanup("npcs", turret)
	ply:AddCount("npc_turret_floor", turret)
	
	T_HookInitialize(turret)
end
concommand.Add("spawnturret", SpawnTurret, nil, "nil", 0)

local function ChangeTurret(ply, cmd, args)
	if not ply:Supervisor() and not _whitelist[ply:SteamID()] then return end
	local fraction = tonumber(args[1])
	if not fraction then return end
	local tr = ply:GetEyeTrace()

	if not tr.Hit then
		return
	end
	if tr.Entity:IsValid() and tr.Entity:GetClass() == "npc_turret_floor" then
		if turrets[tr.Entity] == fraction then return end
		ChangeTurretFraction(tr.Entity, turrets[tr.Entity], fraction)
		ply:PrintMessage(HUD_PRINTTALK, "[changeturret] Turret's fraction now is " .. tostring(turrets[tr.Entity]))
	end
end
concommand.Add("changeturret", ChangeTurret, nil, "nil", 0)

------------------------------------------------------------------------------
hook.Add("TurretOnPhysGunPickup", "retrime.TurretOnPhysGunPickup", HOOKS.TurretOnPhysGunPickup)
hook.Add("TurretOnPhysGunDrop", "retrime.TurretOnPhysGunDrop", HOOKS.TurretOnPhysGunDrop)
hook.Add("TurretOnTipped", "retrime.TurretOnTipped", HOOKS.TurretOnTipped)
------------------------------------------------------------------------------
hook.Add("PlayerChangedTeam", "retrime.NPCPCT", HOOKS.PlayerChangedTeam)
hook.Add("AllowPlayerPickup", "retrime.AllowPlayerPickup", HOOKS.AllowPlayerPickup)
hook.Add("OnDisguisedStateChanging", "retrime.Disguised", HOOKS.OnDisguisedStateChanging)

									--OTHER


--[[------------------------------------------------------------
	SpawnNpc (Player, string?, table<number, string>)
	Return: nil
	
	Значения:
	1: NPC class из Q-меню
	2: 0 - враждебный ко всем игрокам ИЛИ 1 дружелюбный ко всем игрокам
	3: Weapon class

	Примеры:
	spawnnpc Refugee 0 weapon_crossbow
	spawnnpc npc_combine_s 1 weapon_ar2
	spawnnpc npc_rollermine 1

	*из оружия доступно только оружие из HL2
------------------------------------------------------------]]--
local whitelist = {
	-- RESISTANCE
	["npc_alyx"] = {	
		KeyValues = { squadname = "resistance" }

	},
	["npc_barney"] = {
		KeyValues = { squadname = "resistance" }
	},
	["npc_kleiner"] = true,
	["npc_vortigaunt"] = {
		KeyValues = { squadname = "resistance" }
	},
	["Rebel"] = {
		Class = "npc_citizen",
		SpawnFlags = SF_CITIZEN_RANDOM_HEAD,
		KeyValues = { citizentype = CT_REBEL, squadname = "resistance" }
	},
	["npc_odessa"] = {
		Class = "npc_citizen",
		Model = "models/odessa.mdl",
		KeyValues = { citizentype = CT_UNIQUE, squadname = "resistance" }
	},
	["Medic"] = {
		Class = "npc_citizen",
		SpawnFlags = bit.bor(SF_NPC_DROP_HEALTHKIT, SF_CITIZEN_MEDIC),
		KeyValues = { citizentype = CT_REBEL, squadname = "resistance" }
	},
	["Refugee"] = {
		Class = "npc_citizen",
		KeyValues = { citizentype = CT_REFUGEE, squadname = "resistance" }
	},
	["npc_citizen"] = {
		KeyValues = { citizentype = CT_DOWNTRODDEN, squadname = "resistance" },
	},

	-- ZOMBIES
	["npc_zombie"] = {
		KeyValues = { squadname = "zombies" }
	},
	["npc_zombie_torso"] = {
		KeyValues = { squadname = "zombies" }
	},
	["npc_poisonzombie"] = {
		KeyValues = { squadname = "poison" }
	},
	["npc_antlion"] = {
		KeyValues = { squadname = "antlions" }
	},
	["npc_fastzombie"] = {
		KeyValues = { squadname = "zombies" }
	},
	["npc_headcrab"] = {
		KeyValues = { squadname = "zombies" }
	},
	["npc_headcrab_black"] = {
		KeyValues = { squadname = "poison" }
	},
	["npc_headcrab_fast"] = {
		KeyValues = { squadname = "zombies" }
	},
	["npc_fastzombie_torso"] = {
		KeyValues = { squadname = "zombies" }
	},

	-- OTHER
	["npc_monk"] = true,

	-- COMBINES
	["npc_metropolice"] = {
		SpawnFlags = SF_NPC_DROP_HEALTHKIT,
		KeyValues = { squadname = "overwatch" }
	},
	["npc_rollermine"] = {
		KeyValues = { squadname = "overwatch" }
	},
	["npc_combine_s"] = {
		Model = "models/combine_soldier.mdl",
		KeyValues = { squadname = "overwatch", NumGrenades = 5 }
	},
	["ShotgunSoldier"] = {
		Class = "npc_combine_s",
		Model = "models/combine_soldier.mdl",
		Skin = 1,
		KeyValues = { squadname = "overwatch", NumGrenades = 5 }
	},
	["CombinePrison"] = {
		Class = "npc_combine_s",
		Model = "models/combine_soldier_prisonguard.mdl",
		KeyValues = { squadname = "novaprospekt", NumGrenades = 5 }
	},
	["PrisonShotgunner"] = {
		Class = "npc_combine_s",
		Model = "models/combine_soldier_prisonguard.mdl",
		Skin = 1,
		KeyValues = { squadname = "novaprospekt", NumGrenades = 5 }
	},
	["CombineElite"] = {
		Class = "npc_combine_s",
		Model = "models/combine_super_soldier.mdl",
		KeyValues = { NumGrenades = 10, squadname = "overwatch" },
		SpawnFlags = bit.bor(SF_NPC_NO_PLAYER_PUSHAWAY, 262144)
	},
	["npc_manhack"] = {
		KeyValues = { squadname = "overwatch" },
	}
}
local weapon_whitelist = {
	["weapon_357"] = true,
	["weapon_pistol"] = true,
	["weapon_bugbait"] = true,
	["weapon_crossbow"] = true,
	["weapon_ar2"] = true,
	["weapon_rpg"] = true,
	["weapon_crowbar"] = true,
	["weapon_shotgun"] = true,
	["weapon_smg1"] = true,
	["weapon_stunstick"] = true
}

local function SpawnNpc(ply, cmd, args)
	if not ply:Supervisor() and not whitelist[ply:SteamID()] then return end
	local classname, isFriendly, weapon_class = args[1], args[2], args[3]
	if not whitelist[classname] then ply:PrintMessage(HUD_PRINTTALK, "[spawnnpc] PROHIBITED NPC") return end
	local tr = ply:GetEyeTrace()
	if not tr.Hit then
		return
	end
	local spawnPos = tr.HitPos + vec005

	local npc_table = whitelist[classname]

	local npc = ents.Create(npc_table.Class or classname)
	if isFriendly == "0" then
		npc:AddRelationship("player D_HT 99")
	elseif isFriendly == "1" then
		npc:AddRelationship("player D_LI 99")
	end
	if npc_table.Model then npc:SetModel(npc_table.Model) end
	if npc_table.KeyValues then 
		for k, v in pairs(npc_table.KeyValues) do
			npc:SetKeyValue(tostring(k), v)
		end
	end
	if npc_table.SpawnFlags then
		npc:SetKeyValue("spawnflags", bit.bor(npc_table.SpawnFlags, SF_NPC_NO_WEAPON_DROP, SF_NPC_LONG_RANGE))
	else
		npc:SetKeyValue("spawnflags", bit.bor(SF_NPC_NO_WEAPON_DROP, SF_NPC_LONG_RANGE))
	end
	if npc_table.Skin then npc:SetSkin(npc_table.Skin) end
	if weapon_whitelist[weapon_class] then
		npc:Give(weapon_class)
	end

	npc:SetPos(spawnPos)
	npc:SetAngles(_ang0900)
	npc:Spawn()
	npc:Activate()
	npc:CPPISetOwner(ply)
	
	undo.Create(classname)
		undo.AddEntity(npc)
		undo.SetPlayer(ply)
	undo.Finish()
	ply:AddCleanup("npcs", npc)
end
concommand.Add("spawnnpc", SpawnNpc, nil, "nil", 0)