
if not sKeypads.Config.enable_blogs_integration then return end

local SUCCESSFUL_ATTEMPTS_MODULE = GAS.Logging:MODULE()

SUCCESSFUL_ATTEMPTS_MODULE.Category = "Superior Keypads"
SUCCESSFUL_ATTEMPTS_MODULE.Name = "Successful Attempts"
SUCCESSFUL_ATTEMPTS_MODULE.Colour = Color(0, 210, 0)

SUCCESSFUL_ATTEMPTS_MODULE:Hook("sKeypads::SuccessfulAttempt", "keypadsuccess", function(ply, ent)
    SUCCESSFUL_ATTEMPTS_MODULE:Log("{1} successfully used the keypad {2}.", GAS.Logging:FormatPlayer(ply), GAS.Logging:FormatEntity(ent))
end)

GAS.Logging:AddModule(SUCCESSFUL_ATTEMPTS_MODULE)


local FAILED_ATTEMPTS_MODULE = GAS.Logging:MODULE()

FAILED_ATTEMPTS_MODULE.Category = "Superior Keypads"
FAILED_ATTEMPTS_MODULE.Name = "Unsuccessful Attempts"
FAILED_ATTEMPTS_MODULE.Colour = Color(210, 0, 0)

FAILED_ATTEMPTS_MODULE:Hook("sKeypads::UnuccessfulAttempt", "keypadfailed", function(ply, ent)
    FAILED_ATTEMPTS_MODULE:Log("{1} failed to use the keypad {2}.", GAS.Logging:FormatPlayer(ply), GAS.Logging:FormatEntity(ent))
end)

GAS.Logging:AddModule(FAILED_ATTEMPTS_MODULE)
