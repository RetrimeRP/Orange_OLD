if SERVER then
	AddCSLuaFile()
end

ENT.Base = "darkrp_food"
ENT.Category = "Food & Rations"
ENT.Spawnable = true
ENT.PrintName = "Ration 05"

ENT.Food = {}
ENT.Food.Model = "models/pg_plops/pg_food/pg_tortellinap.mdl"
ENT.Food.Amount = 100
ENT.Food.Sound = "physics/cardboard/cardboard_box_strain1.wav"

if SERVER then
	function ENT.Food.Use(ply)
		local runspeed = retrime.GetClassVar(ply:Team(), "runspeed") or 275

		if ply:GetRunSpeed() == runspeed then
			ply:SetRunSpeed(runspeed + 25)
		end
	end
end