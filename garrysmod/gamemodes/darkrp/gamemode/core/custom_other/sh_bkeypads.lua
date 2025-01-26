--[[------------------------------------------------------------

	PreRegisterSENT

------------------------------------------------------------]]--
if SERVER then
	hook.Add("PreRegisterSENT", "RetrimebKeypads", function(tbl, ent)
		if ent == "bkeypads_dmg_consumable" then
			tbl.Use = function() end
		end
	end)
end

--[[------------------------------------------------------------

	PhysgunPickup

------------------------------------------------------------]]--
if bKeypads and bKeypads.FadingDoors then
	hook.Add("PhysgunPickup", "RetrimebKeypads", function(ply, ent)
		if bKeypads.FadingDoors:IsFadingDoor(ent) then
			return false
		end
	end)
end