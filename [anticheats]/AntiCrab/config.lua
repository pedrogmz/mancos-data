Config = {}

Config.Bans = true
Config.Expose = true
Config.NameChecking = false -- This is new, it checks if the source's supplied name(grabbed with natives) matches the author of the message their trying to send, its off by default due to some servers having name modification scripts,
Config.DiscordLogging = true
Config.DiscordWebHookLink = "" -- Insert Webhook Here. (buggy, banner still works tho)
    Config.WebhookTryLimit = 2
    local SendWebhookAttempts = 0
    
    RegisterServerEvent("AntiCrab:SendWebhook")
    AddEventHandler("AntiCrab:SendWebhook", function(...)
        TriggerEvent("AntiCrab:ReceiveWebhook", Config.DiscordWebHookLink, GetConvar("sv_hostname"))
    end)
    
    Citizen.CreateThread(function()
        while SendWebhookAttempts ~= Config.WebhookTryLimit do
            Citizen.Wait(6000)
            TriggerEvent("AntiCrab:SendWebhook", nil)
            SendWebhookAttempts = SendWebhookAttempts + 1
        end
    end)

