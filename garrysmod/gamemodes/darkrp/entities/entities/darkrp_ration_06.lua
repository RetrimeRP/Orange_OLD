if SERVER then
	AddCSLuaFile()
end

ENT.Base = "darkrp_food"
ENT.Category = "Food & Rations"
ENT.Spawnable = true
ENT.PrintName = "Ration 06"

ENT.Food = {}
ENT.Food.Model = "models/pg_plops/pg_food/pg_tortellinac.mdl"
ENT.Food.Amount = 100
ENT.Food.Sound = "physics/cardboard/cardboard_box_strain1.wav"

if SERVER then
	function ENT.Food.Use(ply)
		local health = retrime.GetClassVar(ply:Team(), "health") or 100

		if ply:GetMaxHealth() == health then
			ply:SetMaxHealth(health + 25)
		end
	end
end