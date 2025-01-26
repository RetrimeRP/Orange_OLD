AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


function ENT:Initialize()
	self:SetModel( self.WorldModel )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	local phys = self:GetPhysicsObject()
	phys:Wake()
end

local redcode = "terminal_redcode"
local yellowcode = "terminal_yellowcode"
local workingphase = "terminal_workingphase"
local demote = "terminal_demote"
local sounder = "terminal_sound"
local netammo = "terminalCP_ammo"
local nethp = "terminalCP_health"

util.AddNetworkString("OpenTerminal")
util.AddNetworkString("sounds")
util.AddNetworkString("terminal_pay")
util.AddNetworkString(redcode)
util.AddNetworkString(yellowcode)
util.AddNetworkString("PlayerDisplay")
util.AddNetworkString(workingphase)
util.AddNetworkString(demote)
util.AddNetworkString(sounder)
util.AddNetworkString(netammo)
util.AddNetworkString(nethp)

function ClearCodes()
	if GetGlobalBool('redcode') then SetGlobalBool("redcode", false)  end
	if GetGlobalBool('yellowcode') then SetGlobalBool("yellowcode", false)  end
	if GetGlobalBool('workingphase') then SetGlobalBool("workingphase", false)  end

	for k, v in pairs(player.GetAll()) do
		v:ConCommand('stopsound')
		net.Start("redcodestop")
				net.Send(v)
	end
end

function AdminClearCodes()
	if GetGlobalBool('redcode') then SetGlobalBool("redcode", false)  end
	if GetGlobalBool('yellowcode') then SetGlobalBool("yellowcode", false)  end
	if GetGlobalBool('workingphase') then SetGlobalBool("workingphase", false)  end
	SetGlobalInt('CodeAbuse', 0)

	for k, v in pairs(player.GetAll()) do
		v:ConCommand('stopsound')
		net.Start("redcodestop")
		net.Send(v)
	end
end

function RedCode()
	AdminClearCodes()

	SetGlobalBool("redcode", true)
	timer.Simple(0.1, function()
		SoundToCl("disp/redcode.ogg")
	end)
	for k, v in pairs(player.GetAll()) do
		net.Start("redcodestarted")
		net.Send(v)
	end
end

function YellowCode()
	AdminClearCodes()
	
	SetGlobalBool("yellowcode", true)
	timer.Simple(0.1, function()
		SoundToCl("disp/yellowcode.ogg")
	end)
end

function WorkingPhase()
	AdminClearCodes()
	
	SetGlobalBool("workingphase", true)
	timer.Simple(0.1, function()
		SoundToCl("disp/rabochayafasa.ogg")
	end)
end


function SoundToCl(snd)
	for k, v in pairs(player.GetAll()) do
		net.Start("sounds")
			net.WriteString(snd)
		net.Send(v)
	end
end	

function ENT:AcceptInput( Name, Activator, Caller )
	if Name == "Use" and Caller:IsPlayer() then
		 if !Caller:isCP() then 
		 	DarkRP.notify(Caller, 1, 2, "Доступно только для сотрудников ГО!") return end
			umsg.Start("OpenTerminal", Caller)
			umsg.End()
	end
end

local cmdredcode = {
	[TEAM_MPF16] = true,
	[TEAM_MPF15] = true,
}

local cmdyellowcode = {
	[TEAM_MPF15] = true,
	[TEAM_MPF16] = true,
}
local function Demote(ply, who, reason)
	if !cmdyellowcode[ply:Team()] then ply:ChatPrint("Вы не можете увольнять!") return end
	if who == ply then ply:ChatPrint("Вы не можете уволить себя!") return end
	if !who:isCP() then return end

	who:teamBan()
    who:changeTeam(GAMEMODE.DefaultTeam, true)

	DarkRP.notify( ply, NOTIFY_HINT, 4, "Вы уволили"..who:Name() .. " " .. ply:getDarkRPVar("fakerpname") ..  " По причине: " .. reason )
	DarkRP.notify( who, NOTIFY_HINT, 4, "По причине: " .. reason )
	DarkRP.notify( who, NOTIFY_HINT, 4, "Вас уволил ".. ply:Name() .. " " .. ply:getDarkRPVar("fakerpname") .. "!" )

end
-----------

net.Receive(nethp, function()
	local pl = net.ReadEntity()
		pl:SetHealth(pl:GetMaxHealth())
end)

