local entMeta = FindMetaTable("Entity")

-- Maintains entities that are to be removed after disconnect
local queuedForRemoval = {}

--[[---------------------------------------------------------------------------
DarkRP hooks
---------------------------------------------------------------------------]]
function GM:Initialize()

	self.Sandbox.Initialize(self)

end

function GM:playerBuyDoor(ply, ent)

	return true

end

function GM:getDoorCost(ply, ent)

	return GAMEMODE.Config.doorcost

end

function GM:getVehicleCost(ply, ent)

	return GAMEMODE.Config.vehiclecost

end

local disallowedNames = {

	["ooc"] = true,
	["shared"] = true,
	["world"] = true,
	["world prop"] = true

}

function GM:CanChangeRPName(ply, name)

	if disallowedNames[string.lower(name)] then
		return false, DarkRP.getPhrase("forbidden_name")
	end

	if not string.match(name, "^[a-zA-Z0 ]+$") then
		return false, DarkRP.getPhrase("illegal_characters")
	end

	local len = string.len(name)

	if len > 30 then
		return false, DarkRP.getPhrase("too_long")
	end

	if len < 3 then return
		false, DarkRP.getPhrase("too_short")
	end

end

function GM:canDemote(ply, target, reason)
end

function GM:canVote(ply, vote)
end

function GM:playerWalletChanged(ply, amount)
end

function GM:playerGetSalary(ply, amount)
end

function GM:DarkRPVarChanged(ply, var, oldvar, newvalue)
end

function GM:playerBoughtVehicle(ply, ent, cost)
end

function GM:playerBoughtDoor(ply, ent, cost)
end

function GM:canDropWeapon(ply, weapon)

	if not IsValid(weapon) then return false end

	local class = string.lower(weapon:GetClass())

	if not GAMEMODE.Config.dropspawnedweapons then
		local jobTable = ply:getJobTable()
		if jobTable.weapons and table.HasValue(jobTable.weapons, class) then return false end
	end

	if self.Config.DisallowDrop[class] then return false end

	if not GAMEMODE.Config.restrictdrop then return true end

	for _, v in pairs(CustomShipments) do
		if v.entity ~= class then continue end

		return true
	end

	return false

end

function GM:DatabaseInitialized()

	DarkRP.initDatabase()

end

function GM:canSeeLogMessage(ply, message, colour)

	return true

end

function GM:canEarnNPCKillPay(ply, npc)

	return GAMEMODE.Config.npckillpay > 0

end

function GM:calculateNPCKillPay(ply, npc)

	if npc.KillValue then
		return npc.KillValue
	end

	return GAMEMODE.Config.npckillpay

end

--[[------------------------------------------------------------

	Prop, SWEP, SENT, NPC, Vehicle, Ragdoll, Effect

------------------------------------------------------------]]--
function GM:PlayerSpawnProp(ply, mdl)

	if ply:isArrested() then return false end

	mdl = string.gsub(tostring(mdl), "\\", "/")
	mdl = string.gsub(tostring(mdl), "//", "/")

	return self.Sandbox.PlayerSpawnProp(self, ply, mdl)

end

function GM:PlayerSpawnSWEP(ply, class, info)

	return ply:IsSuperAdmin() and self.Sandbox.PlayerSpawnSWEP(self, ply, class, info)

end

function GM:PlayerGiveSWEP(ply, class, info)

	return ply:IsSuperAdmin() and self.Sandbox.PlayerGiveSWEP(self, ply, class, info)

end

function GM:PlayerSpawnSENT(ply, class)

	return ply:Staff() and self.Sandbox.PlayerSpawnSENT(self, ply, class) -- ply:Supervisor()

end

function GM:PlayerSpawnNPC(ply, type, weapon)

	return ply:Supervisor() and self.Sandbox.PlayerSpawnNPC(self, ply, type, weapon) -- ИЗМЕНЕНО 16.09.2022

end

function GM:PlayerSpawnVehicle(ply, model, class, info)

	return ply:Eventer() and self.Sandbox.PlayerSpawnVehicle(self, ply, model, class, info) -- ИЗМЕНЕНО 16.09.2022

end

