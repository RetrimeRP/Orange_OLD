
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Superior EMP"
ENT.Category = "Superior Keypads"
ENT.Author = "Tom.bat & NoSharp"
ENT.Spawnable = false
ENT.AdminOnly = false

function ENT:GetEMPOwner()
    local owner = self:CPPIGetOwner()
    if owner then return owner end
    return self.Getowning_ent and self:Getowning_ent()
end