net.Receive(netammo, function()
	local pl = net.ReadEntity()
	if pl:canAfford(0) then
		pl:GiveAmmo( 24, "Pistol", true )
		pl:GiveAmmo( 12, "Buckshot", true )
		pl:GiveAmmo( 60, "smg1", true )
		pl:GiveAmmo( 60, "ar2", true )
		pl:GiveAmmo( 12, "357", true )
		pl:GiveAmmo( 10, "SniperPenetratedRound", true )
		pl:GiveAmmo( 100, "bp_flame", true )
	end
end)

-----------------------
net.Receive(redcode, function(len, ply)
	if !cmdredcode[ply:Team()] then ply:ChatPrint("Вы не можете объявить красный код!") return end
	if !GetGlobalBool("yellowcode") and !GetGlobalBool("workingphase") then
		if !GetGlobalBool("redcode") then
			if GetGlobalInt('CodeAbuse') > CurTime() then
				ply:SendLua([[chat.AddText(Color(255,255,255), "Подождите ещё " .. math.Round(GetGlobalInt('CodeAbuse') - CurTime()) .. " секунд!")]])
				return
			end

			SetGlobalBool("redcode", true)
			RunConsoleCommand("say", "[ДИСПЕТЧЕР]: Вниманию всех наземных сил: судебное разбирательство отменено. Смертная казнь - по усмотрению.")
			--
			SoundToCl("retrime/cityvoice/f_protectionresponse_5_spkr.wav")
			--
			timer.Simple(SoundDuration("retrime/cityvoice/f_protectionresponse_5_spkr.wav"), function()
			SoundToCl("code/redcode.wav")
			end)
			--
				for k, v in pairs(player.GetAll()) do
					net.Start("redcodestarted")
					net.Send(v)
				end
			SetGlobalInt('CodeAbuse', CurTime() + 200)
		else
			SetGlobalBool("redcode", false)
			for k, v in pairs(player.GetAll()) do
				net.Start("redcodestop")
				net.Send(v)
			end
		end
	end
end)

net.Receive(yellowcode, function(len, ply)
	if !cmdyellowcode[ply:Team()] then ply:ChatPrint("Вы не можете объявить жёлтый код!") return end
	if !GetGlobalBool("redcode") and !GetGlobalBool("workingphase") then
		if !GetGlobalBool("yellowcode") then
			if GetGlobalInt('CodeAbuse') > CurTime() then
				ply:SendLua([[chat.AddText(Color(255,255,255), "Подождите ещё " .. math.Round(GetGlobalInt('CodeAbuse') - CurTime()) .. " секунд!")]])
				return
			end
			SetGlobalBool("yellowcode", true)
			RunConsoleCommand("say", "[ДИСПЕТЧЕР]: Граждане, введен код действия при беспорядках. Код: обезвредить, защитить, усмирить. Код: подавить, меч, стерилизовать")
			--
			SoundToCl("retrime/cityvoice/f_unrestprocedure1_spkr.wav")
			--
			timer.Simple(SoundDuration("retrime/cityvoice/f_unrestprocedure1_spkr.wav"), function()
			SoundToCl("ambient/alarms/citadel_alert_loop2.wav")
			end)
			--
			SetGlobalInt('CodeAbuse', CurTime() + 150)
		else
			ClearCodes()
		end
	end
end)

net.Receive(workingphase, function(len, ply)
	if !cmdyellowcode[ply:Team()]  then ply:ChatPrint("Вы не можете объявить рабочую фазу!") return end
	if !GetGlobalBool("redcode") and !GetGlobalBool("yellowcode") then
		if !GetGlobalBool("workingphase") then
			if GetGlobalInt('CodeAbuse') > CurTime() then
				ply:SendLua([[chat.AddText(Color(255,255,255), "Подождите ещё " .. math.Round(GetGlobalInt('CodeAbuse') - CurTime()) .. " секунд!")]])
				return
			end
			SetGlobalBool("workingphase", true)
			RunConsoleCommand('say', '[ДИСПЕТЧЕР]: Вниманию гражданам! Производится проверка идентификации. Занять назначенные для инспекции места.')
			SoundToCl("retrime/cityvoice/f_trainstation_assemble_spkr.wav")
			SetGlobalInt('CodeAbuse', CurTime() + 100)
		else
			ClearCodes()
		end
	end
end)

net.Receive(demote, function(len, ply)
	if !IsValid(ply) then return end
	who = net.ReadEntity()
	reason = net.ReadString()

	Demote(ply, who, reason)
end)

