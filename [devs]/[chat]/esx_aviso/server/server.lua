ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_aviso:notify')
AddEventHandler('esx_aviso:notify', function(notification, id)

    TriggerClientEvent('esx_service:notifyAllInService', id, notification, source)
    
end)
