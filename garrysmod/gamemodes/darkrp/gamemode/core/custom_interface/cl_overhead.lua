local draw_RoundedBox = draw.RoundedBox
local draw_SimpleText = draw.SimpleText

local c000 = Color(0, 0, 0)
local c25510251 = Color(255, 102, 51)
local c255255255 = Color(255, 255, 255)

local playercache = {}
local playertable = {}

--[[------------------------------------------------------------

	Overhead

------------------------------------------------------------]]--
timer.Create("DarkRP_RefreshPlayerCache", 0.56, 0, function()

	local client = LocalPlayer()

	if not IsValid(client) then return end

	local playercount = 0

	playercache = {}
	playertable = {}

	for k, v in ipairs(ents.FindInSphere(client:GetPos(), 256)) do
		if not IsValid(v) or not v:IsPlayer() or not v:Alive() or v == client or v:GetRenderMode() == RENDERMODE_TRANSALPHA then continue end

		playercount = playercount + 1
		playercache[playercount] = v

		if v:GetDisguiseVar("combine") or (v:IsCombine() and !v:IsSynth()) then
			local job = v:getDarkRPVar("job")

			if not job then continue end

			job = string.Explode(" ", job)

			local job1 = job[1] or ""
			local job2 = job[2] or ""

			playertable[v] = {
				wanted = v:getDarkRPVar("wanted"),
				line1 = job1,
				line2 = "< -- " .. job2 .. " -- >"
			}
		else
			playertable[v] = {
				wanted = v:getDarkRPVar("wanted"),
				line1 = v:Nick(),
				line2 = v:getDarkRPVar("job")
			}
		end
	end

end)

hook.Add("PostDrawTranslucentRenderables", "DarkRP_Overhead", function()

	for k, v in ipairs(playercache) do
		if not v:IsValid() then continue end

		local playerinfo = playertable[v]

		if not playerinfo then continue end

		local wanted = playerinfo.wanted
		local line1 = playerinfo.line1
		local line2 = playerinfo.line2

		local volume = v:VoiceVolume() * 10

		local z
		if v:GetModel() == "models/retrime/orange/other/cremator_01.mdl" then
			z = 105
		else
			z = 80
		end

		local pos = v:LocalToWorld(Vector(0, 0, z))

		local ang = LocalPlayer():GetAngles()
		ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Right(), 90)

		cam.Start3D2D(pos, ang, 0.15)
			if wanted then
				draw_SimpleText("В розыске", "font_24s", 0, -30, c000, 1, 1)
				draw_SimpleText("В розыске", "font_24b", 0, -30, c25510251, 1, 1)
			end

			draw_SimpleText(line1, "font_40sb", 0, 0, c000, 1, 1)

			if volume > 0 then
				draw_SimpleText(line1, "font_40b", 0, 0, Color(255, 255 - math.min(153, math.Round(153 * volume)), 255 - math.min(204, math.Round(204 * volume))), 1, 1)
			else
				draw_SimpleText(line1, "font_40b", 0, 0, c255255255, 1, 1)
			end

			draw_SimpleText(line2, "font_24s", 0, 30, c000, 1, 1)
			draw_SimpleText(line2, "font_24r", 0, 30, c255255255, 1, 1)
		cam.End3D2D()
	end

end)