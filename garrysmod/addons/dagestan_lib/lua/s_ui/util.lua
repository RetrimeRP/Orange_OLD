local _b = ScrW()
local function ss(a)
    return a/1920*_b
end

for i = 10, 100 do
    surface.CreateFont('ui.' .. i, {
        font = 'Mont Bold',
        size = ss(i),
        //weight = 500,
        extended = true,
        antialias = true
    })
end

--- util

LP = LocalPlayer()

rbx = draw.RoundedBox

draw_text = draw.SimpleText

--- size

ui = {}
ui.save_w = {}
ui.save_h = {}

function ui.w(w)
    if !ui.save_w[w] then
        ui.save_w[w] = w / 1920 * ScrW()
    end

    return ui.save_w[w]
end

function ui.h(h)
    if !ui.save_h[h] then
        ui.save_h[h] = h / 1080 * ScrH()
    end

    return ui.save_h[h]
end


-- ui element

-- Shadow gradient

local gradient = {
    surface.GetTextureID('gui/gradient_up'), -- 1
    surface.GetTextureID('gui/gradient_down'), -- 2
}
local shadow_color = Color(30,30,30,210)

function ui.ShadowGradient(_x, _y, _w, _h, direction)
    draw.TexturedQuad
    {
        texture = gradient[direction],
        color = shadow_color,
        x = _x,
        y = _y,
        w = _w,
        h = _h,
    }
end

-- Sound

function ui.Sound(snd)
    surface.PlaySound(snd or 'ui/test.wav')
end

-- Blur

local color_white = Color(255,255,255)
local mat_blur = Material('pp/blurscreen')
local scrw, scrh = ScrW(), ScrH()

function ui.Blur(panel)
    local x, y = panel:LocalToScreen(0, 0)

    surface.SetDrawColor(color_white)
    surface.SetMaterial(mat_blur)

    for i = 1, 6 do
        mat_blur:SetFloat('$blur', i)
        mat_blur:Recompute()

        render.UpdateScreenEffectTexture()

        surface.DrawTexturedRect(-x, -y, scrw, scrh)
    end
end

-- Download Material

local file, Material, Fetch, find = file, Material, http.Fetch, string.find
local errorMat = Material('error')
local WebImageCache = {}

function ui.DownloadMat(url, path, callback, retry_count)
    if WebImageCache[url] then
        return callback(WebImageCache[url])
    end

    local data_path = 'data/' .. path

    if file.Exists(path, 'DATA') then
        WebImageCache[url] = Material(data_path, 'smooth mips')

        callback(WebImageCache[url])
    else
        Fetch(url, function(img)
            if img == nil or find(img, '<!DOCTYPE HTML>', 1, true) then
                return callback(errorMat)
            end
            
            file.Write(path, img)

            WebImageCache[url] = Material(data_path, 'smooth mips')

            callback(WebImageCache[url])
        end, function()
            if retry_count and retry_count > 0 then
                retry_count = retry_count - 1

                ui.DownloadMat(url, path, callback, retry_count)
            else
                callback(errorMat)
            end
        end)
    end
end




local vguiFucs = {
    ['DTextEntry'] = function(self, p)
        self:SetFont('ui.20')
    end,    
    ['DLabel'] = function(self, p)
        self:SetFont('ui.22')
        self:SetColor(col.White)
    end,
    ['DButton'] = function(self, p)
        self:SetFont('ui.20')
    end,
    ['DComboBox'] = function(self, p)
        self:SetFont('ui.22')
    end,
}

timer.Simple(0, function()
    vgui.GetControlTable('DButton').SetBackgroundColor = function(self, color)
        self.BackgroundColor = color
    end
end)

function ui.Create(t, f, p)
    local parent
    if (not isfunction(f)) and (f ~= nil) then
        parent = f
    elseif not isfunction(p) and (p ~= nil) then
        parent = p
    end

    local v = vgui.Create(t, parent)
    --v:SetSkin('SUP')

    if vguiFucs[t] then vguiFucs[t](v, parent) end

    if isfunction(f) then f(v, parent) elseif isfunction(p) then p(v, f) end

    return v
end

function ui.StringRequest(title, text, default, cback)
    local m = ui.Create('ui-frame', function(self)
        self:SetTitle(title)
        self:SetWide(ScrW() * .3)
        self:MakePopup()
    end)
    
    local txt = string.Explode("\n", text) 
    local y = ui.h(40)

    for k, v in ipairs(txt) do
        local lbl = ui.Create('DLabel', function(self)
            self:SetText(v)
            self:SetFont('ui.18')
            self:SizeToContents()
            self:SetPos((m:GetWide() - self:GetWide()) / 2, y)
            y = y + self:GetTall()
        end, m)
    end
    
    local tb = ui.Create('DTextEntry', function(self) 
        self:SetPos(5, y + 5)
        self:SetSize(m:GetWide() - 10, 25)
        self:SetValue(default or '')
        y = y + self:GetTall() + 10
        self.OnEnter = function(s)
            m:Close()
            cback(self:GetValue())
        end
    end, m)

    local btnOK = ui.Create('ui-button', function(self)
        self:SetText('Да')
        self:SetPos(5, y)
        self:SetSize(m:GetWide() / 2 - 10, 25)  
        self.DoClick = function(s)
            ui.Sound()
            m:Close()
            cback(tb:GetValue())
        end
    end, m)

    local btnCan = ui.Create('ui-button', function(self)
        self:SetText('Отмена')
        self:SetPos(btnOK:GetWide() + 10, y)
        self:SetSize(btnOK:GetWide(), 25)
        self.DoClick = function(s)
            ui.Sound()
            m:Close()
        end
    end, m)

    y = y + btnOK:GetTall() + 5  
    m:SetTall(y)
    m:Center()
    return m
end
