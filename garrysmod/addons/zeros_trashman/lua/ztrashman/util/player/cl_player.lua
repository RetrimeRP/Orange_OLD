/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

if SERVER then return end

ztm = ztm or {}

local last_entcatch = -1
local near_players = {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

local trash_icon_size = 100
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80

local wMod = ScrW() / 1920
local hMod = ScrH() / 1080

local function DrawPlayerTrash()
	if not IsValid(LocalPlayer()) or not LocalPlayer():Alive() or not IsValid(LocalPlayer():GetActiveWeapon()) or LocalPlayer():GetActiveWeapon():GetClass() ~= "ztm_trashcollector" then return end


	if CurTime() > last_entcatch then
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

		near_players = {}

		for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(),500)) do

			if IsValid(v) and v:IsPlayer() and v:Alive() and v:GetNWInt("ztm_trash",nil) ~= nil and v:GetNWInt("ztm_trash",0) > 0 then

				table.insert(near_players,v)
			end
		end

		last_entcatch = CurTime() + 1
	end

	if near_players and table.Count(near_players) > 0 then

		for k, v in pairs(near_players) do
			if IsValid(v) and v:Alive() and v ~= LocalPlayer() then

				local pos = v:GetPos() + Vector(0,0,30)
				pos = pos:ToScreen()

				surface.SetDrawColor(ztm.default_colors["grey01"])
				surface.SetMaterial(ztm.default_materials["ztm_trash_icon"])
				surface.DrawTexturedRect(pos.x - ((trash_icon_size * wMod) / 2), pos.y - ((trash_icon_size * hMod) / 2), trash_icon_size * wMod, trash_icon_size * hMod)

				draw.DrawText(v:GetNWInt("ztm_trash", 0) .. ztm.config.UoW, zclib.GetFont("ztm_playertrash_font02"), pos.x, pos.y + (-10 * hMod), ztm.default_colors["black02"], TEXT_ALIGN_CENTER)
				draw.DrawText(v:GetNWInt("ztm_trash", 0) .. ztm.config.UoW, zclib.GetFont("ztm_playertrash_font01"), pos.x, pos.y + (-10 * hMod), ztm.default_colors["white01"], TEXT_ALIGN_CENTER)
			end
		end
	end
end

zclib.Hook.Add("HUDPaint", "ztm_playertrash", function()
	if ztm.config.PlayerTrash.Enabled then
		DrawPlayerTrash()
	end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8
