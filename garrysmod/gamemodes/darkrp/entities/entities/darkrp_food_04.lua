if SERVER then
	AddCSLuaFile()
end

ENT.Base = "darkrp_food"
ENT.Category = "Food & Rations"
ENT.Spawnable = true
ENT.PrintName = "Food 04"

ENT.Food = {}
ENT.Food.Model = "models/bioshockinfinite/jin_bottle.mdl"
ENT.Food.Amount = 100
ENT.Food.Health = 20
ENT.Food.Sound = "physics/glass/glass_impact_hard1.wav"