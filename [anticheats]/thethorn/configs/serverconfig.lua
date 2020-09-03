FuxiaS = {}

--//ChocoHax Fuxia//--
FuxiaS.ConfigVersion = 11 -- Don't touch, it's better
FuxiaS.GeneralDiscordWebhookLink = "https://discordapp.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN" -- General logging system (Here you will find ALL logs) -- Required.

FuxiaS.EntitiesDiscordWebhookLink = "https://discordapp.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN"  -- Optional , Logging Entities only webhook
FuxiaS.ExplosionsDiscordWebhookLink = "https://discordapp.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN" -- Optional , Logging Explosions only webhook
FuxiaS.SeclyDiscordWebhookLink = "https://discordapp.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN" -- Optional , Logging Secly only webhook (Modmenu Injections,Lua manipulation)

--//Log System//--
FuxiaS.ConsoleLog = false -- This will log on console warnings/kicks/bans/infos
FuxiaS.DiscordLog = true -- This will log on discord webhook warnings/kicks/bans/infos
FuxiaS.ChatLog = false -- This will log on ingame chat FOR ALL PLAYERS warnings/kicks/bans

--//Chat Control Stuff//--
FuxiaS.BlacklistedWordsDetection = false -- Detects and log the player that tried to say something blacklisted (configs/blacklistedwords.lua)
FuxiaS.BlacklistedWordsKick = false -- Kick the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)
FuxiaS.BlacklistedWordsBan = false -- Ban the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)

--//Default Stuff//--
FuxiaS.TriggerDetection = false -- Kick the player that tried to execute or call a blacklisted trigger (remember to edit or obfuscate your original triggers), this will find all newbie cheaters/skids

--//Ban System//--
FuxiaS.GlobalBan = true -- This on true will use the Global Ban List (All verified detected cheaters are on that list) HIGHLY RECOMMENDED!
FuxiaS.BanSystem = true -- This on false will disable the ChocoHax's Ban System

--//Kick Message//--
FuxiaS.KickMessage = "Aló, polisia? Tenemos un intruso." -- You can edit this UwU

--//Anti Blacklisted System (tables are in tables folder)//--
FuxiaS.DetectExplosions = true -- Automatically detect blacklisted explosions from (tables/blacklistedexplosions.lua)

--//Clear Ped Tasks Immediately Detection//-- NEW
FuxiaS.ClearPedTasksImmediatelyDetection = true -- Automatically detect ClearPedTasksImmediately (detect cheaters that are kicking out of vehicles other players) NEW!
FuxiaS.ClearPedTasksImmediatelyKick = true
FuxiaS.ClearPedTasksImmediatelyBan = false

--//BlacklistedEntity Detection//-- NEW
FuxiaS.BlacklistedEntityDetection = false
FuxiaS.BlacklistedEntityDetectionKick = true
FuxiaS.BlacklistedEntityDetectionBan = false

--//BlacklistedWeapons Detection//-- NEW
FuxiaS.BlacklistedWeaponDetection = true -- Automatically detect blacklisted weapons from (tables/blacklistedmodels.lua) NEW!
FuxiaS.MaxWeaponAmmo = 100 -- Automatically detect if someone tries to give themself/someone else more than 100 ammos NEW!


--//Permission System//-- DO NOT TOUCH IF YOU DON'T KNOW WHAT ARE U DOING 
FuxiaS.Bypass = {"chocohaxadministrator","chocohaxmoderator"} -- This will allow the user with these perms to bypass Violation detections such as mod menus/weapons/godmode, etc.
FuxiaS.AdminMenu = {"chocohaxadministrator"} -- This will allow the user with these perms to load the ChocoMenu.
FuxiaS.Spectate = {"chocohaxadministrator","chocohaxmoderator","chocospectate","chocohaxjobs"} -- This will allow the user with these perms to spectate other users.
FuxiaS.Blips = {"chocohaxadministrator","chocohaxmoderator","chocohaxjobs"} -- This will allow the user with these perms to use Player Blips.