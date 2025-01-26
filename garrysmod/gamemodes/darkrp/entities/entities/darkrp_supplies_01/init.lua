AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local nextcapture = -math.huge
local crate1
local crate2

local supplies = {

	config = {
		needplayers = 15,
		needcombine = 5,
		timecapture = 24
	},
	combine = {
		[TEAM_MPF1] = true,
		[TEAM_MPF2] = true,
		[TEAM_MPF3] = true,
		[TEAM_MPF4] = true,
		[TEAM_MPF5] = true,
		[TEAM_MPF6] = true,
		[TEAM_MPF7] = true,
		[TEAM_MPF8] = true,
		[TEAM_MPF9] = true,
		[TEAM_MPF10] = true,
		[TEAM_MPF11] = true,
		[TEAM_MPF11] = true,
		[TEAM_MPF12] = true,
		[TEAM_MPF13] = true,
		[TEAM_MPF14] = true,
		[TEAM_MPF15] = true,
		[TEAM_MPF16] = true,
		[TEAM_OTA1] = true,
		[TEAM_OTA2] = true,
		[TEAM_OTA3] = true,
		[TEAM_OTA4] = true,
		[TEAM_OTA5] = true,
		[TEAM_OTA6] = true,
		[TEAM_OTA7] = true,
		[TEAM_OTA8] = true,
		[TEAM_OTA9] = true,
		[TEAM_OTA10] = true,
		[TEAM_GUARDIAN1] = true,
		[TEAM_GUARDIAN2] = true,
		[TEAM_GUARDIAN3] = true,
		[TEAM_GUARDIAN4] = true,
		[TEAM_GUARDIAN5] = true,
		[TEAM_GUARDIAN6] = true
	},
	resistance = {
		[TEAM_RESISTANCE4] = true,
		[TEAM_RESISTANCE5] = true,
		[TEAM_HECU4] = true,
		[TEAM_HECU5] = true
	}

}

local notify = DarkRP.notify -- ИЗМЕНЕНО 05.02.2022
local timer = timer
local function CaptureFail(ent)

	nextcapture = CurTime() + 900

	timer.Remove("SuppliesCapture")

	if IsValid(ent) then
		ent:SetCaptureStatus(0)
	end

	local players = {}
	local playerscount = 0

	for _, ply in pairs(player.GetAll()) do
		local job = ply:Team()

		if ply:IsMPF() then
			ply:ConCommand("stopsound")
			ply:addMoney(2000)

			playerscount = playerscount + 1
			players[playerscount] = ply
		elseif ply:IsOTA() then
			ply:ConCommand("stopsound")
			ply:addMoney(2500)

			playerscount = playerscount + 1
			players[playerscount] = ply
		elseif ply:IsResistance() then
			ply:ConCommand("stopsound")
			ply:addMoney(1000)

			playerscount = playerscount + 1
			players[playerscount] = ply
		end
	end

	RemoveMark(players, "SuppliesCapture")
	notify(players, 0, 4, "Захват припасов провалился!")
	notify(players, 0, 6, "Участники сторон захвата получают денежный бонус за активность")

end

local vec14715 = Vector(6515, -10240, -5)
local vec14658 = Vector(6389, -10197, 34)
local ang = Angle(0, 90, 0)
local function CaptureSuccess(ent)

	nextcapture = CurTime() + 900

	timer.Remove("SuppliesCapture")

	if IsValid(ent) then
		ent:SetCaptureStatus(0)
	end

	if IsValid(crate1) then
		crate1:SetCrateCharge(crate1:GetCrateCharge() + 5)
	else
		crate1 = ents.Create("darkrp_crate_01")
		crate1:SetPos(vec14715)
		crate1:SetAngles(-ang)
		crate1:Spawn()
	end

	if IsValid(crate2) then
		crate2:SetCrateCharge(crate2:GetCrateCharge() + 5)
	else
		crate2 = ents.Create("darkrp_crate_02")
		crate2:SetPos(vec14658)
		crate2:SetAngles(ang)
		crate2:Spawn()
	end

	local players = {}
	local playerscount = 0

	for _, ply in pairs(player.GetAll()) do
		local job = ply:Team()

		if ply:IsMPF() then
			ply:ConCommand("stopsound")
			ply:addMoney(1000)

			playerscount = playerscount + 1
			players[playerscount] = ply
		elseif ply:IsOTA() then
			ply:ConCommand("stopsound")
			ply:addMoney(1500)

			playerscount = playerscount + 1
			players[playerscount] = ply
		elseif ply:IsResistance() then
			ply:ConCommand("stopsound")
			ply:addMoney(2000)

			playerscount = playerscount + 1
			players[playerscount] = ply
		end
	end

	RemoveMark(players, "SuppliesCapture")
	notify(players, 0, 4, "Сопротивление успешно захватило припасы!")
	notify(players, 0, 6, "Участники сторон захвата получают денежный бонус за активность")

