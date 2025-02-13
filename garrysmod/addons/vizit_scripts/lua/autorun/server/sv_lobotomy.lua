local soundsTable = {
    "npc/fast_zombie/fz_scream1.wav",
    "npc/zombie/zombie_pain1.wav",
    "npc/zombie/zombie_pain4.wav",
    "npc/zombie/zombie_pain6.wav",
    "npc/zombie_poison/pz_pain3.wav",
    "ambient/voices/cough1.wav",
    "ambient/voices/cough2.wav",
    "ambient/voices/cough3.wav",
    "ambient/voices/cough4.wav"
}
local animationsTable = {
    ACT_GMOD_GESTURE_RANGE_ZOMBIE,
    ACT_GMOD_GESTURE_TAUNT_ZOMBIE,
    ACT_MELEE_ATTACK1,
    ACT_MELEE_ATTACK2
}
util.AddNetworkString("LOBOTOMY_START")
util.AddNetworkString("LOBOTOMY_END")
local max = 20
local function punchScreen(ply)
    if not IsValid(ply) then return end

    local punch = Angle(math.Rand(-max, max), math.Rand(-max, max), math.Rand(-max, max))
    ply:ViewPunch(punch)
end

function playSounds(ply,time)
    local textPly = tostring(ply)
    net.Start("LOBOTOMY_START")
    net.WriteInt(time,10)
    net.Send(ply)
    for _, wep in ipairs(ply:GetWeapons()) do
        if not string.find(wep:GetClass(), "cuff") then
            ply:StripWeapon(wep:GetClass())
        end
    end
    timer.Create("lobotomy_" .. textPly, 2, time, function()
        if IsValid(ply) and ply:Alive() then
            ply:EmitSound(soundsTable[math.random(1, #soundsTable)])
            ply:DoAnimationEvent(animationsTable[math.random(1,#animationsTable)])
            ply:SetWalkSpeed(math.random(10,150))
            ply:SetRunSpeed(math.random(10,150))
            punchScreen(ply)
        end
        ply.lobotomia = true
    end)
    timer.Create("LOBOTOMY_DEATH_" .. textPly,time,1,function()
        if IsValid(ply) and ply:Alive() then
            ply:ConCommand("say /it Человек падает замертво, мертв. ")
            ply:SetWalkSpeed(ply:GetWalkSpeed())
            timer.Simple(0.3,function()
                ply:Kill()
                ply.lobotomia = false
            end)
        end
        if timer.Exists("lobotomy_" .. textPly) then
            timer.Remove("lobotomy_" .. textPly)
        end
    end)
end
local replacements = { ["a"] = "@", ["e"] = "3", ["i"] = "1", ["o"] = "0", ["s"] = "$" }

hook.Add("PlayerSay", "CoinFlip", function(ply, text)
    if string.find(text, "/it") or string.find(text,"/me") then
        return text
    end

    if ply.lobotomia then
        local modifiedText = ""

        for i = 1, utf8.len(text) do
            local char = utf8.sub(text, i, i)
            local choice = math.random(1, 4)

            if choice == 1 then
                local repetitions = math.random(1, 4)
                modifiedText = modifiedText .. string.rep(char .. " ", repetitions)
            elseif choice == 2 then

                local lowerChar = char:lower()
                if replacements[lowerChar] then
                    modifiedText = modifiedText .. replacements[lowerChar]
                else
                    modifiedText = modifiedText .. char
                end
            elseif choice == 3 then
                if math.random(1, 2) == 1 then
                    modifiedText = modifiedText .. string.upper(char)
                else
                    modifiedText = modifiedText .. string.lower(char)
                end
            elseif choice == 4 then
                local randomSymbols = {
                    "з", "а", "л", "блять", "нахуй", "гандон", "хуй", 
                    "ебать", "пизда", "сука", "шлюха", "мудило", 
                    "альянс", "союз", "герой", "победа", "война", 
                    "честь", "защитник", "воин", "сила", "судьба", 
                    "лоботомия", "мозг", "хирургия", "нейрохирург", 
                    "операция", "разделение", "мозговая функция", "интервенция", "манипуляция",
                    "победить врага", "героическая война", "союз силы", "честь защиты", 
                    "мозговая операция", "мудило с храбростью", "судьба в битве", 
                    "сила хирурга", "разделение умов", "нейрохирургическая интервенция", 
                    "сила победы", "герой лоботомии", "воин защиты", "манипуляции с разумом",
                    "сперма"
                }
                modifiedText = modifiedText .. char .. randomSymbols[math.random(1, #randomSymbols)]
            end
        end

        local finalText = ""
        for i = 1, utf8.len(modifiedText) do
            local c = utf8.sub(modifiedText, i, i)
            if math.random(1, 2) == 1 then
                finalText = finalText .. string.upper(c)
            else
                finalText = finalText .. string.lower(c)
            end
        end

        return finalText
    end
    return text
end)
