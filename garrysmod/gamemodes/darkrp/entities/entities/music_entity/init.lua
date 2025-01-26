AddCSLuaFile("entities/music_entity/cl_init.lua")
AddCSLuaFile("entities/music_entity/shared.lua")
include("entities/music_entity/shared.lua")

ENT.Type = "anim"
ENT.Base = "base_gmodentity"

function ENT:Initialize()
    self:SetModel("models/props_combine/combine_intmonitor001.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
end

function ENT:Use(activator, caller)
    if not IsValid(activator) or not activator:IsPlayer() then return end
	activator:ConCommand("open_music_menu")
end

function ENT:StartMusic(url, ply)
    local station = nil
    sound.PlayURL(url, "3d", function(sound_station)
        if IsValid(sound_station) then
            sound_station:SetPos(self:GetPos())
            sound_station:Play()
            station = sound_station

			local pos = self:GetPos()
			local player_positions = {}
			for k, v in pairs(player.GetAll()) do
				if v:GetPos():Distance(pos) <= 99999999999999 then
					player_positions[k] = {entity = sound_station, pos = pos}
				end
			end
            timer.Simple(0, function()
				net.Start("play_radio_to_player")
                local filtered_positions = {}
                for k,v in pairs(player_positions) do
                    if IsValid(v.entity) then
                        filtered_positions[k] = v
                    end
                end
				net.WriteTable(filtered_positions)
				net.Broadcast()
            end)
        else
            if ply and IsValid(ply) then
				ply:ChatPrint("Неверный URL-адрес!")
			end
        end
    end)
end