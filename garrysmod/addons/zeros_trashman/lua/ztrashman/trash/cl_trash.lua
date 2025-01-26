/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

if SERVER then return end
ztm = ztm or {}
ztm.Trash = ztm.Trash or {}

function ztm.Trash.Initialize(Trash)
	zclib.EntityTracker.Add(Trash)
end

function ztm.Trash.Draw(Trash)
	if zclib.Convar.Get("zclib_cl_drawui") == 1 and zclib.util.InDistance(LocalPlayer():GetPos(), Trash:GetPos(), 500) and ztm.Player.IsTrashman(LocalPlayer()) then
		ztm.HUD.DrawTrash(Trash:GetTrash(),Trash:GetPos() + Vector(0, 0, 50))
	end
end

function ztm.Trash.OnRemove(Trash)
	ztm.Effects.Trash(Trash:GetPos(), nil)
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e

local function HasToolActive()
	local ply = LocalPlayer()

	if IsValid(ply) and ply:Alive() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "gmod_tool" then
		local tool = ply:GetTool()
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 99f1d1797f4103f9ed8acb86f841b74bc4c30bab0a0d892f8b5891c8a07acb80

		if tool and table.Count(tool) > 0 and IsValid(tool.SWEP) and tool.Mode == "ztm_trashspawner" and tool.Name == "#TrashSpawner" then
			return true
		else
			return false
		end
	else
		return false
	end
end

zclib.Hook.Add("PostDrawTranslucentRenderables", "ztm_trashspawner", function()
	if HasToolActive() then
		local tr = LocalPlayer():GetEyeTrace()

		if tr.Hit and not IsValid(tr.Entity) and zclib.util.InDistance(tr.HitPos, LocalPlayer():GetPos(), 300) then
			render.SetColorMaterial()
			render.DrawWireframeSphere(tr.HitPos, 1, 4, 4, ztm.default_colors["white01"], false)
		end
	end
end)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

local wMod = ScrW() / 1920
local hMod = ScrH() / 1080
local Trash_Hints = {}

net.Receive("ztm_trash_showall", function(len)
	local dataLength = net.ReadUInt(16)
	local d_Decompressed = util.Decompress(net.ReadData(dataLength))
	local positions = util.JSONToTable(d_Decompressed)
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 8428676cd8c47b543e7da66f055fb3e3140ec78d24b3df2ac5d05107c4696e1a

	if positions then
		Trash_Hints = positions

		zclib.Hook.Remove("HUDPaint", "ztm_TrashHints")
		zclib.Hook.Add("HUDPaint", "ztm_TrashHints", function()
			if Trash_Hints and table.Count(Trash_Hints) > 0 then
				for k, v in pairs(Trash_Hints) do
					if v then
						local pos = v:ToScreen()
						local size = 10
						surface.SetDrawColor(ztm.default_colors["red02"])
						surface.DrawRect(pos.x - (size * wMod) / 2, pos.y - (size * hMod) / 2, size * wMod, size * hMod)
					end
				end
			end
		end)
	end
end)

net.Receive("ztm_trash_hideall", function(len)
	Trash_Hints = {}
	zclib.Hook.Remove("HUDPaint", "ztm_TrashHints")
end)
