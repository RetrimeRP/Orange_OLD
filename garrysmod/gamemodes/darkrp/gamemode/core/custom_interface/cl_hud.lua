local draw_RoundedBox = draw.RoundedBox
local draw_SimpleText = draw.SimpleText
local surface_SetFont = surface.SetFont
local surface_GetTextSize = surface.GetTextSize

local job
local money
local salary

local c303030 = Color(30, 30, 30)
local c25510251 = Color(255, 102, 51)
local c255255255 = Color(255, 255, 255)
local c424242 = Color(42, 42, 42)
local c000 = Color(0, 0, 0)
local c1657343 = Color(165, 73, 43)

local hud_igrushki = Material("materials/retrime_orange/hud/lanterns.png")
local hud_hunger = Material("materials/retrime_orange/hud/hunger.png")
local hud_code = Material("materials/retrime_orange/hud/code.png")

hook.Add("DarkRPVarChanged", "DarkRP_VarsChanged", function(ply, var, old, new)

	if ply ~= LocalPlayer() then return end

	if var == "job" then
		job = new
	elseif var == "money" then
		money = DarkRP.formatMoney(new)
	elseif var == "salary" then
		salary = (new > 0 and "+" .. DarkRP.formatMoney(new)) or false
	end

end)

--[[------------------------------------------------------------

	Notifications

------------------------------------------------------------]]--
local notifications = {}

function notification.AddLegacy(text, type, time)

	local x, y = ScrW(), ScrH()

	surface_SetFont("font_22r")
	local w, h = surface_GetTextSize(text)

	table.insert(notifications, 1, {x = x, y = y, w = w + 30, h = h + 12, text = text, time = CurTime() + time})

end

function notification.Kill(id)

	for k, v in pairs(notifications) do
		if v.id == id then
			v.time = 0
		end
	end

end

local function DrawNotifications()

	local scrw = ScrW()
	local scrh = ScrH()

	for k, v in pairs(notifications) do
		local x = math.floor(v.x)
		local y = math.floor(v.y)
		local w = v.w
		local h = v.h

		draw_RoundedBox(0, x, y, w, h, c303030)
		draw_RoundedBox(0, x - 2, y, 2, h, c25510251)
		draw_SimpleText(v.text, "font_22r", x + 15, y + 5, c255255255)

		v.x = Lerp(FrameTime() * 8, v.x, v.time > CurTime() and scrw - v.w - 20 or scrw + 1)
		v.y = Lerp(FrameTime() * 8, v.y, scrh - 14 - (k * (v.h + 6)))
	end

	for k, v in pairs(notifications) do
		if v.x >= scrw and v.time < CurTime() then
			table.remove(notifications, k)
		end
	end

end