function GM:PlayerSpawnRagdoll(ply, mdl)

	return ply:Eventer() and self.Sandbox.PlayerSpawnRagdoll(self, ply, mdl) -- ИЗМЕНЕНО 16.09.2022

end

--[[------------------------------------------------------------

	Prop, SWEP, SENT, NPC, Vehicle, Ragdoll, Effect

------------------------------------------------------------]]--
function GM:PlayerSpawnedProp(ply, mdl, ent)

	self.Sandbox.PlayerSpawnedProp(self, ply, mdl, ent)

	ent.SID = ply.SID
	ent:CPPISetOwner(ply)

	local phys = ent:GetPhysicsObject()

	if IsValid(phys) then
		ent.RPOriginalMass = phys:GetMass()
	end

end

function GM:PlayerSpawnedSENT(ply, ent)

	self.Sandbox.PlayerSpawnedSENT(self, ply, ent)

end

function GM:PlayerSpawnedNPC(ply, ent)

	self.Sandbox.PlayerSpawnedNPC(self, ply, ent)

end

function GM:PlayerSpawnedVehicle(ply, ent)

	self.Sandbox.PlayerSpawnedVehicle(self, ply, ent)

end

function GM:PlayerSpawnedRagdoll(ply, mdl, ent)

	self.Sandbox.PlayerSpawnedRagdoll(self, ply, mdl, ent)

	ent.SID = ply.SID

end

function GM:PlayerSpawnEffect(ply, mdl)

	return self.Sandbox.PlayerSpawnEffect(self, ply, mdl)

end

--[[------------------------------------------------------------

	DarkRP

------------------------------------------------------------]]--
function GM:EntityRemoved(ent)
	self.Sandbox.EntityRemoved(self, ent)
	if ent:IsVehicle() then
		local found = ent:CPPIGetOwner()
		if IsValid(found) then
			found.Vehicles = found.Vehicles or 1
			found.Vehicles = found.Vehicles - 1
		end
	end

	local owner = ent.Getowning_ent and ent:Getowning_ent() or Player(ent.SID or 0)
	if ent.DarkRPItem and IsValid(owner) and not ent.IsPocketing then owner:removeCustomEntity(ent.DarkRPItem) end
	if ent.isKeysOwnable and ent:isKeysOwnable() then ent:removeDoorData() end
end

function GM:ShowSpare1(ply)
end

function GM:ShowSpare2(ply)
end

function GM:ShowTeam(ply)
end

function GM:ShowHelp(ply)
end

function GM:PlayerSpray()

	return true

end

function GM:OnNPCKilled(victim, ent, weapon)
end

function GM:KeyPress(ply, key)

	self.Sandbox.KeyPress(self, ply, key)

end

--[[------------------------------------------------------------

	DarkRP

------------------------------------------------------------]]--
local roomTrResult = {}
local roomTr = {output = roomTrResult}

local function IsInRoom(listenerShootPos, talkerShootPos, talker)

	roomTr.start = talkerShootPos
	roomTr.endpos = listenerShootPos
	roomTr.filter = talker
	roomTr.collisiongroup = COLLISION_GROUP_WORLD
	roomTr.mask = MASK_SOLID_BRUSHONLY

	util.TraceLine(roomTr)

	return not roomTrResult.HitWorld

end

local threed = GM.Config.voice3D
local vrad = GM.Config.voiceradius
local dynv = GM.Config.dynamicvoice
local deadv = GM.Config.deadvoice
local voiceDistance = GM.Config.voiceDistance * GM.Config.voiceDistance
local DrpCanHear = {}

for _, ply in pairs(player.GetAll()) do

	DrpCanHear[ply] = {}

end

local gridSize = GM.Config.voiceDistance
local floor = math.floor
local grid
local plyToGrid = {{}, {}}

