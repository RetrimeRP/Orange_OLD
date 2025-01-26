/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

AddCSLuaFile()
include("sh_ztm_config.lua")
AddCSLuaFile("sh_ztm_config.lua")

TOOL.Category = "Zeros Trashman"
TOOL.Name = "#TrashSpawner"
TOOL.Command = nil


if (CLIENT) then
	language.Add("tool.ztm_trashspawner.name", "Zeros Trashman - Trash Spawner")
	language.Add("tool.ztm_trashspawner.desc", "LeftClick: Creates a Trash Spawnpoint. \nRightClick: Removes a Trash Spawnpoint.")
	language.Add("tool.ztm_trashspawner.0", "LeftClick: Creates a Trash Spawn.")
end

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

function TOOL:LeftClick(trace)
	local trEnt = trace.Entity

	if trEnt:IsPlayer() then return false end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80

	if (CLIENT) then return end
	if (trEnt:GetClass() == "worldspawn") or trEnt == Entity(0) then

		if trace.Hit and trace.HitPos and zclib.util.InDistance(trace.HitPos, self:GetOwner():GetPos(), 1000) then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

	       ztm.Trash.AddSpawnPos(trace.HitPos,self:GetOwner())
	    end

		return true
	else
		return false
	end
end

function TOOL:RightClick(trace)
	if (trace.Entity:IsPlayer()) then return false end
	if (CLIENT) then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

	if trace.Hit and trace.HitPos then

		if zclib.util.InDistance(trace.HitPos, self:GetOwner():GetPos(), 1000) then

	       ztm.Trash.RemoveSpawnPos(trace.HitPos,self:GetOwner())
	    end

		return true
	else
		return false
	end
end

function TOOL:Deploy()
	if SERVER then
		if zclib.Player.IsAdmin(self:GetOwner()) == false then return end

		ztm.Trash.ShowAll(self:GetOwner())
	end
end

function TOOL:Holster()
	if SERVER then
		ztm.Trash.HideAll(self:GetOwner())
	end
end

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {
		Text = "#tool.ztm_trashspawner.name",
		Description = "#tool.ztm_trashspawner.desc"
	})

	CPanel:AddControl("label", {
		Text = "Saves all the Trash points that are currently on the Map"
	})
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

	CPanel:Button("Save Trash points", "ztm_trash_save")

	CPanel:AddControl("label", {
		Text = " "
	})
	CPanel:AddControl("label", {
		Text = "Removes all the Trash points that are currently on the Map"
	})

	CPanel:Button("Remove all Trash points", "ztm_trash_remove")
end
