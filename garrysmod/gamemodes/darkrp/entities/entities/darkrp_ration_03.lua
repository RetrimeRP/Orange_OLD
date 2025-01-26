if SERVER then
	AddCSLuaFile()
end

ENT.Base = "darkrp_food"
ENT.Category = "Food & Rations"
ENT.Spawnable = true
ENT.PrintName = "Ration 03"

ENT.Food = {}
ENT.Food.Model = "models/mres/consumables/zag_mre.mdl"
ENT.Food.Amount = 150
ENT.Food.Sound = "physics/cardboard/cardboard_box_strain2.wav"