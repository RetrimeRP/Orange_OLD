AddCSLuaFile("cl_menu.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("DisguiseUse")

--[[------------------------------------------------------------

	Disguise

------------------------------------------------------------]]--
local removeweapon = {
    "weapon_cuff_elastic",
    "darkrp_stunstick",
    "darkrp_search",
    "darkrp_medkit",
    "darkrp_ram",
    "darkrp_shield_02",
    "darkrp_medkit",
    "tfa_grach",
    "tfa_mp153",
    "tfa_akm",
    "tfa_pistol",
    "tfa_mp5k",
    "tfa_smg",
    "tfa_oicw",
    "tfa_shotgun"
}

net.Receive("DisguiseUse", function(len, ply)
    local model = net.ReadString()
    local k = net.ReadString()
    local disguise = ply:getDarkRPVar("disguise")
    local disguiselist = DarkRP.GetDisguiseList()

    if k == "0" then 
        -- models
        local models = ply:getJobTable().model
        models = istable(models) and models or {models}
        
        if ply.DisguiseModel and table.HasValue(models, ply.DisguiseModel) then
            ply:SetModel(ply.DisguiseModel)
            ply:SetupHands()
        else
            ply:SetModel(models[math.random(#models)])
            ply:SetupHands()
        end

        ply:Freeze(false)
        -- ply:SetModel(ply:getJobTable().model)
        ply:setDarkRPVar("job", ply:getJobTable().name)
        ply:setDarkRPVar("disguise", nil) 
        DarkRP.notify(ply, 2, 3, "Вы сняли маскировку")
        for k, v in pairs(removeweapon) do
            ply:StripWeapon(v)
        end

        return
    else
        if ply.NextDisguiseUse and ply.NextDisguiseUse > CurTime() then
            DarkRP.notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. math.ceil(ply.NextDisguiseUse - CurTime()) .. " секунд")
            return
        end

        ply:Freeze(true)

        -- effect
        local bone = ply:LookupBone("ValveBiped.Anim_Attachment_RH")
        
        if bone then
            ParticleEffectAttach("generic_smoke", 4, ply, bone)
        end
        for k, v in pairs(removeweapon) do
            ply:StripWeapon(v)
        end
    end

	timer.Simple(4.4, function()
		if not IsValid(ply) then return end

		if ply:Alive() then
			-- delay
			local delay = 60
            ply.NextDisguiseUse = CurTime() + delay

			if disguiselist then

                if DarkRP.GetDisguiseList()[k].weapons then
                    for k, v in ipairs(DarkRP.GetDisguiseList()[k].weapons) do
                        if ply:HasWeapon(v) then continue end

                        ply:Give(v, true)
                    end
                end

                -- models
	            local models = DarkRP.GetDisguiseList()[k].model
	            models = istable(models) and models or {models}

	            if ply.DisguiseModel and table.HasValue(models, ply.DisguiseModel) then
	            	ply:SetModel(ply.DisguiseModel)
	            	ply:SetupHands()
	            else
	            	ply:SetModel(models[math.random(#models)])
	            	ply:SetupHands()
	            end

                ply:setDarkRPVar("disguise", k)

                if DarkRP.GetDisguiseList()[k].combine then
                    ply:setDarkRPVar("job", DarkRP.GetDisguiseList()[k].name .. " ".. math.random(1000,9999))
                else
                    ply:setDarkRPVar("job", DarkRP.GetDisguiseList()[k].name)
                end

                DarkRP.notify(ply, 0, 4, DarkRP.GetDisguiseList()[k].name .. " теперь ваша маскировка")
                DarkRP.notify(ply, 0, 5, "Вы можете воспользоваться новой маскировкой через " .. delay .. " секунд")
			end

            ply:StopParticles()
            ply:Freeze( false )
        end
    end)
end)

local HOOKS = {
    PlayerSpawn = function(ply)
        local disguise = ply:getDarkRPVar("disguise")
    
        if disguise then
            ply.NextDisguiseUse = CurTime() + 300
    
            -- disguise
            ply:setDarkRPVar("job", ply:getJobTable().name)
            ply:setDarkRPVar("disguise", nil) 
    
            DarkRP.notify(ply, 0, 5, "Вы потеряли маскировку и можете воспользоваться ей через 5 минут")
        end
    end,
    OnPlayerChangedTeam = function(ply)
        local disguise = ply:getDarkRPVar("disguise")
    
        if disguise then
            ply.NextDisguiseUse = CurTime() + 300
            ply:setDarkRPVar("job", ply:getJobTable().name)
            ply:setDarkRPVar("disguise", nil) 
        end
    end,

    canDropWeapon = function(ply, wep)
        local disguise = ply:getDarkRPVar("disguise")
        local weapons = removeweapon
    
        if disguise then
            if weapons and table.HasValue(weapons, wep:GetClass()) then
                return false
            end
        end
    end
}

--[[------------------------------------------------------------

	PlayerSpawn

------------------------------------------------------------]]--
hook.Add("PlayerSpawn", "RetDisguise", HOOKS.PlayerSpawn)

--[[------------------------------------------------------------

	OnPlayerChangedTeam

------------------------------------------------------------]]--
hook.Add("OnPlayerChangedTeam", "RetDisguise", HOOKS.OnPlayerChangedTeam)

--[[------------------------------------------------------------

	canDropWeapon

------------------------------------------------------------]]--
hook.Add("canDropWeapon", "RetDisguise", HOOKS.canDropWeapon)

