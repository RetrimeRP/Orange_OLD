hook.Add("OnPlayerHitGround", "retrime.AntiBHop", function(ply)
	-- handcuffed
	if ply:IsHandcuffed() then return end

	-- speed
	local speed = ply:GetVelocity()

	ply:SetVelocity(Vector(-(speed.x * 0.75), -(speed.y * 0.75), 0))
end)