local plymeta = FindMetaTable("Player")

--[[------------------------------------------------------------

	Usergroups

------------------------------------------------------------]]--
local staff = {

	["operator"] = true,
	["moderator"] = true,
    ["eventer"] = true,
	["admin"] = true,
	["curator"] = true,
	["manager"] = true,
	["supervisor"] = true,
	["superadmin"] = true

}

local modadm = {
    
    ["moderator"] = true,
    ["admin"] = true,
    
}

local oper = {
    
    ["operator"] = true,
    
}

local cur = {
    
    ["curator"] = true,
    
}

local event = {
    
    ["eventer"] = true,
    
}

local eventer = {

	["admin"] = true,
	["curator"] = true,
	["manager"] = true,
	["supervisor"] = true,
	["superadmin"] = true

}

local manager = {

	["manager"] = true,

}

local supervisor = {

	["supervisor"] = true,
	["superadmin"] = true

}

local silver = {

	["silver"] = true,
	["gold"] = true,
	["platinum"] = true,
	["operator"] = true,
	["moderator"] = true,
	["admin"] = true,
	["curator"] = true,
	["manager"] = true,
	["supervisor"] = true,
	["superadmin"] = true

}

local gold = {

	["gold"] = true,
	["platinum"] = true,
	["admin"] = true,
	["curator"] = true,
	["manager"] = true,
	["supervisor"] = true,
	["superadmin"] = true

}

local platinum = {

	["platinum"] = true,
	["curator"] = true,
	["manager"] = true,
	["supervisor"] = true,
	["superadmin"] = true

}

function plymeta:Staff()

	return staff[self:GetUserGroup()]

end

function plymeta:IsModAdm()

    return modadm[self:GetUserGroup()]

end

function plymeta:IsEvent()

    return event[self:GetUserGroup()]

end 

function plymeta:IsOper()

    return oper[self:GetUserGroup()]

end 

function plymeta:IsCur()

    return cur[self:GetUserGroup()]

end

function plymeta:IsManager()

    return manager[self:GetUserGroup()]

end 

function plymeta:IsEventer()

	return eventer[self:GetUserGroup()]

end

function plymeta:IsSupervisor()

	return supervisor[self:GetUserGroup()]

end

function plymeta:Donator(usergroup)

	if usergroup == "silver" then
		return silver[self:GetUserGroup()]
	elseif usergroup == "gold" then
		return gold[self:GetUserGroup()]
	elseif usergroup == "platinum" then
		return platinum[self:GetUserGroup()]
	end

end

function plymeta:IsAdmin()

	return supervisor[self:GetUserGroup()]

end

--[[------------------------------------------------------------

	Jobs

------------------------------------------------------------]]--
local combine
local mpf
local mpfcmd
local ota
local resistance
local cwu
local bandits
local guild
local guardian
local synth

function plymeta:IsCombine()

	return combine[self:Team()]

end

function plymeta:IsMPF()

	return mpf[self:Team()]

end

function plymeta:IsMPFCMD()

	return mpfcmd[self:Team()]

end

function plymeta:IsOTA()

	return ota[self:Team()]

end

function plymeta:IsSynth()

	return synth[self:Team()]

end

function plymeta:IsCitizen()

	return citizen[self:Team()]

end


function plymeta:IsAdministrator()

	return admin[self:Team()]

end

function plymeta:CanYellowCode()

	return canyellowcode[self:Team()]

end

function plymeta:CanRedCode()

	return canredcode[self:Team()]

end

function plymeta:IsResistance()

	return resistance[self:Team()]

end

function plymeta:IsCWU()

	return cwu[self:Team()]

end

function plymeta:IsBandits()

	return bandits[self:Team()]

end

function plymeta:IsGuild()

	return guild[self:Team()]

end

function plymeta:IsGuardian()

	return guardian[self:Team()]

end

function plymeta:IsSynth()

	return synth[self:Team()]

end

function plymeta:IsFemale()

	return (string.find(string.lower( self:GetModel() ), "female" ))
	
end

