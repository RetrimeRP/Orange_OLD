game.AddParticles("particles/tfa_muzzleflash_ar2.pcf")

PrecacheParticleSystem("ar2_muzzle")

PrecacheParticleSystem("ar2_muzzle2")

PrecacheParticleSystem("ar2_muzzle_sparks")

PrecacheParticleSystem("ar2_muzzleaura1")

PrecacheParticleSystem("ar2_muzzleaura2")

PrecacheParticleSystem("ar2_muzzleaura3")

PrecacheParticleSystem("ar2_muzzleglow")

PrecacheParticleSystem("ar2_muzzleglow2")

PrecacheParticleSystem("ar2_muzzlelong")

PrecacheParticleSystem("ar2_rifle_steam")

PrecacheParticleSystem("ar2_vm_medium_sparks")

PrecacheParticleSystem("ar2_muzzle_brake_energy")

PrecacheParticleSystem("ar2_muzzle_energy")

PrecacheParticleSystem("ar2_muzzle_flash_energy")

PrecacheParticleSystem("ar2_muzzle_flash_energy2")

PrecacheParticleSystem("ar2_muzzle_sparks_energy")

PrecacheParticleSystem("tfa_muzzle_brake_ar2")

PrecacheParticleSystem("tfa_muzzleflash_ar2")

PrecacheParticleSystem("tfa_muzzleflash_ar22")

PrecacheParticleSystem("tfa_muzzle_sparks_ar2")

PrecacheParticleSystem("muzzle_minigun_core")

PrecacheParticleSystem("AR_Muzzle")

sound.Add( {
	name = "Weapon_cmAR2.Shoot",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 100,
	pitch = 100,
	sound = "weapons/cmar2/fire1.wav"
} )
sound.Add( {
	name = "Weapon_cmAR2.RRotate",
	channel = CHAN_USER_BASE+11,
	volume = 1.0,
	level = 100,
	pitch = 100,
	sound = "weapons/cmar2/ar2_reload_rotate.wav"
} )
sound.Add( {
	name = "Weapon_cmAR2.GrabAndPush",
	channel = CHAN_USER_BASE+11,
	volume = 1.0,
	level = 100,
	pitch = 100,
	sound = "weapons/cmar2/grabandpush.wav"
} )
sound.Add( {
	name = "Weapon_cmAR2.RPush",
	channel = CHAN_USER_BASE+11,
	volume = 1.0,
	level = 100,
	pitch = 100,
	sound = "weapons/cmar2/ar2_reload_push.wav"
} )
sound.Add( {
	name = "Weapon_cmAR2.ChargeOut",
	channel = CHAN_USER_BASE+11,
	volume = 1.0,
	level = 100,
	pitch = { 95, 105 },
	sound = "weapons/cmar2/chargeout.wav"
} )
sound.Add( {
	name = "Weapon_cmAR2.Charging",
	channel = CHAN_USER_BASE+11,
	volume = 1.0,
	level = 100,
	pitch = { 95, 105 },
	sound = "weapons/cmar2/charging.wav"
} )
sound.Add( {
	name = "Weapon_cmAR2.GearRuffle",
	channel = CHAN_USER_BASE+11,
	volume = 1.0,
	level = 100,
	pitch = { 95, 105 },
	sound = "weapons/cmar2/gearsound.wav"
} )
sound.Add( {
	name = "Weapon_cmAR2.Grab",
	channel = CHAN_USER_BASE+11,
	volume = 1.0,
	level = 100,
	pitch = { 95, 105 },
	sound = "weapons/cmar2/grab.wav"
} )
sound.Add( {
	name = "Weapon_cmAR2.AltFire1",
	channel = CHAN_USER_BASE+11,
	volume = 1.0,
	level = 100,
	pitch = { 95, 105 },
	sound = "weapons/cmar2/irifle_fire2.wav"
} )
sound.Add( {
	name = "Weapon_cmAR2.MagIn",
	channel = CHAN_USER_BASE+11,
	volume = 1.0,
	level = 100,
	pitch = { 95, 105 },
	sound = "weapons/cmar2/magin2.wav"
} )
sound.Add( {
	name = "Weapon_cmAR2.MagOut",
	channel = CHAN_USER_BASE+11,
	volume = 1.0,
	level = 100,
	pitch = { 95, 105 },
	sound = "weapons/cmar2/magout.wav"
} )
sound.Add( {
	name = "Weapon_cmAR2.DryFire",
	channel = CHAN_USER_BASE+11,
	volume = 1.0,
	level = 100,
	pitch = 100,
	sound = "weapons/cmar2/dryfireclick.wav"
} )