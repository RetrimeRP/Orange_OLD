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
	["models/retrime/metropolice/sec.mdl"] = true,

	["models/retrime/guardian/insp.mdl"] = true

}

local otamodels = {

	["models/retrime/overwatch/echo.mdl"] = true,
	["models/retrime/overwatch/riot.mdl"] = true,
	["models/retrime/overwatch/xray.mdl"] = true,
	["models/retrime/overwatch/mace.mdl"] = true,
	["models/retrime/overwatch/sow.mdl"] = true,
	["models/retrime/overwatch/ordinal.mdl"] = true,

	["models/player/com_night_elite.mdl"] = true,
	["models/player/com_night_elite_prisonguard.mdl"] = true,
	["models/player/com_super_night_elite.mdl"] = true

}

local crematormodels = {
	["models/retrime/orange/other/cremator_01.mdl"] = true
}

hook.Add("PlayerFootstep", "DarkRP_Footsteps", function(ply)

	local mdl = ply:GetModel()

	if mpfmodels[mdl] then
		-- sprinting
		if not ply:IsSprinting() then return end

		-- footstep
		local lvl = (ply == LocalPlayer() and 30) or 60

		ply:EmitSound("npc/metropolice/gear" .. math.random(1, 6) .. ".wav", lvl, 100, 1, CHAN_BODY)
		return true
	elseif otamodels[mdl] then
		-- sprinting
		if not ply:IsSprinting() then return end

		-- footstep
		local lvl = (ply == LocalPlayer() and 30) or 60

		ply:EmitSound("npc/combine_soldier/gear" .. math.random(1, 6) .. ".wav", lvl, 100, 1, CHAN_BODY)
		return true
	elseif crematormodels[mdl] then
		-- footstep
		local lvl = (ply == LocalPlayer() and 30) or 60

		ply:EmitSound("retrime/orange/cremator/foot" .. math.random(1, 3) .. ".wav", lvl, 100, 1, CHAN_BODY)
		return true
	end

end)