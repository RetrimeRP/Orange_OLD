/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

if (not SERVER) then return end
ztm = ztm or {}
ztm.Trashbag = ztm.Trashbag or {}
ztm.Trashbag.List = ztm.Trashbag.List or {}

function ztm.Trashbag.Initialize(Trashbag)
    zclib.EntityTracker.Add(Trashbag)
    table.insert(ztm.Trashbag.List ,Trashbag)
end

function ztm.Trashbag.Touch(Trashbag, other)
    if not IsValid(Trashbag) then return end
    if Trashbag:GetTrash() >= ztm.config.Trashbags.capacity then return end
    if not IsValid(other) then return end
    if other:GetClass() ~= "ztm_trash" and other:GetClass() ~= "ztm_trashbag" then return end
    if zclib.util.CollisionCooldown(other) then return end
	if zclib.util.CollisionCooldown(Trashbag) then return end

    if other:GetTrash() <= 0 then return end
	if zclib.Entity.GettingRemoved(other) then return end

    ztm.Trashbag.AddTrash(Trashbag, other)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

function ztm.Trashbag.OnTakeDamage(Trashbag, dmginfo)
    if (not Trashbag.ztm_bApplyingDamage) then
        Trashbag.ztm_bApplyingDamage = true
        Trashbag:TakePhysicsDamage(dmginfo)
        local damage = dmginfo:GetDamage()
        local entHealth = ztm.config.Damageable[Trashbag:GetClass()]

        if (entHealth > 0) then
            Trashbag.CurrentHealth = (Trashbag.CurrentHealth or entHealth) - damage
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

            if (Trashbag.CurrentHealth <= 0) then
                zclib.Entity.SafeRemove(Trashbag)
            end
        end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

        Trashbag.ztm_bApplyingDamage = false
    end
end

function ztm.Trashbag.AddTrash(Trashbag, OtherTrashbag)

	// Only transfer the amount we want to move
	local FreeSpace = ztm.config.Trashbags.capacity - Trashbag:GetTrash()
	if FreeSpace <= 0 then return end

	local moveAmount = math.Clamp(OtherTrashbag:GetTrash(),0,FreeSpace)

    Trashbag:SetTrash(Trashbag:GetTrash() + moveAmount)
	OtherTrashbag:SetTrash(OtherTrashbag:GetTrash() - moveAmount)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

	if OtherTrashbag:GetTrash() <= 0 then
		zclib.Entity.SafeRemove(OtherTrashbag)
	end
end

function ztm.Trashbag.GetCountByPlayer(ply)
    local count = 0

    for k, v in pairs(ztm.Trashbag.List) do
        if IsValid(v) and zclib.Player.IsOwner(ply, v) then
            count = count + 1
        end
    end

    return count
end

function ztm.Trashbag.Create(pos, trash, ply)
    local ent = ents.Create("ztm_trashbag")
    ent:SetPos(pos)
    ent:Spawn()
    ent:Activate()
    ent:SetTrash(trash)
    zclib.Player.SetOwner(ent, ply)
end
