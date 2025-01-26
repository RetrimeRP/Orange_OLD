/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

local ITEM = XeninInventory:CreateItemV2()
ITEM:SetMaxStack(1)
ITEM:SetModel("models/zerochain/props_trashman/ztm_trashbag.mdl")
ITEM:SetDescription("A bag of trash.")
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

ITEM:AddDrop(function(self, ply, ent, tbl, tr)
	local data = tbl.data
	ent:SetTrash(data.Trash)
	zclib.Player.SetOwner(ent, ply)
end)

function ITEM:GetData(ent)
	return {
		Trash = ent:GetTrash()
	}
end

function ITEM:GetDisplayName(item)
	return self:GetName(item)
end

function ITEM:GetName(item)
	local ent = isentity(item)
	local trash = ent and item:GetTrash() or item.data.Trash
	local name = "Trashbag " .. "[ " .. trash .. ztm.config.UoW .. " ]"

	return name
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

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
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

ITEM:Register("ztm_trashbag")
