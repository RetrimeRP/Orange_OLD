local math_NormalizeAngle = math.NormalizeAngle
local angle = FindMetaTable("Vector").Angle

local mpfmodels = {

	["models/retrime/metropolice/rct.mdl"] = true,
	["models/retrime/metropolice/union.mdl"] = true,
	["models/retrime/metropolice/helix.mdl"] = true,
	["models/retrime/metropolice/grid.mdl"] = true,
	["models/retrime/metropolice/jury.mdl"] = true,
	["models/retrime/metropolice/maid.mdl"] = true,
	["models/retrime/metropolice/apex.mdl"] = true,
	["models/retrime/metropolice/ofc.mdl"] = true,
	["models/retrime/metropolice/epu.mdl"] = true,
	["models/retrime/metropolice/dvl.mdl"] = true,
	["models/retrime/metropolice/sec.mdl"] = true

}

local otamodels = {

	["models/retrime/overwatch/echo.mdl"] = true,
	["models/retrime/overwatch/riot.mdl"] = true,
	["models/retrime/overwatch/xray.mdl"] = true,
	["models/retrime/overwatch/mace.mdl"] = true,
	["models/retrime/overwatch/knight.mdl"] = true,
	["models/retrime/overwatch/king.mdl"] = true,
	["models/retrime/overwatch/heavy.mdl"] = true,
	["models/retrime/overwatch/sow.mdl"] = true,
	["models/retrime/overwatch/ordinal.mdl"] = true

}

local models_cremator = {
	["models/retrime/orange/other/cremator_01.mdl"] = true
}

local mpfanimations = {

	["normal"] = {
		[ACT_MP_STAND_IDLE]               = {ACT_IDLE, ACT_IDLE},
		[ACT_MP_CROUCHWALK]               = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
		[ACT_MP_ATTACK_STAND_PRIMARYFIRE] = {ACT_MELEE_ATTACK_SWING_GESTURE, ACT_MELEE_ATTACK_SWING_GESTURE}
	},
	["pistol"] = {
		[ACT_MP_STAND_IDLE]               = {ACT_IDLE_PISTOL, ACT_IDLE_ANGRY_PISTOL},
		[ACT_MP_CROUCH_IDLE]              = {ACT_COVER_PISTOL_LOW, nil},
		[ACT_MP_WALK]                     = {ACT_WALK_PISTOL, ACT_WALK_AIM_PISTOL},
		[ACT_MP_CROUCHWALK]               = {ACT_WALK_CROUCH, nil},
		[ACT_MP_RUN]                      = {ACT_RUN_PISTOL, ACT_RUN_AIM_PISTOL},
		[ACT_MP_ATTACK_STAND_PRIMARYFIRE] = {ACT_GESTURE_RANGE_ATTACK_PISTOL, ACT_GESTURE_RANGE_ATTACK_PISTOL},
		[ACT_MP_RELOAD_STAND]             = {ACT_GESTURE_RELOAD_PISTOL, ACT_GESTURE_RELOAD_PISTOL}
	},
	["smg"] = {
		[ACT_MP_STAND_IDLE]               = {ACT_IDLE_SMG1, ACT_IDLE_ANGRY_SMG1},
		[ACT_MP_CROUCH_IDLE]              = {ACT_COVER_SMG1_LOW, nil},
		[ACT_MP_WALK]                     = {ACT_WALK_RIFLE, ACT_WALK_AIM_RIFLE},
		[ACT_MP_CROUCHWALK]               = {ACT_WALK_CROUCH, nil},
		[ACT_MP_RUN]                      = {ACT_RUN_RIFLE, ACT_RUN_AIM_RIFLE},
		[ACT_MP_RELOAD_STAND]             = {ACT_GESTURE_RELOAD_SMG1, ACT_GESTURE_RELOAD_SMG1},
		[ACT_MP_RELOAD_CROUCH]            = {ACT_GESTURE_RELOAD_SMG1, ACT_GESTURE_RELOAD_SMG1}
	},
	["shotgun"] = {
		[ACT_MP_STAND_IDLE]               = {ACT_IDLE_SMG1, ACT_IDLE_ANGRY_SMG1},
		[ACT_MP_CROUCH_IDLE]              = {ACT_COVER_SMG1_LOW, nil},
		[ACT_MP_WALK]                     = {ACT_WALK_RIFLE, ACT_WALK_AIM_RIFLE},
		[ACT_MP_CROUCHWALK]               = {ACT_WALK_CROUCH, nil},
		[ACT_MP_RUN]                      = {ACT_RUN_RIFLE, ACT_RUN_AIM_RIFLE},
		[ACT_MP_RELOAD_STAND]             = {ACT_GESTURE_RELOAD_SMG1, ACT_GESTURE_RELOAD_SMG1},
		[ACT_MP_RELOAD_CROUCH]            = {ACT_GESTURE_RELOAD_SMG1, ACT_GESTURE_RELOAD_SMG1}
	},
	["grenade"] = {
		[ACT_MP_STAND_IDLE]               = {ACT_IDLE, ACT_IDLE_ANGRY_MELEE},
		[ACT_MP_WALK]                     = {ACT_WALK, ACT_WALK_ANGRY},
		[ACT_MP_RUN]                      = {ACT_RUN, ACT_RUN},
		[ACT_MP_ATTACK_STAND_PRIMARYFIRE] = {ACT_MELEE_ATTACK_SWING_GESTURE, ACT_MELEE_ATTACK_SWING_GESTURE}
	},
	["melee"] = {
		[ACT_MP_STAND_IDLE]               = {ACT_IDLE, ACT_IDLE_ANGRY_MELEE},
		[ACT_MP_CROUCH_IDLE]              = {ACT_COVER_PISTOL_LOW, ACT_COVER_PISTOL_LOW},
		[ACT_MP_WALK]                     = {ACT_WALK, ACT_WALK_ANGRY},
		[ACT_MP_CROUCHWALK]               = {ACT_WALK_CROUCH, ACT_WALK_CROUCH},
		[ACT_MP_RUN]                      = {ACT_RUN, ACT_RUN},
		[ACT_MP_ATTACK_STAND_PRIMARYFIRE] = {ACT_MELEE_ATTACK_SWING_GESTURE, ACT_MELEE_ATTACK_SWING_GESTURE}
	}

}

