/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

ITEM.Name = "Trashbag"
ITEM.Description = "A bag of trash."
ITEM.Model = "models/zerochain/props_trashman/ztm_trashbag.mdl"
ITEM.Base = "base_darkrp"
ITEM.Stackable = false
ITEM.DropStack = false

function ITEM:GetName()
	local name = "Trashbag " .. "[ " .. self:GetData("Trash") .. ztm.config.UoW .. " ]"
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

	return self:GetData("Name", name)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

function ITEM:SaveData(ent)
	self:SetData("Trash", ent:GetTrash())
end

function ITEM:LoadData(ent)
	ent:SetTrash(self:GetData("Trash"))
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

function ITEM:Drop(ply, container,slot,ent)
	if ztm.Trashbag.GetCountByPlayer(ply) >= ztm.config.Trashbags.limit then
		ply:PickupItem( ent )
		zclib.Notify(ply, ztm.language.General["TrashbagLimit"], 1)
	else
		zclib.Player.SetOwner(ent, ply)
		ent:SetPos(ent:GetPos() + Vector(0,0,20))
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
