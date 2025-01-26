AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/props_c17/lockers001a.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end
end

--[[------------------------------------------------------------

	Use

------------------------------------------------------------]]--
local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
local ceil = math.ceil
local ammopickup = Sound("items/ammopickup.wav")
function ENT:Use(ply)
	-- weapons
	local weapons = ply:getJobTable().locker

	if not weapons then
		DarkRP.notify(ply, 0, 3, "Вы не можете воспользоваться этим")
		return
	end

	local curtime = CurTime()

	-- NextLockerUse
	if ply.NextLockerUse and ply.NextLockerUse > curtime then
		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. ceil(ply.NextLockerUse - curtime) .. " секунд")
		return
	end

	-- NextLockerUse
	ply.NextLockerUse = curtime + 60

	-- weapons
	for k, v in ipairs(weapons) do
		if ply:HasWeapon(v) then continue end

		-- give
		ply:Give(v)
	end

	-- notify
	notify(ply, 0, 4, "Вы успешно получили снаряжение")

	-- sound
	ply:EmitSound(ammopickup)
end

--[[------------------------------------------------------------

	canDropWeapon

------------------------------------------------------------]]--
hook.Add("canDropWeapon", "retrime.Locker", function(ply, ent)
	local weapons = ply:getJobTable().locker

	if weapons and table.HasValue(weapons, ent:GetClass()) then
		return false
	end
end)