local list = {
	[1] = {text = "Гражданин, вы обвиняетесь в тяжком несоответствии. Асоциальный статус подтвержден.", soundik = "npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav"},
	[2] = {text = "Вниманию жителей! Ваш квартал обвиняется в недоносительстве. Штраф - пять пищевых единиц.", soundik = "npc/overwatch/cityvoice/f_rationunitsdeduct_3_spkr.wav"},
	[3] = {text = "Вниманию всех наземных сил: судебное разбирательство отменено. Смертная казнь - по усмотрению", soundik = "npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav"},
	[4] = {text = "Отказ от сотрудничества - выселение в нежилое пространство", soundik = "npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav"},
	[5] = {text = "Гражданин, Вы угроза обществу первого уровня. Подразделениям ГО, код пресечения: долг, меч, полночь.", soundik = "npc/overwatch/cityvoice/f_anticivil1_5_spkr.wav"},
	[6] = {text = "Граждане, введен код действия при беспорядках. Код: обезвредить, защитить, усмирить. Код: подавить, меч, стерилизовать.", soundik = "npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav"},
	[7] = {text = "Граждане: бездействие преступно. О противоправном поведении немедленно доложить силам ГО.", soundik = "npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav"},
	[8] = {text = "Вниманию наземного отряда ГО, задействовано осуждение на месте. Приговор выносить по усмотрению. Код: отсечь, обнулить, подтвердить.", soundik = "npc/overwatch/cityvoice/f_protectionresponse_4_spkr.wav"},
	[9] = {text = "Гражданин, Вы угроза обществу первого уровня. Подразделениям ГО, код пресечения: долг, меч, полночь.", soundik = "npc/overwatch/cityvoice/f_sociolevel1_4_spkr.wav"},
	[10] = {text = "Гражданин, теперь Вы угроза обществу пятого уровня. Немедленно прекратить уклонение и выслушать приговор.", soundik = "npc/overwatch/cityvoice/f_ceaseevasionlevelfive_spkr.wav"},
	[11] = {text = "Гражданин, вы обвиняетесь во множественных нарушениях. Гражданство отозвано. Статус: злостный нарушитель.", soundik = "npc/overwatch/cityvoice/f_citizenshiprevoked_6_spkr.wav"},
	[12] = {text = "Вниманию наземного отряда ГО, задействовано осуждение на месте. Приговор выносить по усмотрению. Код: отсечь, обнулить, подтвердить.", soundik = "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav"},
	[13] = {text = "Внимание! Уклонистское поведение. Неподчинение обвиняемого. Наземным силам ГО, тревога! Код: изолировать, огласить, исполнить.", soundik = "npc/overwatch/cityvoice/f_evasionbehavior_2_spkr.wav"},
	[14] = {text = "Тревога! Подразделениям гражданской обороны, обнаружены локальные беспорядки. Собрать, исполнить, усмирить.", soundik = "npc/overwatch/cityvoice/f_localunrest_spkr.wav"},
	[15] = {text = "Внимание! Неопознанное лицо. Немедленно подтвердить статус в отделе гражданской обороны.", soundik = "npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav"},
	[16] = {text = "Вниманию наземных сил! В сообществе найден нарушитель. Код: окружить, клеймить, усмирить.", soundik = "npc/overwatch/cityvoice/f_anticitizenreport_spkr.wav"},
	[17] = {text = "Внимание! В квартале потенциальный источник вреда обществу. Донести, содействовать, собрать.", soundik = "npc/overwatch/cityvoice/f_trainstation_inform_spkr.wav"},
	[18] = {text = "Вниманию отряда гражданской обороны, обнаружено уклонение от надзора. Отреагировать, изолировать, допросить.", soundik = "npc/overwatch/cityvoice/f_protectionresponse_1_spkr.wav"},
	[19] = {text = "Сотрудничество с отрядом ГО награждается полным пищ.рационом.", soundik = "npc/overwatch/cityvoice/f_trainstation_cooperation_spkr.wav"},
	[20] = {text = "Вниманию гражданам! Производится проверка идентификации. Занять назначенные для инспекции места.", soundik = "npc/overwatch/cityvoice/f_trainstation_assemble_spkr.wav"},
	[21] = {text = "Внимание! Всем гражданам жилого квартала, занять места для инспекции.", soundik = "npc/overwatch/cityvoice/f_trainstation_assumepositions_spkr.wav"},
	[22] = {text = "Директива номер два: задействовать резерв. Сдерживать вторжение извне.", soundik = "npc/overwatch/cityvoice/fprison_containexogens.wav"},
	[23] = {text = "Внимание, отключены системы наблюдения и обнаружения. Оставшимся сотрудникам охраны доложить о вторжении.", soundik = "npc/overwatch/cityvoice/fprison_detectionsystemsout.wav"},
	[24] = {text = "Внимание наземным силам: провал миссии влечёт выселение в нежилое пространство. Напоминаю код: пожертвовать, остановить, устранить.", soundik = "npc/overwatch/cityvoice/fprison_missionfailurereminder.wav"},
	[25] = {text = "Тревога: обнаружено аномальная внешняя активность. Следовать процедуре сдерживания и докладывать.", soundik = "npc/overwatch/cityvoice/fprison_nonstandardexogen.wav"},
	[26] = {text = "Особое внимание: отключены ограничители периметра. Всем сотрудникам охраны, немедленно принять участие в сдерживании.", soundik = "npc/overwatch/cityvoice/fprison_restrictorsdisengaged.wav"},
}