timer.Create("DarkRPCanHearPlayersVoice", 0.6, 0, function()

	if not vrad then return end

	local players = player.GetHumans()

	plyToGrid[1] = {}
	plyToGrid[2] = {}
	grid = {}

	local plyPos = {}
	local eyePos = {}

	for _, ply in ipairs(players) do
		local pos = ply:GetPos()
		plyPos[ply] = pos
		eyePos[ply] = ply:EyePos()
		local x = floor(pos.x / gridSize)
		local y = floor(pos.y / gridSize)

		local row = grid[x] or {}
		local cell = row[y] or {}

		table.insert(cell, ply)
		row[y] = cell
		grid[x] = row

		plyToGrid[1][ply] = x
		plyToGrid[2][ply] = y

		DrpCanHear[ply] = {}
	end

	for _, ply1 in ipairs(players) do
		local gridX = plyToGrid[1][ply1]
		local gridY = plyToGrid[2][ply1]
		local ply1Pos = plyPos[ply1]
		local ply1EyePos = eyePos[ply1]

		for i = 0, 3 do
			local vOffset = 1 - ((i >= 3) and 1 or 0)
			local hOffset = -(i % 3-1)
			local x = gridX + hOffset
			local y = gridY + vOffset

			local row = grid[x]
			if not row then continue end

			local cell = row[y]
			if not cell then continue end

			for _, ply2 in ipairs(cell) do
				local canTalk =
					ply1Pos:DistToSqr(plyPos[ply2]) < voiceDistance and
						(not dynv or IsInRoom(ply1EyePos, eyePos[ply2], ply2))

				DrpCanHear[ply1][ply2] = canTalk and (deadv or ply2:Alive())
				DrpCanHear[ply2][ply1] = canTalk and (deadv or ply1:Alive())
			end
		end
	end

	for _, row in pairs(grid) do
		for _, cell in pairs(row) do
			local count = #cell
			for i = 1, count do
				local ply1 = cell[i]
				for j = i + 1, count do
					local ply2 = cell[j]
					local canTalk =
						plyPos[ply1]:DistToSqr(plyPos[ply2]) < voiceDistance and
							(not dynv or IsInRoom(eyePos[ply1], eyePos[ply2], ply2))

					DrpCanHear[ply1][ply2] = canTalk and (deadv or ply2:Alive())
					DrpCanHear[ply2][ply1] = canTalk and (deadv or ply1:Alive())
				end
			end
		end
	end

end)

hook.Add("PlayerDisconnect", "DarkRPCanHear", function(ply)

	DrpCanHear[ply] = nil

end)

function GM:PlayerCanHearPlayersVoice(listener, talker)

	if not deadv and not talker:Alive() then return false end

	return not vrad or DrpCanHear[listener][talker] == true, threed

end

--[[------------------------------------------------------------

	DarkRP

------------------------------------------------------------]]--
function GM:CanTool(ply, trace, mode)

	if not self.Sandbox.CanTool(self, ply, trace, mode) then return false end

	local ent = trace.Entity

	if IsValid(ent) then
		if ent.onlyremover then
			if mode == "remover" then
				return false
			end
		end

		if ent.nodupe and (mode == "weld" or mode == "weld_ez" or mode == "spawner" or mode == "duplicator" or mode == "adv_duplicator") then
			return false
		end

		if ent:IsVehicle() and mode == "nocollide" and not GAMEMODE.Config.allowvnocollide then
			return false
		end
	end

	return true

end

function GM:CanPlayerSuicide(ply)

	return false

end

function GM:CanDrive(ply, ent)

	return false

end

function GM:CanProperty(ply, property, ent)

	if self.Config.allowedProperties[property] and ent:CPPICanTool(ply, "remover") then
		return true
	end

	if property == "persist" and ply:IsSuperAdmin() then
		return true
	end

	return false

end

function GM:PlayerShouldTaunt(ply, actid)

	return false

end

--[[------------------------------------------------------------

	Death

------------------------------------------------------------]]--
function GM:DoPlayerDeath(ply, attacker, damage, ...)

	self.Sandbox.DoPlayerDeath(self, ply, attacker, damage, ...)

end

