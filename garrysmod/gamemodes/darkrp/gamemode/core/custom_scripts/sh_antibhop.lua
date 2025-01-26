hook.Add("OnPlayerHitGround", "DarkRP_AntiBHop", function(ply)

	if ply:IsHandcuffed() then return end

	local vel = ply:GetVelocity()

	ply:SetVelocity(Vector(-(vel.x * 0.75), -(vel.y * 0.75), 0))

end)