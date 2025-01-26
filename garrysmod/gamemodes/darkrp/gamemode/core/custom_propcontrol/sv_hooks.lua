--[[------------------------------------------------------------

	SpawnProp

------------------------------------------------------------]]--
hook.Add("PlayerSpawnProp", "retrime.SpawnProp", function(ply)
	if not ply:HasWeapon("weapon_physgun") then
		return false
	end
end)

--[[------------------------------------------------------------

	GravGunPunt, PhysgunReload

------------------------------------------------------------]]--
hook.Add("GravGunPunt", "retrime.GravGunPunt", function()
	return false
end)

hook.Add("OnPhysgunReload", "retrime.PhysgunReload", function()
	return false
end)

--[[------------------------------------------------------------

	FreezeEntities

------------------------------------------------------------]]--
local entities = {}

local whitelist = {
	["darkrp_printer_01"] = true,
	["darkrp_printer_02"] = true,
	["darkrp_printer_03"] = true,
	["darkrp_printer_04"] = true,
	["tfa_ammo_357"] = true,
	["tfa_ammo_ar2"] = true,
	["tfa_ammo_buckshot"] = true,
	["tfa_ammo_pistol"] = true,
	["tfa_ammo_smg"] = true,
	["tfa_ammo_sniper_rounds"] = true,
	["tfa_ammo_winchester"] = true,
	["darkrp_food"] = true,
	["darkrp_healthkit"] = true,
	["darkrp_healthvial"] = true,
	["darkrp_suitbattery"] = true,
	["darkrp_uniform"] = true,
	["bkeypads_repair"] = true,
	["bkeypads_shield"] = true,
	["spawned_money"] = true,
	["spawned_shipment"] = true,
	["spawned_weapon"] = true
}

hook.Add("OnEntityCreated", "retrime.FreezeEntities", function(ent)
	if whitelist[ent:GetClass()] and not ent:CreatedByMap() then
		entities[ent] = true
	end
end)

local timer = timer
timer.Create("retrime.FreezeEntities", 15, 0, function()
	for ent in pairs(entities) do
		if not IsValid(ent) then
			entities[ent] = nil
			continue
		end

		-- PropGhosted
		if ent.PropGhosted then continue end

		-- phys
		local phys = ent:GetPhysicsObject()

		if IsValid(phys) and not phys:IsAsleep() then
			phys:Sleep()
		end
	end
end)