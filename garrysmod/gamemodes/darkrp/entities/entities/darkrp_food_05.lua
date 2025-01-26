if SERVER then
	AddCSLuaFile()
end

ENT.Base = "darkrp_food"
ENT.Category = "Food & Rations"
ENT.Spawnable = true
ENT.PrintName = "Food 05"

ENT.Food = {}
ENT.Food.Model = "models/bioshockinfinite/hext_bottle_lager.mdl"
ENT.Food.Amount = 100
ENT.Food.Health = 20
ENT.Food.Sound = "physics/glass/glass_impact_hard1.wav"