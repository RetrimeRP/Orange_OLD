AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/props_junk/gascan001a.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end

	self:SetNoDraw(true)

	-- Dispenser
	self.Dispenser = ents.Create("prop_dynamic")
	self.Dispenser:SetModel("models/props_combine/combine_dispenser.mdl")
	self.Dispenser:SetPos(self:GetPos())
	self.Dispenser:SetAngles(self:GetAngles())
	self.Dispenser:DrawShadow(false)
	self.Dispenser:SetParent(self)
	self.Dispenser:Spawn()

	self:DeleteOnRemove(self.Dispenser)

	-- IsWorking
	self.IsWorking = false
end

--[[------------------------------------------------------------

	Use

------------------------------------------------------------]]--
local notify = DarkRP.notify -- ИЗМЕНЕНО 04.02.2022
local ceil = math.ceil
local combine_terminal_idle4 = Sound("ambient/machines/combine_terminal_idle4")
local combine_button7 = Sound("buttons/combine_button7.wav")
local min = math.min
function ENT:Use(ply)
	-- IsWorking
	if self.IsWorking then return end

	-- weapons
	if not ply:HasWeapon("darkrp_cidcard") and not ply:HasWeapon("darkrp_uidcard") then
		notify(ply, 0, 3, "Вы не можете воспользоваться этим")
		return
	end

	local curtime = CurTime()

	-- NextDispenserUse
	if ply.NextDispenserUse and ply.NextDispenserUse > curtime then
		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. ceil(ply.NextDispenserUse - curtime) .. " секунд")
		return
	end

	-- IsWorking, NextDispenserUse
	self.IsWorking = true
	ply.NextDispenserUse = curtime + 900

	-- ent
	local ent = ents.Create("prop_physics")
	ent:SetModel("models/weapons/w_packatc.mdl")
	ent:SetPos(self:GetPos())
	ent:SetAngles(self:GetAngles())
	ent:Spawn()
	ent:SetNotSolid(true)
	ent:SetParent(self.Dispenser)
	ent:Fire("SetParentAttachment", "package_attachment")

	timer.Simple(1.2, function()
		if IsValid(ply) then
			-- remove
			ent:Remove()

			-- hunger
			ply:setSelfDarkRPVar("Energy", math.Clamp( ( ply:getDarkRPVar("Energy") or 100 ) + math.floor(50), 0, 100 ))

			-- notify
			notify(ply, 0, 4, "Вы частично восстановили голод")
		end
	end)

	-- working
	self:EmitSound(combine_terminal_idle4)
	self.Dispenser:Fire("SetAnimation", "dispense_package", 0)

	-- timer
	timer.Simple(3.5, function()
		self:EmitSound(combine_button7)
		self.IsWorking = false
	end)
end