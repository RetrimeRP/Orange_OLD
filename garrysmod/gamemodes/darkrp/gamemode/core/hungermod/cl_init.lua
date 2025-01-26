local cvars = cvars
local draw = draw
local hook = hook
local math = math
local table = table
local timer = timer
local Color = Color
local ColorAlpha = ColorAlpha
local CreateClientConVar = CreateClientConVar
local GetConVar = GetConVar
local ipairs = ipairs
local pairs = pairs
local unpack = unpack

local ConVars = {
        HungerBackground = {0, 0, 0, 255},
        HungerForeground = {30, 30, 120, 255},
        HungerPercentageText = {255, 255, 255, 255},
        StarvingText = {200, 0, 0, 255},
        FoodEatenBackground = {0, 0, 0}, -- No alpha
        FoodEatenForeground = {20, 100, 20} -- No alpha
    }
local HUDWidth = 0

local FoodAteAlpha = -1
local FoodAteY = 0

surface.CreateFont("HungerPlus", {
    size = 70,
    weight = 500,
    antialias = true,
    shadow = false,
    font = "ChatFont"})

local function ReloadConVars()
    for name, Colour in pairs(ConVars) do
        ConVars[name] = {}
        for num, rgb in ipairs(Colour) do
            local ConVarName = name .. num
            local CVar = GetConVar(ConVarName) or CreateClientConVar(ConVarName, rgb, true, false)
            table.insert(ConVars[name], CVar:GetInt())

            if not cvars.GetConVarCallbacks(ConVarName, false) then
                cvars.AddChangeCallback(ConVarName, function() timer.Simple(0, ReloadConVars) end)
            end
        end
        ConVars[name] = Color(unpack(ConVars[name]))
    end

    if HUDWidth == 0 then
        HUDWidth = 240
        cvars.AddChangeCallback("HudW", function() timer.Simple(0, ReloadConVars) end)
    end

    HUDWidth = GetConVar("HudW") and GetConVar("HudW"):GetInt() or 240
end
timer.Simple(0, ReloadConVars)

local function AteFoodIcon(msg)
    FoodAteAlpha = 1
    FoodAteY = ScrH() - 8
end
usermessage.Hook("AteFoodIcon", AteFoodIcon)
