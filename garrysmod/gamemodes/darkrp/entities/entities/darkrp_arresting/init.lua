AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/retrime/metropolice/union.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)
	self:SetHullSizeNormal()
	self:SetSkin(math.random(0, 20))

	self:CapabilitiesAdd(bit.bor(CAP_ANIMATEDFACE, CAP_TURN_HEAD))
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	self:SetMaxYawSpeed(90)
end

--[[------------------------------------------------------------

	Use

------------------------------------------------------------]]--
local notify = DarkRP.notify
function ENT:Use(ply)
	-- job
	if not ply:IsCombine() then
		notify(ply, 0, 4, "Вы должны быть юнитом ГО")
		return
	end

	-- arrest
	for k, v in ipairs(ents.FindInSphere(ply:GetPos(), 256)) do
		if not v:IsPlayer() or not v:IsHandcuffed() then continue end

		-- canarrest, message
		local canarrest, message = hook.Call("canArrest", DarkRP.hooks, ply, v)

		-- canarrest
		if not canarrest then
			if message then
				notify(ply, 0, 5, message)
			end

			continue
		end

		-- arrest
		v:arrest(300, ply)

		-- notify
		notify(v, 0, 6, "Вас арестовал " .. ply:Nick())
	end
end