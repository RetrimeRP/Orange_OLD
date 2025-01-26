AddCSLuaFile("shared.lua")
include("shared.lua")

local loot = {

	{class = "tfa_akm", model = "models/orange/weapons/w_models/wpn_akm.mdl"},
	{class = "tfa_aug_a1", model = "models/orange/weapons/w_models/w_aug_a1.mdl"},
	{class = "tfa_desert_eagle", model = "models/orange/weapons/w_models/wpn_desert_eagle_w.mdl"},
	{class = "tfa_beretta", model = "models/orange/weapons/w_models/wpn_beretta92fs.mdl"},
	{class = "tfa_ak47u", model = "models/orange/weapons/w_models/wpn_ak74u.mdl"},
	{class = "tfa_grach", model = "models/orange/weapons/w_models/wpn_grach_w.mdl"},
	{class = "tfa_galil", model = "models/weapons/w_rif_galil.mdl"},
	{class = "tfa_glock", model = "models/orange/weapons/w_models/wpn_glock_w.mdl"},
	{class = "tfa_ump45", model = "models/orange/weapons/w_models/wpn_ump45_w.mdl"},
	{class = "tfa_fnx45", model = "models/orange/weapons/w_models/wpn_fnx45_w.mdl"},
	{class = "tfa_m4a1", model = "models/orange/weapons/w_models/wpn_m4a1_w.mdl"},
	{class = "tfa_vz61", model = "models/orange/weapons/w_models/wpn_vz61_w.mdl"},
	{class = "tfa_mp5sd", model = "models/orange/weapons/w_models/wpn_mp5sd_w.mdl"},
	{class = "tfa_pm", model = "models/orange/weapons/w_models/wpn_pm_w.mdl"},
	{class = "tfa_p90", model = "models/orange/weapons/w_models/wpn_p90_w.mdl"},
	{class = "tfa_sig552", model = "models/orange/weapons/w_models/wpn_sig552_w.mdl"},
	{class = "tfa_knife", model = "models/weapons/w_knife_t.mdl"}

}

function ENT:Initialize()

	self:SetModel("models/items/item_item_crate.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end

	self.Container = itemstore.Container(4, 1, 1)
	self.Container:SetOwner(self)

	if self.Items then
		for _, item in ipairs(self.Items) do
			self.Container:AddItem(item:Copy())
		end
	end

	local function callback(_, ply)
		if not IsValid(ply) then return end

		if ply:GetPos():DistToSqr(self:GetPos()) < 62500 then
			return true
		end

		return false
	end

	self.Container:AddCallback("read", callback)
	self.Container:AddCallback("write", callback)

end

function ENT:Use(ply)

	if (ply:IsResistance() or ply:IsGuild()) and ply:HasWeapon("darkrp_inventory") then
		self.Container:Sync()
		ply:OpenContainer(self.Container:GetID(), "Ящик")
	end

end

function ENT:OnRemove()

	self.Container:Remove()

end

timer.Create("DarkRP_ItemStoreLoot", 900, 0, function()

	for _, ent in ipairs(ents.FindByClass("itemstore_loot")) do
		local container = ent.Container

		if container:IsValid() and #container:GetItems() <= 0 then
			container:SetSuppressed(true)

			for i = 1, math.random(3) do
				local randomitem = loot[math.random(#loot)]

				local itemtable = {}
				itemtable.Ammo = 0
				itemtable.Amount = 1
				itemtable.Class = randomitem.class
				itemtable.Clip1 = 0
				itemtable.Clip2 = 0
				itemtable.Model = randomitem.model

				local item = itemstore.Item("spawned_weapon", itemtable)

				container:AddItem(item)
			end

			container:SetSuppressed(false)
		end
	end

end)