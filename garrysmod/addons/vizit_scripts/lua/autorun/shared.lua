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

VIZIT_SCRIPTS.DOGOVOR = true    -- Договор между NS и сопротивлением
VIZIT_SCRIPTS.COOLDOWN = 40 -- кул даун, между началом захвата точек, типо захватил и кд на отхват 40 секунд
VIZIT_SCRIPTS.CAPTURETIME = 25 -- время на захват
VIZIT_SCRIPTS.COOLDOWNTIME = 600 -- Кулдаун на расторжение/заключение договоров
VIZIT_SCRIPTS.SOUNDFORALLIANCE = "npc/overwatch/cityvoice/fprison_contactlostlandsea.wav" -- поставь на nil, чтобы звука не было
VIZIT_SCRIPTS.COLOR = {
   ["NS - DOD"] = clr(0,158,47), -- ns
   ["Сопротивление"] = clr(209,171,0), -- resistance
   ["Альянс"] = clr(0,75,238), -- aliance
   ["Бандиты"] = clr(122,122,21), -- bandits and cuckolds  
   ["Силы Коалиции и Самообороны"] = clr(8,175,119)

}
VIZIT_SCRIPTS.MAXNAGRADA = 5000 -- максималья награда за захват точки
VIZIT_SCRIPTS.MINNAGRADA = 2000 -- минимальная
VIZIT_SCRIPTS.COLOR_VGUI = {
    clr(255, 255, 255),
    clr(243,46,46), -- redCapture
    clr(40,255,130), -- greenCapture
    clr(22,22,22),
    clr(41,41,41),
    --chequeColor
    clr(12,12,12)
}

VIZIT_SCRIPTS.RANDOMWORDS = {
    ["NS - DOD"] = {
        "Взламываем систему...",
        "Переподключаем терминал...",
        "Захватываем контрольный пункт...",
        "Перепрограммируем защитные системы...",
        "Обходим протоколы безопасности...",
        "Синхронизируемся с сетью...",
        "Запускаем вирус в базу данных...",
        "Открываем доступ к заблокированным файлам...",
        "Перенастраиваем систему наблюдения...",
        "Подключаемся к энергетическим узлам...",
        "Декодируем сообщения Альянса...",
        "Активируем автономные дроны...",
        "Включаем системы обороны на себя...",
        "Запираем врага в его же сети...",
        "Ломаем код доступа к главному серверу..."
    },
    ["Сопротивление"] = {
        "Отключаем камеры наблюдения...",
        "Захватываем контроль над терминалом...",
        "Запускаем сигнал тревоги в рядах врага...",
        "Переписываем коды доступа...",
        "Сбиваем связь с командованием...",
        "Меняем приоритеты боевых систем...",
        "Ложные команды отправлены...",
        "Перенаправляем ресурсы врага...",
        "Изменяем координаты авиаудара...",
        "Дезориентируем системы наведения...",
        "Включаем режим эвакуации вражеских солдат...",
        "Сбрасываем данные системы мониторинга...",
        "Перехватываем управление дронами...",
        "Деактивируем защитные турели...",
        "Блокируем экстренные протоколы Альянса..."
    },
    ["Бандиты"] = {
        "Крутим не ту кнопку...",
        "Бьём по терминалу кулаком...",
        "Эй, а чего он не включается?!",
        "Зачем столько проводов?!",
        "Разбираем терминал на запчасти...",
        "Случайно включаем сирену...",
        "Вытаскиваем все микросхемы подряд...",
        "Ломаем экран, потому что не понятно...",
        "Заливаем систему алкоголем...",
        "Тыкай во все кнопки, вдруг сработает...",
        "Короткое замыкание? Само так вышло!",
        "Разбираем всю панель управления...",
        "Продаём детали терминала на чёрном рынке...",
        "Терминал взорвался? Это не мы!",
        "Случайно открыли двери вражеской базы..."
    },
    ["Альянс"] = {
        "Перезапускаем терминал...",
        "Восстанавливаем контроль над системой...",
        "Очищаем систему от взлома...",
        "Переподключаем оборонительные сети...",
        "Сканируем на наличие угроз...",
        "Перепрограммируем защитные протоколы...",
        "Закрываем несанкционированный доступ...",
        "Откатываем систему до стабильной версии...",
        "Обновляем ключи безопасности...",
        "Очищаем базу данных от вредоносного кода...",
        "Заменяем скомпрометированные пароли...",
        "Блокируем вражеские команды...",
        "Восстанавливаем сеть связи...",
        "Фиксируем ошибки в системе...",
        "Возвращаем контроль над дронами...",
        "Настраиваем защитные турели...",
        "Перекрываем пути взлома...",
        "Проверяем логи на вмешательство...",
        "Перезаписываем коды доступа...",
        "Проводим диагностику системы...",
        "Обновляем ПО терминалов...",
        "Запускаем аварийный перезапуск...",
        "Локализуем вражеский вирус...",
        "Ограничиваем права доступа врага...",
        "Запечатываем систему от повторного взлома..."
    },
    ["Силы Коалиции и Самообороны"] = {
        "Проникаем в систему врага...",
        "Захватываем все точки...",
        "Настраиваем систему обороны...",
        "Взламываем терминал за секунды...",
        "Устанавливаем защитный протокол...",
        "Меняем маршрут вражеских патрулей...",
        "Деактивируем системы перехвата...",
        "Переподключаем турели на нас...",
        "Адаптируем технологии Альянса...",
        "Запускаем контрмеры против хакеров...",
        "Контролируем все узлы связи...",
        "Запираем врага в его же базе...",
        "Перекрываем пути отхода...",
        "Зачищаем терминалы от вирусов...",
        "Держим полный контроль над сетью..."
    }
}


