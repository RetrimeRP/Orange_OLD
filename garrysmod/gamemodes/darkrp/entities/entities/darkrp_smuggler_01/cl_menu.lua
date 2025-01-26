local pnl

local c230230230 = Color(230, 230, 230)
local c303030 = Color(30, 30, 30)
local c255255255 = Color(255, 255, 255)
local c454545 = Color(45, 45, 45)
local c109109109 = Color(109, 109, 109)
local c424242 = Color(42, 42, 42)
local c165165165 = Color(165, 165, 165)
local c25510251 = Color(255, 102, 51)

local weapons = {

	["Пистолеты"] = {
		{"GLOCK 18", 2800, "models/orange/weapons/w_models/wpn_glock_w.mdl", "tfa_glock"},
		{"FNX-45 TACTICAL", 3200, "models/orange/weapons/w_models/wpn_fnx45_w.mdl", "tfa_fnx45"},
		{"ПМ", 2600, "models/flaymi/anomaly/weapons/w_models/wpn_pm_w.mdl", "tfa_pm"},
		{"DESERT EAGLE", 4200, "models/orange/weapons/w_models/wpn_desert_eagle_w.mdl", "tfa_desert_eagle"},
		{"BERETTA 92F", 3800, "models/orange/weapons/w_models/wpn_beretta92fs.mdl", "tfa_beretta"},
		{"COLT M1911", 3400, "models/orange/weapons/w_models/wpn_colt1911_w.mdl", "tfa_colt1911"}
	},
	["Пистолеты-пулемёты"] = {
		{"SCORPION VZ.61", 4600, "models/orange/weapons/w_models/wpn_vz61_w.mdl", "tfa_vz61"},
		{"H&K MP7", 5600, "models/orange/weapons/w_models/wpn_mp7_w.mdl", "tfa_mp7"},
		{"MP5SD", 5000, "models/orange/weapons/w_models/wpn_mp5sd_w.mdl", "tfa_mp5sd"},
		{"H&K UMP 45", 5400, "models/orange/weapons/w_models/wpn_ump45_w.mdl", "tfa_ump45"},
		{"P90", 6000, "models/orange/weapons/w_models/wpn_p90_w.mdl", "tfa_p90"}
	},
	["Штурмовые винтовки"] = {
		{"GALIL", 8200, "models/weapons/w_rif_galil.mdl", "tfa_galil"},
		{"FN SCAR-H", 9000, "models/orange/weapons/w_models/wpn_scar_w.mdl", "tfa_scar"},
		{"AKМ", 10800, "models/orange/weapons/w_models/wpn_akm.mdl", "tfa_akm"},
		{"M4A1", 11600, "models/orange/weapons/w_models/wpn_m4a1_w.mdl", "tfa_m4a1"},
		{"SIG SG552 COMMANDO", 12200, "models/orange/weapons/w_models/wpn_sig552_w.mdl", "tfa_sig552"},
		{"STEYR AUG A1", 12600, "models/orange/weapons/w_models/w_aug_a1.mdl", "tfa_aug_a1"}
	},
	["Дробовики и пулемёты"] = {
		{"REMINGTON 870", 14000, "models/orange/weapons/w_models/wpn_remington870_w.mdl", "tfa_remington870"},
		{"MP-153", 20000, "models/orange/weapons/w_models/wpn_mp153_w.mdl", "tfa_mp153"},
		{"ПКМ", 26000, "models/orange/weapons/w_models/wpn_pkm_w.mdl", "tfa_pkm"}
	},
	["Снайперские винтовки"] = {
		{"ВИНТОВКА МОСИНА", 34000, "models/orange/weapons/w_models/wpn_mosin_w.mdl", "tfa_mosin"},
		{"СВ-98", 40000, "models/orange/weapons/w_models/wpn_sv98_w.mdl", "tfa_sv98"},
		{"G3 SG1", 48000, "models/orange/weapons/w_models/wpn_g3sg1_w.mdl", "tfa_g3sg1"},
		{"SR-25", 50000, "models/orange/weapons/w_models/wpn_sr25_w.mdl", "tfa_sr25"}
	},
	["Патроны"] = {
		{"Патроны 357", 250, "models/items/357ammobox.mdl", "ammo_357"},
		{"Патроны штурм. винтовок", 250, "models/items/boxmrounds.mdl", "ammo_ar2"},
		{"Патроны дробовиков", 250, "models/items/boxbuckshot.mdl", "ammo_buckshot"},
		{"Патроны для пистолетов", 250, "models/items/boxsrounds.mdl", "ammo_pistol"},
		{"Патроны пист.-пулемётов", 250, "models/items/boxsrounds.mdl", "ammo_smg"},
		{"Патроны снайп. винтовок", 250, "models/items/sniper_round_box.mdl", "ammo_sniper_rounds"},
		{"Патроны арбалета", 500, "models/items/crossbowrounds.mdl", "ammo07"},
		{"Патроны гранатомёта", 2000, "models/weapons/w_missile_closed.mdl", "ammo08"}
	},
	["Остальное"] = {
		{"Аптечка", 500, "models/items/healthkit.mdl", "health"},
		{"Зарядник брони", 500, "models/items/battery.mdl", "armor"},
		{"Отмычка", 3000, "models/weapons/w_crowbar.mdl", "darkrp_lockpick"},
		{"Взломщик кейпадов", 4000, "models/weapons/w_c4_planted.mdl", "base_keypadcracker"},
		{"EMP", 10000, "models/alyx_emptool_prop.mdl", "darkrp_hackdevice"},
		{"Нож", 250, "models/weapons/w_knife_t.mdl", "tfa_knife"},
	}

}

