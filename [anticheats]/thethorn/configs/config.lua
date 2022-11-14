RS = {}
RC = {}

RS.version = "M0421" -- ChocoHax Ribes Version

RS.SeclyWhitelistedResources = { -- Put here resources that have to be Whitelisted from being secly injected
    "t1ger_drugbusiness",
    "t1ger_bankrobbery",
    "t1ger_truckrobbery"
}

--//Logs//--

RS.ConsoleLogs = false -- Get detection info on your Server Console

RS.GeneralDiscordWebhookLink = "https://discord.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN" -- ChocoHax Detection Logs Webhook Link

RS.ConnectionLogs = false -- Connection Logs Masterswitch
RS.ConnectionLogsWebhookLink = "https://discord.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN" -- Webhook Link ^^

RS.DisconnectionLogs = false -- Disconnection Logs Masterswitch
RS.DisconnectionLogsWebhookLink = "https://discord.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN" -- Webhook Link ^^

-- Separated Logs (Use it only if you want to have diffrent webhook link logs otherwise leave it empty)

RS.EntitiesDiscordWebhookLink = "https://discord.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN"
RS.WeaponsDiscordWebhookLink = "https://discord.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN"
RS.ExplosionsDiscordWebhookLink = "https://discord.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN"
RS.SeclyDiscordWebhookLink = "https://discord.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN"
RS.EventsDiscordWebhookLink = "https://discord.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN"
--------------------------------

--//General Stuff//--

RS.AntiXSSInjection = true
RS.FXParticlesBlock = false -- Experimental (Blocks any kind of FXParticle, DO NOT USE IF YOUR SERVER USES ANY FXPARTICLE)
RS.ProjectileBlock = false -- Experimental (Blocks any kind of Projectile, DO NOT USE IF YOUR SERVER USES ANY PROJECTILE SCRIPT)
--------------------------------

--//Client Side Stuff//--
RC.AntiSpectate = false
RC.AntiBlips = false
RC.ResourceChecker = false -- (HEAVY SCRIPT, MAY REDUCE PERFORMANCE ON CLIENT SIDE AND SERVER SIDE)
RC.AntiASIMenu = true -- Experimental (Useful and light)

