/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

ITEM.Name = "Recycled Trash"
ITEM.Description = "A block of recycled trash."
ITEM.Model = "models/zerochain/props_trashman/ztm_recycleblock.mdl"
ITEM.Base = "base_darkrp"
ITEM.Stackable = false
ITEM.DropStack = false
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80

function ITEM:GetName()
	local name = ztm.config.Recycler.recycle_types[self:GetData("RecycleType")].name
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

	return self:GetData("Name", name)
end

function ITEM:SaveData(ent)
	self:SetData("RecycleType", ent:GetRecycleType())
end

function ITEM:LoadData(ent)
	ent:SetRecycleType(self:GetData("RecycleType"))
	local _recycle_type = ztm.config.Recycler.recycle_types[ent:GetRecycleType()]

	ent:SetMaterial( _recycle_type.mat, true )
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8
