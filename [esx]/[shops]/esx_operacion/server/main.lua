ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_operacion:pay')
AddEventHandler('esx_operacion:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(Config.Price)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Price)))
end)

ESX.RegisterServerCallback('esx_operacion:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.getMoney() >= Config.Price)
end)
