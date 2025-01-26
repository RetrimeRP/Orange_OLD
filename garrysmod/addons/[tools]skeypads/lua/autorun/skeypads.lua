sKeypads = {}


-- Fucking hyrogenic. I'm really not happy.
function sKeypads.printToClient(msg)
    if CLIENT then return end
    BroadcastLua([[print("]] .. msg .. [[")]])
end

function sKeypads.LoadDirectory(dir)
    local fil, fol = file.Find(dir .. "/*", "LUA")
    for k,v in pairs(fol) do
        sKeypads.LoadDirectory(dir .. "/" .. v)
    end
    for k,v in ipairs(fil) do
        local dirs = dir .. "/" .. v
        if v:StartWith("cl_") then
            if SERVER then
                AddCSLuaFile(dirs)
            else
                include(dirs)
            end
        elseif v:StartWith("sh_") then
            AddCSLuaFile(dirs)
            include(dirs)
        else
            if SERVER then
                include(dirs)
            end
        end
    end
end
sKeypads.LoadDirectory("skeypads")

timer.Simple(1, function()
    if sKeypads.Config.keypads_crackers then
        local baseKeyPad = {}
        for k,v in pairs(weapons.GetList()) do
            if v.ClassName == "skeypad_cracker_base" then baseKeyPad = v end
        end

        sKeypads.Utils.assert(baseKeyPad ~= {} && baseKeyPad ~= nil, "You've changed the name of the base keypad, don't do that.")

        for k,v in pairs(sKeypads.Config.keypads_crackers) do
            local newKeypad = table.Copy(weapons.GetStored( "skeypad_cracker_base" ))
            sKeypads.Utils.assert(isbool(v.deployable), "Invalid deployable state for keypad cracker.")
            newKeypad.Deployable = v.deployable
            sKeypads.Utils.assert(isnumber(v.time), "Invalid time for keypad cracker.")
            newKeypad.CrackTime = v.time
            sKeypads.Utils.assert(isstring(v.name), "Invalid name for keypad cracker.")
            newKeypad.PrintName = v.name
            sKeypads.Utils.assert(isstring(v.class_name), "Invalid class name for keypad cracker.")
            newKeypad.Spawnable = true
            print(v.class_name)
            weapons.Register(newKeypad, v.class_name)
        end
    end
end)

if SERVER then
    resource.AddWorkshop("2133246824")
end

--[[ Register Sounds ]]--

local soundLevel = 70

sound.Add({
    name = "sKeypads.Beep_Keypress",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = soundLevel,
    pitch = 100,
    sound = sKeypads.Config.sounds.press or "skeypads/beep_keypress.mp3"
})

sound.Add({
    name = "sKeypads.Beep_Success",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = soundLevel,
    pitch = 100,
    sound = sKeypads.Config.sounds.success or "skeypads/beep_success.mp3"
})

sound.Add({
    name = "sKeypads.Beep_Error",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = soundLevel,
    pitch = 100,
    sound = sKeypads.Config.sounds.error or "skeypads/beep_error.mp3"
})
-------------------------

hook.Add("libgmodstore_init","7243_libgmodstore",function()
    libgmodstore:InitScript(7243, "Superior Keypads", {
        version = "2.5.10",
        licensee = "76561198427344474",
        tracker = "09f0706764fc607b1f75f6d223b1e180b2235e354a5f16e871659effc9f28f43"
    })
end)


print("__Loaded__ Superior Keypads.")
for k,v in pairs(player.GetAll()) do

    v:Give("skeypad_cracker_base")
end
