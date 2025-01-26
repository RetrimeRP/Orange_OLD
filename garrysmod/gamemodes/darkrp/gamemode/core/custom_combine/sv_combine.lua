local blockiddoors

hook.Add("DarkRPFinishedLoading", "DarkRP_BlockDoors", function()

	blockiddoors = {}
    blockiddoors[969] = true
    blockiddoors[968] = true
    blockiddoors[645] = true
    blockiddoors[644] = true
    blockiddoors[1206] = true
    blockiddoors[1205] = true
    blockiddoors[1208] = true
    blockiddoors[1207] = true
    blockiddoors[491] = true
    blockiddoors[490] = true
    blockiddoors[499] = true
    blockiddoors[495] = true
    blockiddoors[496] = true
    blockiddoors[497] = true
    blockiddoors[498] = true
    blockiddoors[625] = true
    blockiddoors[516] = true
    blockiddoors[1410] = true
    blockiddoors[848] = true
    blockiddoors[849] = true
    blockiddoors[1679] = true
    blockiddoors[1673] = true
    blockiddoors[1674] = true
    blockiddoors[1675] = true
    blockiddoors[1676] = true
    blockiddoors[1697] = true
    blockiddoors[1699] = true
    blockiddoors[1698] = true
    blockiddoors[1696] = true
    blockiddoors[1695] = true

    blockiddoors[1116] = true
    blockiddoors[1117] = true
    blockiddoors[1118] = true
    blockiddoors[1119] = true
    blockiddoors[1120] = true
    blockiddoors[1116] = true
    blockiddoors[1117] = true
    blockiddoors[1118] = true
    blockiddoors[1119] = true
    blockiddoors[1120] = true
    blockiddoors[1122] = true
    blockiddoors[1123] = true
    blockiddoors[1124] = true
    blockiddoors[1125] = true
    blockiddoors[1126] = true
    blockiddoors[1128] = true
    blockiddoors[1129] = true
    blockiddoors[1130] = true
    blockiddoors[1131] = true
    blockiddoors[1132] = true

    blockiddoors[662] = true
    blockiddoors[663] = true
    blockiddoors[986] = true
    blockiddoors[987] = true
    blockiddoors[1223] = true
    blockiddoors[1224] = true

end)



function DarkRP.IsCombineDoor()

	return blockiddoors

end

hook.Add("KeyPress", "DarkRP_door_opener", function(ply, key)
    if ply:IsCombine() or ply:Team() == TEAM_ADMIN or ply:Team() == TEAM_FSG or ply:Team() == TEAM_GMAN or ply:getDarkRPVar("job"):find("C82") then
        if key == IN_USE then
            local t = {}
            t.start = ply:GetPos()
            t.endpos = ply:GetShootPos() + ply:GetAimVector() * 100
            t.filter = ply
            local trace = util.TraceLine(t)
            if trace.Entity and trace.Entity:IsValid() and trace.Entity:GetClass() == "func_door" then
                if !DarkRP.IsCombineDoor()[trace.Entity:EntIndex()] then
                    trace.Entity:Fire("Open")
                end
            end
        end
    end
end)

local meta = FindMetaTable("Player")

function meta:UpdateJobName(new)
	local tbl = RPExtraTeams[new or self:Team()]
	local old_name = self:GetVar("OldName")
	if old_name then
		self:setDarkRPVar("rpname", old_name)
		self:SetVar("OldName", nil) 
	end
	if tbl.newname then
		self:SetVar("OldName", self:getDarkRPVar("rpname"))
		self:setDarkRPVar("rpname", tbl.newname)
	end
end

local pattern = "%s %s"

function meta:UpdateJobCode(new)
	local tbl = RPExtraTeams[new or self:Team()]
	if not self:IsMPF() and not self:IsOTA() and not self:IsGuardian() or tbl.nojobnamechange then return end
	local team_name = tbl.fakejobname or tbl.name
	local new_name = pattern:format(team_name, math.random(1000,9999)) --(tbl.fakejobname or tbl.name) .. " #" .. self:GetID()
	self:setDarkRPVar("job", new_name)
	DarkRP.notify(self, 2, 3, "Вам было присвоено кодовое имя " .. new_name)
end

hook.Add("OnPlayerChangedTeam", "changeNameForDaun", function(ply, old, new)
	ply:UpdateJobName(new)
	ply:UpdateJobCode(new)
end)

hook.Add('loadCustomDarkRPItems', 'NoFallDamageWait', function()
    local Team = FindMetaTable("Player").Team

    local blacklist = {
        [TEAM_FSG] = true,
        [TEAM_GUILD7] = true,
        [TEAM_OTA9] = true
    }
    
    function GM:GetFallDamage(ply, speed)
        if blacklist[Team(ply)] then
            return 0
        end
    
        return (speed / 8)
    end
end)