hook.Add("DarkRPFinishedLoading", "DarkRP_AssetJobs", function()

	combine = {}
	combine[TEAM_MPF1] = true
	combine[TEAM_MPF2] = true
	combine[TEAM_MPF3] = true
	combine[TEAM_MPF4] = true
	combine[TEAM_MPF5] = true
	combine[TEAM_MPF6] = true
	combine[TEAM_MPF7] = true
	combine[TEAM_MPF8] = true
	combine[TEAM_MPF9] = true
	combine[TEAM_MPF10] = true
	combine[TEAM_MPF11] = true
	combine[TEAM_MPF12] = true
	combine[TEAM_MPF13] = true
	combine[TEAM_MPF14] = true
	combine[TEAM_MPF15] = true
	combine[TEAM_MPF16] = true
	combine[TEAM_ITZTOMBER] = true
	combine[TEAM_OTA1] = true
	combine[TEAM_OTA2] = true
	combine[TEAM_OTA3] = true
	combine[TEAM_OTA4] = true
	combine[TEAM_OTA5] = true
	combine[TEAM_OTA6] = true
	combine[TEAM_OTA7] = true
	combine[TEAM_OTA8] = true
	combine[TEAM_OTA9] = true
	combine[TEAM_OTA10] = true
	combine[TEAM_GUARDIAN1] = true
	combine[TEAM_GUARDIAN2] = true
	combine[TEAM_GUARDIAN3] = true
	combine[TEAM_GUARDIAN4] = true
	combine[TEAM_GUARDIAN5] = true
	combine[TEAM_GUARDIAN6] = true
	combine[TEAM_SYNTH1] = true

	mpf = {}
	mpf[TEAM_MPF1] = true
	mpf[TEAM_MPF2] = true
	mpf[TEAM_MPF3] = true
	mpf[TEAM_MPF4] = true
	mpf[TEAM_MPF5] = true
	mpf[TEAM_MPF6] = true
	mpf[TEAM_MPF7] = true
	mpf[TEAM_MPF8] = true
	mpf[TEAM_MPF9] = true
	mpf[TEAM_MPF10] = true
	mpf[TEAM_MPF11] = true
	mpf[TEAM_MPF12] = true
	mpf[TEAM_MPF13] = true
	mpf[TEAM_MPF14] = true
	mpf[TEAM_MPF15] = true
	mpf[TEAM_MPF16] = true
	mpf[TEAM_ITZTOMBER] = true

	mpfcmd = {}
	mpfcmd[TEAM_MPF13] = true
	mpfcmd[TEAM_MPF14] = true
	mpfcmd[TEAM_MPF15] = true
	mpfcmd[TEAM_MPF16] = true

	ota = {}
	ota[TEAM_OTA1] = true
	ota[TEAM_OTA2] = true
	ota[TEAM_OTA3] = true
	ota[TEAM_OTA4] = true
	ota[TEAM_OTA5] = true
	ota[TEAM_OTA6] = true
	ota[TEAM_OTA7] = true
	ota[TEAM_OTA8] = true
	ota[TEAM_OTA9] = true
	ota[TEAM_OTA10] = true

	synth = {}
	synth[TEAM_SYNTH1] = true

	citizen = {}
	citizen[TEAM_CITIZEN] = true
	citizen[TEAM_LOYALIST1] = true
	citizen[TEAM_LOYALIST2] = true
	citizen[TEAM_LOYALIST3] = true
	citizen[TEAM_GMAN] = true

	admin = {}
	admin[TEAM_ADMIN] = true

	canyellowcode = {}
	canyellowcode[TEAM_MPF14] = true

	canredcode = {}
	canredcode[TEAM_MPF15] = true
	canredcode[TEAM_OTA6] = true

	resistance = {}
	resistance[TEAM_RESISTANCE1] = true
	resistance[TEAM_RESISTANCE2] = true
	resistance[TEAM_RESISTANCE3] = true
	resistance[TEAM_RESISTANCE4] = true
	resistance[TEAM_RESISTANCE5] = true
	resistance[TEAM_RESISTANCE6] = true
	resistance[TEAM_RESISTANCE7] = true
	resistance[TEAM_RESISTANCE8] = true
	resistance[TEAM_RESISTANCE9] = true
	resistance[TEAM_HECU1] = true
	resistance[TEAM_HECU2] = true
	resistance[TEAM_DONATE23] = true
	resistance[TEAM_HECU3] = true
	resistance[TEAM_HECU4] = true
	resistance[TEAM_HECU5] = true
	resistance[TEAM_HECU6] = true
	resistance[TEAM_DONATE22] = true
	resistance[TEAM_HECU7] = true

	cwu = {}
	cwu[TEAM_CWU1] = true
	cwu[TEAM_CWU2] = true
	cwu[TEAM_CWU3] = true
	cwu[TEAM_CWU4] = true
	cwu[TEAM_CWU5] = true
	cwu[TEAM_CWU6] = true
	cwu[TEAM_CWU7] = true

	bandits = {}
	bandits[TEAM_BANDIT] = true
	bandits[TEAM_BOSS] = true
	bandits[TEAM_SMUGGLER] = true
	bandits[TEAM_BURGLAR] = true

	guild = {}
	guild[TEAM_GUILD1] = true
	guild[TEAM_GUILD2] = true
	guild[TEAM_GUILD3] = true
	guild[TEAM_GUILD4] = true
	guild[TEAM_GUILD5] = true
	guild[TEAM_GUILD6] = true
	guild[TEAM_GUILD7] = true
	guild[TEAM_GUILD8] = true
	guild[TEAM_GUILD9] = true
	guild[TEAM_GUILD10] = true
	guild[TEAM_GUILD11] = true
	guild[TEAM_DOD1] = true
	guild[TEAM_DOD2] = true
	guild[TEAM_DOD3] = true
	guild[TEAM_DOD4] = true
	guild[TEAM_DOD5] = true
	guild[TEAM_DOD6] = true

	guardian = {}
	guardian[TEAM_GUARDIAN1] = true
	guardian[TEAM_GUARDIAN2] = true
	guardian[TEAM_GUARDIAN3] = true
	guardian[TEAM_GUARDIAN4] = true
	guardian[TEAM_GUARDIAN5] = true
	guardian[TEAM_GUARDIAN6] = true

end)

--[[------------------------------------------------------------

	Usergroups

------------------------------------------------------------]]--
hook.Add("InitPostEntity", "retrimeUsergroups", function(ply)
	function plymeta:IsAdmin()
		return self:GetUserGroup() == "superadmin"
	end

	function plymeta:IsSuperAdmin()
		return self:GetUserGroup() == "superadmin"
	end
end)

--[[------------------------------------------------------------

	Assets

------------------------------------------------------------]]--
local disguiselist

function plymeta:GetDisguiseVar(var)

	local disguise = self:getDarkRPVar("disguise")
	local disguisevar = false

	if disguise then
		disguiselist = DisguiseList or DarkRP.GetDisguiseList()
		disguisevar = disguiselist[disguise][var] or false
	end

	return disguisevar

end

hook.Add("PlayerChangedTeam", "AdministratorGoroda", function(ply, oldTeam, newTeam)
	if newTeam == TEAM_ADMIN then
		ply.isMayor = true
	end
	if oldTeam == TEAM_ADMIN then
		ply.isMayor = false
	end
end)