function plyMeta:GetWords()
    local faction = self:ReturnFaction()
    -- print("ФРАКЦИЯ ИГРОКА: ", faction)
    return VIZIT_SCRIPTS.RANDOMWORDS[faction]
end

function plyMeta:ReturnFaction()
    local fractions = VIZIT_SCRIPTS.STANDART_FRACTIONS
    if VIZIT_SCRIPTS.DOGOVOR and self:IsResistance() or VIZIT_SCRIPTS.DOGOVOR and self:IsGuild() then
        return fractions[4] -- NS-DOD + Сопротивление
    elseif self:IsResistance() then
        return fractions[2]
    elseif self:IsGuild() then
        return fractions[1]
    elseif self:IsOTA() or self:IsMPF() then
        return fractions[3] -- Альянс
    elseif self:IsBandits() then
        return fractions[5] -- Бандиты
    end
end

function plyMeta:AllowCapture() -- надо переписать, колхоз чутка
    return self:IsResistance() or self:IsGuild() or self:IsOTA() or self:IsMPF() or self:IsBandits()
end

function entMeta:CanCapture(ply)
    return ply:AllowCapture() and self:GetCanCapture() and self:GetWhoCapture() ~= ply:ReturnFaction()
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

--[[
[Текст песни «Зомби апокалипсис»]

[Интро: СЕРЕГА ПИРАТ]
Эта история про то, как я попал в зомби апокалипсис
Выживал среди зомбаков
Выживал среди зомбаков
Выживал среди зомбаков

[Куплет 1: СЕРЕГА ПИРАТ]
Я катаюсь на пикапе (Е, е)
Никого вокруг нет (Нет, нет)
Только парочка взрывчаток (У-у, у)
У меня в багажнике, е, е, е (У)

[Припев: СЕРЕГА ПИРАТ]
И злобных зомби, е
Кругом безумие
Я будто бы во сне
Мой дом весь в огне
Они чуют запах, идут сюда
Они очень скоро съедят меня

[Постприпев: СЕРЕГА ПИРАТ]
Выживал среди зомбаков
Выживал среди зомбаков
You might also like
Не сей любовь (Don’t Plant Love)
DK
Ринопластика (Surgery)
9mice & Kai Angel
Адская колыбельная (Infernal Lullaby)
Пошлая Молли (Poshlaya Molly)
[Куплет 2: qeqoqeq]
У этой зомбячки отличная попка
Укусит за член — будет неловко
Зашёл в магазин, взял очочечки Prada
Жизнь удалась — мне больше не надо
Слышу рык с под стола
Подруга, не надо, ты будешь мертва
Достал пистолет, но я не попал
Укусила за член, и я упал (У)

[Припев: СЕРЕГА ПИРАТ]
И вот я зомби, я полон безумия
Я будто бы во сне, мой дом весь в огне
Я чую твой запах, иду туда
И я очень скоро найду тебя

[Постприпев: СЕРЕГА ПИРАТ]
Выживал среди зомбаков
Выживал среди зомбаков

[Бридж: СЕРЕГА ПИРАТ]
И, и я погиб
И я погиб (Гр-ра, гр-ра, гр-ра, гр-ра)
И я погиб (Дайте мне мозги, гр-ра)
И я погиб (Гр-ра, дай мозги, сука, я хочу поесть)
И я погиб (Гр-ра, гр-ра, гр-ра, дай мозги)
И я погиб
[Куплет 3: СЕРЕГА ПИРАТ]
Разрываю тебя на части
Твоя смерть — это моё счастье (И я погиб)
Я съедаю твоё запястье
Ты же знал, что здесь опасно (И я погиб)

[Аутро: СЕРЕГА ПИРАТ]
Среди зомбаков
(И я погиб)
Среди зомбаков
(И я погиб)
Среди зомбаков
(И я погиб)
Среди зомбаков
]]