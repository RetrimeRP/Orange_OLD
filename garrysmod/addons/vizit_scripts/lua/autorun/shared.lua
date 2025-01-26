local FindMetaTable = FindMetaTable
local Material = Material
local cam_Start3D2D = CLIENT and cam.Start3D2D
local cam_End3D2D = CLIENT and cam.End3D2D
local render_SetStencilWriteMask = CLIENT and render.SetStencilWriteMask
local render_SetStencilTestMask = CLIENT and render.SetStencilTestMask
local render_SetStencilReferenceValue = CLIENT and render.SetStencilReferenceValue
local render_SetStencilPassOperation = CLIENT and render.SetStencilPassOperation
local render_SetStencilZFailOperation = CLIENT and render.SetStencilZFailOperation
local render_ClearStencil = CLIENT and render.ClearStencil
local render_SetStencilEnable = CLIENT and render.SetStencilEnable
local render_SetStencilCompareFunction = CLIENT and render.SetStencilCompareFunction
local render_SetStencilFailOperation = CLIENT and render.SetStencilFailOperation
local CreateClientConVar = CreateClientConVar
local plyMeta = FindMetaTable("Player")
local entMeta = FindMetaTable("Entity")
local clr = Color

VIZIT_SCRIPTS = VIZIT_SCRIPTS or {}
VIZIT_SCRIPTS.CaptureAmount = 5 -- Количество игроков для начала захвата
-- VIZIT_SCRIPTS.STANDART_TRIGGER_SIZE = Vector(50,50,50) -- Стандартный размер триггера
VIZIT_SCRIPTS.STANDART_FRACTIONS = { -- Фракции
    "NS - DOD",
    "Сопротивление",
    "Альянс",
    "Силы Коалиции и Самообороны", -- щит
    "Бандиты" -- фу фу фу
}

VIZIT_SCRIPTS.DOGOVOR = true   -- Договор между NS и сопротивлением

VIZIT_SCRIPTS.COLOR = {
   ["NS - DOD"] = clr(0,158,47), -- ns
   ["Сопротивление"] = clr(209,171,0), -- resistance
   ["Альянс"] = clr(0,75,238), -- aliance
   ["Бандиты"] = clr(122,122,21), -- bandits and cuckolds  
   ["Силы Коалиции и Самообороны"] = clr(8,175,119)
}

VIZIT_SCRIPTS.COLOR_VGUI = {
    clr(255, 255, 255),
    clr(243,46,46), -- redCapture
    clr(40,255,130) -- greenCapture
}

VIZIT_SCRIPTS.RANDOMWORDS = {
    ["NS - DOD"] = {
        "Код Омега",
        "Пророчество Единства",
        "Тёмная тропа",
        "Знак Судьбы",
        "Ритуал пробуждения",
        "Священный обряд",
        "Глас пророка",
        "Врата очищения",
        "Небесный завет",
        "Духовное единение",
        "Книга теней",
        "Печать изгнания",
        "Шёпот предков",
        "Осколок истины",
        "Храм забвения"
    },
    ["Сопротивление"] = {
        "Протокол Бета",
        "Сигнал надежды",
        "Баррикада свободы",
        "Голос революции",
        "Эхо справедливости",
        "Укрытие номер семь",
        "Штаб сопротивления",
        "Партизанский дозор",
        "Точка перелома",
        "Путь к освобождению",
        "Последний рубеж",
        "Фронтальная атака",
        "Операция 'Свобода'",
        "Щит народа",
        "Вызов тирану"
    },
    ["Альянс"] = {
        "Код Альфа",
        "Сканирование зоны",
        "Командный центр",
        "Гарнизон Вектор",
        "Патрульный пост",
        "Дроновый разведчик",
        "Сектор зачистки",
        "Лазерный маяк",
        "Программа подавления",
        "Блокировка территории",
        "Сигнал тревоги",
        "Цель локализована",
        "Управление дроном",
        "Массивная атака",
        "Охранный комплекс"
    },
    ["Бандиты"] = {
        "Лагерь отступников",
        "Контрабандный склад",
        "Укрытие мародёров",
        "Чёрный рынок",
        "Воровская сходка",
        "Разбойничий дозор",
        "Точка налёта",
        "Погоня за наживой",
        "Тёмный переулок",
        "Подпольная операция",
        "Схрон контрабанды",
        "Бар 'Последний шанс'",
        "Район разборок",
        "Грабительский рейд",
        "Кодекс воров"
    },
    ["Силы Коалиции и Самообороны"] = {
        "Объединённый фронт",
        "Щит и меч",
        "Точка сопротивления",
        "Флаг свободы",
        "Гарнизон надежды",
        "Рота героев",
        "Союзный рубеж",
        "Секретный штаб",
        "Кодекс выживания",
        "Дружина воли",
        "Фронтовое братство",
        "Воплощение мира",
        "Точка единства",
        "Сердце оплота",
        "Эхо победы"
    }
}

