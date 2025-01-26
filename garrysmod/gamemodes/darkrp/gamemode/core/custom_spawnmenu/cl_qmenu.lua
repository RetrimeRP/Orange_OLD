function GM:SpawnMenuOpen()

	return LocalPlayer():HasWeapon("weapon_physgun") or LocalPlayer():IsSupervisor()

end