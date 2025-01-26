AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_menu.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("MusicMenu")
util.AddNetworkString("MusicOn")

function ENT:Initialize()

	self:SetModel("models/props_lab/citizenradio.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	self.RadioSong = false
	
	net.Receive("MusicOn", function(len, ply)
		local name = net.ReadString()
		local music = net.ReadString()
		self:StopSound("music/urthemoon.mp3")
		self:StopSound("music/whatsuppppppxddDDD2.mp3")
		self:StopSound("music/whereismymind.mp3")
		self:StopSound("music/zombiapokalipsis.mp3")
		self:StopSound("music/cypher.mp3")



		util.PrecacheSound(music)
		-- self:EmitSound(music, 80, 100)
		self.RadioSong = CreateSound(self, music)
		self.RadioSong:Play()
		self.RadioSong:ChangeVolume(1, 0)
		
		DarkRP.notify(ply, 0, 5, string.format("Вы включили %s", name))
	end)
end


--  function ENT:AcceptInput(name, activator, caller)
--     if ( name == "Use" && IsValid( activator ) && activator:IsPlayer( ) ) then
-- 		net.Start('MusicMenu')
-- 		net.Send(activator)
-- 	end
-- end

function ENT:OnRemove()
	if self.RadioSong then
		self.RadioSong:ChangeVolume(0, 0)
		self.RadioSong:Stop()
		self.RadioSong = false
	end
end

function ENT:Use(activator, ply)
	
	net.Start('MusicMenu')
		net.WriteEntity(self)
		net.WriteEntity("MusicOn")
	net.Send(activator)

end