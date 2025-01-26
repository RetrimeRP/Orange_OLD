AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
    self:SetModel("models/ogl/ogl_skeypad.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local physObj = self:GetPhysicsObject()
    if (physObj:IsValid()) then
        physObj:Wake()
    end

    self:SetBodygroup(2, 1)

    self.Buffer = ""
    if sKeypads.Config.nocollide then
        timer.Simple(0.2,function()
            self:SetCollisionGroup(COLLISION_GROUP_WORLD)
        end)
    end
    if not WireLib then return end
    self.Outputs = Wire_CreateOutputs(self, {"success", "fail"})
end

function ENT:SetMeta(meta)
    self.meta = meta
end

function ENT:GetMeta()
    return self.meta
end

function ENT:DeployCracker(ply, time, wepClass)
    if IsValid(self.Cracker) then
        self.Cracker:Remove()
    end

    self:BlockInput(time)

    self.Cracker = ents.Create("skeypad_cracker")
    self.Cracker:SetParent(self)

    local angles = self:GetAngles()
    angles:RotateAroundAxis(angles:Right(), 90)
    angles:RotateAroundAxis(angles:Up(), math.random(2, 7))

    self.Cracker:SetPos(self:GetPos() + angles:Forward() * (6 + math.Rand(.2, .7)) - angles:Right() * .8)
    self.Cracker:SetAngles(angles)
    self.Cracker:Spawn()
    self.Cracker:SetCollisionGroup(COLLISION_GROUP_WORLD)

    self:StartCrackEffects(time)

    timer.Simple(time, function()
        if IsValid(ply) and ply:Alive() then
            ply:Give(wepClass)
        end

        if not IsValid(self) then return end
        self:Process(true, ply)

        if not IsValid(self.Cracker) then return end
        self.Cracker:Remove()
    end)
end

local crackingSound = Sound("buttons/blip2.wav")
local sparkingSound = Sound("weapons/stunstick/spark1.wav")

local screenGlitches = {
    "#1/?",
    "\\/*6",
    ".{#0",
    "8--D",
    "6910",
    ".420#",
    "1337",
    ":'3'",
    ";.)5",
    "}*%$",
    "$&£%",
    "-@:.",
    "_UwU"
}

function ENT:StartCrackEffects(time)
    timer.Create("sKeypads.Cracker.Glitching:" .. self:EntIndex(), .1, time * 10, function()
        if not IsValid(self) then return end

        self:SetScreenText(screenGlitches[math.random(1, #screenGlitches)])
    end)

    timer.Create("sKeypads.Cracker.Sparking:" .. self:EntIndex(), 2.4, time * .3, function()
        if not IsValid(self) then return end

        local effectdata = EffectData()
        effectdata:SetOrigin(self:GetPos())
        effectdata:SetMagnitude(2)
        util.Effect("ElectricSpark", effectdata, true, true)

        self:EmitSound(sparkingSound, 60, 100 + math.Rand(-10, 10))
    end)

    timer.Create("sKeypads.Cracker.Sounds:" .. self:EntIndex(), 1, time, function()
        if not IsValid(self) then return end

        self:EmitSound(crackingSound, 100, 100)
    end)
end

function ENT:StopCrackEffects()
    timer.Remove("sKeypads.Cracker.Glitching:" .. self:EntIndex())
    timer.Remove("sKeypads.Cracker.Sparking:" .. self:EntIndex())
    timer.Remove("sKeypads.Cracker.Sounds:" .. self:EntIndex())

    self:ClearScreen()
end

function ENT:Process(granted, ply, timeOverride)
    if not (ply and IsValid(ply)) then return end

    local meta = self:GetMeta()
    local time = 0

    if granted then
        time = timeOverride or meta:getFadingTime()

        self:EmitSound("sKeypads.Beep_Success")
        self:BlockInput(time)
        meta:executeSuccess(ply)

        self:SetIsOpen(true)

        sKeypads.Utils.RunHook("SuccessfulAttempt", ply, self)
    else
        time = timeOverride or 2

        self:EmitSound("sKeypads.Beep_Error")
        self:BlockInput(time)
        meta:executeFail(ply)

        sKeypads.Utils.RunHook("UnuccessfulAttempt", ply, self)
    end

    self:ClearScreen(time)
end

function ENT:OnRemove()
    local meta = self:GetMeta()
    if not meta then return end
    meta:getOwner():sKeypadsRemoveKeypad(self:EntIndex())
end

function ENT:BlockInput(time)
    self:SetInputBlocked(true)

    timer.Simple(time, function()
        if not IsValid(self) then return end
        self:SetInputBlocked(false)
    end)
end

function ENT:WaitForAnim(func, time)
    timer.Simple(time or 0.15, function()
        if not IsValid(self) then return end
        func()
    end)
end

function ENT:ClearScreen(time)
    self:SetScreenText("----")
    self:BlockInput(time or .5)
    self:WaitForAnim(function()
        self:SetBuffer("")
        self:SetIsOpen(false)
    end, time or .5)
end

function ENT:HandleButtonPress(ply, btn)
    if not btn then return end
    local meta = self:GetMeta()

    if btn == "fingerprint" then
        self:Process(meta:canFingerPrintOpen(ply), ply)
        return
    end

    if btn == "clear" then
        self:ClearScreen(time)
        return
    end

    if btn != "enter" then
        self:HandleNumberPress(ply, btn)
        return
    end
    meta:enterKey(ply, btn)
    self:Process(meta:canOpen(self.Buffer), ply)
end

function ENT:HandleNumberPress(ply, btn)
    if self:GetMeta():isCoolingDown() then
        local effectData = EffectData()
        effectData:SetOrigin(self:GetPos())
        effectData:SetNormal(self:GetAngles():Forward())
        effectData:SetMagnitude(30)
        util.Effect("ElectricSpark", effectData, true, true)
        return
    end

    self:GetMeta():enterKey(ply, btn)

    self:EmitSound("sKeypads.Beep_Keypress")

    if #self.Buffer >= 4 then
        self:ClearScreen()
        return
    end

    self:SetBuffer(self.Buffer .. btn)
end

function ENT:SetHiddenCharacters()
    local protectedBuffer = ""
    for i = 1, math.min(#self.Buffer, 4) do
        protectedBuffer = protectedBuffer .. "*"
    end
    self:SetScreenText(protectedBuffer)
end

function ENT:SetBuffer(str)
    self.Buffer = str

    if self:GetMeta():getProtected() then self:SetHiddenCharacters() return end
    self:SetScreenText(str)
end

function ENT:OnTakeDamage(dmg)
    local conf = sKeypads.Config
    if not conf.shootable_keypads then return end -- Not our issue.
    if not self:GetMeta():canIssueCooldown() then return end -- We're cooling down.

    if sKeypads.Utilities.correctDamageType(dmg:GetDamageType()) then
        local effectData = EffectData()
        effectData:SetOrigin(self:GetPos())
        effectData:SetNormal(self:GetAngles():Forward())
        effectData:SetScale(1)

        util.Effect("ElectricSpark", effectData, true, true)
        self:GetMeta():issueCooldown()
    end
end

net.Receive("sKeypads::PressKey", function(len, ply)
    local ent = net.ReadEntity()
    local key = net.ReadString()

    if not IsValid(ent) or ent:GetClass() != "skeypad" then return end
    if not ent.KeyRegions[key] then return end
    if ply:GetPos():DistToSqr(ent:GetPos()) > 100 ^ 2 then return end


    if ent:GetInputBlocked() then return end
    if ent.InputBlocked then return end

    ent:HandleButtonPress(ply, key)
end)

duplicator.RegisterEntityModifier("skeypad_data", function(ply, entity, data)
    local keypadMeta = sKeypads.Utilities.createNewButtonPad(entity)

    keypadMeta:setCode(data.code)
    keypadMeta:setTime(math.Clamp(data.time,sKeypads.Config.min_keypad_open_time, sKeypads.Config.max_keypad_open_time))
    keypadMeta:setMaterial(sKeypads.Materials.validateMaterial(data.material))
    keypadMeta:setAutoLock(tobool(data.autoLock))
    keypadMeta:setProtected(data.protected)
    keypadMeta:setKeyBinds(data.keybindSuccess, data.keybindFail)
    keypadMeta:setupWireOutput(data.wireOn, data.wireOff)
    keypadMeta:attachToEntity(data.attachedEntity)

    entity:CPPISetOwner(ply)
    entity:SetMeta(keypadMeta)
end)
