if SERVER then
    util.AddNetworkString("PrivateJob")
end

local wl = {
    ["STEAM_0:0:541451703"] = {"donate2", "donate23"}, -- {donate2, donate23}
    ["STEAM_0:1:190680623"] = {"itztomber"}, -- {itztomber}
    ["STEAM_0:1:448435965"] = {"itztomber", "donate2", "donate23"}
}

concommand.Add("pj", function(ply, cmd, args)
    if CLIENT then
        local sid = ply:SteamID()

        if not wl[sid] then return end

        local nextuse = CurTime()

        local frame = vgui.Create("DFrame")
        frame:SetTitle("Личные профессии")
        frame:SetSize(200, 200)
        frame:Center()
        frame:MakePopup()
    
        local DScrollPanel = vgui.Create("DScrollPanel", frame)
        DScrollPanel:Dock(FILL)
    
        for i, v in ipairs(wl[sid]) do
            local tbl, index = DarkRP.getJobByCommand(v)

            local DButton = DScrollPanel:Add("DButton")
            DButton:SetText(tbl.name)
            DButton:Dock(TOP)
            DButton:DockMargin(0, 0, 0, 5)
            DButton.DoClick = function()
                if CurTime() >= nextuse then
                    net.Start("PrivateJob")
                    net.WriteUInt(index, 8)
                    net.SendToServer()
                    nextuse = CurTime() + 5
                end
            end
        end
    end
end)

if SERVER then
    net.Receive("PrivateJob", function(len, ply)
        local job = net.ReadUInt(8)
        ply:changeTeam(job, true, true, true)
    end)
end