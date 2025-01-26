AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/props_combine/masterinterface.mdl" )
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
						delaytime = 20,
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
							local sell =  math.random( 1000, 2400 ) 
							caller:addMoney(sell)
							DarkRP.notify(caller, 4, 4, "За данный терминал вы получили ".. sell .." ₮")
							self:SetNW2Int("FuckedUp", CurTime() + math.random(600,1200))
						end
					}
					caller:AddAction("Починка", data)

			end
			
		end
	end
end