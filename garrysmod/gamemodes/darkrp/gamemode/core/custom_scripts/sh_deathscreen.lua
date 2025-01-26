local function death_time(ply)

    if ply:SteamID() == "STEAM_0:0:217253683" then
        return 1
    end
    
	if ply:Donator("platinum") then
		return 10
	end

	if ply:Donator("gold") then
		return 20
	end

	if ply:Donator("silver") then
		return 35
	end

	return 40

end

local function GetChance(ply)

	if ply:Donator("platinum") then

		return math.random(100) == 82

	end



	if ply:Donator("gold") then

		return math.random(150) == 82

	end



	if ply:Donator("silver") then

		return math.random(200) == 82

	end



	return math.random(300) == 82

end


if SERVER then

	util.AddNetworkString("DeathScreen")

end

if CLIENT then

	local draw_RoundedBox = draw.RoundedBox
	local draw_SimpleText = draw.SimpleText
	local c303030230 = Color(30, 30, 30, 230)
	local c255255255 = Color(255, 255, 255)

	net.Receive("DeathScreen", function()
		local shoulddraw = net.ReadBool()
		local scrw = ScrW()
		local scrh = ScrH()

		if shoulddraw then
			local deathtime = CurTime()
			local chance = GetChance(LocalPlayer())

			if chance then
				surface.PlaySound("music/whatsuppppppxddDDD.mp3")
			end

			hook.Add("HUDPaint", "DarkRP_DeathScreen", function()
				local time = math.Round(death_time(LocalPlayer()) - CurTime() + deathtime)

				if time > 0 then
					draw.Blur(0, 0, scrw, scrh, 5, 0.2)
					draw_RoundedBox(0, 0, 0, scrw, scrh, c303030230)
					draw_SimpleText("Вы возродитесь через " .. time .. " секунд", "font_32b", scrw * 0.5, scrh * 0.5, c255255255, 1, 1)
				end
			end)
		else
			hook.Remove("HUDPaint", "DarkRP_DeathScreen")
		end
	end)

end