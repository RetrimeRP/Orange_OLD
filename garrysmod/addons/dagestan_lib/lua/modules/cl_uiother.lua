function draw.Circle( x, y, radius, seg )
    local cir = {}

    table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
    for i = 0, seg do
        local a = math.rad( ( i / seg ) * -360 )
        table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
    end

    local a = math.rad( 0 ) -- This is needed for non absolute segment counts
    table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

    surface.DrawPoly( cir )
end

local math_clamp  = math.Clamp
local Color       = Color
local mat = Material
local texOutlinedCorner = surface.GetTextureID( "gui/corner16" )
function draw.RoundedBoxOutlined( bordersize, x, y, w, h, color, bordercol )

  x = math.Round( x )
  y = math.Round( y )
  w = math.Round( w )
  h = math.Round( h )

  draw.RoundedBox( bordersize, x, y, w, h, color )
  
  surface.SetDrawColor( bordercol )
  
  surface.SetTexture( texOutlinedCorner )
  surface.DrawTexturedRectRotated( x + bordersize/2 , y + bordersize/2, bordersize, bordersize, 0 ) 
  surface.DrawTexturedRectRotated( x + w - bordersize/2 , y + bordersize/2, bordersize, bordersize, 270 ) 
  surface.DrawTexturedRectRotated( x + w - bordersize/2 , y + h - bordersize/2, bordersize, bordersize, 180 ) 
  surface.DrawTexturedRectRotated( x + bordersize/2 , y + h -bordersize/2, bordersize, bordersize, 90 ) 
  
  surface.DrawLine( x+bordersize, y, x+w-bordersize, y )
  surface.DrawLine( x+bordersize, y+h-1, x+w-bordersize, y+h-1 )
  
  surface.DrawLine( x, y+bordersize, x, y+h-bordersize )
  surface.DrawLine( x+w-1, y+bordersize, x+w-1, y+h-bordersize )

end

function pt.DrawBar(x, y, w, h, perc)
  local color = Color(255 - (perc * 255), perc * 255, 0, 255)

  draw.OutlinedBox(x, y, math_clamp((w * perc), 3, w), h, color, color_outline)
end

function pt.DrawProgress(x, y, w, h, perc)
  local color = Color(255 - (perc * 255), perc * 255, 0, 255)

  draw.RoundedBoxOutlined( 2, x, y, w, h, Color(0, 0, 0, 90), Color(70,70,70,150) )
  draw.RoundedBoxOutlined( 2, x + 5, y + 5, math_clamp((w * perc) - 10, 3, w), h - 10, color, Color(50,50,50,150) )
end

local cached_mat = {}

function draw.DrawMaterial(material, x, y, w, h, color)
    if isstring(material) then
        local crc = util.CRC(material)
        if not cached_mat[crc] then
            cached_mat[crc] = mat(material, "smooth")
        end
        material = cached_mat[crc]
    end

    surface.SetDrawColor(color)
    surface.SetMaterial(material)
    surface.DrawTexturedRect(x, y, w, h)
end


function DrawWrappedText(text, x, y, font, color, maxWidth)
    surface.SetFont(font)
    local words = string.Split(text, " ")
    local currentLine = ""
    local lineHeight = select(2, surface.GetTextSize("A"))

    for _, word in ipairs(words) do
        local testLine = currentLine .. word .. " "
        local textWidth = surface.GetTextSize(testLine)

        if textWidth > maxWidth then
            draw.DrawText(currentLine, font, x, y, color)
            currentLine = word .. " "
            y = y + lineHeight 
        else
            currentLine = testLine
        end
    end
    draw.DrawText(currentLine, font, x, y, color)
end

auroria = {}
auroria.config = {}
auroria.config.relations = {}
auroria.color = {
    ["white80"] = Color(255,255,255,125),
    ["main2"] = Color(34,34,34,255),
    ["black75"] = Color(0,0,0,200),
    ["black80"] = Color(0,0,0,204),
    ["main"] = Color(36,36,36),
    ["main3"] = Color(24,24,24),
    ["color_miniwhite"] = Color(200,200,200),
    ["main45"] = Color(36,36,36, 114.75),
    ["red"] = Color(255, 63, 63),
    ["color_red"] = Color(255, 0, 0),
    ["red_bg"] = Color(167, 0, 0),
    ["green"] = Color(63, 255, 63),
    ["blue"] = Color(85, 193, 255),
    ["blue2"] = Color(0, 137, 215),
    ["dark_blue"] = Color(0, 57, 90),
    ["green_outline"] = Color(82, 255, 0),
    ["green_bg"] = Color(41, 160, 0),
    ["better_green"] = Color(113, 155, 103),
    ["orange"] = Color(235, 160, 0),
    ["better_yellow"] = Color(255, 190, 24),
    ["pink"] = Color(182,51,194),
    ["better_pink"] = Color(239,58,255),

    ["bad_blue"] = Color(79, 111, 212),
    ["bad_dark_blue"] = Color(0, 51, 156),

    ["better_black"] = Color(18, 18, 18),
    ["better_white"] = Color(73, 73, 73),

    ["green_gradientl"] = Color(2, 125, 0),
    ["green_gradientr"] = Color(3, 148, 0),

    ["blue_gradientl"] = Color(0, 132, 189),
    ["blue_gradientr"] = Color(0, 77, 148),

    ["red_gradientl"] = Color(255, 73, 73),
    ["red_gradientr"] = Color(148, 0, 0),

    ["dark_green"] = Color(0, 28, 23),
    ["light_green"] = Color(164, 255, 206)
}


