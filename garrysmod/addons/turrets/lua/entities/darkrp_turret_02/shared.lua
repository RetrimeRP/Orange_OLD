ENT.Type = "anim"
ENT.PrintName = "DShK"
ENT.Author = "Black Tea & VALERY"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.Category = "Retrime"
ENT.AutomaticFrameAdvance = true
ENT.RenderGroup = RENDERGROUP_BOTH

do

	local customsound = {channel = CHAN_WEAPON, volume = 1, soundlevel = 130, pitchstart = 95, pitchend = 100}
	customsound.name = "PSHK_STATIONARY.Single"
	customsound.sound = {"kord_1.wav"}

	sound.Add(customsound)

end

function ENT:GetShootDir()

	local pos, ang = self:GetBonePosition(8)
	return ang:Up()

end

function ENT:GetShootPos()

	local pos, ang = self:GetBonePosition(4)
	return pos + ang:Right() * -45 + ang:Up() * 20

end

function ENT:GetShellDir()

	local pos, ang = self:GetBonePosition(8)
	return ang:Forward() * -1

end

function ENT:GetShellPos()

	local pos, ang = self:GetBonePosition(4)
	return pos + ang:Forward() * 4 + ang:Right() * 11 + ang:Up() * 5

end