CITYWORKER = CITYWORKER or {}

CITYWORKER.Config = CITYWORKER.Config or {}


-- How often should we check (in seconds) for City Workers with no assigned jobs, so we can give them?
CITYWORKER.Config.Time = 5

-- Configuration for the DarkRP job.
CITYWORKER.Config.Job = {
    name = "Agent Municipal",

    color = Color( 20, 150, 20, 255 ),
    model = {"models/player/kerry/class_d_1.mdl",
                "models/player/kerry/class_d_2.mdl",
                "models/player/kerry/class_d_3.mdl",
                "models/player/kerry/class_d_4.mdl",
                "models/player/kerry/class_d_5.mdl",
                "models/player/kerry/class_d_6.mdl",
                "models/player/kerry/class_d_7.mdl"},
    description = "Vous �tes engag� par la mairie, prenez votre camionnette au PNJ, puis vous devez ensuite r�parer les fuites, les bornes incendient, d�layer les gravats et probl�me d'�lectricit�, si jamais il y en a.",
    weapons = { "cityworker_pliers", "cityworker_shovel", "cityworker_wrench", "re_hands", "itemstore_pickup", "weapon_arc_atmcard", "wallet", "weapon_arc_phone"},
    command = "cityworker",
    max = 4,
    salary = 50,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citoyens",

}

------------
-- RUBBLE --
------------

CITYWORKER.Config.Rubble = {}

-- Whether or not rubble is enabled or disabled.
CITYWORKER.Config.Rubble.Enabled = true

-- Rubble models and the range of time (in seconds) it takes to clear them.
CITYWORKER.Config.Rubble.Models = {
    ["models/props_debris/concrete_debris128pile001a.mdl"] = { min = 20, max = 30 },
    ["models/props_debris/concrete_debris128pile001b.mdl"] = { min = 10, max = 15 },
    ["models/props_debris/concrete_floorpile01a.mdl"] = { min = 10, max = 20 },
    ["models/props_debris/concrete_cornerpile01a.mdl"] = { min = 10, max = 20 },
    ["models/props_debris/concrete_spawnplug001a.mdl"] = { min = 7, max = 13 },
    ["models/props_debris/plaster_ceilingpile001a.mdl"] = { min = 10, max = 15 },
}

-- Payout per second it takes to clear a given pile of rubble.
-- (i.e. 10 seconds = 10 * 30 = 300)
CITYWORKER.Config.Rubble.Payout = 1

-------------------
-- FIRE HYDRANTS --
-------------------

CITYWORKER.Config.FireHydrant = {}

-- Whether or not fire hydrants are enabled or disabled.
CITYWORKER.Config.FireHydrant.Enabled = true

-- The range for how long it takes to fix a fire hydrant.
-- Maximum value: 255 seconds.
CITYWORKER.Config.FireHydrant.Time = { min = 23, max = 32 }

-- Payout per second it takes to fix a fire hydrant.
CITYWORKER.Config.FireHydrant.Payout = 2

-----------
-- LEAKS --
-----------

CITYWORKER.Config.Leak = CITYWORKER.Config.Leak or {}

-- Whether or not leaks are enabled or disabled.
CITYWORKER.Config.Leak.Enabled = true

-- The range for how long it takes to fix a leak.
-- Maximum value: 255 seconds.
CITYWORKER.Config.Leak.Time = { min = 15, max = 23 }

-- Payout per second it takes to fix a leak.
CITYWORKER.Config.Leak.Payout = 2

--------------
-- ELECTRIC --
--------------

CITYWORKER.Config.Electric = CITYWORKER.Config.Electric or {}

-- Whether or not electrical problems are enabled or disabled.
CITYWORKER.Config.Electric.Enabled = true

-- The range for how long it takes to fix an electrical problem.
-- Maximum value: 255 seconds.
CITYWORKER.Config.Electric.Time = { min = 15, max = 25 }

-- Payout per second it takes to fix an electrical problem.
CITYWORKER.Config.Electric.Payout = 2

----------------------------
-- LANGUAGE CONFIGURATION --
----------------------------

CITYWORKER.Config.Language = {
    ["FireHydrant"]         = "Продолжается ремонт пожарного гидранта...",
    ["Leak"]                = "Устранение течи продолжается...",
    ["Electric"]            = "Ремонт в процессе",
    ["Rubble"]              = "Расчищаем завалов",
    ["CANCEL"]              = "Нажмите F2, чтобы отменить действие..",
    ["PAYOUT"]              = "Альянс выплатил вам %s за вашу работу!",
    ["CANCELLED"]           = "Вы отменили свое действие!",
    ["NEW_JOB"]             = "Альянс выдал вам новую задачу!",
    ["NOT_CITY_WORKER"]     = "Вы не Разнорабочий!",
    ["JOB_WORKED"]          = "Эта задача уже выполняется",
    ["ASSIGNED_ELSE"]       = "Эта работа поручена кому-то другому!",
}