function plyMeta:GetWords()
    local faction = self:ReturnFaction()
    -- print("ФРАКЦИЯ ИГРОКА: ", faction)
    return VIZIT_SCRIPTS.RANDOMWORDS[faction]
end


function plyMeta:AllowCapture() -- надо переписать, колхоз чутка
    return self:IsResistance() or self:IsGuild() or self:IsOTA() or self:IsMPF() or self:IsBandits()
end

function entMeta:CanCapture(ply)
    return ply:AllowCapture() and  self:GetCanCapture()
end

function plyMeta:ReturnFaction()
    local fractions = VIZIT_SCRIPTS.STANDART_FRACTIONS

    if self:IsResistance() or self:IsGuild() then
        if VIZIT_SCRIPTS.DOGOVOR then
            return fractions[4] -- NS-DOD + Сопротивление
        end
        return self:IsResistance() and fractions[2] or fractions[1] -- Сопротивление или NS-DOD
    elseif self:IsOTA() or self:IsMPF() then
        return fractions[3] -- Альянс
    elseif self:IsBandits() then
        return fractions[5] -- Бандиты
    end
end

function VIZIT_SCRIPTS.GetGroupColor(ply)
    local faction = ply:ReturnFaction()
    -- print("ФРАКЦИЯ ИГРОКА: ", faction)
    return VIZIT_SCRIPTS.COLOR[faction] or clr(99, 99, 99)
end

function VIZIT_SCRIPTS.GetPlayerTextForm(playerCount)
    local lastDigit = playerCount % 10
    local lastTwoDigits = playerCount % 100
    if lastTwoDigits >= 11 and lastTwoDigits <= 19 then
        return "человек"
    elseif lastDigit == 1 then
        return "человек"
    elseif lastDigit >= 2 and lastDigit <= 4 then
        return "человека"
    else
        return "человек"
    end
end


if not CLIENT then return end
local colorAlpha = ColorAlpha
local multi = surface.GetAlphaMultiplier
local function paintColor(val)
    return colorAlpha(val, multi() * 255)
end

local vgui_start = paint.startVGUI
local vgui_end = paint.endVGUI
local function startPaint(callback)
    vgui_start()
    callback()
    vgui_end()
end
local function lerpColor(t, from, to)
    return clr(
        (1 - t) * from.r + t * to.r,
        (1 - t) * from.g + t * to.g,
        (1 - t) * from.b + t * to.b,
        (1 - t) * from.a + t * to.a
    )
end

local cacheMaterial = {}
local function cacheMaterialFunc(material, val)
    if cacheMaterial[material] then return cacheMaterial[material] end
    val = val or "noclamp smooth"
    local mat = Material(material, val)
    cacheMaterial[material] = mat
    return mat
end

-- local cacheColors = {}
-- local function cacheColorsFunc(color, lepred)
--     return color
--         -- return color
--     -- else
--         -- if cacheColors[color] then return cacheColors[color] end
--         -- cacheColors[color] = color
--         -- return color
--     -- end
-- end

local function cam3D2D(pos, angle, scale, func)
    cam_Start3D2D(pos, angle, scale)
    func()
    cam_End3D2D()
end

local function vizitmask(funcMask, funcDraw)
    render_SetStencilWriteMask(0xFF)
    render_SetStencilTestMask(0xFF)
    render_SetStencilReferenceValue(0)
    render_SetStencilPassOperation(STENCIL_KEEP)
    render_SetStencilZFailOperation(STENCIL_KEEP)
    render_ClearStencil()
    render_SetStencilEnable(true)
    render_SetStencilReferenceValue(1)
    render_SetStencilCompareFunction(STENCIL_NEVER)
    render_SetStencilFailOperation(STENCIL_REPLACE)

    funcMask()

    render_SetStencilCompareFunction(STENCIL_EQUAL)
    render_SetStencilFailOperation(STENCIL_KEEP)

    funcDraw()
    render_SetStencilEnable(false)
end

VIZIT_SCRIPTS.lerpClr = lerpColor
VIZIT_SCRIPTS.cacheMaterial = cacheMaterialFunc
VIZIT_SCRIPTS.cacheColors = cacheColorsFunc
VIZIT_SCRIPTS.mask = vizitmask
VIZIT_SCRIPTS.cam3D2D = cam3D2D
VIZIT_SCRIPTS.paintColor = paintColor
VIZIT_SCRIPTS.startPaint = startPaint
CreateClientConVar("ret_points_show_borders",0,true,false,"Включает отображение полей точек",0,1)