local function CloseMenu()

	if IsValid(pnl) then
		pnl:Close()
		pnl = nil
	end

end

net.Receive("SupplierMenu", function()

	if IsValid(pnl) then pnl:Remove() end

	local scrw = math.max(1152, ScrW() * 0.6)
	local scrh = math.max(720, ScrH() * 0.7)
	local curtime = CurTime()
	local supplier = net.ReadEntity()

	pnl = vgui.Create("DFrame")
	pnl:SetSize(scrw, scrh)
	pnl:Center()
	pnl:SetTitle("")
	pnl:ShowCloseButton(false)
	pnl:SetDraggable(false)
	pnl:MakePopup()
	pnl.Paint = function(self, w, h)
		if input.IsKeyDown(15) then
			if self.delay then CloseMenu() return end
		else
			if CurTime() - curtime > 0.3 then self.delay = true end
		end

		draw.RoundedBox(0, 0, 0, w, 40, c230230230)
		draw.RoundedBox(0, 0, 40, w, h - 40, c303030)
		draw.SimpleText("Альберт", "font_22r", 17, 20, c303030, 0, 1)
	end

	pnl.scrlpnl = vgui.Create("DScrollPanel", pnl)
	pnl.scrlpnl:SetSize(pnl:GetWide(), pnl:GetTall() - 133)
	pnl.scrlpnl:SetPos(0, 91)
	pnl.scrlpnl.Paint = function() end

	pnl.scrlbar = pnl.scrlpnl:GetVBar()

	pnl.scrlbar.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c454545)
	end

	pnl.scrlbar.btnUp.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c303030)
	end

	pnl.scrlbar.btnGrip.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c109109109)
	end

	pnl.scrlbar.btnDown.Paint = function(self, w, h)
		draw.RoundedBox(0, w - 4, 0, 4, h, c303030)
	end

	pnl.lt1 = vgui.Create("DIconLayout", pnl.scrlpnl)
	pnl.lt1:SetSize(467, pnl.scrlpnl:GetTall())
	pnl.lt1:SetPos(42, 0)
	pnl.lt1:SetSpaceY(32)
	pnl.lt1:SetSpaceX(32)
	pnl.lt1.Paint = function() end

	pnl.lt2 = vgui.Create("DIconLayout", pnl.scrlpnl)
	pnl.lt2:SetSize(pnl.scrlpnl:GetWide() - 467, pnl.scrlpnl:GetTall())
	pnl.lt2:SetPos(509, 0)
	pnl.lt2:SetSpaceY(32)
	pnl.lt2:SetSpaceX(32)
	pnl.lt2.Paint = function() end

	for key, val in pairs(weapons) do
		if #key % 2 ~= 1 then
			pnl.wep = pnl.lt1:Add("DPanel")
		else
			pnl.wep = pnl.lt2:Add("DPanel")
		end

		pnl.wep:SetSize(435, 80 + (#val * 58))
		pnl.wep.Paint = function(self, w, h)
			draw.RoundedBoxEx(3, 0, 0, w, 58, c454545, true, true, false, false)
			draw.RoundedBoxEx(3, 0, 58, w, h - 58, c424242, false, false, true, true)
			draw.SimpleText(key, "font_22r", 24, 18, c255255255)
		end

		for k, v in ipairs(val) do
			pnl.wep_pnl = vgui.Create("DPanel", pnl.wep)
			pnl.wep_pnl:SetSize(pnl.wep:GetWide(), 58)
			pnl.wep_pnl:SetPos(0, 69 + (k - 1) * 58)
			pnl.wep_pnl.Paint = function(self, w, h)
				draw.SimpleText(v[1], "font_22r", 74, 9, c255255255)
				draw.SimpleText("цена: " .. DarkRP.formatMoney(v[2]), "font_19r", 74, 29, c165165165)
			end

			pnl.wep_mdl = vgui.Create("SpawnIcon", pnl.wep_pnl)
			pnl.wep_mdl:SetSize(32, 32)
			pnl.wep_mdl:SetPos(25, 13)
			pnl.wep_mdl:SetModel(v[3])
			pnl.wep_mdl.PaintOver = function() return end

			pnl.wep_btn = vgui.Create("DButton", pnl.wep_pnl)
			pnl.wep_btn:SetSize(75, 26)
			pnl.wep_btn:SetPos(pnl.wep_pnl:GetWide() - 100, 16)
			pnl.wep_btn:SetText("")
			pnl.wep_btn.Paint = function(self, w, h)
				draw.RoundedBox(0, 0, 0, w, h, c25510251)
				draw.SimpleText("КУПИТЬ", "font_15r", w * 0.5, h * 0.5 - 1, c255255255, 1, 1)
			end
			pnl.wep_btn.DoClick = function()
				local name = v[1]
				local weapon_to_give = v[4]
				local price = v[2]
				net.Start("SupplierPurchase")
				net.WriteEntity(supplier)
				net.WriteString(name)
				net.WriteString(weapon_to_give)
				net.WriteString(price)
				net.SendToServer()
			end
		end
	end

end)