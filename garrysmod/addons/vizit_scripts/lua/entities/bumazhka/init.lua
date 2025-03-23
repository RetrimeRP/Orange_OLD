AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("OpenCheque")

function ENT:Initialize()
    self:SetModel("models/props_lab/clipboard.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:DrawShadow(true)
    self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end
end

-- local cooldown = 3
-- -- self.text = {
-- --     ["Заголовок"] = {},
-- --     ["Основной текст"] = {}
-- -- }
-- function ENT:Use(activator)
--     if self.NextUse and self.NextUse > CurTime() then return end
--     self.NextUse = CurTime() + cooldown
--     net.Start("OpenCheque")
--     if self.text then
--         net.WriteTable(self.text)
--     end
--     activator.currentCheque = self
--     net.Send(activator)
-- end
-- function ENT:OnRemove()
--     if IsValid(self.owner) then
--         self.owner:SetNWInt("ChequiID",nil)
--     end
-- end


-- local function createCheque(ply)
--     local ent = ents.Create("bumazhka")
--     if not IsValid(ent) then return end
--     local forward = ply:GetForward() * 50
--     local up = Vector(0, 0, 10)
--     ent:SetPos(ply:GetPos() + forward + up)
--     ent.owner = ply
--     if not ply.cheques then
--         ply.cheques = {}
--     end
--     ply.cheques[#ply.cheques + 1] = ent
--     ply:SetNWInt("ChequeID",ent:EntIndex())
--     ent:Spawn()
-- end

-- concommand.Add("createCheaque", function(ply)
--     createCheque(ply)
-- end)

