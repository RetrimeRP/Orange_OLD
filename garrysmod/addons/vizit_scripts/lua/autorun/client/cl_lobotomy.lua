sound.Add({
	name = "lobotomy_fire",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 80,
	pitch = {10, 255},
	sound = "lbtmy/lobotomy_2.wav"
})
sound.Add({
	name = "lobotomy_cry",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 80,
	pitch = {90, 100},
	sound = "lbtmy/lobotomy_cry.wav"
})
sound.Add({
	name = "lobotomy_sound1",
	channel = CHAN_STATIC,
	volume = 0.4,
	level = 80,
	pitch = {90, 255},
	sound = "lbtmy/lobotomy_1.wav"
})
sound.Add({
	name = "lobotomy_sound2",
	channel = CHAN_STATIC,
	volume = 0.4,
	level = 80,
	pitch = {90, 155},
	sound = "vo/npc/female01/pain03.wav"
})
sound.Add({
	name = "lobotomy_sound3",
	channel = CHAN_STATIC,
	volume = 0.4,
	level = 80,
	pitch = {90, 155},
	sound = "vo/npc/female01/pain04.wav"
})
sound.Add({
	name = "lobotomy_sound4",
	channel = CHAN_STATIC,
	volume = 0.4,
	level = 80,
	pitch = {90, 155},
	sound = "vo/npc/female01/pain05.wav"
})

local sounds = {
    "lobotomy_fire",
    "lobotomy_cry",
    "lobotomy_sound1",
    "lobotomy_sound2",
    "lobotomy_sound3"
}

local texts = {
    "Спокойстив... но... но это чтото... нет... о нет...",
    "Голва... ттяжело... очень... мир ломиццаа...",
    "Тепл...нет...горячо...МЫсли... куда... куда... они уходят...",
    "ЧЁРНый...бесконечност... мозг... растворяецца...",
    "Эти звуки... или нет... нет звуков? Кто-то... я... я есть???",
    "Руки... нет... есть... но я... не чуствую... себя...",
    "Все... разлетаеца... слова... они... безсмыслом...",
    "Мысли... гдебыли...почему... пусто... темнота...",
    "Эта тишина... она... она... гдето... или только вглове?",
    "ЧЯСТИ... МЕНЯ... растикаютса... зачем это... происходит?",
    "Холод... темно... пусто... ничег... я...кто?",
    "Память... тёкёт... убегает... нет нет нет нет..."
}
local thirdPersonTexts = {
    "Человек дергается, лицо искажено болью.",
    "Выражение паники, он теряет контроль.",
    "Его глаза тускнеют, он теряет ориентиры.",
    "Движения хаотичные, голос теряет чёткость.",
    "Он бормочет, тело сливается с мраком."
}

CreateClientConVar("ret_lobotomia","0",true)

local clr = Color(8, 8, 8)



local function lobotomyStart(time,tab)
    local blackScreen = vgui.Create("EditablePanel")
    blackScreen:Dock(FILL)
    blackScreen:SetAlpha(0)
    blackScreen:AlphaTo(240, 0.4)
    function blackScreen:Paint(ww, hh)
        draw.RoundedBox(0, 0, 0, ww, hh, clr)
    end

    timer.Create("randomText", 2, time, function()
        chat.AddText(ColorRand(false), texts[math.random(1, #texts)])
        LocalPlayer():EmitSound(sounds[math.random(1, #sounds)])
        if GetConVar("ret_lobotomia"):GetInt() == 1 then
            clr = Color(255, 255, 255)
            blackScreen:SetAlpha(255)
            blackScreen:AlphaTo(150, 0.4, 0, function()
                blackScreen:SetAlpha(255)
                clr = Color(8, 8, 8)
                blackScreen:AlphaTo(240, 0.4)
            end)
        else
            blackScreen:SetAlpha(math.random(180,255))
            blackScreen:AlphaTo(math.random(180,255),0.4)
        end
    end)

    RunConsoleCommand("say", "/it " .. thirdPersonTexts[math.random(1, #thirdPersonTexts)])

    timer.Simple(time, function()
        if IsValid(blackScreen) then
            blackScreen:Remove()
        end
        if timer.Exists("randomText") then
            timer.Remove("randomText")
        end
        if timer.Exists("invertMouseTimer") then
            timer.Remove("invertMouseTimer")
        end
    end)
end
net.Receive("LOBOTOMY_START", function()
    local tab = player.GetAll()
    local time = net.ReadInt(10)
    lobotomyStart(time,tab)
end)
