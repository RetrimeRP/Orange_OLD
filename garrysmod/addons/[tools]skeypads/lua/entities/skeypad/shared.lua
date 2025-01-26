
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Superior Keypad"
ENT.Category = "Superior Keypads"
ENT.Author = "Tom.bat & NoSharp"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.IsKeypad = true
ENT.KeyRegions = {
    ["1"] = {
        displayText = "1",
        num = true,
        order = 1,
    },
    ["2"] = {
        displayText = "2",
        num = true,
        order = 2,
    },
    ["3"] = {
        displayText = "3",
        num = true,
        order = 3,
    },
    ["4"] = {
        displayText = "4",
        num = true,
        order = 4,
    },
    ["5"] = {
        displayText = "5",
        num = true,
        order = 5,
    },
    ["6"] = {
        displayText = "6",
        num = true,
        order = 6,
    },
    ["7"] = {
        displayText = "7",
        num = true,
        order = 7,
    },
    ["8"] = {
        displayText = "8",
        num = true,
        order = 8,
    },
    ["9"] = {
        displayText = "9",
        num = true,
        order = 9,
    },
    ["clear"] = {
        displayText = sKeypads.Lang.keypadClear,
        num = true,
        order = 10,
    },
    ["0"] = {
        displayText = "0",
        num = true,
        order = 11,
    },
    ["enter"] = {
        displayText = sKeypads.Lang.keypadEnter,
        num = true,
        order = 12,
    },
    ["fingerprint"] = {
        pos = {-28, 690},
        size = {536, 175}
    }
}

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "ScreenText")
    self:NetworkVar("Bool", 0, "InputBlocked")
    self:NetworkVar("Bool", 1, "IsOpen")
    self:NetworkVar("Entity", 0, "owning_ent")

    if SERVER then
        self:SetScreenText("")
        self:SetInputBlocked(false)
        self:SetIsOpen(false)
    end
end

function ENT:SendCommand() end --These two functions are here to prevent errors if the workshop keypads are installed alongside
function ENT:GetHoveredElement() end
