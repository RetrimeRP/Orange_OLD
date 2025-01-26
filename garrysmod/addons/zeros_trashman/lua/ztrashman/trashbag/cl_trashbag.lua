/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

if SERVER then return end
ztm = ztm or {}
ztm.Trashbag = ztm.Trashbag or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

function ztm.Trashbag.Initialize(Trashbag)
    zclib.EntityTracker.Add(Trashbag)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

function ztm.Trashbag.Draw(Trashbag)
    if zclib.Convar.Get("zclib_cl_drawui") == 1 and zclib.util.InDistance(LocalPlayer():GetPos(), Trashbag:GetPos(), 300) and ztm.Player.IsTrashman(LocalPlayer()) then
        ztm.HUD.DrawTrash(Trashbag:GetTrash(),Trashbag:GetPos() + Vector(0, 0, 35))
    end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795


function ztm.Trashbag.OnRemove(Trashbag)
    ztm.Effects.Trash(Trashbag:GetPos())
    ztm.Effects.Trash(Trashbag:GetPos())
    ztm.Effects.Trash(Trashbag:GetPos())
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e
