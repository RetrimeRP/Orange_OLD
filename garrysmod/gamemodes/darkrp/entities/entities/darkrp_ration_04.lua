if SERVER then
	AddCSLuaFile()
end

ENT.Base = "darkrp_food"
ENT.Category = "Food & Rations"
ENT.Spawnable = true
ENT.PrintName = "Ration 04"

ENT.Food = {}
ENT.Food.Model = "models/pg_plops/pg_food/pg_tortellinar.mdl"
ENT.Food.Amount = 100
ENT.Food.Sound = "physics/cardboard/cardboard_box_strain1.wav"

if SERVER then
	function ENT.Food.Use(ply)
		local health = ply:Health()
		local maxhealth = ply:GetMaxHealth()

		if health < maxhealth then
			ply:SetHealth(maxhealth)
		end
	end
end