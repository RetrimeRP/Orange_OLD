AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

--[[------------------------------------------------------------

	Ignite Player, Ignite Build, Ignite Corpse

------------------------------------------------------------]]--
function SWEP:IgnitePlayer(ent, ply)

	if ent:IsOnFire() then
		local dmg = DamageInfo()
		dmg:SetDamage(30)
		dmg:SetInflictor(ent)
		dmg:SetAttacker(ply)
		dmg:SetDamageType(DMG_BURN)

		ent:TakeDamageInfo(dmg)
	else
		ent:Ignite(10)
	end

end

local random = math.random
local timer = timer
local epicmetal_hard6 = Sound("phx/epicmetal_hard6.wav")
function SWEP:IgniteBuild(ent, ply)

	-- Ignited
	if ent.Ignited then return end

	ent.Ignited = true

	-- Ignite
	local expires = random(4, 7)

	ent:Ignite(expires)

	timer.Simple(expires + 1, function()
		if IsValid(ent) then
			ent:EmitSound(epicmetal_hard6)
			ent:Remove()
		end
	end)

end

local notify = DarkRP.notify
local formatMoney = DarkRP.formatMoney
function SWEP:IgniteCorpse(ent, ply)

	-- Ignited
	if ent.Ignited then return end

	ent.Ignited = true

	-- Ignite
	local expires = random(4, 7)

	ent:Ignite(expires)

	timer.Simple(expires + 1, function()
		if IsValid(ent) and IsValid(ply) then
			ent:SetNoDraw(true)

			-- money
			local money = random(500, 1000)

			ply:addMoney(money)
			notify(ply, 0, 4, "Вы получили " .. formatMoney(money) .. " за утилизацию трупа")

			timer.Simple(random(25, 45), function()
				if IsValid(ent) and ent.Ignited then
					ent:SetNoDraw(false)
					ent.Ignited = nil
				end
			end)
		end
	end)

end