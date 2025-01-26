
TOOL.Name = "#tool.skeypads.name"
TOOL.Category = sKeypads.Lang.systemName
TOOL.Desc = "#tool.skeypads.desc"
TOOL.Author = "Tom.bat & NoSharp"
TOOL.ConfigName = ""

TOOL.ClientConVar["password"] = "1234"
TOOL.ClientConVar["securemode"] = 1
TOOL.ClientConVar["output_type"] = "fadingdoor"
TOOL.ClientConVar["output_time"] = 5
TOOL.ClientConVar["fade_material"] = "models/shadertest/shader3"
TOOL.ClientConVar["key_success"] = 0
TOOL.ClientConVar["key_fail"] = 0
TOOL.ClientConVar["auto_lock"] = 0
TOOL.ClientConVar["wire_on"] = 1
TOOL.ClientConVar["wire_off"] = 0

cleanup.Register("skeypads")

if CLIENT then
    TOOL.Information = {
        {name = "left", stage = 0 }, --Select a fading door
        {name = "left_1", stage = 1}, --Click on a place to put the keypad
        {name = "left_2", stage = 2}, --Add fading door
        {name = "right", stage = 0 }, --Delete keypad
        {name = "right_1", stage = 1}, --Cancel placement
        {name = "right_2", stage = 2}, --Remove fading door
        {name = "reload", stage = 0}, --Update settings of keypad
        {name = "reload_2", stage = 2} --Exit fading door editor
    }

    language.Add("tool.skeypads.name", sKeypads.Lang.toolgunName)
    language.Add("tool.skeypads.desc", sKeypads.Lang.toolgunDescription)
    language.Add("tool.skeypads.left", sKeypads.Lang.toolgunSelectFadingDoor)
    language.Add("tool.skeypads.left_1", sKeypads.Lang.toolgunPlaceKeypad)
    language.Add("tool.skeypads.left_2", sKeypads.Lang.toolgunAddFadingDoor)
    language.Add("tool.skeypads.right", sKeypads.Lang.toolgunDeleteKeypad)
    language.Add("tool.skeypads.right_1", sKeypads.Lang.toolgunCancelPlacement)
    language.Add("tool.skeypads.right_2", sKeypads.Lang.toolgunRemoveFadingDoor)
    language.Add("tool.skeypads.reload", sKeypads.Lang.toolgunUpdateSettings)
    language.Add("tool.skeypads.reload_2", sKeypads.Lang.toolgunCancelEdit)


    language.Add("Undone_sKeypad", sKeypads.Lang.keypadUndone)
    language.Add("Cleanup_skeypads", sKeypads.Lang.keypadCleanupName)
    language.Add("Cleaned_skeypads", sKeypads.Lang.keypadCleanedUp)
    language.Add("SBoxLimit_skeypads", sKeypads.Lang.keypadReachedLimit)

    surface.CreateFont("sKeypads.ToolGun.Display", {
        font = "Roboto",
        size = 33,
        weight = 600,
        antialias = true
    })

    local backgroundCol = Color(50, 50, 50)
    local gradientMat = Material("gui/gradient_down")
    local hsvCol = HSVToColor

    TOOL.RainbowProg = 0
    function TOOL:DrawToolScreen(w, h)
        self.RainbowProg = self.RainbowProg + FrameTime() * 100

        surface.SetDrawColor(backgroundCol)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(hsvCol(self.RainbowProg / 4 % 360, 1, 1))
        surface.SetMaterial(gradientMat)
        surface.DrawTexturedRect(0, 0, w, h)

        draw.SimpleText(sKeypads.Lang.systemName, "sKeypads.ToolGun.Display", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    TOOL.BuildCPanel = sKeypads.BuildToolMenu

    function TOOL:UpdateGhost(ent, ply)
        if not IsValid(ent) then return end

        local pos, ang = self:GetKeypadPos(ent)
        if not (pos and ang) then
            ent:SetNoDraw(true)
            return
        end

        ent:SetAngles(ang)
        ent:SetPos(pos)
        ent:SetNoDraw(false)
    end

    function TOOL:Think()
        local ent = self.GhostEntity

        if self:GetStage() != 1 then
            if IsValid(ent) then self:ReleaseGhostEntity() end
            return
        end

        if not IsValid(ent) then
            self:MakeGhostEntity("models/ogl/ogl_skeypad.mdl", vector_origin, Angle())
        end

        self:UpdateGhost(self.GhostEntity, self:GetOwner())

        if IsValid(self.GhostEntity) then
            self.GhostEntity:SetBodygroup(2, 1)
        end
    end

    function TOOL:LeftClick(tr) return true end
    function TOOL:RightClick(tr) return true end
    function TOOL:Reload(tr) return self:GetStage() == 0 or self:GetStage() == 2 end
end

function TOOL:GetKeypadPos(ent)
    local tr = self:GetOwner():GetEyeTrace()
    if not tr.Hit or (IsValid(tr.Entity) and tr.Entity:IsPlayer()) then return false end

    local ang = tr.HitNormal:Angle()
    ang:RotateAroundAxis(ang:Up(), 180)

    return tr.HitPos - tr.HitNormal * -0.38, ang
end

if CLIENT then return end

CreateConVar("sbox_maxskeypads", 100)

function TOOL:Think()
    local outputType = self:GetClientInfo("output_type")
    if outputType == "wiremod" or outputType == "keybind" then
        self:SetStage(1)
    end
end

function TOOL:RestartPlacement()
    self.KeypadTable = nil
    self:SetStage(0)
end

function TOOL:IsOwner(ent, ply)
    local entOwner = ent:CPPIGetOwner()

    if entOwner == CPPI_DEFER or entOwner == nil then
        for i = 1, 10 do
            sKeypads.Utils.log("CPPI NOT PROPERLY USED IN YOUR PROP PROTECTION ON THE SERVER sKeypads WILL BE BROKEN!")
        end
        return false
    end

    if entOwner != ply then return false end
end

function TOOL:LeftClick(tr)
    local ent = tr.Entity
    if IsValid(ent) and string.lower(ent:GetClass()) == "player" then return false end --No player clicky clicky grrr

    local ply = self:GetOwner()
    if not ply:CheckLimit("skeypads") then
        self:RestartPlacement()
        return false
    end

    if ply:sKeypadsGetCount() >= sKeypads.Config.max_keypads then
        self:RestartPlacement()
        ply:sKeypadsNotify(sKeypads.Lang.keypadReachedPersonalLimit, 1)
        return false
    end

    if tr.HitPos:DistToSqr(ply:GetPos()) >= sKeypads.Config.max_distance_from_placement ^ 2 then return false end

    local outputType = self:GetClientInfo("output_type")

    if self:GetStage() == 0 then
        if ent:GetClass() != "prop_physics" then
            if outputType == "mapdoor" and ent:isDoor() then
                if ent:getDoorOwner() != ply then
                    ply:sKeypadsNotify(sKeypads.Lang.toolgunDontOwnDoor, 1)
                    return false
                end
                self.SelectedDoor = ent
                self:SetStage(1)

                return
            end

            if ent:GetClass() == "skeypad" then
                if outputType != "fadingdoor" then return false end

                if self:IsOwner(ent, ply) then return false end
                self.KeypadTable = ent:GetMeta()
                self:SetStage(2)

                sKeypads.DoorHalos.sendDoors(ply, ent)

                return
            end

            return
        end

        if outputType != "fadingdoor" then return false end
        if self:IsOwner(ent, ply) then return false end

        self.SelectedDoor = ent
        self:SetStage(1)

        return true
    elseif self:GetStage() == 2 then
        if ent:GetClass() != "prop_physics" then return false end
        if self:IsOwner(ent, ply) then return false end

        local keypad = self.KeypadTable:getAttachedEntity()

        if not IsValid(keypad) then
            self:RestartPlacement()
            return false
        end

        if table.Count(self.KeypadTable:getFadingDoors()) >= sKeypads.Config.max_fading_doors then
            ply:sKeypadsNotify(sKeypads.Lang.keypadReachedMaxFadingDoors, 1)
            return false
        end

        self.KeypadTable:conectToFadingDoor(ent)
        sKeypads.DoorHalos.sendDoors(ply, keypad)

        return true
    end

    local keypad = ents.Create("skeypad")

    local pos, ang = self:GetKeypadPos(keypad)
    if not (pos and ang) then
        SafeRemoveEntityDelayed(keypad, 0)
        return
    end

    keypad:SetAngles(ang)
    keypad:SetPos(pos)
    keypad:Spawn()

    keypad:CPPISetOwner(ply)

    local keypadMeta = sKeypads.Utilities.createNewButtonPad(keypad)

    if outputType == "keybind" then
        keypadMeta:setKeyBinds(self:GetClientNumber("key_success"), self:GetClientNumber("key_fail"))
    elseif outputType == "wiremod" then
        if not keypadMeta:setupWireOutput(self:GetClientNumber("wire_on"), self:GetClientNumber("wire_off")) then
            SafeRemoveEntityDelayed(keypad, 0)
            self:RestartPlacement()
            return false
        end
    elseif outputType == "fadingdoor" then
        if not (IsValid(self.SelectedDoor) and self.SelectedDoor:GetClass() == "prop_physics") then
            SafeRemoveEntityDelayed(keypad, 0)
            self:RestartPlacement()
            return false
        end

        keypadMeta:conectToFadingDoor(self.SelectedDoor)
        keypadMeta:setMaterial(sKeypads.Materials.validateMaterial(self:GetClientInfo("fade_material")))
    elseif outputType == "mapdoor" then
        if not (IsValid(self.SelectedDoor) and self.SelectedDoor:isDoor()) then
            SafeRemoveEntityDelayed(keypad, 0)
            self:RestartPlacement()
            return false
        end

        keypadMeta:connectToMapDoor(self.SelectedDoor)
        keypadMeta:setAutoLock(tobool(self:GetClientNumber("auto_lock")))
    else
        SafeRemoveEntityDelayed(keypad, 0)
        self:RestartPlacement()
        return false
    end

    if not keypadMeta:setOutputMethod(outputType) then --Returns false when user does a naughty
        SafeRemoveEntityDelayed(keypad, 0)
        self:RestartPlacement()
        return false
    end

    local fadeTime = self:GetClientNumber("output_time", 10)
    keypadMeta:setCode(self:GetClientInfo("password"))
    keypadMeta:setProtected(self:GetClientNumber("securemode", 1))
    keypadMeta:setTime(math.Clamp(fadeTime,sKeypads.Config.min_keypad_open_time,sKeypads.Config.max_keypad_open_time))
    keypadMeta:attachToEntity(keypad)

    keypad:SetMeta(keypadMeta)

    duplicator.StoreEntityModifier(keypad, "skeypad_data", {
        code = self:GetClientInfo("password"),
        time = math.Clamp(fadeTime,sKeypads.Config.min_keypad_open_time,sKeypads.Config.max_keypad_open_time),
        material = sKeypads.Materials.validateMaterial(self:GetClientInfo("fade_material")),
        autoLock = tobool(self:GetClientNumber("auto_lock")),
        protected = self:GetClientNumber("securemode", 1),
        keybindSuccess = self:GetClientNumber("key_success"),
        keybindFail = self:GetClientNumber("key_fail"),
        wireOn = self:GetClientNumber("wire_on"),
        wireOff = self:GetClientNumber("wire_off"),
        attachedEntity = keypadMeta:getAttachedEntity()
    })

    if sKeypads.Config.freeze_keypads then
        local physObj = keypad:GetPhysicsObject()
        if IsValid(physObj) then
            physObj:EnableMotion(false)
        end
    end

    if sKeypads.Config.weld_keypads then constraint.Weld(keypad, ent, 0, tr.PhysicsBone or 0, 0, false, true) end

    undo.Create("sKeypad")
        undo.AddEntity(keypad)
        undo.SetPlayer(ply)
    undo.Finish()

    ply:AddCount("skeypads", keypad)
    ply:AddCleanup("skeypads", keypad)

    ply:sKeypadsAddKeypad(keypad:EntIndex())

    self:RestartPlacement()
end

function TOOL:RightClick(tr)
    if self:GetStage() == 1 then
        self:RestartPlacement()
        return
    elseif self:GetStage() == 2 then
        local ent = tr.Entity
        local ply = self:GetOwner()

        if ent:GetClass() != "prop_physics" then return false end
        if self:IsOwner(ent, ply) then return false end

        local keypad = self.KeypadTable:getAttachedEntity()

        if not IsValid(keypad) then
            self:RestartPlacement()
            return false
        end

        self.KeypadTable:disconnectFromFadingDoor(ent)
        sKeypads.DoorHalos.sendDoors(ply, keypad)

        return true
    end

    local ent = tr.Entity
    if not IsValid(ent) or ent:GetClass() != "skeypad" then return false end

    local ply = self:GetOwner()
    if tr.HitPos:DistToSqr(ply:GetPos()) >= sKeypads.Config.max_distance_from_placement ^ 2 then return false end

    if self:IsOwner(ent, ply) then return false end

    SafeRemoveEntityDelayed(ent, 0)
end

function TOOL:Reload(tr)
    if self:GetStage() == 2 then
        self:SetStage(0)
        sKeypads.DoorHalos.resetDoors(self:GetOwner())
        return
    end

    if self:GetStage() != 0 then return end

    local ent = tr.Entity
    if not IsValid(ent) or ent:GetClass() != "skeypad" then return false end

    local ply = self:GetOwner()
    if tr.HitPos:DistToSqr(ply:GetPos()) >= sKeypads.Config.max_distance_from_placement ^ 2 then return false end

    if self:IsOwner(ent, ply) then return false end

    local keypadMeta = ent:GetMeta()
    if not keypadMeta then
        ent:Remove()
        return false
    end

    local fadeTime = self:GetClientNumber("output_time", 10)
    keypadMeta:setCode(self:GetClientInfo("password"))
    keypadMeta:setTime(math.Clamp(fadeTime,sKeypads.Config.min_keypad_open_time,sKeypads.Config.max_keypad_open_time))
    keypadMeta:setMaterial(sKeypads.Materials.validateMaterial(self:GetClientInfo("fade_material")))
    keypadMeta:setAutoLock(tobool(self:GetClientNumber("auto_lock")))
    keypadMeta:setProtected(self:GetClientNumber("securemode", 1))
    keypadMeta:setKeyBinds(self:GetClientNumber("key_success"), self:GetClientNumber("key_fail"))
    keypadMeta:setupWireOutput(self:GetClientNumber("wire_on"), self:GetClientNumber("wire_off"))

    ent:SetMeta(keypadMeta)

    duplicator.StoreEntityModifier(ent, "skeypad_data", {
        code = self:GetClientInfo("password"),
        time = math.Clamp(fadeTime,sKeypads.Config.min_keypad_open_time,sKeypads.Config.max_keypad_open_time),
        material = sKeypads.Materials.validateMaterial(self:GetClientInfo("fade_material")),
        autoLock = tobool(self:GetClientNumber("auto_lock")),
        protected = self:GetClientNumber("securemode", 1),
        keybindSuccess = self:GetClientNumber("key_success"),
        keybindFail = self:GetClientNumber("key_fail"),
        wireOn = self:GetClientNumber("wire_on"),
        wireOff = self:GetClientNumber("wire_off"),
        attachedEntity = keypadMeta:getAttachedEntity()
    })
end

function TOOL:Holster()
    self:SetStage(0)
    sKeypads.DoorHalos.resetDoors(self:GetOwner())
end
