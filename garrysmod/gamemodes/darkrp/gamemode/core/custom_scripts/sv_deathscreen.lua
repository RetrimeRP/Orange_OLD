--[[------------------------------------------------------------

	Death Screen

------------------------------------------------------------]]--
local function death_time(ply)

    if ply:SteamID() == "STEAM_0:1:448435965" then
        return 1
    end
    
	if ply:Donator("platinum") then
		return 10
	end

	if ply:Donator("gold") then
		return 20
	end

	if ply:Donator("silver") then
		return 35
	end

	return 40

end

if SERVER then

	util.AddNetworkString("DeathScreen")

	hook.Add("PlayerDeath", "DarkRP_PlayerDeathScreen", function(ply, wep, ent)
		ply.DeathTime = CurTime()

		net.Start("DeathScreen")
		net.WriteBool(true)
		net.Send(ply)
	end)

	hook.Add("PlayerDeathThink", "DarkRP_DeathScreenThink", function(ply)
		if ply.DeathTime and ply.DeathTime > CurTime() - death_time(ply) then
			return false
		end
	end)

	hook.Add("PlayerSpawn", "DarkRP_DeathScreenThink", function(ply)
		if ply.DeathTime then ply.DeathTime = nil end

		net.Start("DeathScreen")
		net.WriteBool(false)
		net.Send(ply)
	end)

	hook.Add("OnPlayerChangedTeam", "DarkRP_DeathScreenSpawn", function(ply)
		timer.Simple(1.4, function()
			ply:Spawn()
		end)
	end)

end


local push = {}
local PushSound = {
    "physics/body/body_medium_impact_soft1.wav",
    "physics/body/body_medium_impact_soft2.wav",
    "physics/body/body_medium_impact_soft3.wav",
    "physics/body/body_medium_impact_soft4.wav",
    "physics/body/body_medium_impact_soft5.wav"
}

local adminPushCooldown = {}

hook.Add("KeyPress", "suck my big cloud dick", function(ply, key)
    if key == IN_USE then
        if not push[ply:UserID()] or CurTime() - push[ply:UserID()] >= 2 then
        local ent = ply:GetEyeTrace().Entity
            if ply and ply:IsValid() and ent and ent:IsValid() then
                if ply:IsPlayer() and ent:IsPlayer() then
                    if ply:GetPos():Distance(ent:GetPos()) <= 100 then
                        if ent:Alive() and ent:GetMoveType() == MOVETYPE_WALK then
                            if ent:IsAdmin() or ent:IsSuperAdmin() then
                                if not adminPushCooldown[ent:UserID()] or CurTime() - adminPushCooldown[ent:UserID()] >= 5 then
                                    ent:ChatPrint("Тебя пытался толкнуть " .. ply:Nick())
                                    adminPushCooldown[ent:UserID()] = CurTime()
                                end
                                ply:ChatPrint("Ты что дурак? Зачем толкаешь Админов?")
                            else
                                ply:EmitSound(PushSound[math.random(#PushSound)], 100, 100)
                                local velAng = ply:EyeAngles():Forward()
                                ent:SetVelocity(velAng * 400)
                                ent:ViewPunch(Angle(math.random(-30, 30), math.random(-30, 30), 0))
                                push[ply:UserID()] = CurTime()
                            end
                         end
                    end
                end
            end
        end
    end
end)