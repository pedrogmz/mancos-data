ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

print ("SERVERRR")

-- Arnedo5 Check Money
RegisterServerEvent('hook:money')
AddEventHandler('hook:money', function()


    print ("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")

    local _source = source

    local xPlayer = ESX.GetPlayerFromId(_source)

    print ("ENTERRR")


end)
