AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/weapons/w_packate.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
	end

	self:SetTrigger(true)

	-- Food, Water
	self.Food = false
	self.Water = false
end

--[[------------------------------------------------------------

	StartTouch

------------------------------------------------------------]]--
local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
local medshot4 = Sound("items/medshot4.wav")
local metal_computer_impact_hard3 = Sound("physics/metal/metal_computer_impact_hard3.wav")
local formatMoney = DarkRP.formatMoney
local random = math.random
function ENT:StartTouch(ent)
	local class = ent:GetClass()

	-- food
	if class == "darkrp_factory_04" then
		if self.Food then return end

		-- remove
		ent:Remove()

		-- food
		self.Food = true

		-- sound
		self:EmitSound(medshot4)
		return
	end

	-- water
	if class == "darkrp_factory_05" then
		if self.Water then return end

		-- remove
		ent:Remove()

		-- water
		self.Water = true

		-- sound
		self:EmitSound(medshot4)
		return
	end

	-- sell
	if class == "darkrp_factory_07" then
		if not self.Food then return end
		if not self.Water then return end

		-- remove
		self:SetTrigger(false)
		self:Remove()

		-- sound
		ent:EmitSound(metal_computer_impact_hard3)

		if IsValid(self.RationOwner) then
			-- money
			local money = random(350, 550)

			self.RationOwner:addMoney(money)

			-- command
			self.RationOwner:ConCommand("playmusic")

			-- notify
			notify(self.RationOwner, 0, 4, "Вы успешно сделали рацион и получили ".. formatMoney(money))
		end
	end
end