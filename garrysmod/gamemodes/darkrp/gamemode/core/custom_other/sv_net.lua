-- local delays = {}
-- local punished = {}

-- --[[------------------------------------------------------------

-- 	PreNetworking

-- ------------------------------------------------------------]]--
-- local function PreNetworking(len, ply, name)
-- 	-- valid
-- 	if not IsValid(ply) then
-- 		return true
-- 	end

-- 	-- kick
-- 	if len >= 512000 then
-- 		ply:Kick("Net Overflow")
-- 		return true
-- 	end

-- 	-- punished
-- 	if punished[ply] then
-- 		return true
-- 	end

-- 	-- delays
-- 	delays[ply] = delays[ply] or {}

-- 	if delays[ply][name] then
-- 		local delay = delays[ply][name].last

-- 		if delay < CurTime() then
-- 			delays[ply][name].last = CurTime() + 1
-- 			delays[ply][name].penalty = 1
-- 		elseif delay > CurTime() then
-- 			delays[ply][name].last = CurTime() + 1
-- 			delays[ply][name].penalty = delays[ply][name].penalty + 1

-- 			if delays[ply][name].penalty > 256 then
-- 				punished[ply] = true

-- 				if ply:Staff() then
-- 					ply:Kick("Net Overflow")
-- 				else
-- 					RunConsoleCommand("sam", "ban", ply:SteamID(), "0", "(net overflow)") -- ИЗМЕНЕНО
-- 				end

-- 				return true
-- 			end
-- 		end
-- 	else
-- 		delays[ply][name] = {}
-- 		delays[ply][name].last = CurTime() + 1
-- 		delays[ply][name].penalty = 1
-- 	end
-- end

-- --[[------------------------------------------------------------

-- 	net.Incoming

-- ------------------------------------------------------------]]--
-- function net.Incoming(len, ply)
-- 	-- name
-- 	local id = net.ReadHeader()
-- 	local name = util.NetworkIDToString(id)

-- 	if not name then return end

-- 	-- callfunction
-- 	local callfunction = net.Receivers[name:lower()]

-- 	if not callfunction then return end

-- 	-- len
-- 	len = len - 16

-- 	-- PreNetworking
-- 	local prevent = PreNetworking(len, ply, name)

-- 	if prevent then return end

-- 	-- callfunction
-- 	callfunction(len, ply)
-- end

-- --[[------------------------------------------------------------

-- 	PlayerDisconnect

-- ------------------------------------------------------------]]--
-- hook.Add("PlayerDisconnect", "retrime.Networking", function(ply)
-- 	delays[ply] = nil
-- 	punished[ply] = nil
-- end)