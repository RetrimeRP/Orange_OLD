local entitycache = {}

--[[------------------------------------------------------------

	Entities

------------------------------------------------------------]]--
timer.Create("DarkRP_RefreshEntityCache", 1, 0, function()

	local client = LocalPlayer()

	if not IsValid(client) then return end

	local entitycount = 0
	entitycache = {}

	for k, v in ipairs(ents.FindInSphere(client:GetPos(), 300)) do
		if not IsValid(v) or not v.DrawCustom3D2D then continue end

		entitycount = entitycount + 1
		entitycache[entitycount] = v
	end

end)

hook.Add("PostDrawTranslucentRenderables", "DarkRP_Entities", function()

	for k, v in ipairs(entitycache) do
		if not v:IsValid() then continue end

		v:DrawCustom3D2D()
	end

end)