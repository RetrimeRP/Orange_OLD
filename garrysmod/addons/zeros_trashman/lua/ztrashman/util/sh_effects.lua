/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

ztm = ztm or {}
ztm.Effects = ztm.Effects or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

local effects = {"ztm_trash_break01","ztm_trash_break02","ztm_trash_break03"}
function ztm.Effects.Trash(pos,ent)
	zclib.Effect.ParticleEffect(effects[ math.random( #effects ) ],pos, angle_zero, ent or Entity(1))
	if IsValid(ent) then ent:EmitSound("ztm_trash_break") end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

zclib.NetEvent.AddDefinition("ztm_leafpile_fx", {
	[1] = {
		type = "entity"
	}
}, function(received)
	local ent = received[1]
	if not IsValid(ent) then return end
	if zclib.util.InDistance(LocalPlayer():GetPos(), ent:GetPos(), 1500) == false then return end
	ent:EmitSound("ztm_leafpile_explode01")
	zclib.Effect.ParticleEffect("ztm_leafpile_explode", ent:GetPos(), ent:GetAngles(), ent)
end)

zclib.NetEvent.AddDefinition("ztm_trashcollector_primary_fx", {
	[1] = {
		type = "entity"
	}
}, function(received)
	local SwepOwner = received[1]
	if not IsValid(SwepOwner) then return end
	if zclib.util.InDistance(LocalPlayer():GetPos(), SwepOwner:GetPos(), 500) == false then return end
	local swep = SwepOwner:GetActiveWeapon()
	if not IsValid(swep) then return end
	if swep:GetClass() ~= "ztm_trashcollector" then return end

	if LocalPlayer() == SwepOwner then
		local ve = GetViewEntity()

		if ve:GetClass() ~= "player" then
			zclib.Effect.ParticleEffectAttach("ztm_air_burst", PATTACH_POINT_FOLLOW, swep, 1)
		end
	else
		zclib.Effect.ParticleEffectAttach("ztm_air_burst", PATTACH_POINT_FOLLOW, swep, 1)
	end
end)
