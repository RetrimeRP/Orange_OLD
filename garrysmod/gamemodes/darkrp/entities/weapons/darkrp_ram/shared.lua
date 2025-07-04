AddCSLuaFile()

if CLIENT then

	SWEP.PrintName = "ТАРАН"
	SWEP.Slot = 5
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false

end

DEFINE_BASECLASS("darkrp_base")
SWEP.Instructions = "Left click to break open doors/unfreeze props or get people out of their vehicles\nRight click to raise"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IsDarkRPDoorRam = true

SWEP.IconLetter = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/weapons/c_rpg.mdl")
SWEP.WorldModel = Model("models/weapons/w_rocket_launcher.mdl")
SWEP.AnimPrefix = "rpg"
SWEP.UseHands = true

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Category = "Role Play"
SWEP.Sound = Sound("physics/wood/wood_box_impact_hard3.wav")

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()

	if CLIENT then
		self.LastIron = CurTime()
	end

	self:SetHoldType("normal")

end

function SWEP:Holster()

	self:SetIronsights(false)

	return true

end

local function canRam(ply)

	return IsValid(ply) and (ply.warranted == true or ply:isWanted() or ply:isArrested())

end

local function ramDoor(ply, trace, ent)

	if ply:EyePos():DistToSqr(trace.HitPos) > 2025 or (not GAMEMODE.Config.canforcedooropen and ent:getKeysNonOwnable()) then return false end

	local allowed = false

	if GAMEMODE.Config.doorwarrants and ent:isKeysOwned() and not ent:isKeysOwnedBy(ply) then
		for _, v in ipairs(player.GetAll()) do
			if ent:isKeysOwnedBy(v) and canRam(v) then
				allowed = true
				break
			end
		end
	else
		allowed = true
	end

	local keysDoorGroup = ent:getKeysDoorGroup()

	if GAMEMODE.Config.doorwarrants and keysDoorGroup then
		local teamDoors = RPExtraTeamDoors[keysDoorGroup]

		if teamDoors then
			allowed = false

			for _, v in ipairs(player.GetAll()) do
				if table.HasValue(teamDoors, v:Team()) and canRam(v) then
					allowed = true
					break
				end
			end
		end
	end

	if CLIENT then return allowed end

	if not allowed then
		DarkRP.notify(ply, 1, 5, DarkRP.getPhrase("warrant_required"))

		return false
	end

	ent:keysUnLock()
	ent:Fire("open", "", .6)
	ent:Fire("setanimation", "open", .6)

	return true

end

local function ramVehicle(ply, trace, ent)

	if ply:EyePos():DistToSqr(trace.HitPos) > 10000 then return false end
	if CLIENT then return false end

	local driver = ent:GetDriver()

	if not IsValid(driver) or not driver.ExitVehicle then return false end

	driver:ExitVehicle()
	ent:keysLock()

	return true

end

local function ramFadingDoor(ply, trace, ent)

	if ply:EyePos():DistToSqr(trace.HitPos) > 10000 then return false end

	local Owner = ent:CPPIGetOwner()

	if CLIENT then return canRam(Owner) end

	if not canRam(Owner) then
		DarkRP.notify(ply, 1, 5, DarkRP.getPhrase("warrant_required"))

		return false
	end

	if not ent.fadeActive then
		ent:fadeActivate()

		timer.Simple(5, function()
			if IsValid(ent) and ent.fadeActive then
				ent:fadeDeactivate()
			end
		end)
	end

	return true

end

local function ramProp(ply, trace, ent)

	if ply:EyePos():DistToSqr(trace.HitPos) > 10000 then return false end
	if ent:GetClass() ~= "prop_physics" then return false end

	local Owner = ent:CPPIGetOwner()

	if CLIENT then return canRam(Owner) end

	if not canRam(Owner) then
		DarkRP.notify(ply, 1, 5, DarkRP.getPhrase(GAMEMODE.Config.copscanunweld and "warrant_required_unweld" or "warrant_required_unfreeze"))

		return false
	end

	if GAMEMODE.Config.copscanunweld then
		constraint.RemoveConstraints(ent, "Weld")
	end

	if GAMEMODE.Config.copscanunfreeze then
		ent:GetPhysicsObject():EnableMotion(true)
	end

	return true

