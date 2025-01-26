local nextplay = 0

local songs = {
	{
		song = "retrime/orange/song1.mp3",
		name = "Low Roar – Don't Be So Serious"
	},
	{
		song = "retrime/orange/song2.mp3",
		name = "Silent Poets, Leila Adu, Michiharu Shimoda – Asylums for the Feeling"
	},
	{
		song = "retrime/orange/song3.mp3",
		name = "Low Roar, Jófriður – Bones"
	}
}

concommand.Add("playmusic", function()
	-- nextplay
	if nextplay > CurTime() then return end

	nextplay = CurTime() + 1800

	-- random
	local random = songs[math.random(#songs)]

	-- sound
	surface.PlaySound(random.song)

	-- chat
	chat.AddText(Color(49, 107, 94), "[♪] ", Color(65, 150, 131), random.name)
end)