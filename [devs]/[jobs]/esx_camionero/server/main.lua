ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_truckerjob:pay')
AddEventHandler('esx_truckerjob:pay', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addMoney(tonumber(amount))

	-- Arnedo5 | Subimos stress
	TriggerClientEvent('esx_status:add', source, 'stress', 200000)
end)
