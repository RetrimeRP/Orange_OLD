if SERVER then
	AddCSLuaFile()
end

ENT.Base = "darkrp_food"
ENT.Category = "Food & Rations"
ENT.Spawnable = true
ENT.PrintName = "Ration 02"

ENT.Food = {}
ENT.Food.Model = "models/mres/consumables/pag_mre.mdl"
ENT.Food.Amount = 125
ENT.Food.Sound = "physics/cardboard/cardboard_box_strain2.wav"