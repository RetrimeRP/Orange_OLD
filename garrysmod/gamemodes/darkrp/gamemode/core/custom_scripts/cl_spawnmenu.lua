--[[------------------------------------------------------------



	SpawnMenuOpen



------------------------------------------------------------]]--

hook.Add("SpawnMenuOpen", "retrime.SpawnMenu", function()
	local client = LocalPlayer()
	if client:IsSuperAdmin() then return end

	if not client:HasWeapon("weapon_physgun") then

		return false

	end

end)



--[[------------------------------------------------------------



	SpawnMenuCreated



------------------------------------------------------------]]--

hook.Add("SpawnMenuCreated", "retrime.SpawnMenu", function()

	local tabs = spawnmenu.GetCreationTabs()
	tabs["#spawnmenu.category.postprocess"] = nil
	tabs["#spawnmenu.category.dupes"] = nil
	tabs["#spawnmenu.category.saves"] = nil

end)