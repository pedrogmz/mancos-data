Config = {}

Config.Key = "49FBX9038" -- Put Key Here.

Config.Bans = true
Config.Expose = false
Config.NameChecking = true -- This is new, it checks if the source's supplied name(grabbed with natives) matches the author of the message their trying to send, its off by default due to some servers having name modification scripts,
Config.TeleportChecking = true
Config.TeleportBanning = false -- Only works if TeleportChecking is true
Config.ModelChecking = true -- Checks model and plate id, if plate matches with different vehicle immediately it bans.
Config.DiscordLogging = true
Config.DiscordWebHookLink = "https://discordapp.com/api/webhooks/616767680254443536/aVzk_zX7-bX1ed9qSvujHrhBLu1jKatnT4dxL8T6sTo_BYTj1z04NVUFog2vmno5KrxN" -- Insert Webhook Here. (buggy, banner still works tho)

Config.WebhookTryLimit = 2
local SendWebhookAttempts = 0
    
RegisterServerEvent("AntiCrab:SendWebhook")
AddEventHandler("AntiCrab:SendWebhook", function(...)
    TriggerEvent("AntiCrab:ReceiveWebhook", Config.DiscordWebHookLink)
end)
    
Citizen.CreateThread(function()
    while SendWebhookAttempts ~= Config.WebhookTryLimit do
        Citizen.Wait(6000)
        TriggerEvent("AntiCrab:SendWebhook", nil)
        SendWebhookAttempts = SendWebhookAttempts + 1
    end
end)

