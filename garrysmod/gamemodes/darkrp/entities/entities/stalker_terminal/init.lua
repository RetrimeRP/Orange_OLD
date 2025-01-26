AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

util.AddNetworkString("Un.Actions")
util.AddNetworkString("Un.Marks")

local Actions = Actions or {}

local pMeta = FindMetaTable("Player")

local func = function() end
function pMeta:AddAction(text, data)

	if IsValid(self) and not Actions[self:SteamID()] then
		local onfinishtime = CurTime() + data.delaytime
		local check = data.check or func
		local onaction = data.onaction or func
		local onfinish = data.onfinish or func
		local onfail = data.onfail or func
		Actions[self:SteamID()] = {
			ply = self,
			time = onfinishtime,
			check = check,
			onaction = onaction,
			onfinish = onfinish,
			onfail = onfail,
		}

		net.Start("Un.Actions")
		net.WriteBool(true)
		net.WriteString(text)
		net.WriteFloat(onfinishtime)
		net.Send(self)
	end

end 

local function RemoveAction(ply)

	if IsValid(ply) and Actions[ply:SteamID()] then
		Actions[ply:SteamID()] = nil

		net.Start("Un.Actions")
		net.WriteBool(false)
		net.Send(ply)
	end
end

hook.Add("PlayerDisconnected", "Un.ActionDisc", function(ply)
	RemoveAction(ply)
end)

local next_think = CurTime() + 0.1

hook.Add("Think", "ActionCalculate", function()

	if next_think >= CurTime() then return end

	for k, v in pairs(Actions) do
		if IsValid(v.ply) then
			if v.time >= CurTime() then
				if v.check(v.ply) then
					if not v.timer or v.timer >= 10 then
						v.onaction(v.ply)
						v.timer = 0
					end
					v.timer = (v.timer or 0) + 1
				else
					RemoveAction(v.ply)
					v.onfail(v.ply)
				end
			else
				RemoveAction(v.ply)
				v.onfinish(v.ply)
			end
		end
	end

	next_think = CurTime() + 0.1
end)

hook.Add("AddMark", "Un.AddMark", function(text, data, rcp)
	local data = {
		id = data.id or "",
		text = text or "",
		pos = data.pos or Entity(0),
		time = data.time + CurTime(),
		icon = data.icon or "add",
		sounds = data.sounds,
		dist = data.dist or 1000
	}

	net.Start("Un.Marks")
	net.WriteTable(data)
	if rcp then
		net.Send(rcp)
	else
		net.Broadcast()
	end
end)

hook.Add("RemoveMark", "Un.RemoveMark", function(uniqID)
	local data = { id = uniqID, bool = false }

	net.Start("Un.Marks")
	net.WriteTable(data)
	net.Broadcast()
end)


function ENT:Initialize()
	self:SetModel( "models/props_combine/combine_interface001.mdl" )
	--[[self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )]]
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetNW2Int("FuckedUp", CurTime())
end

function ENT:AcceptInput(ply, caller)
    if IsValid( caller ) and caller:IsPlayer() then
		if caller:Team() == TEAM_SYNTH2 or caller:IsSuperAdmin() then
			if(self:GetNW2Int("FuckedUp") < CurTime()) then
					local data = {
						delaytime = 10,
						check = function(caller)
							if not IsValid(self) or caller:GetEyeTrace().Entity ~= self or self:GetNW2Int("FuckedUp") > CurTime() or not caller:Alive() or not (caller:GetPos():DistToSqr(self:GetPos()) <= (100 * 100)) then
								return false
							end

							return true
						end,
						onaction = function(caller)
							caller:EmitSound("physics/metal/metal_barrel_impact_hard".. math.random(1,7) ..".wav", 45)
						end,
						onfinish = function(caller) 
							local sell =  math.random( 500, 1200 ) 
							caller:addMoney(sell)
							DarkRP.notify(caller, 4, 4, "За данный терминал вы получили ".. sell .." ₮")
							self:SetNW2Int("FuckedUp", CurTime() + math.random(300,600))
						end
					}
					caller:AddAction("Починка", data)

			end
			
		end
	end
end