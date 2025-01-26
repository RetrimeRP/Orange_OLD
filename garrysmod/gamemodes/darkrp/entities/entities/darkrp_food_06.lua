if SERVER then
	AddCSLuaFile()
end

ENT.Base = "darkrp_food"
ENT.Category = "Food & Rations"
ENT.Spawnable = true
ENT.PrintName = "Food 06"

ENT.Food = {}
ENT.Food.Model = "models/bioshockinfinite/hext_apple.mdl"
ENT.Food.Amount = 100
ENT.Food.Health = 20
ENT.Food.Sound = "physics/flesh/flesh_squishy_impact_hard2.wav"