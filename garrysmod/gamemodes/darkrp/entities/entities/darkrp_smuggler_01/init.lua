AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_menu.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("SupplierMenu")
util.AddNetworkString("SupplierPurchase")

function ENT:Initialize()
	self:SetModel("models/retrime/group04/male_09.mdl")
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


function ENT:Use(ply)
	-- job
	local p_team = ply:Team()

	if not ply:IsResistance() then -- ИЗМЕНЕНО
		DarkRP.notify(ply, 0, 4, "Этим может воспользоваться только Сопротивление")
		return
	end

	if p_team == TEAM_RESISTANCE9 then
		DarkRP.notify(ply, 0, 4, "Вортигонт не может воспользоваться этим")
		return
	end
	net.Start('SupplierMenu')
	net.Send(ply)
end

net.Receive("SupplierPurchase", function(len, ply)
	local supplier = net.ReadEntity()
	local name = net.ReadString()
    local weapon_to_give = net.ReadString()
	local price = net.ReadString()

	if not ply:canAfford(price) then
		DarkRP.notify(ply, 1, 4, "У вас не хватает денег!")

		return
	end

	if weapon_to_give == "health" then
		ply:SetHealth(ply:GetMaxHealth())
	elseif weapon_to_give == "armor" then
		ply:SetArmor(ply:GetMaxArmor())
	elseif weapon_to_give == "ammo_357" then
		ply:GiveAmmo(30, "357")
	elseif weapon_to_give == "ammo_ar2" then
		ply:GiveAmmo(150, "ar2")
	elseif weapon_to_give == "ammo_buckshot" then
		ply:GiveAmmo(30, "buckshot")
	elseif weapon_to_give == "ammo_pistol" then
		ply:GiveAmmo(50, "pistol")
	elseif weapon_to_give == "ammo_smg" then
		ply:GiveAmmo(120, "smg1")
	elseif weapon_to_give == "ammo_sniper_rounds" then
		ply:GiveAmmo(30, "SniperPenetratedRound")
	elseif weapon_to_give == "ammo07" then
		ply:GiveAmmo(1, "XBowBolt")
	elseif weapon_to_give == "ammo08" then
		ply:GiveAmmo(1, "RPG_Round")
	else
		ply:Give(weapon_to_give)
	end
	
	DarkRP.notify(ply, 0, 5, string.format("Вы купили %s", name))
	ply:addMoney(-price, "Инвестировал в говно")
end)