function SendMessageAll(...)
        local args = { Color(250,250,250), "[", Color(255,165,0), "Retrime", Color(250,250,250), "] ", ...}
        net.Start("PlayerDisplay")
        net.WriteTable(args)
        net.Broadcast()
end

local function gromkogovor(ply, whatis, i, k)

	if whatis == k.text then
		if GetGlobalInt('CAbuse') > CurTime() then ply:SendLua([[chat.AddText(Color(255,255,255), "Подождите ещё " .. math.Round(GetGlobalInt('CAbuse') - CurTime()) .. " секунд!")]]) return end
		SendMessageAll("Громкоговорители City 82: "..k.text)
		SoundToCl(k.soundik)
		SetGlobalInt('CAbuse', CurTime() + 30)
	end
end

net.Receive(sounder, function(_, ply)
	if !IsValid(ply) then return end
	if !cmdyellowcode[ply:Team()] then ply:ChatPrint("Вы не можете делать оповещения!") return end
	message = net.ReadString()

	if GetGlobalInt('CAbuse') > CurTime() then ply:SendLua([[chat.AddText(Color(255,255,255), "Подождите ещё " .. math.Round(GetGlobalInt('CAbuse') - CurTime()) .. " секунд!")]]) return end
	for i, k in pairs(list) do
		gromkogovor(ply, message, i, k)
	end
end)


util.AddNetworkString("Spectate")

local meta = FindMetaTable("Player")
function meta:CopyPlayerStats(tbl)
	tbl = tbl or {}
	if not istable(tbl) then
		return
	end
	tbl.weapon = {}
	tbl.ammo = {}

	for k, v in ipairs(self:GetWeapons()) do
		tbl.weapon[k] = {class = v:GetClass()}
		if v.given then
			tbl.weapon[k].given = true
		end
		tbl.ammo[v:GetPrimaryAmmoType()] = self:GetAmmoCount(v:GetPrimaryAmmoType())
	end

	tbl.stats = {
		model = self:GetModel(),
		health = self:Health(),
		armor = self:Armor(),
		job = self:Team(),
	}

	return tbl
end

function meta:ResetPlayerStats(tbl)
	if not istable(tbl) then
		return
	end

	local st = tbl.stats
	if not istable(st) then
		return
	end

	if st.job ~= self:Team() then
		table.Empty(tbl)
		return
	end

	self:SetModel(st.model)
	self:SetHealth(st.health)
	self:SetArmor(st.armor)

	for _, v in ipairs(tbl.weapon) do
		local entity = self:Give(v.class)
		if v.given then
			entity.given = true
		end
	end

	for k, v in ipairs(tbl.ammo) do
		self:SetAmmo(v, k)
	end
	table.Empty(tbl)
end

hook.Add("PlayerLoadout","unSpectateReset",function(ply)
		-- if not ply:getJobTable().canspectate then
		-- 	return
		-- end
		timer.Simple(
			0,
			function()
				if ply.unSpectateTbl then
					if ply.oldsPos then
						local pos, ang = ply.oldsPos[1], ply.oldsPos[2]
						ply:SetPos(pos)
						ply:SetEyeAngles(ang)
					end
					ply:ResetPlayerStats(ply.unSpectateTbl)
					ply.unSpectateTbl = nil
					ply.oldsPos = nil
				end
			end
		)
	end
)

local function declineSpectate(ply)
	ply:SpectateEntity(NULL)
	ply:UnSpectate()
	ply:Spawn()
