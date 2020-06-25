ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('loffe_burglary:getDoorFreezeStatus', function(source, cb, house)
    cb(Config.Burglary[house].Door.Frozen)
end)

ESX.RegisterServerCallback('loffe_burglary:getDoorHealth', function(source, cb, house)
    cb(Config.Burglary[house].Door.Health)
end)

RegisterServerEvent('loffe_burglary:setDoorFreezeStatus')
AddEventHandler('loffe_burglary:setDoorFreezeStatus', function(house, status)
    if status == false then
        local src = source
        local cops = 0
        local xPlayers = ESX.GetPlayers()
        for i = 1, #xPlayers do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then
                cops = cops + 1
            end
        end
        if cops >= Config.Burglary[house].Cops then
            Config.Burglary[house].Door.Frozen = status
        else
            sendNotification(src, 'Hay gente dentro de la casa. ¡Vete de aquí!', 'error', 3500)
        end
    else
        Config.Burglary[house].Door.Frozen = status
        Config.Burglary[house].Door.Health = 1000
        TriggerClientEvent('loffe_burglary:setHealth', -1, house, Config.Burglary[house].Door.Health)
    end
    TriggerClientEvent('loffe_burglary:setFrozen', -1, house, Config.Burglary[house].Door.Frozen)
end)

RegisterServerEvent('loffe_burglary:setDoorHealth')
AddEventHandler('loffe_burglary:setDoorHealth', function(house, health)
    local src = source
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end
    if cops >= Config.Burglary[house].Cops then
        Config.Burglary[house].Door.Health = health
    else
        sendNotification(src, 'Hay gente dentro de la casa. ¡Vete de aquí!', 'error', 3500)
    end
    TriggerClientEvent('loffe_burglary:setHealth', -1, house, Config.Burglary[house].Door.Health)
end)

RegisterServerEvent('loffe_burglary:loot')
AddEventHandler('loffe_burglary:loot', function(house, furniture)
    local src = source
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end
    if cops >= Config.Burglary[house].Cops then
        Config.Burglary[house].MultipleSearch[furniture].Items = Config.Burglary[house].MultipleSearch[furniture].Items - 1
        TriggerClientEvent('loffe_burglary:setItems', -1, house, furniture, Config.Burglary[house].MultipleSearch[furniture].Items)
        Wait(6500)
        local xPlayer = ESX.GetPlayerFromId(src)
        local randomItem = math.random(1, #Config.Items)
        local randomAmount = math.random(1, 3)
        if Config.Items[randomItem].Amount ~= nil then
            xPlayer.addInventoryItem(Config.Items[randomItem].Name, Config.Items[randomItem].Amount)
            sendNotification(src, 'Has encontrado ' .. Config.Items[randomItem].Amount .. ' ' .. Config.Items[randomItem].Label)
        else
            xPlayer.addInventoryItem(Config.Items[randomItem].Name, randomAmount)
            sendNotification(src, 'Has encontrado ' .. randomAmount .. ' ' .. Config.Items[randomItem].Label)
        end
    else
        sendNotification(src, 'Hay gente dentro de la casa. ¡Vete de aquí!', 'error', 3500)
    end
end)

function sendNotification(xSource, message, messageType, messageTimeout)
    TriggerClientEvent("pNotify:SendNotification", xSource, {
        text = message,
        type = messageType,
        queue = "lmfao",
        timeout = messageTimeout,
        layout = "bottomCenter"
    })
end

AddEventHandler('roboCasaProgress', function(position)
    local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Policia', 'Ruidos', "Se estan escuchando ruidos de una puerta y disparos, piu piu!", 'CHAR_CALL911', 0)
            TriggerClientEvent('roboPlace', xPlayers[i], position)
    --TriggerClientEvent("outlawNotify", -1, "~r~Venta de drogas por ~w~"..sex.."~r~near~w~"..street1.."~r~ and ~w~"..street2)
    --TriggerClientEvent("roboHouseEntorno", -1, "~r~Se escuchan ruidos que golpean una puerta!")
        end
    end
    --TriggerClientEvent('esx:showAdvancedNotification', -1, 'title', 'subject', 'msg', 'CHAR_AMMUNATION', 0)
end)

RegisterServerEvent('roboCasaProgress')
AddEventHandler('roboCasaProgress', function(gx, gy, gz)
	TriggerClientEvent('roboPlace', gx, gy, gz)
end)