if SERVER then
    local mat_min, mat_max, mat_huge, vect = math.min, math.max, math.huge, Vector
    function TOOL:Reload(trace)
        local own = self:GetOwner()
        if not own:IsSuperAdmin() then return end
        if not own.triggerEntity then return end
        if own.triggerEntity then
            own.triggerEntity:Remove()
            own.triggerEntity = nil
        end
        return true
    end

    function TOOL:LeftClick(trace)
        local own = self:GetOwner()
        if not own:IsSuperAdmin() then return end

        if not self.Points then self.Points = {} end

        if #self.Points >= 4 then
            -- own:ChatPrint("4 ТОЧКИ ЕЕЕСТЬ. Нажмите ПКМ, чтобы завершить.")
            return false
        end

        table.insert(self.Points, trace.HitPos)
        own:ChatPrint("Точка " .. #self.Points)
        return true
    end

    function TOOL:RightClick(trace)
        local own = self:GetOwner()
        if not own:IsSuperAdmin() then return end

        if not self.Points or #self.Points < 4 then
            -- own:ChatPrint("4 ТОЧКИ, ТОЧКИ ОЧИЩЕНЫ")
            self.Points = {}
            return false
        end

        local minBounds = vect(mat_huge, mat_huge, mat_huge)
        local maxBounds = vect(-mat_huge, -mat_huge, -mat_huge)

        for _, point in ipairs(self.Points) do
            minBounds.x = mat_min(minBounds.x, point.x)
            minBounds.y = mat_min(minBounds.y, point.y)
            minBounds.z = 0

            maxBounds.x = mat_max(maxBounds.x, point.x)
            maxBounds.y = mat_max(maxBounds.y, point.y)
            maxBounds.z = 500
        end

        local center = (minBounds + maxBounds) / 2

        local newEntity = ents.Create("point_trigger")
        if IsValid(newEntity) then
            newEntity:SetPos(center)
            timer.Simple(0.1,function()
                newEntity:SetCollisionBounds(minBounds - center, maxBounds - center)
            end)
            newEntity:SetTrigger(true)
            newEntity:Spawn()
            -- own:ChatPrint("Энтити point_trigger создана.")
            own.triggerEntity = newEntity
        end

        self.Points = nil
        return true
    end
end
