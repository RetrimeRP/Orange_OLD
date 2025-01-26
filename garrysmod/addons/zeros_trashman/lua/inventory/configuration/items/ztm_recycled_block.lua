/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

local ITEM = XeninInventory:CreateItemV2()
ITEM:SetMaxStack(10)
ITEM:SetModel("models/zerochain/props_trashman/ztm_recycleblock.mdl")
ITEM:SetDescription("A block of recycled trash.")

ITEM:AddDrop(function(self, ply, ent, tbl, tr)
	local data = tbl.data
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

	ent:SetRecycleType(data.RecycleType)

	zclib.Player.SetOwner(ent, ply)
end)

function ITEM:CanStack(newItem, invItem)
	local ent = isentity(newItem)
	local RecycleType = ent and newItem:GetRecycleType() or newItem.data.RecycleType
	return RecycleType == invItem.data.RecycleType
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

function ITEM:GetData(ent)
	return {
		RecycleType = ent:GetRecycleType(),
	}
end

function ITEM:GetDisplayName(item)
	return self:GetName(item)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80

function ITEM:GetName(item)
	local ent = isentity(item)
	local RecycleType = ent and item:GetRecycleType() or item.data.RecycleType
	local trash_name = ztm.config.Recycler.recycle_types[RecycleType].name
	return trash_name
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

function ITEM:GetCameraModifiers(tbl)
	return {
		FOV = 40,
		X = 0,
		Y = -22,
		Z = 25,
		Angles = Angle(0, -190, 0),
		Pos = Vector(0, 0, -1)
	}
end

function ITEM:GetClientsideModel(tbl, mdlPanel)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

	local RecycleType = tbl.data.RecycleType
	local _recycle_type = ztm.config.Recycler.recycle_types[RecycleType]

	mdlPanel.Entity:SetMaterial( _recycle_type.mat, true )
end

ITEM:Register("ztm_recycled_block")
