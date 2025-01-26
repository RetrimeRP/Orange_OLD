--[[hook.Add("PlayerInitialSpawn","RetrimeAmbient",function(ply)
-- concommand.Add("RetrimeAmbient", function(ply)
	local function RetrimeAmbientStart()
		local ambients = {
			"retrime/passive/passivemusic_01.ogg",
			"retrime/passive/passivemusic_02.mp3",
			"retrime/passive/passivemusic_03.ogg",
			"retrime/passive/passivemusic_04.ogg",
			"retrime/passive/passivemusic_05.ogg",
			"retrime/passive/passivemusic_06.ogg",
			"retrime/passive/passivemusic_07.ogg",
			"retrime/passive/passivemusic_08.ogg",
			"retrime/passive/passivemusic_09.ogg",
			"retrime/passive/passivemusic_10.ogg",
			"retrime/passive/passivemusic_11.ogg",
			"retrime/passive/passivemusic_12.ogg",
			"retrime/passive/passivemusic_13.ogg",
			"retrime/passive/passivemusic_14.ogg",
			"retrime/passive/passivemusic_15.ogg",
			"retrime/passive/passivemusic_16.ogg",
			"retrime/passive/passivemusic_17.ogg",
			"retrime/passive/passivemusic_18.ogg",
			"retrime/passive/passivemusic_19.ogg",
			"retrime/passive/passivemusic_20.ogg",
		}
	
		local ambient = ambients[math.random(#ambients)]
		
		ply.ambient = CreateSound(ply, ambient)
		ply.ambient:Play()
		ply.ambient:ChangeVolume(0.2,0)
		timer.Simple(SoundDuration(ambient) + math.random(50,70),function()
			RetrimeAmbientStart()
		end)
	end
 
	RetrimeAmbientStart()
end)]]--

