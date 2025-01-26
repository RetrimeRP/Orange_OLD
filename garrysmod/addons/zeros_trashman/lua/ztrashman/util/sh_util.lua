/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

ztm = ztm or {}
ztm.util = ztm.util or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

function ztm.Print(msg)
	print("[Zero´s Trashman] " .. msg)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80

if (CLIENT) then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398

	// Checks if the entity did not got drawn for certain amount of time and call update functions for visuals
	function ztm.util.UpdateEntityVisuals(ent)
		if zclib.util.InDistance(LocalPlayer():GetPos(), ent:GetPos(), 1000) then

			local curDraw = CurTime()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

			if ent.LastDraw == nil then
				ent.LastDraw = CurTime()
			end

			if ent.LastDraw < (curDraw - 1) then
				//print("Entity: " .. ent:EntIndex() .. " , Call UpdateVisuals() at " .. math.Round(CurTime()))

				ent:UpdateVisuals()
			end

			ent.LastDraw = curDraw
		end
	end
end
