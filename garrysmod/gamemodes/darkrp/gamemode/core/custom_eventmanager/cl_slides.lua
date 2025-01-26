scene_start = {
    {
        material = Material("materials/retrime_orange/credits/start.png"),
        duration = 20,
        text = [[Была обычная война. Сопротивление, как всегда, совершало набеги на альянс.... Практически все они были безуспешными... И в обычный день произошло то, чего никто не мог предугадать....]],
        -- fake = true,
        isend = true
    }
    -- {
    --     material = Material("materials/retrime/event/start/S_01.png"),
    --     duration = 2,
    --     text = [[]]
    -- },
    -- {
    --     material = Material("materials/retrime/event/start/S_02.png"),
    --     duration = 2,
    --     text = [[]],
    --     isend = true
    -- }
}

scene_end = {
    {
        material = Material(""),
        duration = 1,
        text = [[]],
        fake = true,
    },
    {
        material = Material("materials/retrime_orange/credits/start.png"),
        duration = 10,
        text = [[В течении долгого времени шла ожесточённая война на уничтожение каждой из сторон конфликта, одни теряли других, потери росли в разы. И победа была уже близка, но Альянс поступил довольно дерзко - сбросил атомную бомбу на С82.]],
        -- fake = true,
        -- isend = true
    },
    {
        material = Material("materials/retrime_orange/credits/soldier.png"),
        duration = 20,
        text = [[Если военное командование и солдаты не могут справиться с угрозой Сопротивления, Оружие Массового Уничтожения всегда решит данную проблему. И вот произошёл сброс и все увидели вспышку! И вот он, конец бытия, жизнь казалось закончилась, но неожиданно.. Я снова оказался в городе, рядом были бойцы и появился... Снег! ]],
        -- fake = true,
        -- isend = true
    },
    {
        material = Material("materials/retrime_orange/credits/end.png"),
        duration = 20,
        text = [[Я и другие бойцы не понимали, что происходит, только что на своих глазах мы видели, как взорвалась бомба и уже прощались со своими жизнями, но видимо судьба решила дать нам иной шанс на будущее. Вопрос теперь стоит по-другому - что сейчас?]],
    },
    {
        material = Material("materials/retrime_orange/credits/winter.png"),
        duration = 10,
        text = [[Поскольку война осталась позади, а судьба наших врагов остаётся неизвестной, нам нужно идти дальше и найти выход из данного места, чего бы он не стоил!]],
        lastslide = true,
        isend = true
    },
}

local currentSlide = 1
local nextSlide = 2
local transitionDuration = 3
local lastSwitchTime = CurTime()
local isTransitioning = false
local transitionStartTime = 0
local fadeDuration = 1 -- Длительность фейда текста
local function WrapText(text, font, maxWidth)
    local lines = {}
    surface.SetFont(font)
    local words = string.Explode(" ", text)
    local currentLine = ""
    for _, word in ipairs(words) do
        local testLine = currentLine .. (currentLine == "" and "" or " ") .. word
        local lineWidth, _ = surface.GetTextSize(testLine)
        if lineWidth > maxWidth then
            table.insert(lines, currentLine)
            currentLine = word
        else
            currentLine = testLine
        end
    end

    if currentLine ~= "" then table.insert(lines, currentLine) end
    return lines
end

function EM_StartSlides(slides)
    hook.Add("DrawOverlay", "SlideShowEffect", function()
        local screenWidth = ScrW()
        local screenHeight = ScrH()
        local currentTime = CurTime()
        draw.RoundedBox(0, 0, 0, screenWidth, screenHeight, Color(0, 0, 0))
        surface.PlaySound('retrime/radio/credits.mp3')
        if isTransitioning then
            local elapsedTime = currentTime - transitionStartTime
            local progress = math.Clamp(elapsedTime / transitionDuration, 0, 1)
            local easedProgress = math.ease.InOutElastic(progress)
            if not slides[currentSlide].fake then -- Отрисовка текущего слайда, который уходит вверх
                surface.SetMaterial(slides[currentSlide].material)
                surface.SetDrawColor(255, 255, 255, 255 * (1 - easedProgress))
                surface.DrawTexturedRect(0, -easedProgress * screenHeight, screenWidth, screenHeight)
            end

            nextSlide = currentSlide % #slides + 1 -- Следующий слайд, который появляется сверху
            if slides[nextSlide].isend then
                timer.Simple(slides[nextSlide].duration + 2, function()
                    hook.Remove("DrawOverlay", "SlideShowEffect")
                    if slides[nextSlide].lastslide then net.Start("StartEnd") net.SendToServer() end
                end)
            end

            surface.SetMaterial(slides[nextSlide].material)
            surface.SetDrawColor(255, 255, 255, 255 * easedProgress)
            surface.DrawTexturedRect(0, -screenHeight * (1 - easedProgress), screenWidth, screenHeight)
            if progress >= 1 then
                currentSlide = nextSlide
                isTransitioning = false
                lastSwitchTime = currentTime
            end
        else
            if not slides[currentSlide].fake then
                surface.SetMaterial(slides[currentSlide].material) -- Показ текущего слайда без анимации
                surface.SetDrawColor(255, 255, 255, 255)
                surface.DrawTexturedRect(0, 0, screenWidth, screenHeight)
                local font = "EM:WrapText" -- Отображение текста
                local textWidth = screenWidth - 2 * 50
                local lines = WrapText(slides[currentSlide].text, font, textWidth)
                local textHeight = 0
                for i, line in ipairs(lines) do
                    local _, lineHeight = surface.GetTextSize(line)
                    textHeight = textHeight + lineHeight
                end

                local yOffset = screenHeight - textHeight - 50
                local fadeInStart = lastSwitchTime -- Вычисление альфа-канала текста
                local fadeOutStart = lastSwitchTime + slides[currentSlide].duration - fadeDuration
                local fadeEnd = lastSwitchTime + slides[currentSlide].duration
                local alpha = 255
                if currentTime < fadeInStart then
                    alpha = 0
                elseif currentTime < fadeOutStart then
                    alpha = Lerp((currentTime - fadeInStart) / fadeDuration, 0, 255)
                elseif currentTime < fadeEnd then
                    alpha = Lerp((currentTime - fadeOutStart) / fadeDuration, 255, 0)
                else
                    alpha = 0
                end

                local textColor = Color(255, 255, 255, alpha)
                for _, line in ipairs(lines) do
                    draw.DrawText(line, font, screenWidth / 2, yOffset, textColor, TEXT_ALIGN_CENTER)
                    local _, lineHeight = surface.GetTextSize(line)
                    yOffset = yOffset + lineHeight
                end
            end

            if currentTime - lastSwitchTime >= slides[currentSlide].duration then
                surface.PlaySound('retrime/change.mp3')

                isTransitioning = true
                transitionStartTime = currentTime
            end
        end
    end)
end