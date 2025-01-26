AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local nextcapture = -math.huge
local crate

local supplies = {

	config = {
		needplayers = 10,
		needcombine = 5,
		timecapture = 18
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
	boss = {
		[TEAM_BOSS] = true
	},
	bandits = {
		[TEAM_BANDIT] = true,
		[TEAM_BOSS] = true
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
		elseif supplies.bandits[job] then
			ply:ConCommand("stopsound")
			ply:addMoney(3000)

			playerscount = playerscount + 1
			players[playerscount] = ply
		end
	end

	RemoveMark(players, "SuppliesCapture")
	notify(players, 0, 4, "Захват припасов провалился!")
	notify(players, 0, 6, "Участники сторон захвата получают денежный бонус за активность")

end

local vec1323 = Vector(-1323, -2440, 0)
local ang0900 = Angle(0, -90, 0)
local function CaptureSuccess(ent)

	nextcapture = CurTime() + 900

	timer.Remove("SuppliesCapture")

	if IsValid(ent) then
		ent:SetCaptureStatus(0)
	end

	if IsValid(crate) then
		crate:SetCrateCharge(crate:GetCrateCharge() + 5)
	else
		crate = ents.Create("darkrp_crate_03")
		crate:SetPos(vec1323)
		crate:SetAngles(ang0900)
		crate:Spawn()
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
		elseif supplies.bandits[job] then
			ply:ConCommand("stopsound")
			ply:addMoney(15000)

			playerscount = playerscount + 1
			players[playerscount] = ply
		end
	end

	RemoveMark(players, "SuppliesCapture")
	notify(players, 0, 4, "Бандиты успешно захватили припасы!")
	notify(players, 0, 6, "Участники сторон захвата получают денежный бонус за активность")

end

function ENT:Initialize()

	self:SetModel("models/props_junk/wood_crate002a.mdl")

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

	if not supplies.boss[ply:Team()] then
		notify(ply, 0, 4, "Этим может воспользоваться только пахан")
		return
	end

	local curtime = CurTime()

	if nextcapture > curtime then
		notify(ply, 0, 4, "Вы можете воспользоваться этим через " .. math.ceil(nextcapture - curtime) .. " секунд")
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

			if v:IsPlayer() and v:Alive() and supplies.bandits[v:Team()] then
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
			v:ConCommand("play music/hl2_song20_submix0.mp3")

			playerscount = playerscount + 1
			players[playerscount] = v
		elseif supplies.bandits[job] then
			if v:GetPos():DistToSqr(pos) <= 1327104 then
				v:ConCommand("play music/hl2_song31.mp3")
				v:wanted(nil, "Ограбление склада ГСР", 300)
			end

			playerscount = playerscount + 1
			players[playerscount] = v
		end
	end

	CreateMark(players, 1, supplies.config.timecapture * 5, "Захват припасов", "SuppliesCapture", pos)
	notify(players, 0, 5, "Бандиты пытаются захватить припасы!")
	notify(ply, 0, 6, "Не отходите от припасов или захват будет провален!")

end