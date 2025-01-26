/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

if SERVER then return end
local last_entcatch = -1
local near_trashcans = {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

local function DrawTrashcans()
	if IsValid(LocalPlayer()) and LocalPlayer():Alive() and IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() ~= "ztm_trashcollector" then return end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

	if CurTime() > last_entcatch then
		near_trashcans = {}

		for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), 500)) do
			if IsValid(v) and ztm.config.TrashCans.models[v:GetModel()] and v:GetNWInt("ztm_trash", nil) ~= nil and v:GetNWInt("ztm_trash") > 0 then
				table.insert(near_trashcans, v)
			end
		end

		last_entcatch = CurTime() + 1
	end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

	if near_trashcans and table.Count(near_trashcans) > 0 then
		for k, v in pairs(near_trashcans) do
			if IsValid(v) then
				ztm.HUD.DrawTrash(v:GetNWInt("ztm_trash", 0),v:GetPos() + Vector(0, 0, 50))
			end
		end
	end
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

zclib.Hook.Add("PostDrawOpaqueRenderables", "ztm_Trashcans", function()
	if ztm.config.TrashCans.Enabled then
		DrawTrashcans()
	end
end)
