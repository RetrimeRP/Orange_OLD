/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

include("shared.lua")
SWEP.PrintName = "Trash Collector" -- The name of your SWEP
SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true -- Do you want the SWEP to have a crosshair?
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

function SWEP:Initialize()
	ztm.TrashCollector.Initialize(self)
end

function SWEP:Think()
	ztm.TrashCollector.Think(self)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

function SWEP:PrimaryAttack()
	ztm.TrashCollector.PrimaryAttack(self)
end

function SWEP:SecondaryAttack()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- e110b4cc003a87b43ce6c41f4c4be402d2df062bdddb996ee76c2076b4305398
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911786

function SWEP:OnRemove()
	ztm.TrashCollector.OnRemove(self)
end

function SWEP:Holster(swep)
	ztm.TrashCollector.Holster(self)
end
