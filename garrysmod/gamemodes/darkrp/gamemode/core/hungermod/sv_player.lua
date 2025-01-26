local meta = FindMetaTable("Player")

function meta:newHungerData()
    if not IsValid(self) then return end
    self:setSelfDarkRPVar("Energy", 100)
end

function meta:hungerUpdate()

    if not IsValid(self) then return end
    if not 0.30 then return end

    local energy = self:getDarkRPVar("Energy")
    local override = hook.Call("hungerUpdate", nil, self, energy)
    local hungerjobs = DarkRP.GetHungerJobs()

    if override then return end
    if hungerjobs[self:Team()] then return end
    if self:Health() == 5 then return end

    self:setSelfDarkRPVar("Energy", energy and math.Clamp(energy - 0.30, 0, 100) or 100)

    if self:getDarkRPVar("Energy") == 0 then
        self:SetHealth(self:Health() - 5)
        if self:Health() <= 0 then
            self.Slayed = true
            self:Kill()
            hook.Call("playerStarved", nil, self)
        end
    end
end