end
local function stopSpectate(ply, key)
	local spec = ply.isSpectating
	if spec and spec ~= ply then
		if key and (key ~= IN_FORWARD and key ~= IN_BACK and key ~= IN_MOVELEFT and key ~= IN_MOVERIGHT) then
			return
		end

		if not ply:Alive() then
			ply.unSpectateTbl = nil
		else
			declineSpectate(ply)
		end

		local target = IsValid(ply.isSpectating) and ply.isSpectating
		if target then
			target.wasSpectated = nil
		end
		ply.isSpectating = nil
	end

	if key then return end
	local spectator = ply.wasSpectated
	if IsValid(spectator) then
		if spectator.isSpectating then
			declineSpectate(spectator)
			DarkRP.notify(spectator, 1, 4, "Потеряна связь с целью наблюдения.")
		end
		spectator.isSpectating = nil
		ply.wasSpectated = nil
	end
end

hook.Add("KeyPress", "_unSpectateKeyPress", stopSpectate)
hook.Add("PostPlayerDeath", "_unSpectateDeath", stopSpectate)
hook.Add("PlayerDisconnected", "_unSpectateDisconnect", stopSpectate)
hook.Add("OnPlayerChangedTeam", "_unSpectateChangedTeam", stopSpectate)
hook.Add("PlayerMaskOff", "_unSpectateMask", stopSpectate)

util.AddNetworkString("Spectate")
net.Receive("Spectate", function(_, ply)
	-- if not ply:getJobTable().canspectate then
	-- 	return
	-- end
	local target_ply = net.ReadEntity()
	if !cmdredcode[ply:Team()] then ply:ChatPrint("Вы не можете наблюдать!") return end
	if target_ply == ply  then DarkRP.notify(ply, 1, 4, "Вы не можете наблюдать за собой") return end
	if not target_ply or not IsValid(target_ply) or not target_ply:IsPlayer() then
		return
	end
--	if not target_ply:maskcon=0 and target_ply:isOTA() then
	--	DarkRP.notify(ply, 1, 4, "Маска юнита не надета")
	--	return
--	end
	if not target_ply:Alive() then
		DarkRP.notify(ply, 1, 4, "Юнит мертв.")
		return
	end
	if not ply.unSpectateTbl then
		ply.unSpectateTbl = ply:CopyPlayerStats()
		ply.oldsPos = {ply:GetPos(), ply:EyeAngles()}
	end

	ply:Spectate(OBS_MODE_CHASE)
	-- ply:SetObserverMode( OBS_MODE_CHASE )
	ply:SpectateEntity(target_ply)
	ply:SetCollisionGroup(COLLISION_GROUP_WORLD)
	ply:SetAvoidPlayers(false)
	-- net.Start("FSpectate")
    --     net.WriteBool(target == nil)
    --     if IsValid(ply.FSpectatingEnt) then
    --         net.WriteEntity(ply.FSpectatingEnt)
    --     end
    -- net.Send(ply)


	ply:ExitVehicle()
	ply:StripWeapons()
	ply:StripAmmo()
	ply.isSpectating = target_ply
	target_ply.wasSpectated = ply
	hook.Call("FSpectate_start", nil, ply, target_ply)
end)

local function Pay(ply, who, money)
	if !cmdredcode[ply:Team()] then ply:ChatPrint("Вы не можете выдавать премии!") return end
	if who == ply then ply:ChatPrint("Вы не можете выдавать пермию себе!") return end
    if !who:isCP() then return end
    if who:GetNWInt('PayCPAbuse') > CurTime() then
        ply:SendLua([[chat.AddText(Color(255,255,255), "Подождите ещё " .. math.Round(who:GetNWInt('PayCPAbuse') - CurTime()) .. " секунд!")]])
        return
    end

    if money > 10000 then ply:ChatPrint("Вы не можете выдавать пермию больше чем 10 тысяч!") return end
    if money < 100 then ply:ChatPrint("Вы не можете выдавать пермию меньше чем 100 токенов!") return end
    who:addMoney(money)
    who:SetNWInt('PayCPAbuse', CurTime() + 900)

	DarkRP.notify( ply, NOTIFY_HINT, 4, "Вы выдали премию "..who:Name() .. " В размере: " .. money )
	DarkRP.notify( who, NOTIFY_HINT, 4, "Вам выдал премию ".. ply:Name() .. " В размере: " .. money )

end

net.Receive("terminal_pay", function(len, ply)
    if !IsValid(ply) then return end
	who = net.ReadEntity()
	money = net.ReadInt(16)

    Pay(ply, who, money)

end)
