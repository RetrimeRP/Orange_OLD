AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_menu.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("SupplierMenu02")
util.AddNetworkString("SupplierPurchase02")

function ENT:Initialize()
	self:SetModel("models/retrime/group02b/male_0".. math.random(1,5) ..".mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)
	self:SetHullSizeNormal()
	self:SetSkin(math.random(0, 3)) 
	self:SetBodygroup(1,1)

	self:CapabilitiesAdd(bit.bor(CAP_ANIMATEDFACE, CAP_TURN_HEAD))
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	self:SetMaxYawSpeed(90)

end

-- function ENT:OnTakeDamage(dmg)

-- 	self:TakePhysicsDamage(dmg)

-- 	self.damage = (self.damage or 500) - dmg:GetDamage()

-- 	if self.damage <= 0 then
-- 		self:Remove()
-- 	end

-- end


function ENT:Use(ply)
	-- job
	local p_team = ply:Team()

	if (not ply:IsBandits() and not ply:getDarkRPVar("disguise")) then -- ИЗМЕНЕНО
		DarkRP.notify(ply, 0, 4, "Этим может воспользоваться только Бандиты")
		return
	end

	net.Start('SupplierMenu02')
	net.Send(ply)
end

net.Receive("SupplierPurchase02", function(len, ply)
	local supplier = net.ReadEntity()
	local name = net.ReadString()
    local weapon_to_give = net.ReadString()
	local price = net.ReadString()

	if not ply:canAfford(price) then
		DarkRP.notify(ply, 1, 4, "У вас не хватает денег!")

		return
	end

	if weapon_to_give == "uniform" then
		local uniforms = {
			"models/retrime/group01/female_01.mdl",
			"models/retrime/group01/female_02.mdl",
			"models/retrime/group01/female_03.mdl",
			"models/retrime/group01/female_04.mdl",
			"models/retrime/group01/female_06.mdl",
			"models/retrime/group01/female_07.mdl",
			"models/retrime/group01/male_01.mdl",
			"models/retrime/group01/male_02.mdl",
			"models/retrime/group01/male_03.mdl",
			"models/retrime/group01/male_04.mdl",
			"models/retrime/group01/male_05.mdl",
			"models/retrime/group01/male_06.mdl",
			"models/retrime/group01/male_07.mdl",
			"models/retrime/group01/male_08.mdl",
			"models/retrime/group01/male_09.mdl"
		}
		-- model
		local model = uniforms[ply:GetModel()]
		-- job
		if not ply:IsBandits() then
			DarkRP.notify(ply, 0, 4, "Это могут купить только бандиты")
			return
		end
		-- model
		ply:SetModel(table.Random( uniforms ))
		ply:SetupHands()
		-- sound
		ply:EmitSound(Sound("physics/cardboard/cardboard_box_break3.wav"))
		-- notify
		DarkRP.notify(ply, 0, 4, "Вы успешно надели на себя униформу Гражданина")
	elseif weapon_to_give == "ammo_ar2" then
		ply:GiveAmmo(150, "ar2")
	elseif weapon_to_give == "ammo_buckshot" then
		ply:GiveAmmo(30, "buckshot")
	elseif weapon_to_give == "ammo_pistol" then
		ply:GiveAmmo(50, "pistol")
	elseif weapon_to_give == "ammo_smg" then
		ply:GiveAmmo(120, "smg1")
	else
		ply:Give(weapon_to_give)
	end
	
	DarkRP.notify(ply, 0, 5, string.format("Вы купили %s", name))
	ply:addMoney(-price, "Инвестировал в говно")
end)