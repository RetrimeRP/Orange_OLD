ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.Category = "Food & Rations"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.PrintName = "Food"

function ENT:PhysgunPickup(ply, ent) return false end

ENT.Food = {}
ENT.Food.Model = ""
ENT.Food.Amount = 0
ENT.Food.Health = 0
ENT.Food.Sound = ""