end

local function getRamFunction(ply, trace)

	local ent = trace.Entity

	if not IsValid(ent) then return fp{fn.Id, false} end

	local override = hook.Call("canDoorRam", nil, ply, trace, ent)

	return override ~= nil and fp{fn.Id, override} or ent:isDoor() and fp{ramDoor, ply, trace, ent} or ent:IsVehicle() and fp{ramVehicle, ply, trace, ent} or ent.fadeActivate and fp{ramFadingDoor, ply, trace, ent} or ent:GetPhysicsObject():IsValid() and not ent:GetPhysicsObject():IsMoveable() and fp{ramProp, ply, trace, ent} or fp{fn.Id, false}

end

function SWEP:PrimaryAttack()

	if not self:GetIronsights() then return end

	self:SetNextPrimaryFire(CurTime() + 0.1)
	self:GetOwner():LagCompensation(true)

	local trace = self:GetOwner():GetEyeTrace()

	self:GetOwner():LagCompensation(false)

	local hasRammed = getRamFunction(self:GetOwner(), trace)()

	if SERVER then
		hook.Call("onDoorRamUsed", GAMEMODE, hasRammed, self:GetOwner(), trace)
	end

	if not hasRammed then return end

	self:SetNextPrimaryFire(CurTime() + 2.5)
	self:SetTotalUsedMagCount(self:GetTotalUsedMagCount() + 1)
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:GetOwner():EmitSound(self.Sound)
	self:GetOwner():ViewPunch(Angle(-10, math.Round(util.SharedRandom("DarkRP_DoorRam" .. self:EntIndex() .. "_" .. self:GetTotalUsedMagCount(), -5, 5)), 0))

end

function SWEP:SecondaryAttack()

	if CLIENT then
		self.LastIron = CurTime()
	end

	self:SetNextSecondaryFire(CurTime() + 0.30)
	self:SetIronsights(not self:GetIronsights())

	if self:GetIronsights() then
		self:SetHoldType("rpg")
	else
		self:SetHoldType("normal")
	end

end

function SWEP:GetViewModelPosition(pos, ang)

	local Mul = 1

	if self.LastIron > CurTime() - 0.25 then
		Mul = math.Clamp((CurTime() - self.LastIron) / 0.25, 0, 1)
	end

	if self:GetIronsights() then
		Mul = 1 - Mul
	end

	ang:RotateAroundAxis(ang:Right(), -15 * Mul)

	return pos, ang

end

DarkRP.hookStub{

	name = "canDoorRam",
	description = "Called when a player attempts to ram something. Use this to override ram behaviour or to disallow ramming.",
	parameters = {
		{
			name = "ply",
			description = "The player using the door ram.",
			type = "Player"
		},
		{
			name = "trace",
			description = "The trace containing information about the hit position and ram entity.",
			type = "table"
		},
		{
			name = "ent",
			description = "Short for the entity that is about to be hit by the door ram.",
			type = "Entity"
		}
	},
	returns = {
		{
			name = "override",
			description = "Return true to override behaviour, false to disallow ramming and nil (or no value) to defer the decision.",
			type = "boolean"
		}
	},
	realm = "Shared"

}

if SERVER then

	DarkRP.hookStub{
		name = "onDoorRamUsed",
		description = "Called when the door ram has been used.",
		parameters = {
			{
				name = "success",
				description = "Whether the door ram has been successful in ramming.",
				type = "boolean"
			},
			{
				name = "ply",
				description = "The player that used the door ram.",
				type = "Player"
			},
			{
				name = "trace",
				description = "The trace containing information about the hit position and ram entity.",
				type = "table"
			}
		},
		returns = {}
	}

end

hook.Add("SetupMove", "DarkRP_DoorRamJump", function(ply, mv)

	local wep = ply:GetActiveWeapon()

	if not wep:IsValid() or wep:GetClass() ~= "door_ram" or not wep.GetIronsights or not wep:GetIronsights() then return end

	mv:SetButtons(bit.band(mv:GetButtons(), bit.bnot(IN_JUMP)))

end)