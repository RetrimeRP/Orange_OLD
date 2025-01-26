include('shared.lua')

local FindAR3At = ZAR3_FindAR3At
ZAR3_FindAR3At, ZAR3_AR3Position = nil, nil

local AR3 = nil
local Shooting = false

usermessage.Hook('ZAR3_S', function(msg)

	AR3 = msg:ReadEntity()

	local wep = LocalPlayer():GetActiveWeapon()
	local vm = LocalPlayer():GetViewModel()

	if not IsValid(wep) then
		if IsValid(vm) then
			vm:SetNoDraw(false)
		end

		return
	end

	if IsValid(AR3) then
		vm:SetNoDraw(true)
	else
		if IsValid(vm) then
			vm:SetNoDraw(false)
		end

		wep:SendWeaponAnim(ACT_VM_DRAW)
		wep:SetNextPrimaryFire(math.max(CurTime() + wep:SequenceDuration(), wep:GetNextPrimaryFire()))
		wep:SetNextSecondaryFire(math.max(CurTime() + wep:SequenceDuration(), wep:GetNextSecondaryFire()))

		timer.Simple(vm:SequenceDuration(), function()
			if IsValid(wep) and wep == LocalPlayer():GetActiveWeapon() then
				wep:SendWeaponAnim(ACT_VM_IDLE)
			end
		end)
	end

end)

function ENT:Draw()

	self:DrawModel()

end

hook.Add('CreateMove', '_ZAR3CreateMove', function(cmd)

	if IsValid(AR3) then
		if cmd:KeyDown(IN_ATTACK) then
			cmd:SetButtons(cmd:GetButtons() - IN_ATTACK)

			if not Shooting then
				Shooting = true
				RunConsoleCommand('zar3_attack', '1')
			end
		elseif Shooting then
			Shooting = false
			RunConsoleCommand('zar3_attack', '0')
		end

		if cmd:KeyDown(IN_ATTACK2) then
			cmd:SetButtons(cmd:GetButtons() - IN_ATTACK2)
		end
	end

end)