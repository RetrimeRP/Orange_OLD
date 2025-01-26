AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


--[[------------------------------------------------------------

	Initialize

------------------------------------------------------------]]--
function ENT:Initialize()
	self:SetModel("models/mark2580/ue4/trees/christmastree.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetSkin(3)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end

	-- Инициализируем количество игрушек
	self:SetIgrushki(0)
    -- Инициализируем флаг Use в NWVar, чтобы он сохранялся между перезагрузками
	self:SetNWBool("Christmas_Tree_Used", false) 
end

--[[------------------------------------------------------------

	Use

------------------------------------------------------------]]--
function ENT:Use(ply)
	local igrushki = ply:GetNWInt("Christmas_Balls", 0)

    -- Получаем состояние Use из NWVar
	local use = self:GetNWBool("Christmas_Tree_Used")

    -- Проверяем, что Use не true, если True, то дальше код не исполняется
    if use then
        DarkRP.notify(ply, 0, 4, "Вы уже собрали ёлку.")
        return
    end

	if igrushki > 0 then
		DarkRP.notify(ply, 0, 4, "Вы принесли игрушки к ёлке.")
		ply:SetNWInt("Christmas_Balls", 0)
		self:SetIgrushki(self:GetIgrushki() + igrushki)
		if self:GetIgrushki() >= 1500 and self:GetIgrushki() < 15000 then
			self:SetSkin(5)
		elseif self:GetIgrushki() >= 15000 then
			self:SetSkin(6)
		end

		-- Если игрушек стало 15000, то устанавливаем флаг Use в true, и вызываем ивент для начисления денег
		if self:GetIgrushki() >= 15000 then
			for k, v in ipairs(player.GetAll()) do
				v:addMoney(5000)
				DarkRP.notify(v, 0, 4, "Вы собрали ёлку.")
			end
            -- Устанавливаем флаг Use в NWVar
			self:SetNWBool("Christmas_Tree_Used", true)
		end
	else
		DarkRP.notify(ply, 0, 4, "У вас нет ёлочных игрушек.")
	end
end