--[[------------------------------------------------------------

	HUDPaint

------------------------------------------------------------]]--
function GM:HUDPaint()

	DrawNotifications()

	local client = LocalPlayer()
	local scrw = ScrW()
	local scrh = ScrH()

	local health = math.Clamp(client:Health(), 0, 99999)
	health = (health > 44444 and "∞") or health

	local armor = math.Clamp(client:Armor(), 0, 99999)
	armor = (armor > 44444 and "∞") or armor

	local width = 0

	-- health
	draw_RoundedBox(0, 20, scrh - 90, 82, 70, c303030) -- c25510251
	draw_SimpleText(health, "font_32r", 59, scrh - 55, c25510251, 1, 1) -- c255255255

	-- armor
	if armor == "∞" or armor > 0 then
		draw_RoundedBox(0, 102, scrh - 90, 1, 70, c424242)
		draw_RoundedBox(0, 103, scrh - 90, 82, 70, c303030) -- c424242
		draw_SimpleText(armor, "font_32r", 141, scrh - 55, c255255255, 1, 1)

		width = width + 82
	end

	-- job
	draw_RoundedBox(0, 112 + width, scrh - 90, 200, 30, c303030)
	draw_SimpleText(job, "font_19r", 122 + width, scrh - 85, c255255255)

	-- salary
	if salary then
		surface_SetFont("font_19r")
		local width2 = surface_GetTextSize(salary or "Unknown")

		draw_RoundedBox(0, 112 + width, scrh - 50, 170 - width2, 30, c303030)
		draw_SimpleText(money, "font_19r", 122 + width, scrh - 45, c255255255)

		draw_RoundedBox(0, 292 + width - width2, scrh - 50, 20 + width2, 30, c424242)
		draw_SimpleText(salary, "font_19r", 302 + width - width2, scrh - 45, c255255255)
	else
		draw_RoundedBox(0, 112 + width, scrh - 50, 200, 30, c303030)
		draw_SimpleText(money, "font_19r", 122 + width, scrh - 45, c255255255)
	end

	-- hunger
	local hungerjobs = DarkRP.GetHungerJobs()

	if not hungerjobs[client:Team()] then
		local hunger = math.ceil(client:getDarkRPVar("Energy") or 0)
		local height = 70 * (hunger / 100)

		draw_RoundedBox(0, 322 + width, scrh - 90, 30, 70, c303030)
		draw_RoundedBox(0, 322 + width, scrh - 20 - height, 30, height, c424242)
		draw.Icon(329 + width, scrh - 43, 16, 16, c255255255, hud_hunger)
	end

	-- rcode, ycode, lockdown
	if GetGlobalBool("DarkRP_RedCode") then
		draw_SimpleText("КРАСНЫЙ КОД", "font_32sb", scrw * 0.5, 19, c000, 1)
		local width3 = draw_SimpleText("КРАСНЫЙ КОД", "font_32b", scrw * 0.5, 19, c255255255, 1)

		draw.Icon(scrw * 0.5 - (width3 * 0.5 + 42), 19, 32, 32, c25510251, hud_code)
		draw.Icon(scrw * 0.5 + (width3 * 0.5 + 10), 19, 32, 32, c25510251, hud_code)
	elseif GetGlobalBool("DarkRP_YellowCode") then
		draw_SimpleText("ЖЕЛТЫЙ КОД", "font_32sb", scrw * 0.5, 19, c000, 1)
		local width3 = draw_SimpleText("ЖЕЛТЫЙ КОД", "font_32b", scrw * 0.5, 19, c255255255, 1)

		draw.Icon(scrw * 0.5 - (width3 * 0.5 + 42), 19, 32, 32, c25510251, hud_code)
		draw.Icon(scrw * 0.5 + (width3 * 0.5 + 10), 19, 32, 32, c25510251, hud_code)
	elseif GetGlobalBool("DarkRP_LockDown") then
		draw_SimpleText("КОМЕНДАНТСКИЙ ЧАС", "font_32sb", scrw * 0.5, 19, c000, 1)
		local width3 = draw_SimpleText("КОМЕНДАНТСКИЙ ЧАС", "font_32b", scrw * 0.5, 19, c255255255, 1)

		draw.Icon(scrw * 0.5 - (width3 * 0.5 + 42), 19, 32, 32, c25510251, hud_code)
		draw.Icon(scrw * 0.5 + (width3 * 0.5 + 10), 19, 32, 32, c25510251, hud_code)
	end

	self.Sandbox.HUDPaint(self)

end

--[[------------------------------------------------------------

	ScreenspaceEffects

------------------------------------------------------------]]--
local effects = {

	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 0,
	["$pp_colour_mulr"] = 0.05,
	["$pp_colour_mulg"] = 0.05,
	["$pp_colour_mulb"] = 0.05

}

hook.Add("RenderScreenspaceEffects", "DarkRP_ScreenEffects", function()

	if LocalPlayer():Health() < 15 then
		DrawColorModify(effects)
	end

end)

--[[------------------------------------------------------------

	Notify

------------------------------------------------------------]]--
usermessage.Hook("_Notify", function(msg)

	local text = msg:ReadString()

	GAMEMODE:AddNotify(text, msg:ReadShort(), msg:ReadLong())
	surface.PlaySound("buttons/lightswitch2.wav")

	MsgC(Color(255, 102, 51), "[DarkRP] ", Color(215, 215, 215), text, "\n")

end)

--[[------------------------------------------------------------

	HUDShouldDraw

------------------------------------------------------------]]--
local elements = {

	["CHudAmmo"] = true,
	["CHudBattery"] = true,
	["CHudDamageIndicator"] = true,
	["CHudHealth"] = true,
	["CHudPoisonDamageIndicator"] = true,
	["CHUDQuickInfo"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudSquadStatus"] = true,
	["CHudSuitPower"] = true,
	["CHudVoiceSelfStatus"] = true,
	["CHudVoiceStatus"] = true

}

function GM:HUDShouldDraw(name)

	if elements[name] then
		return false
	else
		return true
	end

end

--[[------------------------------------------------------------

	HUDDrawTargetID

------------------------------------------------------------]]--
function GM:HUDDrawTargetID()

	return false

end

--[[------------------------------------------------------------

	DrawDeathNotice

------------------------------------------------------------]]--
function GM:DrawDeathNotice(x, y)
	if LocalPlayer():Team() == TEAM_FSG then
		self.Sandbox.DrawDeathNotice(self, x, y)
	end
end


--[[------------------------------------------------------------

	HideDefaultMessages

------------------------------------------------------------]]--
local hide = {

	["joinleave"] = true,
	["namechange"] = true,
	["servermsg"] = true

}

hook.Add("ChatText", "DarkRP_HideDefaultMessages", function(index, name, text, type)

	if hide[type] then
		return true
	end

end)