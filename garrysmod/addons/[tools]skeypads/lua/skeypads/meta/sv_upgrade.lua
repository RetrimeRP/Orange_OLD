sKeypads.UPGRADE = {}
sKeypads.UPGRADE.__index = sKeypads.UPGRADE


function sKeypads.UPGRADE:getName()
    return "BASE"
end

function sKeypads.UPGRADE:setMaxUpgrade(lvl)
    self.maxUpgrade = lvl
end

function sKeypads.UPGRADE:getMaxUpgrade()
    return self.maxUpgrade
end

function sKeypads.UPGRADE:getUpgradeLevel()
    return self.upgradeLevel
end

function sKeypads.UPGRADE:setUpgradeLevel(lvl)
    self.upgradeLevel = lvl
end

function sKeypads.UPGRADE:addUpradeLevel()
    self.upgradeLevel = self.upgradeLevel + 1
end

function sKeypads.UPGRADE:canUpgrade()
    return self:getUpgradeLevel() + 1 <= self:getMaxUpgrade()
end

function sKeypads.UPGRADE:setParentMeta(meta)
    self.parent = meta
end

function sKeypads.UPGRADE:hookFunction(funcName, detour)
    self.parent["old_" .. funcName] = funcName
    self.parent[funcName] = function(...)
        local detouredRet = detour(...)
        if detouredRet then return detouredRet end
        return self.parent["old_" .. funcName](...)
    end
end