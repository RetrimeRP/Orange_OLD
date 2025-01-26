					-- MAIN FUNCTIONS --
local whitelist = {
	["STEAM_0:0:202344166"] = true,
	["STEAM_0:1:190680623"] = true,
}
--[[------------------------------------------------------------
	BuggyTD (Vehicle, CTakeDamageInfo)
	Return: boolean
	*

	HookInitialize (Vehicle)
	Return: nil
	*

	SpawnBuggy (Player?, string?, table<number, string>)
	Return: nil
	Функция спавнит багги с оружием или без + с нефункциональной
	коробкой патронов.

	spawnbuggy - багги без оружия
	spawnbuggy 1 - с оружием
------------------------------------------------------------]]--
local buggies = {}
local ShouldDie = {}
local VEHICLE_COUNT = 0

local timer, ents, undo, hook = timer, ents, undo, hook
local vec005 = Vector(0, 0, 5)
local DEF_ang = Angle(0, 0, 0)
local COL_burned = Color(75, 70, 70, 255)

local HOOKS = {
	PlayerUse = function(ply, ent)
		if not buggies[ent] then return end
		if ply:GetEyeTrace().HitGroup == 5 then return false end	
	end,
	EntityTakeDamage = function (target, dmginfo)
		if buggies[target] and not ShouldDie[target] then
			if dmginfo:GetAttacker():GetClass() == "env_explosion" then
				target:SetHealth(target:Health() - 50)
			elseif dmginfo:IsExplosionDamage() then
				target:SetHealth(target:Health() - dmginfo:GetDamage() / 5)
			else
				target:SetHealth(target:Health() - 1)
			end
			if target:Health() <= 0 then
				ShouldDie[target] = true
				local explosion = ents.Create("env_explosion")
				explosion:SetPos(target:GetPos())
				explosion:SetKeyValue("iMagnitude", 100)
				explosion:SetKeyValue("iRadiusOverride", 128)
				explosion:SetKeyValue("spawnflags", 3)
				explosion:SetParent(target)
				explosion:Spawn()
				explosion:Activate()
				explosion:Fire("explode")
				
				timer.Simple(2, function()
					if not target or not target:IsValid() then return end

					local driver = target:GetDriver()
					if driver:IsPlayer() then
						driver:Kill()
					end
					local broken_model = ents.Create("prop_physics")
					broken_model:SetModel("models/buggy.mdl")
					broken_model:SetPos(target:GetPos())
					broken_model:SetAngles(target:GetAngles())
					broken_model:SetVelocity(target:GetVelocity())
					broken_model:SetColor(COL_burned)
					broken_model:SetCollisionGroup(COLLISION_GROUP_WORLD)
				
					target:Remove()
					broken_model:Spawn()
					broken_model:Activate()
					explosion:SetPos(broken_model:GetPos())
					explosion:SetParent(broken_model)
					explosion:Fire("explode")
				
					timer.Simple(30, function()
						if not IsValid(broken_model) then return end
						broken_model:Remove()
					end)
				end)
			end
			return true
		end
	end
}

local function V_HookInitialize(VEHICLE)
	if VEHICLE_COUNT <= 0 then
		hook.Add("PlayerUse", "retrime.BuggyPU", HOOKS.PlayerUse)
		hook.Add("EntityTakeDamage", "retrime.BuggyTD", HOOKS.EntityTakeDamage)
	end
	VEHICLE_COUNT = VEHICLE_COUNT + 1

	VEHICLE:CallOnRemove("HookDelete", function()
		VEHICLE_COUNT = VEHICLE_COUNT - 1
		if VEHICLE_COUNT <= 0 then
			hook.Remove("PlayerUse", "retrime.BuggyPU")
			hook.Remove("EntityTakeDamage", "retrime.BuggyTD")
		end
	end)
end
local function SpawnBuggy(ply, cmd, args)
	if not ply:Supervisor() and not whitelist[ply:SteamID()] then return end
	local tr = ply:GetEyeTrace()
	if not tr.Hit then
		return
	end

	local spawnPos = tr.HitPos + vec005
	local buggy = ents.Create("prop_vehicle_jeep")
	buggy:SetModel("models/buggy.mdl")
	buggy:SetKeyValue("vehiclescript", "scripts/vehicles/jeep_test.txt")
	buggy:SetHealth(100)
	if args[1] then
		buggy:SetKeyValue("EnableGun", "1")
	end
	buggy:SetPos(spawnPos)
	buggy:SetAngles(DEF_ang)
	buggy:Spawn()
	buggy:Activate()
	buggy:CPPISetOwner(ply)

	undo.Create("buggy")
		undo.AddEntity(buggy)
		undo.SetPlayer(ply)
	undo.Finish()

	buggies[buggy] = true
	V_HookInitialize(buggy)
end
concommand.Add("spawnbuggy", SpawnBuggy, nil, "nil", 0)