local otaanimations = {

	["smg"] = {
		[ACT_MP_STAND_IDLE]               = {ACT_IDLE_SMG1, nil},
		[ACT_MP_CROUCHWALK]               = {ACT_WALK_CROUCH_RIFLE, nil}
	},
	["ar2"] = {
		[ACT_MP_STAND_IDLE]               = {ACT_IDLE_SMG1, nil},
		[ACT_MP_CROUCHWALK]               = {ACT_WALK_CROUCH_RIFLE, nil}
	},
	["shotgun"] = {
		[ACT_MP_STAND_IDLE]               = {ACT_IDLE_SMG1, nil},
		[ACT_MP_CROUCHWALK]               = {ACT_WALK_CROUCH_RIFLE, nil}
	}

}

local animations_cremator = {
	[ACT_LAND]                            = ACT_RESET,
	[ACT_MP_STAND_IDLE]                   = ACT_IDLE,
	[ACT_MP_CROUCH_IDLE]                  = ACT_IDLE,
	[ACT_MP_WALK]                         = ACT_WALK,
	[ACT_MP_CROUCHWALK]                   = ACT_WALK,
	[ACT_MP_RUN]                          = ACT_WALK,
	[ACT_MP_JUMP]                         = ACT_IDLE,
	[ACT_LAND]                            = ACT_RESET,
	[ACT_MP_SWIM]                         = ACT_IDLE
}

local blacklist = {

	["darkrp_medkit"] = true,
	["darkrp_lockpick"] = true,
	["darkrp_ram"] = true,
	["darkrp_hackdevice"] = true

}

hook.Add("TranslateActivity", "DarkRP_Animations", function(ply, act)

	local mdl = ply:GetModel()

	if mpfmodels[mdl] then
		--
		-- fix jump animations
		--
		if act == ACT_LAND then
			return ACT_RESET
		end

		--
		-- weapon
		--
		local weapon = ply:GetActiveWeapon()
		weapon = IsValid(weapon) and weapon or nil

		if not weapon then return end

		local class = weapon:GetClass()

		if blacklist[class] then return end

		--
		-- holdtype
		--
		local animations = mpfanimations[(weapon.HoldType or weapon:GetHoldType()) or "normal"]

		if animations then
			local newact = animations[act]

			if newact then
				return newact[(string.sub(class, 1, 4) == "tfa_" and weapon.IsSafety and weapon:IsSafety()) and 1 or 2]
			end
		end
	elseif otamodels[mdl] then
		--
		-- fix jump animations
		--
		if act == ACT_LAND then
			return ACT_RESET
		end

		--
		-- weapon
		--
		local weapon = ply:GetActiveWeapon()
		weapon = IsValid(weapon) and weapon or nil

		if not weapon then return end

		local class = weapon:GetClass()

		if blacklist[class] then return end

		--
		-- holdtype
		--
		local animations = otaanimations[(weapon.HoldType or weapon:GetHoldType()) or "normal"]

		if animations then
			local newact = animations[act]

			if newact then
				return newact[(string.sub(class, 1, 4) == "tfa_" and weapon.IsSafety and weapon:IsSafety()) and 1 or 2]
			end
		end
	elseif models_cremator[mdl] then
		local newact = animations_cremator[act]

		if newact then
			return newact
		end
	end

end)

hook.Add("CalcMainActivity", "DarkRP_Animations", function(ply, vel)

	local mdl = ply:GetModel()

	if mpfmodels[mdl] then
		ply:SetPoseParameter("move_yaw", math_NormalizeAngle(angle(vel)[2] - ply:EyeAngles()[2]))
	elseif otamodels[mdl] then
		ply:SetPoseParameter("move_yaw", math_NormalizeAngle(angle(vel)[2] - ply:EyeAngles()[2]))
	end

end)