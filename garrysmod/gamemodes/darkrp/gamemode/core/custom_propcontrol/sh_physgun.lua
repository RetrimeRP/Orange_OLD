-- local whitelist = {
-- 	["prop_physics"] = true,
-- 	["gmod_cameraprop"] = true
-- }

-- --[[------------------------------------------------------------

-- 	GhostProp

-- ------------------------------------------------------------]]--
-- local function MakeGhostProp(ply, ent)
-- 	if ent:IsPlayer() then return end
-- 	if ply:Staff() then return true end
-- end

-- hook.Add("PhysgunPickup", "retrime.Ghosting", function(ply, ent)
-- 	if whitelist[ent:GetClass()] then
-- 		MakeGhostProp(ent)
-- 	end
-- end)
-- -- --Physgun Pickup
-- -- function FPP.Protect.PhysgunPickup(ply, ent)
-- --     if not tobool(FPP.Settings.FPP_PHYSGUN1.toggle) then if FPP.UnGhost then FPP.UnGhost(ply, ent) end return end
-- --     if not ent:IsValid() then return end

-- --     if type(ent.PhysgunPickup) == "function" then
-- --         local val = ent:PhysgunPickup(ply, ent)
-- --         if val ~= nil then return val end
-- --     elseif ent.PhysgunPickup ~= nil then
-- --         return ent.PhysgunPickup
-- --     end

-- --     if ent:IsPlayer() then return end
-- --     if ply:Staff() then return true end

-- --     local cantouch = FPP.plyCanTouchEnt(ply, ent, "Physgun")

-- --     if cantouch and FPP.UnGhost then
-- --         FPP.UnGhost(ply, ent)
-- --     end

-- --     if not cantouch then return false end
-- -- end
-- -- hook.Add("OnPhysgunPickup", "retrime.Ghosting", function(ply, ent)
-- -- 	if whitelist[ent:GetClass()] then
-- -- 		MakeGhostProp(ent)
-- -- 	end
-- -- end)
-- -- hook.Add("PhysgunPickup", "FPP.Protect.PhysgunPickup", FPP.Protect.PhysgunPickup)