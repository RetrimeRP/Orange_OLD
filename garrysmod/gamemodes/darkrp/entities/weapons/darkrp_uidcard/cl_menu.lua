local pnl

local c230230230 = Color(230, 230, 230)
local c303030 = Color(30, 30, 30)
local c424242 = Color(42, 42, 42)
local c109109109 = Color(109, 109, 109)
local c255255255 = Color(255, 255, 255)
local c25525525525 = Color(255, 255, 255, 25)

local cidcard_combine = Material("materials/retrime_orange/combine.png")
local cidcard_close = Material("materials/retrime_orange/close.png")

net.Receive("OpenUIDCard", function()

	if IsValid(pnl) then return end

	local ply = net.ReadEntity()
	local mdl = ply:GetModel()
	local job = ply:getDarkRPVar("job")
    job = string.Explode(" ", job)

	pnl = vgui.Create("DFrame")
	pnl:SetSize(600, 256)
	pnl:Center()
	pnl:SetTitle("")
	pnl:ShowCloseButton(false)
	pnl:SetDraggable(false)
	pnl:MakePopup()
	pnl.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, 40, c230230230)
		draw.RoundedBox(0, 0, 40, w, h - 40, c303030)
		draw.SimpleText("UID карта", "font_22r", 17, 20, c303030, 0, 1)
		draw.Icon(w - 256, h - 180, 256, 256, c424242, cidcard_combine)
	end

	pnl.cls = vgui.Create("DButton", pnl)
	pnl.cls:SetSize(16, 16)
	pnl.cls:SetPos(pnl:GetWide() - 32, 12)
	pnl.cls:SetText("")
	pnl.cls.Paint = function(self, w, h)
		draw.Icon(0, 0, w, h, c303030, cidcard_close)
	end
	pnl.cls.DoClick = function()
		pnl:Close()
		pnl = nil
	end

	pnl.pnl_mdl = vgui.Create("DPanel", pnl)
	pnl.pnl_mdl:SetSize(122, 144)
	pnl.pnl_mdl:SetPos(36, 76)
	pnl.pnl_mdl.Paint = function(self, w, h)
		draw.OutlinedBox(0, 0, w, h, 3, c424242)
	end

	if util.IsValidModel(mdl) then
		pnl.mdl = vgui.Create("DModelPanel", pnl.pnl_mdl)
		pnl.mdl:SetSize(pnl.pnl_mdl:GetWide() - 6, pnl.pnl_mdl:GetTall() - 6)
		pnl.mdl:SetPos(3, 3)
		pnl.mdl:SetModel(mdl)
		pnl.mdl.LayoutEntity = function() return end

		local eyepos = pnl.mdl.Entity:GetBonePosition(pnl.mdl.Entity:LookupBone("ValveBiped.Bip01_Head1"))
		eyepos:Add(Vector(0, 0, -2))

		pnl.mdl:SetLookAt(eyepos)
		pnl.mdl:SetCamPos(eyepos - Vector(-18, 0, -2))
	end

	pnl.pnl1 = vgui.Create("DPanel", pnl)
	pnl.pnl1:SetSize(185, 144)
	pnl.pnl1:SetPos(158, 76)
	pnl.pnl1.Paint = function(self, w, h)
		draw.SimpleText("СОТРУДНИК", "font_22r", 23, 7, c109109109)
		draw.SimpleText("ДОЛЖНОСТЬ", "font_22r", 23, 41, c109109109)
		draw.SimpleText("UID НОМЕР", "font_22r", 23, 75, c109109109)
	end

	pnl.pnl2 = vgui.Create("DPanel", pnl)
	pnl.pnl2:SetSize(221, 144)
	pnl.pnl2:SetPos(343, 76)
	pnl.pnl2.Paint = function(self, w, h)
		draw.RoundedBox(0, 10, 28, w - 10, 1, c25525525525)
		draw.SimpleText(ply:Nick(), "font_22r", 9, 7, c255255255)
		draw.RoundedBox(0, 10, 62, w - 10, 1, c25525525525)
		draw.SimpleText(job[1], "font_22r", 9, 41, c255255255)
		draw.RoundedBox(0, 10, 96, w - 10, 1, c25525525525)
		draw.SimpleText(job[2], "font_22r", 9, 75, c255255255)
	end

end)