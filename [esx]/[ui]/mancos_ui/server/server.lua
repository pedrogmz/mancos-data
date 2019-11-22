ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)





-- Buscamos a todos los usuarios en servicio
RegisterServerEvent('mancosui:getusers')
AddEventHandler('mancosui:getusers', function(robb)

	local _source = source
    local xPlayers = ESX.GetPlayers()
    local policeonline = 0
    local emsonline = 0
    local taxionline = 0
    local mechaniconline = 0
    local barmanonline = 0
    local cardeleronline = 0
    local tenderonline = 0
    local data = {};

	for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
         
 		if xPlayer.job.name == 'police' then policeonline = policeonline + 1  end
        if xPlayer.job.name == 'ambulance' then emsonline = emsonline + 1	end
        if xPlayer.job.name == 'taxi' then taxionline = taxionline + 1	end
        if xPlayer.job.name == 'mechanic' then mechaniconline = mechaniconline + 1	end
        if xPlayer.job.name == 'barman' then barmanonline = barmanonline + 1	end
        if xPlayer.job.name == 'cardealer' then cardeleronline = cardeleronline + 1	end
        if xPlayer.job.name == '247' then tenderonline = tenderonline + 1	end
        
    end

    data.policeonline = policeonline
    data.emsonline = emsonline
    data.taxionline = taxionline
    data.mechaniconline = mechaniconline
    data.barmanonline = barmanonline
    data.cardeleronline = cardeleronline
    data.tenderonline = tenderonline
    
    TriggerClientEvent('mancosui:sendjobs', _source, data)
	
end)