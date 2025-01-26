AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022

function ENT:Explode()

	local pos = self:GetPos()

	local effect = EffectData()
	effect:SetStart(pos)
	effect:SetOrigin(pos)
	effect:SetScale(1)

	util.Effect("Explosion", effect)

	local owner = self:Getowning_ent()

	if IsValid(owner) then
		notify(owner, 1, 4, "Ваш принтер был уничтожен!")
	end

	self:Remove()

end

local min = math.min
local random = math.random
local timer = timer
function ENT:StartPrint()

	local max = self.max
	local print = self.print

	timer.Simple(60, function()
		if not IsValid(self) then return end

		local printed = self:GetPrinted()

		if printed < max then
			self:SetPrinted(min(printed + print, max))
		end

		if self:GetClass() == "darkrp_printer_02" then
			local chance = random(0, 200)
			--local chance2 = random(0, 99)
			local owner = self:Getowning_ent()

			if (chance == 82) and (owner:GetCount("rp_printer") <= 0) then
				local ent = ents.Create("darkrp_printer_04")
				ent:SetPos(self:GetPos())
				ent:SetAngles(self:GetAngles())
				ent:Spawn()

				ent:Setowning_ent(owner)

				owner:AddCount("rp_printer", ent)

				self:Remove()
			end
		end

		self:StartPrint()
	end)

end
local equipment_printer_loop1 = Sound("ambient/levels/labs/equipment_printer_loop1.wav")
function ENT:StartSound()

	self.sound = CreateSound(self, equipment_printer_loop1)
	self.sound:SetSoundLevel(37)
	self.sound:PlayEx(1, 100)

end

function ENT:Initialize()

	self.material = "models/debug/debugwhite"

	self:InitializeVariables()

	self:SetModel(self.model)
	self:SetMaterial(self.material)
	self:SetColor(self.color)

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	local physics = self:GetPhysicsObject()

	if IsValid(physics) then
		physics:Wake()
	end

	self:StartPrint()
	self:StartSound()

end

function ENT:OnTakeDamage(dmg)

	self:TakePhysicsDamage(dmg)

	self.damage = (self.damage or 100) - dmg:GetDamage()

	if self.damage <= 0 then
		self:Explode()
	end

end

local formatMoney = DarkRP.formatMoney
function ENT:Use(ent, ply)

	local printed = self:GetPrinted()

	if printed > 0 then
		ply:addMoney(printed)
		notify(ply, 1, 5, "Вы получили " .. formatMoney(printed) .. "!")

		self:SetPrinted(0)
	end

end

function ENT:OnRemove()

	if self.sound then
		self.sound:Stop()
	end

end