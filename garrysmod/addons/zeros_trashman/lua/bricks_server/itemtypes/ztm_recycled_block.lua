/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

local ITEM = BRICKS_SERVER.Func.CreateItemType("ztm_recycled_block")

ITEM.GetItemData = function(ent)
    if (not IsValid(ent)) then return end
    local itemData = {"ztm_recycled_block", "models/zerochain/props_trashman/ztm_recycleblock.mdl",ent:GetRecycleType()}

    return itemData, 1
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

ITEM.OnSpawn = function(ply, pos, itemData, itemAmount)
    local ent = ents.Create("ztm_recycled_block")
    if not IsValid(ent) then return end
    ent:SetPos(pos)
    ent:Spawn()
    ent:Activate()
	ent:SetRecycleType(itemData[3])
	zclib.Player.SetOwner(ent, ply)
end

ITEM.GetInfo = function(itemData)

	local trash_name = ztm.config.Recycler.recycle_types[itemData[3]].name
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80

    return {trash_name, "A block of recycled trash.", ""}
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

ITEM.ModelDisplay = function(Panel, itemtable)
    if (not Panel.Entity or not IsValid(Panel.Entity)) then return end
    local mn, mx = Panel.Entity:GetRenderBounds()
    local size = 0
    size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
    size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
    size = math.max(size, math.abs(mn.z) + math.abs(mx.z))
    Panel:SetFOV(20)
    Panel:SetCamPos(Vector(size, size * 3, size * 2))
    Panel:SetLookAt((mn + mx) * 0.5)
    Panel.Entity:SetAngles(Angle(0, -45, 0))

	local RecycleType = itemtable[3]
	local _recycle_type = ztm.config.Recycler.recycle_types[RecycleType]
	if _recycle_type and _recycle_type.mat then
		Panel.Entity:SetMaterial(_recycle_type.mat, true)
	end
end

ITEM.CanCombine = function(itemData1, itemData2) return false end
ITEM:Register()

if BRICKS_SERVER and BRICKS_SERVER.CONFIG and BRICKS_SERVER.CONFIG.INVENTORY and BRICKS_SERVER.CONFIG.INVENTORY.Whitelist then
    BRICKS_SERVER.CONFIG.INVENTORY.Whitelist["ztm_recycled_block"] = {false, true}
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a
