AddCSLuaFile()

function AddAmmoType(name, text)
	game.AddAmmoType({name = name,
	dmgtype = DMG_BULLET})
	
	if CLIENT then
		language.Add(name .. "_ammo", text)
	end
end

AddAmmoType("ammo_m209", "Граната М209")
AddAmmoType("tfa_ammo_ar2", "Боевые Патроны")
AddAmmoType("tfa_ammo_357", "357")
AddAmmoType("tfa_ammo_buckshot", "Патроны Дробовика")
AddAmmoType("tfa_ammo_pistol", "Пистолетные Патроны")
AddAmmoType("tfa_ammo_smg1_grenade", "SMG Grenade")
AddAmmoType("tfa_ammo_smg1_grenade_large", "SMG Grenades+")
AddAmmoType("tfa_ammo_smg", "Патроны для ПП")
AddAmmoType("tfa_ammo_sniper_rounds", "Снайперские Патроны")
AddAmmoType("tfa_ammo_winchester", "Патроны Для Винчестера")