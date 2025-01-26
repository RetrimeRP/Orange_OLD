/*
    Addon id: 28ddc61a-392d-42d6-8fb0-ed07a8920d3c
    Version: v1.6.3 (stable)
*/

if SERVER then return end
ztm = ztm or {}
ztm.HUD = ztm.HUD or {}
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- f127586c7613db6a75f4e52cc25e9683b470c1b9f85589e3ddb76f384bb73ed8

function ztm.HUD.DrawTrash(amount,pos)
    cam.Start3D2D(pos, zclib.HUD.GetLookAngles(), 0.1)
        draw.RoundedBox(5, -5, 80, 5, 250, ztm.default_colors["white01"])
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795

        surface.SetDrawColor(ztm.default_colors["grey01"])
        surface.SetMaterial(ztm.default_materials["ztm_trash_icon"])
        surface.DrawTexturedRect(-100, -100, 200, 200)

        draw.DrawText(amount .. ztm.config.UoW, zclib.GetFont("ztm_trash_font02"), 0, -20, ztm.default_colors["black02"], TEXT_ALIGN_CENTER)
        draw.DrawText(amount .. ztm.config.UoW, zclib.GetFont("ztm_trash_font01"), 0, -20, ztm.default_colors["white01"], TEXT_ALIGN_CENTER)
    cam.End3D2D()
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 76561198074911795
                                                                                                                                                                                                                                                                                                                                                                                                                                                       -- 9cbc7500025622669036f40fff72bd826ceb5c77b717478b9f101ab72a76cf9e
