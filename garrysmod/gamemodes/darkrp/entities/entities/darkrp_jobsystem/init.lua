AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_menu.lua")
include("cl_menu.lua")
include("shared.lua")
util.AddNetworkString("retrime.JobSystem.Menu")
util.AddNetworkString("retrime.JobSystem.Purchase")
util.AddNetworkString("retrime.JobSystem.Choose")

function ENT:Initialize()
	self:PhysicsInit(SOLID_BBOX)

	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)

	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)

	self:SetSkin(math.random(0, 20))

	-- category
	self:SetCategory("Other")

	-- LastUse
	self.LastUse = CurTime()
end

net.Receive("retrime.JobSystem.Purchase", function(len, ply)
	if not GAS or not GAS.JobWhitelist then return end

	local jobsystem = net.ReadEntity()
	local id = net.ReadUInt(8)

	if not jobsystem then return end
	if not id then return end

	if jobsystem:GetClass() ~= "darkrp_jobsystem" then return end
	if ply:GetPos():DistToSqr(jobsystem:GetPos()) > 65536 then return end

	-- job
	local job = RPExtraTeams[id]

	if job.category ~= jobsystem:GetCategory() then return end

	-- alive
	if not ply:Alive() then
		DarkRP.notify(ply, 0, 3, "Вы должны быть живы")
		return
	end

	-- customCheck
	if job.customCheck and not job.customCheck(ply) then
		DarkRP.notify(ply, 0, 4, job.CustomCheckFailMsg or "Вы не можете купить эту работу")
		return
	end

	-- whitelist
	if job.require and GAS.JobWhitelist:IsWhitelistEnabled(job.require) and not GAS.JobWhitelist:IsWhitelisted(ply, job.require) then
		DarkRP.notify(ply, 0, 4, "Вы ещё не купили требуемую работу")
		return
	end

	-- blacklist
	if GAS.JobWhitelist:IsBlacklistEnabled(id) and GAS.JobWhitelist:IsBlacklisted(ply, id) then
		DarkRP.notify(ply, 0, 4, "Вы в чёрном списке этой работы")
		return
	end

	-- whitelist
	if GAS.JobWhitelist:IsWhitelistEnabled(id) and GAS.JobWhitelist:IsWhitelisted(ply, id) then
		DarkRP.notify(ply, 0, 4, "Вы уже купили эту работу")
		return
	end

	-- afford
	if not ply:canAfford(job.price) then
		DarkRP.notify(ply, 0, 4, "У вас недостаточно денег для покупки")
		return
	end

	-- money
	ply:addMoney(-job.price)

	-- whitelist
	GAS.JobWhitelist:AddToWhitelist(job.team, GAS.JobWhitelist.LIST_TYPE_STEAMID, ply:SteamID())

	-- notify
	DarkRP.notify(ply, 0, 5, "Вы купили " .. job.name .. " за " .. DarkRP.formatMoney(job.price))
end)

net.Receive("retrime.JobSystem.Choose", function(len, ply, category)
	local jobsystem = net.ReadEntity()
	local id = net.ReadUInt(8)

	if not jobsystem then return end
	if not id then return end

	if jobsystem:GetClass() ~= "darkrp_jobsystem" then return end
	if ply:GetPos():DistToSqr(jobsystem:GetPos()) > 65536 then return end

	-- job
	local job = RPExtraTeams[id]

	if id ~= TEAM_ARRIVAL and job.category ~= jobsystem:GetCategory() then return end

	-- alive
	if not ply:Alive() then
		DarkRP.notify(ply, 0, 3, "Вы должны быть живы")
		return
	end

	-- gas
	if not GAS or not GAS.JobWhitelist then
		ply:changeTeam(id)
		return
	end

	-- whitelist
	if job.require and GAS.JobWhitelist:IsWhitelistEnabled(job.require) and not GAS.JobWhitelist:IsWhitelisted(ply, job.require) then
		DarkRP.notify(ply, 0, 4, "Вы ещё не купили требуемую работу")
		return
	end
	for num, v in pairs(RPExtraTeams) do
        if v.command == ent then
            k = num
			ply:changeTeam(k, false, true)
        end
    end
	
	-- choose
	ply:changeTeam(id)
end)

local function GetJob(ply, job)
	-- blocked
	if job.customCheck and not job.customCheck(ply) then
		return 1
	end

	if GAS and GAS.JobWhitelist then
		-- blacklisted
		if GAS.JobWhitelist:IsBlacklistEnabled(job.team) and GAS.JobWhitelist:IsBlacklisted(ply, job.team) then
			return 2
		end

		-- blocked
		if job.require and GAS.JobWhitelist:IsWhitelistEnabled(job.require) and not GAS.JobWhitelist:IsWhitelisted(ply, job.require) then
			return 3
		end

		-- price
		if job.price then
			-- purchase
			if GAS.JobWhitelist:IsWhitelistEnabled(job.team) and not GAS.JobWhitelist:IsWhitelisted(ply, job.team) then
				return 4
			end
		else
			-- blocked
			if GAS.JobWhitelist:IsWhitelistEnabled(job.team) and not GAS.JobWhitelist:IsWhitelisted(ply, job.team) then
				return 5
			end
		end
	end

	-- choose
	return 6
end

function JobSystem(ply, category)
	local list = {}

	-- list
	for k, v in pairs(RPExtraTeams) do
		if v.category ~= category then continue end

		list[k] = GetJob(ply, v)
	end

	-- list
	list = util.TableToJSON(list)
	list = util.Compress(list)

	return list
end

function ENT:Use(ply)
	-- list
	local list = JobSystem(ply, self:GetCategory())

	-- LastUse
	if self.LastUse > CurTime() then return end

	self.LastUse = CurTime() + 2


	-- net
	net.Start("retrime.JobSystem.Menu")
		net.WriteEntity(self)
		net.WriteUInt(#list, 12)
		net.WriteData(list, #list)
	net.Send(ply)
end

function ENT:Think()

	if SERVER then
		if self.SequenceID == nil then
			self.SequenceID = self:LookupSequence("pose_standing_0" .. math.random(1, 4))
		end

		self:ResetSequence(self.SequenceID)
	end

	self:NextThink(CurTime() + 3)
	return true

end