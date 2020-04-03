ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('mancos_arrest:request_arrest')
AddEventHandler('mancos_arrest:request_arrest', function(targetid, playerheading, playerCoords,  playerlocation)
    TriggerClientEvent('mancos_arrest:get_arrested', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('mancos_arrest:do_arrested', source)
end)

RegisterServerEvent('mancos_arrest:request_release')
AddEventHandler('mancos_arrest:request_release', function(targetid, playerheading, playerCoords,  playerlocation)
    TriggerClientEvent('mancos_arrest:get_uncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('mancos_arrest:do_uncuffing', source)
end)
