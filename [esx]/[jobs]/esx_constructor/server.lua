ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj 
end)

RegisterServerEvent('uwu:startANIAMTIEpicammer')
AddEventHandler('uwu:startANIAMTIEpicammer', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source

    if xPlayer.job.name == 'builder' then
        TriggerClientEvent('esx:showNotification', _source, " ~h~~p~Has comenzado a trabajar ! \n~o~~h~\n[TALADRADORA]")
    end
end)


RegisterServerEvent('uwu:BANIIIpicammer')
AddEventHandler('uwu:BANIIIpicammer', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source
    local random = math.random(15, 20)

    if xPlayer.job.name == 'builder' then
        xPlayer.addMoney(random)
        TriggerClientEvent('esx:showNotification', _source, " ~h~~p~Necesitas un descanso! \n~o~~h~\n[TALADRADORA]\n~g~\nPAGADO:[" .. random ..  "$]")
    end
end)

RegisterServerEvent('uwu:startANIAMTIEciocan')
AddEventHandler('uwu:startANIAMTIEciocan', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source

    if xPlayer.job.name == 'builder' then
        TriggerClientEvent('esx:showNotification', _source, " ~h~~p~Has comenzado a trabajar ! \n~c~~h~\n[MARTILLO]")
    end
end)

RegisterServerEvent('uwu:BANIIIciocan')
AddEventHandler('uwu:BANIIIciocan', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source

    if xPlayer.job.name == 'builder' then
        local random = math.random(11, 15)
        xPlayer.addMoney(random)
        TriggerClientEvent('esx:showNotification', _source, " ~h~~p~Necesitas un descanso! ! \n~c~~h~\n[MARTILLO]\n~g~\nPAGADO:[" .. random ..  "$]")
    end
end)


RegisterServerEvent('uwu:startANIAMTIEsudat')
AddEventHandler('uwu:startANIAMTIEsudat', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source

    if xPlayer.job.name == 'builder' then
        TriggerClientEvent('esx:showNotification', _source, " ~h~~p~Has comenzado a trabajar ! \n~w~~h~\n[SOLDADURA]")
    end
end)

RegisterServerEvent('uwu:BANIIIsudat')
AddEventHandler('uwu:BANIIIsudat', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local _source = source

    if xPlayer.job.name == 'builder' then
        local random = math.random(8, 11)
        xPlayer.addMoney(random)
        TriggerClientEvent('esx:showNotification', _source, " ~h~~p~Necesitas un descanso! ! \n~w~~h~\n[SOLDADURA]\n~g~\nPAGADO:[" .. random ..  "$]")
    end
end)