--//Anti Resource Restart//-- (Yea... he's back) (Detects Start/Stop/Restart)
RC.AntiResourceRestart = false
RS.AntiResourceRestartCooldown = 10000 -- If you are going to restart a resource, the anticheat gets disabled for 10 seconds (Set on 0 if you don't want a cooldown)

--//Health Checker//-- (FALSE POSTIVE WARNING, DO NOT USE IF YOUR SERVER IS NOT COMPATIBLE WITH THIS CHECKER)
RC.AntiGodModeMasterSwitch = false -- Masterswitch
RC.AntiGodModeKick = false
RC.AntiGodModeBan = false

RC.AntiGodMode = true -- METHOD 1 (Faster,Simple)
RC.AntiSemiGodMode = false -- METHOD 2 (Reliable,Less False Positives)
    RC.AntiSemiGodModeWarns = 5 -- The player gets kicked/banned after 5 SEMI-godmode detections (Default: 5 == 50 seconds)

RC.AntiGodModeHealthCheck = true -- METHOD 3
    RC.AntiGodModeMaxHealth = 200 -- MAX PLAYER HEALTH

RC.WeaponsClientDetection = false -- Detects if a player own a blacklisted weapon and remove it
RC.WeaponsClientWarn = false -- Send a log if a player own a blacklisted weapon (NOT RECOMMENDED, IS GOING TO SPAM YOUR LOGS)
RC.WeaponsClientKick = false -- Kick a player that own a blacklisted weapon (NOT RECOMMENDED, FALSE POSITIVE WARNING)
RC.WeaponsClientBan = false -- Ban a player that own a blacklisted weapon (NOT RECOMMENDED, FALSE POSITIVE WARNING)
--------------------------------

--//Screenshots//--
RC.ScreenshotsMasterSwitch = false
RC.ScreenshotsDiscordWebhookLinkStorage = "" -- Leave it blank if you want to use ChocoHax's Webhook Link (Storage, this webhook may be vulnerable, do not use this webhook for any kind of use except for screenshots storage)
RS.ScreenshotsDiscordWebhookLink = "" -- Screenshot Logs (SERVER ONLY, KEEP THIS SECRET)

RC.ScreenshotsDetectionOnKeyPress = false -- (MAY REDUCE PERFORMANCE ON CLIENT SIDE!)
RC.ScreenshotsDetectionOnKeyPressKeys = {121,122,37}
--------------------------------

--//ChocoHax AI//-- UNDER TESTING, THIS IS FEATURE MAY NOT WORK CORRECTLY
RS.ChocoHaxAI = false --(This feature requires RC.ScreenshotsDetectionOnKeyPress enabled)
RS.ChocoHaxAIKick = false
RS.ChocoHaxAIBan = false
RS.ChocoHaxAIAPIKey = "" -- Register your API FREE KEY from https://ocr.space/OCRAPI
RS.ChocoHaxAIDiscordWebhookLink = "" 
RS.ChocoHaxAIDetectionWords = {"Fallout Menu","Fallout","Cheat","Eulen","Weapon Menu","Self Menu","Vehicle Menu","God Mode","Semi God Mode",
"Aimbot","Teleport to waypoint","Fast Run","Infinite Stamina","Infinite Ammo","Nuke","Destroy ESX","Lua Executor",
"Super Jump","Give All Weapons","Remove all weapons","AntiAim","Trigger Bot","Trigger bot","Aim bot",
"Explode Everyone","Give Money","Lynx Revolution","Lynx Menu","Atomic","Noclip","Unknowncheats","Watermalone","Brutan","Dopamine",
"Tiago Menu","Lua options","Self options","Absolute","Matrix","Troll Menu","Troll","Panic Button","Kill menu","Destroy Menu","34ByTe Community",
"Powerfulsokin","Falcon","Cage Players","Rage bot","Unlimited ammo","One shot","All players"}
--------------------------------

--//Connection Checks//--
    --//Identifiers Checker//-- Detects players connecting without some identifiers, you can force players to have steam/discord/fivem connected to their accounts
    RS.IdentifiersChecker = false
        RS.IdentifiersCheckerForceSteam = false -- Steam
            RS.IdentifiersCheckerForceSteamKickMessage = "You're not allowed to join this server without Steam"

        RS.IdentifiersCheckerForceDiscord = false -- Discord
            RS.IdentifiersCheckerForceDiscordKickMessage = "You're not allowed to join this server without Discord"

        RS.IdentifiersCheckerForceRockstar = false -- Rockstar License
            RS.IdentifiersCheckerForceRockstarKickMessage = "You're not allowed to join this server without a Rockstar License"

        RS.IdentifiersCheckerForceXbox = false -- Xbox License
            RS.IdentifiersCheckerForceXboxKickMessage = "You're not allowed to join this server without a Xbox License"

        RS.IdentifiersCheckerForceLive = false -- Live License
            RS.IdentifiersCheckerForceLiveKickMessage = "You're not allowed to join this server without a Live License"

        RS.IdentifiersCheckerForceFiveM = false -- FiveM Account License
            RS.IdentifiersCheckerForceFiveMKickMessage = "You're not allowed to join this server without a FiveM account"

    --//Blacklisted Names//-- Detects players using a name that's not allowed on your server
    RS.BlacklistedNamesMasterSwitch = true
    RS.BlacklistedNamesKickMessage = ""
    RS.BlacklistedNames = {"administrator", "admin", "adm1n", "adm!n", "admln", "moderator", "owner", "nigger", "n1gger", "moderator", "eulencheats", "lynxmenu", "atgmenu", "hacker", "bastard", "hamhaxia", "333gang", "ukrp", "eguk", "n1gger", "n1ga", "nigga", "n1gga", "nigg3r",
    "nig3r", "shagged", "4dm1n", "4dmin", "m0d3r4t0r", "n199er", "n1993r", "rustchance.com", "rustchance", "hellcase.com", "hellcase", "youtube.com", "youtu.be", "youtube", "twitch.tv", "twitch", "anticheat.gg", "anticheat", "fucking",
    "chocohax", "civilgamers.com", "civilgamers", "csgoempire.com", "csgoempire", "g4skins.com", "g4skins", "gameodds.gg", "duckfuck.com", "crysishosting.com", "crysishosting", "key-drop.com", "key-drop.pl", "skinhub.com", "skinhub",
    "casedrop.eu", "casedrop", "cs.money", "rustypot.com","rampage.lt", "?", "xcasecsgo.com", "xcasecsgo", "csgocases.com",
    "csgocases", "K9GrillzUK.co.uk", "moat.gg", "princevidz.com", "princevidz", "pvpro.com", "Pvpro", "ez.krimes.ro", "loot.farm", "arma3fisherslife.net", "arma3fisherslife", "egamers.io", "ifn.gg", "key-drop", "sups.gg", "tradeit.gg",
    "§", "csgotraders.net", "csgotraders", "hurtfun.com", "hurtfun", "gamekit.com", "t.tv", "yandex.ru", "yandex", "csgofly.com", "csgofly", "pornhub.com", "pornhub","cs.deals","twat", "STRESS.PW"}
    --------------------------------
--------------------------------

--//Events Protection//-- This category will be updated as soon as possible
RS.BlacklistedTriggersDetection = false -- Detect triggers that you have blacklisted in TABLES/BlacklistedEvents.lua

RS.ClearTriggersProtection = true -- Detects weird stuff and/or spamming
    RS.ClearTriggersProtectionChecker = true -- Detects strings or numbers
    RS.ClearTriggersProtectionStringProtection = false -- Detects blacklisted strings
    RS.ClearTriggersProtectionValueProtection = false -- Detects Value Cap
    
    RS.ClearTriggersProtectionAntiSpam = true -- Detects spamming
        RS.ClearTriggersProtectionAntiSpammer = 15 -- How many triggers a user can do in X seconds
        RS.ClearTriggersProtectionAntiSpammerResetTime = 10000 -- 10 seconds
--------------------------------

--//Chat Control//--
RS.ChatControlMasterSwitch = false
    RS.ChatControlAntiSpam = false -- Detect if a players spam messages
    RS.ChatControlMaxMessages = 5 -- How many messages can a player write before getting blocked
    RS.ChatControlMSecondsBetweenMaxMessages = 5000 -- How many seconds needs the player to wait for being able to talk again

    RS.BlacklistedWords = false -- Detect/Warn
    RS.BlacklistedWordsKick = false -- Detect/Warn/Kick
    RS.BlacklistedWordsBan = false -- Detect/Warn/Ban (Requires RS.BlacklistedWordsKick on false)
--------------------------------

--//BanSystem//--
RS.BanSystem = false
RS.KickMessage = "Ribes are sweet <3"
--------------------------------

--//ClearPedTasksImmediately//-- Detects players that tries to kick everyone out of the vehicles (or stuff like that)
RS.ClearPedTasksImmediatelyMasterSwitch = false -- Detect/Warn
RS.ClearPedTasksImmediatelyKick = false -- Detect/Warn/Kick
RS.ClearPedTasksImmediatelyBan = false -- Detect/Warn/Ban (Requires RS.ClearPedTasksImmediatelyKick on false)
--------------------------------

--//Explosions//--
RS.ExplosionsMasterSwitch = true
RS.ExplosionsDetection = false -- Detects if a player creates a blacklisted explosion (Due to FiveM's sync that option may not work correctly on all servers)

RS.ExplosionsAntiNuke = true -- Detects if a players creates multiple explosions (Blacklisted or not)
    RS.ExplosionsAntiNukeWarningCount = 7 -- After 7 explosions the player gets warned
    RS.ExplosionsAntiNukeBanCount = 15 -- After 15 explosions the player gets banned
    RS.ExplosionsAntiNukeResetTime = 8000 -- After 8 seconds the AntiNuke gets reseted
--------------------------------

--//Particles//--

--TODO

--------------------------------

--//Entities//--
RS.EntitiesMasterSwitch = true
RS.EntitiesNONPC = false -- Enable this only if your server is a `NONPC` server (it blocks any kind of uncommon entity spawn)

    --(IMPORTANT!! If you are going to use WHITELISTED Method remember to edit your TABLES/Entities.lua table before starting the server)

    --Peds
    RS.EntitiesPedsDetection = false
    RS.EntitiesPedsKick = false
    RS.EntitiesPedsBan = false

    --Vehicles
    RS.EntitiesVehiclesDetection = false
    RS.EntitiesVehiclesKick = false
    RS.EntitiesVehiclesBan = false

    --Objects/Models
    RS.EntitiesObjectsMethod = 1 -- 1 FOR BLACKLISTED , 2 FOR WHITELISTED
    RS.EntitiesObjectsDetection = true
    RS.EntitiesObjectsKick = true
    RS.EntitiesObjectsBan = false

    --AntiNuke
    RS.EntitiesAntiNukePeds = true
    RS.EntitiesAntiNukeVehicles = true
    RS.EntitiesAntiNukeObjects = true
    RS.EntitiesAntiNukeSpawnLimit = 15 -- After 15 Spawned PEDS/VEH/OBJ the player gets automatically banned or warned
    RS.EntitiesAntiNukeResetTime = 8000 -- After 8 seconds the AntiNuke timer gets reseted
--------------------------------

--//Weapons//--
RS.WeaponsMasterSwitch = false
RS.WeaponsDetectGive = false -- Detects any kind of weapons GIVE (not spawn)
RS.WeaponsDetectGiveBlacklisted = false -- Detect Blacklisted Weapons GIVE (not spawn) (DO NOT USE IF WEAPONSDETECTGIVE IS ACTIVE!!)
RS.WeaponsDetectRemove = false -- Detect any kind of weapons REMOVE (not drop)
RS.WeaponsDetectRemoveAll = false -- Detect any kind of RemoveAllWeapons event (not drop)
RS.WeaponsDetectUse = false -- Detects Blacklisted Weapons USE (NOT HOLDING, only if he/she shoots)
RS.WeaponsGiveMaxAmmo = 250 -- Detects any kind of weapons GIVE MAX AMMO (default 250)

--------------------------------

--//Permissions//--
RS.AdminMenu = {"chocohaxadministrator"}
RS.Bypass = {"chocohaxadministrator","chocohaxmoderator"}
RS.Spectate = {"chocohaxadministrator","chocohaxmoderator"}
RS.Blips = {"chocohaxadministrator","chocohaxmoderator", "chocohaxjobs"}
--------------------------------