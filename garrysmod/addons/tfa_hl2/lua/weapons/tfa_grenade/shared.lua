--include("weapons/tfa_grenade_base.lua")

SWEP.Category = "Retrime [Альянс]"
SWEP.Spawnable = true
SWEP.PrintName = "Граната"
SWEP.Base = "tfa_nade_base"
SWEP.Author = "VALERY"
SWEP.Contact = "https://steamcommunity.com/id/valery/"
SWEP.ViewModel = "models/weapons/v_grenade.mdl"
SWEP.ViewModelFOV = 54
SWEP.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.Weight = 5
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.DrawCrosshair = false
SWEP.Primary.Ammo = "grenade"
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.UseHands = false

-- WEAPON HANDLING
SWEP.Delay = 0.001
SWEP.Delay_Underhand = 0.001
SWEP.Primary.Round = "npc_grenade_frag"

SWEP.Callback = {

	ChoosePullAnim = function(self)
		local pullback = false
		local pullbacked = false
		local owner = self:GetOwner()

		if owner:KeyDown(IN_ATTACK2) then
			pullback = true
		end

		if not pullbacked then
			pullbacked = true

			if pullback then
				self:SendWeaponAnim(ACT_VM_PULLBACK_LOW)
			else
				self:SendWeaponAnim(ACT_VM_PULLBACK_HIGH)
			end
		end
	end

}

function SWEP:Holster()

	if self.PreviousWeapon then self.PreviousWeapon = nil end

	return true

end

function SWEP:Reload()
end

function SWEP:Think()
end

--function SWEP:CycleFireMode()
--end

--function SWEP:CycleSafety()
--end

-- WORLDMODEL
SWEP.HoldType = "grenade"

local function CheckPosition(owner, pos1, pos2)

	local trace = {}
	trace.start = pos1
	trace.endpos = pos2
	trace.mins = -Vector(6, 6, 6)
	trace.maxs = Vector(6, 6, 6)
	trace.mask = MASK_PLAYERSOLID
	trace.filter = owner
	trace.collision = owner:GetCollisionGroup()

	if owner:IsPlayer() then
		owner:LagCompensation(true)
	end

	local tr = util.TraceHull(trace)

	if owner:IsPlayer() then
		owner:LagCompensation(false)
	end

	if tr.Hit then
		pos2 = tr.HitPos
	end

	return pos2

end

function SWEP:ThrowGrenade(vel1, vel2, vel3)

	if SERVER then
		local owner = self:GetOwner()
		local eyepos = owner:EyePos()
		local eyeang = owner:EyeAngles()

		local pos = CheckPosition(owner, eyepos, eyepos + eyeang:Forward() * 18 + eyeang:Right() * 8)

		if not pos then return end

		local grenade = ents.Create("npc_grenade_frag")
		grenade:SetPos(pos)
		grenade:SetAngles(Angle(0, 0, 0))
		grenade.Activator = owner
		grenade:Fire("SetTimer", 2.5, nil, owner, owner)
		grenade:Spawn()
		grenade:Activate()

		local phys = grenade:GetPhysicsObject()

		if phys then
			phys:SetVelocity(owner:GetVelocity() + eyeang:Forward() * vel1)
			phys:AddAngleVelocity(Vector(vel2, math.random(-vel3, vel3), 0))
		end
	end

end

function SWEP:Throw()

	local owner = self:GetOwner()

	if not self.PreviousWeapon then self.PreviousWeapon = owner:GetPreviousWeapon() end

	if self:Clip1() > 0 then
		local underhanded = self:GetNW2Bool("Underhanded", false)

		if underhanded then
			self:ThrowGrenade(100, 200, 600)
		else
			self:ThrowGrenade(400*3, 600*2, 1200*5)
		end

		self:TakePrimaryAmmo(1)

		if SERVER and self:Ammo1() <= 0 then

			timer.Create("strip_timer" .. tostring(self), 1/66, 1, function()

				if not IsValid(self) or not self:OwnerIsValid() then return end

				owner:StripWeapon(self.ClassName)

			end)

			return

		end

		if CLIENT and self:Ammo1() <= 0 then

			timer.Create("strip_timer" .. tostring(self), 1/66, 1, function()

				if not IsValid(self) or not self:OwnerIsValid() or not self.PreviousWeapon or not self.PreviousWeapon:IsWeapon() then return end

				input.SelectWeapon(self.PreviousWeapon)

			end)

			return

		end

		timer.Create("deploy_timer" .. tostring(self), 0.5, 1, function()

			if not IsValid(self) or not self:OwnerIsValid() then return end

			self:Deploy()

		end)

	end

end