auroria.material = {
    ["health"] =  mat( "auroria/icons/health.png", "noclamp smooth" ),
    ["armor"] =  mat( "auroria/icons/armor.png", "noclamp smooth" ),
    ["feed"] =  mat( "auroria/icons/feed.png", "noclamp smooth" ),
    ["mic"] =  mat( "auroria/icons/mic.png", "noclamp smooth" ),
    ["name"] =  mat( "auroria/icons/name.png", "noclamp smooth" ),
    ["job"] =  mat( "auroria/icons/job.png", "noclamp smooth" ),
    ["radio"] =  mat( "auroria/icons/radio.png", "noclamp smooth" ),
    ["bullet"] =  mat( "auroria/icons/bullet.png", "noclamp smooth" ),
    ["stamina"] =  mat( "auroria/icons/stamina.png", "noclamp smooth" ),
    ["warning"] =  mat( "auroria/icons/warning.png", "noclamp smooth" ),
    ["blood"] =  mat( "auroria/icons/blood.png", "noclamp smooth" ),
    ["skull"] =  mat( "auroria/icons/skull.png", "noclamp smooth" ),
    ["ellipse"] = mat( "auroria/icons/ellipse.png", "noclamp smooth"),
    ["star_white"] = mat( "auroria/ui_dodged.png", "noclamp smooth"),
    ["circle_unfilled"] = mat( "auroria/icons/circle_unfilled.png", "noclamp smooth"),
    ["user"] = mat("icons/user.png", "noclamp smooth"),
    ["chat"] = mat("auroria/icons/chat.png", "noclamp smooth"),
    ["level"] = mat("auroria/icons/level.png", "noclamp smooth"),
    ["bleeding"] = mat("auroria/icons/bleeding.png", "noclamp smooth"),
    ["brokenbone"] = mat("auroria/icons/brokenbone.png", "noclamp smooth"),

    ["cidcitizen"] =  mat( "auroria/cards/cidcitizen.png", "noclamp smooth" ),
    ["cidcp"] =  mat( "auroria/cards/cidcp.png", "noclamp smooth" ),
    ["cidcwu"] =  mat( "auroria/cards/cidcwu.png", "noclamp smooth" ),
    ["cidlow"] =  mat( "auroria/cards/cidlow.png", "noclamp smooth" ),
    ["cidmedic"] =  mat( "auroria/cards/cidmedic.png", "noclamp smooth" ),
    ["cidota"] =  mat( "auroria/cards/cidota.png", "noclamp smooth" ),

    ["alliance"] =  mat( "auroria/icons/alliance.png", "noclamp smooth" ),
    ["alliance_2"] =  mat( "auroria/icons/alliance_2.png", "noclamp smooth" ),
    ["bandit"] =  mat( "auroria/icons/bandits.png", "noclamp smooth" ),
    ["bandit_2"] =  mat( "auroria/icons/bandits_2.png", "noclamp smooth" ),
    ["citizen"] =  mat( "auroria/icons/what.png", "noclamp smooth" ),
    ["civil_admin"] =  mat( "auroria/icons/civil.png", "noclamp smooth" ),
    ["gro"] =  mat( "auroria/icons/gro.png", "noclamp smooth" ),
    ["gro_cook"] =  mat( "auroria/icons/cook.png", "noclamp smooth" ),
    ["lambda"] =  mat( "auroria/icons/lambda.png", "noclamp smooth" ),
    ["undenfiend"] =  mat( "auroria/icons/gun.png", "noclamp smooth" ),
    ["background"] =  mat( "bg/job.png", "noclamp smooth" ),

    ["close"] =  mat( "auroria/icons/close.png", "noclamp smooth" ),
    ["star"] =  mat( "auroria/icons/star.png", "noclamp smooth" ),
    ["check"] =  mat( "auroria/icons/check.png", "noclamp smooth" ),
    ["arrow"] =  mat( "auroria/icons/arrow.png", "noclamp smooth" ),
    ["what"] =  mat( "auroria/icons/quest.png", "noclamp smooth" ),

    -- Донат
    ["gold"] =  mat( "auroria/icons/gold.png", "noclamp smooth" ),
    ["gold_bars"] =  mat( "auroria/icons/gold_bars.png", "noclamp smooth" ),
    ["gold_bar"] =  mat( "auroria/icons/gold_bar.png", "noclamp smooth" ),

    ["overlay"] =  mat( "bg/terminal.jpg", "noclamp smooth" ),
    ["gradient-u"] =  mat( "vgui/gradient-u", "noclamp smooth" ),
    ["gradient-up"] =  mat( "vgui/gradient_up", "noclamp smooth" ),

    ["gradient-l"] =  mat( "vgui/gradient-r", "noclamp smooth" ),
    ["gradient-r"] =  mat( "vgui/gradient-l", "noclamp smooth" ),

    --Icons
    ["management"] =  mat( "auroria/icons/management.png", "noclamp smooth" ),
    ["materials"] =  mat( "auroria/icons/materials.png", "noclamp smooth" ),
    ["speed"] =  mat( "auroria/icons/speed.png", "noclamp smooth" ),
    ["sound"] =  mat( "auroria/icons/sound.png", "noclamp smooth" ),
    ["cooler"] =  mat( "auroria/icons/cooler.png", "noclamp smooth" ),
    ["inventory"] =  mat( "auroria/icons/inventory.png", "noclamp smooth" ),

    ["logo"] =  mat( "auroria/material_zvezda.png", "noclamp smooth" ),

}
