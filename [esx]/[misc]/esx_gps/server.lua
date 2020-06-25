ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('ex_gps:enable')
AddEventHandler('ex_gps:enable', function(idPlayerBlip)

    local _source = source
	local xPlayers = ESX.GetPlayers()
    local ped = GetPlayerPed(_source)
    
    if idPlayerBlip ~= nil then

        TriggerEvent('es:getPlayers', function(players)
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                
                if xPlayer.job.name == 'police' then -- En caso de que el jugador sea policia y este en servicio
                
                    print(xPlayer.name)
                    TriggerClientEvent('esx_gps:enable', xPlayers[i], idPlayerBlip)
    
                end
            end
        end)

    end

end)


RegisterServerEvent('esx_gps:disable')
AddEventHandler('esx_gps:disable', function(idPlayerBlip)

    local _source = source
	local xPlayers = ESX.GetPlayers()
    local ped = GetPlayerPed(_source)
    
    if idPlayerBlip ~= nil then

        TriggerEvent('es:getPlayers', function(players)
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                
                if xPlayer.job.name == 'police' or xPlayer.job.name == 'offpolice' then -- En caso de que el jugador sea policia y este dentro o fuera de servicio
                
                    TriggerClientEvent('esx_gps:disable', xPlayers[i], idPlayerBlip)
    
                end
            end
        end)

    end
	
    
end)

