ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('cigarett', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cigarett', 1)

	TriggerClientEvent('esx_basicneeds:OnSmokeCigarett', source)
	TriggerClientEvent('esx:showNotification', source, ('Estas fumando un cigarro.'))
end)
