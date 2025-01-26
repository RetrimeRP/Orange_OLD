
if not sKeypads.Config.output_types["mapdoor"] then return end

hook.Add("CanTool", "sKeypads::AllowToolgunDoors", function(ply, tr, tool)
    if tool != "skeypads" then return end
    if not DarkRP then return end

    local ent = tr.Entity
    if not IsValid(ent) then return end

    if not ent:isDoor() then return end
    if ent:getDoorOwner() != ply then return end

    return true
end)
