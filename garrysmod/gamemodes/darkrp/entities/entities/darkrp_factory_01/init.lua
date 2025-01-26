AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/props_phx/wheels/drugster_back.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end

	-- NextUse
	self.NextUse = 0
end

--[[------------------------------------------------------------

	Use

------------------------------------------------------------]]--
local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
local ceil = math.ceil
local angle0090 = Angle(0, 0, 90)
local button4 = Sound("buttons/button4.wav")
function ENT:Use(ply)
	-- job
	if ply:Team() ~= TEAM_CWU5 then
		notify(ply, 0, 3, "Этим могут воспользоваться только фасовщики")
		return
	end

	local curtime = CurTime()

	-- NextUse
	if self.NextUse > curtime then
		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. ceil(self.NextUse - curtime) .. " секунд")
		return
	end

	-- limit
	if ply:GetCount("retrime.FactoryFood") > 2 then
		notify(ply, 0, 4, "Вы достигли лимита раздатчика еды")
		return
	end

	-- NextUse
	self.NextUse = curtime + 3

	-- FactoryPos
	if not self.FactoryPos then
		self.FactoryPos = self:GetPos() + (self:GetForward() * 3) + (self:GetUp() * 50)
	end

	-- FactoryAng
	if not self.FactoryAng then
		self.FactoryAng = self:GetAngles() + angle0090
	end

	-- ent
	local ent = ents.Create("darkrp_factory_04")
	ent:SetPos(self.FactoryPos)
	ent:SetAngles(self.FactoryAng)
	ent:Spawn()

	ply:AddCleanup("sents", ent)

	ply:AddCount("retrime.FactoryFood", ent)

	-- sound
	self:EmitSound(button4)
end