end

function ENT:Initialize()

	self:SetModel("models/props_misc/standing_tarp_short.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()

	if IsValid(phys) then
		phys:Wake()
		phys:EnableMotion(false)
	end

	self.NextUse = 0

end

local ceil = math.ceil
function ENT:Use(ply)

	if self.NextUse > CurTime() then return end

	if not supplies.resistance[ply:Team()] then
		notify(ply, 0, 4, "Этим могут воспользоваться только командиры Сопротивления")
		return
	end

	local curtime = CurTime()

	if nextcapture > curtime then
		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. ceil(nextcapture - curtime) .. " секунд")
		return
	end

	if timer.Exists("SuppliesCapture") then
		notify(ply, 0, 4, "В данный момент уже где-то идёт захват")
		return
	end

	self.NextUse = curtime + 2.2

	local totalplayers = player.GetCount()

	if totalplayers < supplies.config.needplayers then
		notify(ply, 0, 3, "Игроков недостаточно (" .. totalplayers .. "/" .. supplies.config.needplayers .. ")")
		return
	end

	local allplayers = player.GetAll()
	local fighters = 0

	for _, v in pairs(allplayers) do
		if supplies.combine[v:Team()] then
			fighters = fighters + 1
		end
	end

	if fighters < supplies.config.needcombine then
		notify(ply, 0, 3, "Альянса недостаточно (" .. fighters .. "/" .. supplies.config.needcombine .. ")")
		notify(ply, 0, 4, "Считаются все, начиная c RCT")
		return
	end

	self:SetCaptureStatus(1)

	local pos = self:GetPos()

	timer.Create("SuppliesCapture", 5, supplies.config.timecapture + 1, function()
		if not IsValid(self) then
			CaptureFail()
			return
		end

		local capture = false

		for _, v in pairs(ents.FindInSphere(pos, 256)) do
			if capture then break end

			if v:IsPlayer() and v:Alive() and v:IsResistance() then
				capture = true
			end
		end

		if not capture then
			CaptureFail(self)
			return
		end

		self:SetCaptureStatus(self:GetCaptureStatus() + 1)

		if self:GetCaptureStatus() >= supplies.config.timecapture then
			CaptureSuccess(self)
		end
	end)

	local players = {}
	local playerscount = 0

	for _, v in pairs(allplayers) do
		local job = v:Team()

		if v:IsMPF() then
			v:ConCommand("play music/hl2_song14.mp3")

			playerscount = playerscount + 1
			players[playerscount] = v
		elseif v:IsOTA() then
			v:ConCommand("play music/hl2_song12_long.mp3")

			playerscount = playerscount + 1
			players[playerscount] = v
		elseif v:IsResistance() then
			v:ConCommand("play music/hl2_song16.mp3")

			playerscount = playerscount + 1
			players[playerscount] = v
		end
	end

	CreateMark(players, 1, supplies.config.timecapture * 5, "Захват припасов", "SuppliesCapture", pos)
	notify(players, 0, 5, "Сопротивление пытается захватить припасы!")
	notify(ply, 0, 6, "Не отходите от припасов или захват будет провален!")

end