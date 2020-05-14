ChocoHaxCs = {}

--//LoliHunter//--
ChocoHaxCs.ConfigVersion = 8 -- Don't touch, it's better
ChocoHaxCs.License = "235561350821183489dfwm"
ChocoHaxCs.DiscordWebhookLink = "https://discordapp.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN"

--//Log System//--
ChocoHaxCs.ConsoleLog = true -- This will log on console warnings/kicks/bans/infos
ChocoHaxCs.DiscordLog = true -- This will log on discord webhook warnings/kicks/bans/infos
ChocoHaxCs.ChatLog = true -- This will log on ingame chat FOR ALL PLAYERS warnings/kicks/bans

--//Chat Control Stuff//--
ChocoHaxCs.BlacklistedWordsDetection = true -- Detects and log the player that tried to say something blacklisted (configs/blacklistedwords.lua)
ChocoHaxCs.BlacklistedWordsKick = true -- Kick the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)
ChocoHaxCs.BlacklistedWordsBan = false -- Ban the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)

--//Default Stuff//--
ChocoHaxCs.TriggerDetection = false -- Kick the player that tried to execute or call a blacklisted trigger (remember to edit or obfuscate your original triggers), this will find all newbie cheaters/skids

--//Ban System//--
ChocoHaxCs.GlobalBan = true -- This on true will use the Global Ban List (All verified detected cheaters are on that list) HIGHLY RECOMMENDED!
ChocoHaxCs.BanSystem = true -- This on false will disable the ChocoHax's Ban System

--//Kick Message//--
ChocoHaxCs.KickMessage = "Valiste verga, onii-chan." -- You can edit this UwU

--//Anti Explosion System (tables are in tables folder)//--
ChocoHaxCs.DetectExplosions = true -- Automatically detect blacklisted explosions from (tables/blacklistedexplosions.lua)

--//Anti Blacklisted Models//--
ChocoHaxCs.BlacklistedWeapons = true
ChocoHaxCs.KawaiiFuckMethod = false


--//Permission System//-- DO NOT TOUCH IF YOU DON'T KNOW WHAT ARE U DOING 
ChocoHaxCs.Bypass = {"chocohaxadministrator","chocohaxmoderator"} -- This will allow the user with these perms to bypass Violation detections such as mod menus/weapons/godmode, etc.
ChocoHaxCs.AdminMenu = {"chocohaxadministrator"} -- This will allow the user with these perms to load the ChocoMenu.
ChocoHaxCs.Spectate = {"chocohaxadministrator","chocohaxmoderator","chocospectate","chocohaxjobs"} -- This will allow the user with these perms to spectate other users.
ChocoHaxCs.Blips = {"chocohaxadministrator","chocohaxmoderator","chocohaxjobs"} -- This will allow the user with these perms to use Player Blips.