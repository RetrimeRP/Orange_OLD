AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
-- cleanup.Register("build_entities")

local NextUse, NextReloadUse, util = {}, {}, util

--[[------------------------------------------------------------

	Turret

------------------------------------------------------------]]--

local epicmetal_hard = Sound("phx/epicmetal_hard.wav") -- ИЗМЕНЕНО 05.02.2022
function SWEP:CreateTurret(ply, trace)
	local ent = ents.Create("darkrp_turret_01")
	ent:SpawnFunction(ply, trace)
	ent.Turret:CPPISetOwner(ply)
	ent.TurretProp:CPPISetOwner(ply)
	ent.TurretProp.BuildEntity = true

	-- undo
	undo.Create("build_entity")
	undo.AddEntity(ent.Turret)
	undo.AddEntity(ent.TurretProp)
	undo.SetPlayer(ply)
	undo.Finish()

	-- cleanup
	ply:AddCleanup("props", ent.Turret)
	ply:AddCleanup("props", ent.TurretProp)
	ply:AddCount("build_turrets", ent.TurretProp)

	-- sound
	ent:EmitSound(epicmetal_hard)
end

--[[------------------------------------------------------------

	Build

------------------------------------------------------------]]--
local ceil = math.ceil
function SWEP:Build(ply)
	-- NextUse
	if NextUse[self] and NextUse[self] > CurTime() then return end

	NextUse[self] = CurTime() + 1

	-- trace
	ply:LagCompensation(true)
	local trace = util.QuickTrace(ply:EyePos(), ply:GetAimVector() * 128, {ply})
	ply:LagCompensation(false)

	if IsValid(trace.Entity) then return end
	if not trace.Hit then return end
	if ceil(trace.HitNormal.z) ~= 1 then return end
	if ply:GetVelocity():Length() > 25 then return end
	if ply:Crouching() then return end

	-- slot
	local slot = self.Slots[self:GetSelectedSlot()]

	-- limit
	if ply:GetCount(slot.type) >= slot.max then
		ply:LimitHit("build_entities")
		return
	end

	-- turret
	if slot.class == "darkrp_turret_01" then
		self:CreateTurret(ply, trace)
		return
	elseif slot.class == "npc_turret_floor" then -- ИЗМЕНЕНО 08.11.2022
		ply:ConCommand("spawnturret 0")
	end

	-- ang
	local ang = Angle(0, ply:EyeAngles().y, 0)

	-- offset
	if slot.offset then
		ang = ang + slot.offset
	end

	-- ent
	local ent = ents.Create(slot.class)
	ent:SetModel(slot.model)
	ent:SetPos(trace.HitPos - trace.HitNormal * ent:OBBMins().z)
	ent:SetAngles(ang)
	ent:Spawn()
	ent:CPPISetOwner(ply)
	ent.BuildEntity = true
	ent.EntityOwner = ply -- ИЗМЕНЕНО 15.01.2022

	-- phys
	local phys = ent:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end

	-- undo
	undo.Create("build_entity")
	undo.AddEntity(ent)
	undo.SetPlayer(ply)
	undo.Finish()

	-- cleanup
	ply:AddCleanup("sents", ent)
	ply:AddCount(slot.type, ent)

	-- sound
	ent:EmitSound(epicmetal_hard)
end

--[[------------------------------------------------------------

	Think

------------------------------------------------------------]]--
function SWEP:Think()
	-- owner
	local owner = self:GetOwner()

	-- slots
	if not self.Slots then
		self.Slots = self:GetSlots(owner)
	end

	-- build
	if owner:KeyPressed(IN_USE) then
		self:Build(owner)
	end

	-- think
	self:NextThink(CurTime() + 1)
	return true
end

--[[------------------------------------------------------------

	PrimaryAttack

------------------------------------------------------------]]--
function SWEP:PrimaryAttack()
	-- slots
	if not self.Slots then return end

	-- slot, max, min
	local slot = self:GetSelectedSlot()
	--local max = #self.Slots
	--local min = 1

	-- select
	if slot + 1 <= #self.Slots then
		self:SetSelectedSlot(slot + 1)
	else
		self:SetSelectedSlot(1)
	end
end

--[[------------------------------------------------------------

	SecondaryAttack

------------------------------------------------------------]]--
function SWEP:SecondaryAttack()
	-- slots
	if not self.Slots then return end

	-- slot, max, min
	local slot = self:GetSelectedSlot()
	--local max = 1
	--local min = #self.Slots

	-- select
	if slot - 1 >= 1 then
		self:SetSelectedSlot(slot - 1)
	else
		self:SetSelectedSlot(#self.Slots)
	end
end

--[[------------------------------------------------------------

	Reload

------------------------------------------------------------]]--
local random = math.random
local sounds = {Sound("physics/wood/wood_crate_break1.wav"),
				Sound("physics/wood/wood_crate_break2.wav"),
				Sound("physics/wood/wood_crate_break3.wav"),
				Sound("physics/wood/wood_crate_break4.wav"),
				Sound("physics/wood/wood_crate_break5.wav")
}
function SWEP:Reload()
	-- NextReloadUse
	if self.NextReloadUse > CurTime() then return end

	self.NextReloadUse = CurTime() + 0.5

	-- owner
	local owner = self:GetOwner()

	-- trace
	owner:LagCompensation(true)
	local trace = util.QuickTrace(owner:EyePos(), owner:GetAimVector() * 128, {owner})
	owner:LagCompensation(false)

	-- ent
	local ent = trace.Entity

	if not IsValid(ent) then return end
	if not ent.BuildEntity then return end

	-- remove
	ent:EmitSound(sounds[random(#sounds)])
	ent:Remove()
end