function GM:PlayerDeath(ply, weapon, killer)

	local jobTable = ply:getJobTable()

	if jobTable.PlayerDeath then
		jobTable.PlayerDeath(ply, weapon, killer)
	end

	if weapon:IsVehicle() and weapon:GetDriver():IsPlayer() then
		killer = weapon:GetDriver()
	end

	self.Sandbox.PlayerDeath(self, ply, weapon, killer)

	ply:Extinguish()
	ply:ExitVehicle()

	ply.NextSpawnTime = CurTime() + math.Clamp(GAMEMODE.Config.respawntime, 0, 10)
	ply.DeathPos = ply:GetPos()

	if IsValid(ply) and (ply ~= killer or ply.Slayed) and not ply:isArrested() then
		ply:setDarkRPVar("wanted", nil)

		ply.DeathPos = nil
		ply.Slayed = false
	end

	ply.ConfiscatedWeapons = nil

end

--[[------------------------------------------------------------

	DarkRP

------------------------------------------------------------]]--
function GM:PlayerCanPickupWeapon(ply, weapon)

	if ply:isArrested() or (weapon.PlayerUse == false) then return false end

	return true

end

function GM:PlayerSetModel(ply)
	local jobTable = ply:getJobTable()

	-- Invalid job, return to Sandbox behaviour
	if not jobTable then return self.Sandbox.PlayerSetModel(ply) end

	if jobTable.PlayerSetModel then
		local model = jobTable.PlayerSetModel(ply)
		if model then ply:SetModel(model) return end
	end

	local EndModel = ""
	if GAMEMODE.Config.enforceplayermodel then
		if istable(jobTable.model) then
			local ChosenModel = string.lower(ply:getPreferredModel(ply:Team()) or "")

			local found
			for _, Models in pairs(jobTable.model) do
				if ChosenModel == string.lower(Models) then
					EndModel = Models
					found = true
					break
				end
			end

			if not found then
				EndModel = jobTable.model[math.random(#jobTable.model)]
			end
		else
			EndModel = jobTable.model
		end

		ply:SetModel(EndModel)
	else
		local cl_playermodel = ply:GetInfo("cl_playermodel")
		local modelname = player_manager.TranslatePlayerModel(cl_playermodel)
		ply:SetModel(ply:getPreferredModel(ply:Team()) or modelname)
	end

	self.Sandbox.PlayerSetModel(self, ply)

	ply:SetupHands()
end

local function initPlayer(ply)

	ply:initiateTax()

	ply:updateJob(team.GetName(GAMEMODE.DefaultTeam))
	ply:setSelfDarkRPVar("salary", DarkRP.retrieveSalary(ply))
	ply.LastJob = nil -- so players don't have to wait to get a job after joining

	ply.Ownedz = {}

	ply.LastLetterMade = CurTime() - 61
	ply.LastVoteCop = CurTime() - 61

	ply:SetTeam(GAMEMODE.DefaultTeam)
	ply.DarkRPInitialised = true

	-- Whether or not a player is being prevented from joining
	-- a specific team for a certain length of time
	if GAMEMODE.Config.restrictallteams then
		for i = 1, #RPExtraTeams do
			ply:teamBan(i, 0)
		end
	end
end

local function restoreReconnectedEnts(ply)
	local sid = ply:SteamID64()
	if not queuedForRemoval[sid] then return end

	timer.Remove("DarkRP_removeDisconnected_" .. sid)

	for _, e in pairs(queuedForRemoval[sid]) do
		if not IsValid(e) then continue end

		e.SID = ply.SID

		if e.Setowning_ent then
			e:Setowning_ent(ply)
		end

		ply:addCustomEntity(e.DarkRPItem)
	end

	queuedForRemoval[sid] = nil
end

function GM:PlayerInitialSpawn(ply)

	self.Sandbox.PlayerInitialSpawn(self, ply)

	DrpCanHear[ply] = {}

	DarkRP.log(ply:Nick() .. " (" .. ply:SteamID() .. ") has joined the game", Color(0, 130, 255))

	ply:SetCanZoom(false)

	ply.DarkRPVars = ply.DarkRPVars or {}

	ply:restorePlayerData()

	initPlayer(ply)

	ply.SID = ply:UserID()

	restoreReconnectedEnts(ply)

end

function GM:PlayerSelectSpawn(ply)

	local spawn = self.Sandbox.PlayerSelectSpawn(self, ply)
	local pos

	if spawn and spawn.GetPos then
		pos = spawn:GetPos()
	else
		pos = ply:GetPos()
	end

	if ply:isArrested() then
		pos = DarkRP.retrieveJailPos() or ply.DeathPos
	end

	pos = DarkRP.findEmptyPos(pos, {ply}, 600, 30, Vector(16, 16, 64))

	return spawn, pos

end

function GM:PlayerSpawn(ply)

	if not ply.DarkRPInitialised then
		DarkRP.error(string.format("DarkRP was unable to introduce player \"%s\" to the game!", IsValid(ply) and ply:Nick() or "unknown"))
	end

	ply:CrosshairEnable()
	ply:UnSpectate()
	ply:Extinguish()

	local activeWeapon = ply:GetActiveWeapon()

	if activeWeapon:IsValid() then
		activeWeapon:Extinguish()
	end

	for _, v in ipairs(ents.FindByClass("predicted_viewmodel")) do
		v:Extinguish()
	end

	player_manager.SetPlayerClass(ply, "player_darkrp")
	ply:applyPlayerClassVars()
	player_manager.RunClass(ply, "Spawn")

	hook.Call("PlayerLoadout", self, ply)
	hook.Call("PlayerSetModel", self, ply)

	local ent, pos = hook.Call("PlayerSelectSpawn", self, ply)
	ply:SetPos(pos or ent:GetPos())

end

function GM:PlayerLoadout(ply)
	ply:SetMaxHealth(100)
	ply:SetMaxArmor(100)

	self.Sandbox.PlayerLoadout(self, ply)

	if ply:isArrested() then return end

	ply.RPLicenseSpawn = true

	timer.Simple(1, function()
		if IsValid(ply) then
			ply.RPLicenseSpawn = false
		end
	end)

	local jobTable = ply:getJobTable()

	for _, v in pairs(jobTable.weapons or {}) do
		ply:Give(v)
	end

	if jobTable.PlayerLoadout then
		local val = jobTable.PlayerLoadout(ply)
		if val == true then
			ply:SwitchToDefaultWeapon()
			return
		end
	end

	if jobTable.ammo then
		for k, v in pairs(jobTable.ammo) do
			ply:SetAmmo(v, k)
		end
	end

	for _, v in pairs(self.Config.DefaultWeapons) do
		ply:Give(v)
	end

	ply:SwitchToDefaultWeapon()

end

--[[------------------------------------------------------------

	DarkRP

------------------------------------------------------------]]--
local function GetRemoveEntities(ply)

	local entities = {}
	local removeclass = {}

	for _, class in pairs(DarkRPEntities) do
		removeclass[string.lower(class.ent)] = true
	end

	for _, ent in ipairs(ents.GetAll()) do
		if ent.SID ~= ply.SID or not ent:IsVehicle() and not removeclass[string.lower(ent:GetClass() or "")] then continue end
		table.insert(entities, ent)
	end

	return entities

end

function GM:PlayerDisconnected(ply)

	self.Sandbox.PlayerDisconnected(self, ply)

	timer.Remove(ply:SteamID64() .. "jobtimer")
	timer.Remove(ply:SteamID64() .. "propertytax")

	local entities = GetRemoveEntities(ply)

	for _, ent in pairs(entities) do
		SafeRemoveEntity(ent)
	end

	DarkRP.destroyQuestionsWithEnt(ply)
	DarkRP.destroyVotesWithEnt(ply)

	ply:keysUnOwnAll()
	DarkRP.log(ply:Nick() .. " (" .. ply:SteamID() .. ") disconnected", Color(0, 130, 255))

end

--[[------------------------------------------------------------

	DarkRP

------------------------------------------------------------]]--

function GM:InitPostEntity()

	self.InitPostEntityCalled = true

	game.ConsoleCommand("physgun_DampingFactor 0.9\n")
	game.ConsoleCommand("sv_sticktoground 0\n")
	game.ConsoleCommand("sv_airaccelerate 1000\n")
	game.ConsoleCommand("sv_alltalk 0\n")

end

timer.Simple(0.1, function()

	if not GAMEMODE.InitPostEntityCalled then
		GAMEMODE:InitPostEntity()
	end

end)

function GM:loadCustomDarkRPItems()
end

function GM:PlayerLeaveVehicle(ply, veh)

	self.Sandbox.PlayerLeaveVehicle(self, ply, veh)

end