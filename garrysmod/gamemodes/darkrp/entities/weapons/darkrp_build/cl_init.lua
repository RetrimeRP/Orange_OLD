include("shared.lua")

language.Add("SBoxLimit_build_entities", "Достигнут лимит на этот тип строительства")

local c25500100 = Color(255, 0, 0, 100)
local c02550100 = Color(0, 255, 0, 100)

--[[------------------------------------------------------------

	GetGhostDraw

------------------------------------------------------------]]--
local function GetGhostDraw(trace)
	-- entity
	if IsValid(trace.Entity) then
		return true
	end

	-- hit
	if not trace.Hit then
		return true
	end

	-- normal
	if math.ceil(trace.HitNormal.z) ~= 1 then
		return true
	end

	return false
end

--[[------------------------------------------------------------

	GetGhostColor

------------------------------------------------------------]]--
local function GetGhostColor(ply)
	-- velocity
	if ply:GetVelocity():Length() > 25 then
		return c25500100
	end

	-- crouching
	if ply:Crouching() then
		return c25500100
	end

	return c02550100
end

--[[------------------------------------------------------------

	GhostModel

------------------------------------------------------------]]--
function SWEP:RemoveGhostModel()
	if self.GhostModel then
		if not IsValid(self.GhostModel) then
			self.GhostModel = nil
			return
		end

		self.GhostModel:Remove()
		self.GhostModel = nil
	end
end

function SWEP:CreateGhostModel(mdl)
	self:RemoveGhostModel()

	self.GhostModel = ents.CreateClientProp()
	self.GhostModel:SetModel(mdl)
	self.GhostModel:Spawn()
	self.GhostModel:DestroyShadow()
	self.GhostModel:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.GhostModel:SetMaterial("debug/debugwireframe")
	self.GhostModel:SetColor(c25500100)
end

function SWEP:UpdateGhostModel(ply, offset)
	-- trace
	local trace = util.QuickTrace(ply:EyePos(), ply:GetAimVector() * 128, {ply})

	-- nodraw, drawcolor
	local nodraw = GetGhostDraw(trace)
	local drawcolor = GetGhostColor(ply)

	-- ang
	local ang = Angle(0, ply:EyeAngles().y, 0)

	-- offset
	if offset then
		ang = ang + offset
	end

	-- update
	self.GhostModel:SetNoDraw(nodraw)
	self.GhostModel:SetColor(drawcolor)
	self.GhostModel:SetPos(trace.HitPos - trace.HitNormal * self.GhostModel:OBBMins().z)
	self.GhostModel:SetAngles(ang)

	if IsValid(self.GhostTurret) then
		self.GhostTurret:SetNoDraw(nodraw)
		self.GhostTurret:SetColor(drawcolor)
	end
end

--[[------------------------------------------------------------

	GhostTurret

------------------------------------------------------------]]--
function SWEP:RemoveGhostTurret()
	if self.GhostTurret then
		if not IsValid(self.GhostTurret) then
			self.GhostTurret = nil
			return
		end

		self.GhostTurret:Remove()
		self.GhostTurret = nil
	end
end

function SWEP:CreateGhostTurret()
	if not IsValid(self.GhostModel) then return end

	self:RemoveGhostTurret()

	self.GhostTurret = ents.CreateClientProp()
	self.GhostTurret:SetModel("models/props_combine/bunker_gun01.mdl")
	self.GhostTurret:SetPos(self.GhostModel:GetPos())
	self.GhostTurret:SetParent(self.GhostModel)
	self.GhostTurret:SetLocalAngles(Angle(0, 0, 0))
	self.GhostTurret:SetLocalPos(Vector(-4, 0, 10))
	self.GhostTurret:Spawn()
	self.GhostTurret:DestroyShadow()
	self.GhostTurret:SetRenderMode(RENDERMODE_TRANSALPHA)
	self.GhostTurret:SetMaterial("debug/debugwireframe")
	self.GhostTurret:SetColor(c25500100)
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

	-- slot
	local slot = self.Slots[self:GetSelectedSlot()]

	--
	-- model
	--
	if not IsValid(self.GhostModel) or self.GhostModel:GetModel() ~= slot.model then
		self:CreateGhostModel(slot.model)
	end

	--
	-- turret
	--
	if slot.class == "darkrp_turret_01" and not IsValid(self.GhostTurret) then
		self:CreateGhostTurret()
	end

	if slot.class ~= "darkrp_turret_01" then
		self:RemoveGhostTurret()
	end

	--
	-- update
	--
	self:UpdateGhostModel(owner, slot.offset)
end

--[[------------------------------------------------------------

	Build

------------------------------------------------------------]]--
function SWEP:PrimaryAttack()
	-- NextUse
	if self.NextUse and self.NextUse > CurTime() then return end

	self.NextUse = CurTime() + 0.1

	-- sound
	surface.PlaySound("physics/cardboard/cardboard_box_impact_bullet" .. math.random(4, 5) .. ".wav")
end

function SWEP:SecondaryAttack()
	-- NextUse
	if self.NextUse and self.NextUse > CurTime() then return end

	self.NextUse = CurTime() + 0.1

	-- sound
	surface.PlaySound("physics/cardboard/cardboard_box_impact_bullet" .. math.random(4, 5) .. ".wav")
end

function SWEP:Holster()
	-- model
	self:RemoveGhostModel()

	-- turret
	self:RemoveGhostTurret()

	-- holster
	return true
end

function SWEP:OnRemove()
	-- model
	self:RemoveGhostModel()

	-- turret
	self:RemoveGhostTurret()
end