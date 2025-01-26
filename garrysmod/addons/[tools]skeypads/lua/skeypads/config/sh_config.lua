sKeypads.Config = {
    language = "english", -- What language should be used, you can find available languages in the sh_language.lua file.

    door_halo_color = Color(255, 255, 255),

    keypad_num_color = Color(106, 188, 235),
    keypad_num_blocked_color = Color(235, 106, 106),
    keypad_num_outline_color = Color(255, 255, 255),
    keypad_num_accepted_color = Color(108, 235, 106),

    cracker_title_color = Color(255, 255, 255),
    cracker_hint_color = Color(125, 125, 125),
    cracker_start_color = Color(204, 45, 45),
    cracker_end_color = Color(45, 204, 85),

    output_types = { -- Enable/disable output types here
        ["fadingdoor"] = true, -- Fading doors
        ["mapdoor"] = true, -- Player's owned doors - Only works on DarkRP/Derivates of DarkRP (Auto disables)
        ["keybind"] = false, -- Keybinds (works with sandbox tools such as thrusters)
        ["wiremod"] = true -- A Wiremod output triggers upon open/fail - Only works with wiremod installed (Auto disables)
    },

    nocollide = true, -- Should keypads spawn no collided?
    weld_keypads = true, -- Should we automatically weld keypads to the item the player targeted?
    freeze_keypads = true, -- Should we automatically freeze keypads when spawning them?

    max_distance_from_placement = 500, -- What is the furthest distance from the player that a keypad can be placed at?

    fading_door_material = "models/shadertest/shader3", -- If you're not allowing uses to choose materials then this matters.
    fading_door_allow_custom_materials = true, -- Should we allow custom materials?
    fading_door_stop_stuck = true, -- Keep the fading door open if a person is trapped in the fading door. It will try and close it after an interval.
    fading_door_stuck_check_interval = 1, -- How many SECONDS will it take before it checks again.
    fading_door_allowed_materials = { -- The list of materials we should allow users to use.
        "sprites/heatwave",
        "models/wireframe",
        "debug/env_cubemap_model",
        "models/shadertest/shader3",
        "models/shadertest/shader4",
        "models/shadertest/shader5",
        "models/shiny",
        "models/debug/debugwhite",
        "Models/effects/comball_sphere",
        "Models/effects/comball_tape",
        "Models/effects/splodearc_sheet",
        "Models/effects/vol_light001",
        "models/props_combine/stasisshield_sheet",
        "models/props_combine/portalball001_sheet",
        "models/props_combine/com_shield001a",
        "models/props_c17/frostedglass_01a",
        "models/props_lab/Tank_Glass001",
        "models/props_combine/tprings_globe",
        "models/rendertarget",
        "models/screenspace",
        "brick/brick_model",
        "models/props_pipes/GutterMetal01a",
        "models/props_pipes/Pipesystem01a_skin3",
        "models/props_wasteland/wood_fence01a",
        "models/props_foliage/tree_deciduous_01a_trunk",
        "models/props_c17/FurnitureFabric003a",
        "models/props_c17/FurnitureMetal001a",
        "models/props_c17/paper01",
        "models/flesh"
    },

    max_key_length = 6, -- Any number more than 6 will be ignored, the amount of digits a player can enter

    max_keypads = 5, -- Max keypads a player can have.
    max_fading_doors = 10, --Maximum fading doors per keypad.

    max_keypad_delay = 10, -- The maximum delay a keypad can have before it's opened.

    max_keypad_open_time = 10, -- The length of time a keypad can be open for.
    min_keypad_open_time = 5, -- The MINIMUM length oftime a keypad can be open for.

    use_cppi_friends = false, -- Use CPPI friends.
    max_friends = 10, -- If we're not using CPPI this will default to the keypad friend system.

    friends = true, -- Allow for people to use friends
    allow_teams_keypads = true, -- Should we allow users to use team keypads?

    -- WIP Features.
    emp_range = 500,
    emp_disable_time = 1,

    keypads_crackers = {
        {
            name = "Pro Keypad Cracker",
            class_name = "pro_keypadcracker",
            deployable = true, -- Should the cracker be placed on the keypad while it cracks?
            time = 10 -- The time in seconds it takes to crack
        },
        {
            name = "Base Keypad Cracker",
            class_name = "base_keypadcracker",
            deployable = false, -- Should the cracker be placed on the keypad while it cracks?
            time = 20, -- The time in seconds it takes to crack
        }
    },

    shootable_keypads = true, -- Should keypads be shootable
    shoot_cooldown = 4, -- The cooldown that should occur if they've been shot
    shoot_cooldown_between = 0, -- The cooldown between cooldowns (thanks zeo.)
    shoot_damage_type_whitelist_enabled = true, -- Should we use the whitelist?
    shoot_damage_type_whitelist = { -- These can be found here: https://wiki.facepunch.com/gmod/Enums/DMG
        DMG_BULLET,
        DMG_CLUB
    },

    sounds = {
        ["press"] = "skeypads/beep_keypress.mp3",
        ["success"] = "skeypads/beep_success.mp3",
        ["error"] =  "skeypads/beep_error.mp3",
    },

    eyetrace_protection = false, -- This stops people from using possible hacks to trace what button a player is using.
    eyetrace_protection_speed = 0.0075, -- Lower this amount for more precision.
    -- A warning about Eye trace protection:
    -- This feature is an *attempt* at fixing the isues if you find away around it
    -- then feel free to submit to us on gmodstore!
    -- We'll actively improve this feature.
    -- Updated. on 19/06

    enable_blobs_party_support = false, -- This means they can use the finger prints if they're in the party.
    enable_blogs_integration = false, -- Should we make keypad logs appear in bLogs?
    sparty_support = false, -- Finger print support for sParties.

    paid_doors = true, -- Should we allow for paid doors?
    paid_doors_min = 400,
    paid_doors_max = 1000,
}
