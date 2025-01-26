ENT.Base = "base_anim"
ENT.Type = "anim"
ENT.Category = "Retrime"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.PrintName = "Turret"
ENT.Author = "Zaubermuffin & VALERY"
ENT.Contact = "https://steamcommunity.com/id/valery/"
ENT.AutomaticFrameAdvance = true

local FindAR3At

function ENT:CanTool(ply, tr, mode)

	return mode == "remover" or mode == "colour" or mode == "material" or mode == "nocollide"

end

ENT.PhysgunDisabled = true

hook.Add("CanProperty", "_ZAR3CanProperty", function(ply, act, ent)

	if not IsValid(ent) then return end
	local class = ent:GetClass()

	if (class ~= "darkrp_turret_01" and ent:GetModel() ~= "models/props_combine/combine_barricade_short01a.mdl") or (act ~= "bonemanipulate" and act ~= "drive" and act ~= "persist" and act ~= "nocollide_on" and act ~= "collision") then return end
	if class == "darkrp_turret_01" then return false end
	if FindAR3At(ent) then return false end

end)

local function AR3Position(clamp)

	return clamp:GetPos() + clamp:GetUp() * 10 - clamp:GetForward() * 4

end

local vec111 = Vector(1, 1, 1)
function FindAR3At(clamp)

	local pos = AR3Position(clamp)

	for k, v in pairs(ents.FindInBox(pos - vec111, pos + vec111)) do
		if v:GetClass() == "darkrp_turret_01" then return v end
	end

	return false

end

ZAR3_FindAR3At, ZAR3_AR3Position = FindAR3At, AR3Position

properties.Add("zar3_collision_off", {

	MenuLabel = "Turn world collision off",
	Order = 1501,
	MenuIcon = "icon16/collision_off.png",
	Filter = function(self, ent, ply)
		if not IsValid(ent) or (ent:GetClass() ~= "darkrp_turret_01" and not FindAR3At(ent)) then return false end

		local clamp = ent:GetClass() == "darkrp_turret_01" and ent:GetParent() or ent

		if not IsValid(clamp) then return false end
		if clamp:GetCollisionGroup() ~= COLLISION_GROUP_NONE then return false end
		if not gamemode.Call("CanProperty", ply, "zar3_nocollide", FindAR3At(clamp)) then return false end

		return true
	end,
	Action = function(self, ent)
		self:MsgStart()
		net.WriteEntity(ent)
		self:MsgEnd()
	end,
	Receive = function(self, length, player)

		local ent = net.ReadEntity()

		if not self:Filter(ent, player) then return end

		local clamp = ent:GetClass() == "darkrp_turret_01" and ent:GetParent() or ent
		local phys = clamp:GetPhysicsObject()

		if not IsValid(phys) then return end

		phys:EnableCollisions(false)
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:EnableMotion(false)

		clamp:SetCollisionGroup(COLLISION_GROUP_WORLD)
		clamp.ZAR3NoCollided = true
	end

})

properties.Add("zar3_collision_on", {

	MenuLabel = "Turn world collision on",
	Order = -99,
	MenuIcon = "icon16/collision_on.png",
	Filter = function(self, ent, ply)

		if not IsValid(ent) or (ent:GetClass() ~= "darkrp_turret_01" and not FindAR3At(ent)) then return false end

		local clamp = ent:GetClass() == "darkrp_turret_01" and ent:GetParent() or ent

		if not IsValid(clamp) then return false end
		if clamp:GetCollisionGroup() ~= COLLISION_GROUP_WORLD then return false end
		if not gamemode.Call("CanProperty", ply, "zar3_nocollide", FindAR3At(clamp)) then return false end

		return true
	end,
	Action = function(self, ent)
		self:MsgStart()
		net.WriteEntity(ent)
		self:MsgEnd()
	end,
	Receive = function(self, length, player)

		local ent = net.ReadEntity()

		if not self:Filter(ent, player) then return end

		local clamp = ent:GetClass() == "darkrp_turret_01" and ent:GetParent() or ent
		local phys = clamp:GetPhysicsObject()

		if not IsValid(phys) then return end

		phys:EnableCollisions(true)
		phys:EnableDrag(true)
		phys:EnableGravity(true)
		phys:EnableMotion(true)

		clamp:SetCollisionGroup(COLLISION_GROUP_NONE)
		clamp.ZAR3NoCollided = nil
	end

})