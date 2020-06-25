ESX = nil

-- Obtener el steam id
RegisterServerEvent('getIdentifiers')
AddEventHandler('getIdentifiers', function()
    local msg = ""
    local _source = source

    TriggerClientEvent("redirect", _source,'redirect', GetPlayerIdentifiers(_source)[1])

end)