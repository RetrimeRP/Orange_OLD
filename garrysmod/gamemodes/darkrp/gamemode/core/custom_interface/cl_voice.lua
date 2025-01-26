local pnl

local c255255255 = Color(255, 255, 255)
local c150150150 = Color(150, 150, 150)
local c25510251 = Color(255, 102, 51)
local c303030 = Color(30, 30, 30)
local c0000 = Color(0, 0, 0, 0)

local voices = {}

--[[------------------------------------------------------------

	Panel

------------------------------------------------------------]]--
local PANEL = {}

function PANEL:Init()

	self.TalkerModel = vgui.Create("DModelPanel", self)
	self.TalkerModel:SetSize(32, 32)
	self.TalkerModel:SetPos(8, 8)
	self.TalkerModel:SetModel("models/gman_high.mdl")
	self.TalkerModel.LayoutEntity = function() return end

	local eyepos = self.TalkerModel.Entity:GetBonePosition(self.TalkerModel.Entity:LookupBone("ValveBiped.Bip01_Head1"))

	self.TalkerModel:SetLookAt(eyepos)
	self.TalkerModel:SetCamPos(eyepos - Vector(-18, 4, -2))

	self.TalkerNick = vgui.Create("DLabel", self)
	self.TalkerNick:SetFont("font_19r")
	self.TalkerNick:SetPos(52, 5)
	self.TalkerNick:SetTextColor(c255255255)

	self.TalkerJob = vgui.Create("DLabel", self)
	self.TalkerJob:SetFont("font_15r")
	self.TalkerJob:SetPos(52, 25)
	self.TalkerJob:SetTextColor(c150150150)

	self:SetSize(188, 48)
	self:DockMargin(0, 10, 0, 0)
	self:Dock(BOTTOM)

end

function PANEL:Setup(ply)

	self.Talker = ply
	self.VoiceColor = c25510251

	local model = ply:GetModel()

	if util.IsValidModel(model) then
		self.TalkerModel:SetModel(model)
		self.Model = model
	else
		self.TalkerModel:SetModel("")
		self.Model = ""
	end

	local nick = ply:Nick()

	if #nick > 13 then
		nick = nick:Left(13) .. "..."
	end

	self.TalkerNick:SetText(nick)
	self.TalkerNick:SizeToContents()

	local job = ply:getDarkRPVar("job") or "Error"

	if #job > 33 then
		job = job:Left(33) .. "..."
	end

	self.TalkerJob:SetText(job)
	self.TalkerJob:SizeToContents()

	self:InvalidateLayout()

end

function PANEL:Paint(w, h)

	if not IsValid(self.Talker) then return end

	draw.RoundedBox(0, 0, 0, w, h, c303030)

	local color1 = self.VoiceColor
	local color2 = Color(201, 157, 61, self.Talker:VoiceVolume() * 255)

	draw.OutlinedBox(6, 6, 36, 36, 1, color1)
	draw.OutlinedBox(5, 5, 38, 38, 1, color2)

end

function PANEL:Think()

	if self.fadeAnim then
		self.fadeAnim:Run()
	end

	if not IsValid(self.Talker) then
		voices[self.Talker]:Remove()
		voices[self.Talker] = nil
	end

end

function PANEL:FadeOut(anim, delta)

	if anim.Finished then
		if IsValid(voices[self.Talker]) then
			voices[self.Talker]:Remove()
			voices[self.Talker] = nil
			return
		end

		return
	end

	self:SetAlpha(255 - (255 * delta))

end

derma.DefineControl("RetrimeVoice", "", PANEL, "DPanel")

--[[------------------------------------------------------------

	Hooks

------------------------------------------------------------]]--
hook.Add("PlayerStartVoice", "DarkRP_StartVoice", function(ply)

	if not IsValid(pnl) then return end

	GAMEMODE:PlayerEndVoice(ply)

	local voice = voices[ply]

	if IsValid(voice) then
		if voice.fadeAnim then
			voice.fadeAnim:Stop()
			voice.fadeAnim = nil
		end

		if voice.TalkerModel and voice.Model then
			voice.TalkerModel:SetModel(voice.Model)
		end

		voice:SetAlpha(255)
		voice.VoiceColor = c25510251
		return
	end

	if IsValid(ply) then
		local panel = pnl:Add("RetrimeVoice")
		panel:Setup(ply)

		voices[ply] = panel
	end

end)

hook.Add("PlayerEndVoice", "DarkRP_EndVoice", function(ply)

	local voice = voices[ply]

	if IsValid(voice) then
		if voice.fadeAnim then return end

		if voice.TalkerModel then
			voice.TalkerModel:SetModel("")
		end

		voice.fadeAnim = Derma_Anim("FadeOut", voice, voice.FadeOut)
		voice.fadeAnim:Start(0.125)

		voice.VoiceColor = c0000
	end

end)

hook.Add("InitPostEntity", "DarkRP_CreateVoice", function()

	pnl = vgui.Create("DPanel")
	pnl:ParentToHUD()
	pnl:SetPos(ScrW() - 208, 20)
	pnl:SetSize(188, ScrH() - 40)
	pnl:SetPaintBackground(false)

end)

timer.Create("RetrimeVoiceClean", 10, 0, function()

	for ply in pairs(voices) do
		if not IsValid(ply) then
			GAMEMODE:PlayerEndVoice(ply)
		end
	end

end)

hook.Remove("InitPostEntity", "CreateVoiceVGUI")