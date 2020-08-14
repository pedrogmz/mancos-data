ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_venta:hacerPorros')
AddEventHandler('esx_venta:hacerPorros', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xBolsasMaria  = xPlayer.getInventoryItem('bagofdope')
	local xPapel =  xPlayer.getInventoryItem('papel')
	local xPorros =  xPlayer.getInventoryItem('porros')

	if xPorros.limit ~= -1 and (xPorros.count + 1) >= xPorros.limit then
		TriggerClientEvent('esx:showNotification', _source, "~r~No puedes llevas más porros.")
	end
	if xPapel.count < 2 then
		TriggerClientEvent('esx:showNotification', _source, "~r~Necesitas mínimo dos papeles.")
	end
	if xPapel.count > 1 then
		if xBolsasMaria.count > 0 then
			xPlayer.removeInventoryItem('bagofdope', 1)
			xPlayer.removeInventoryItem('papel', 2)
			xPlayer.addInventoryItem('porros', 2)
		else
			TriggerClientEvent('esx:showNotification', _source, "~r~Necesitas una bolsa de marihuana.")
		end
	end
end)

ESX.RegisterUsableItem('bagofdope', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPapel = xPlayer.getInventoryItem('papel')
	
		if xPapel.count > 1 then
			xPlayer.removeInventoryItem('papel', 2)
			xPlayer.removeInventoryItem('bagofdope', 1)
			xPlayer.addInventoryItem('porros', 2)
			TriggerEvent('esx_venta:hacerPorros')
		else
			TriggerClientEvent('esx:showNotification', source, "~r~Necesitas minimo dos papeles para hacer un porro")
		end
end)

ESX.RegisterUsableItem('porros', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('porros', 1)

	TriggerClientEvent('esx_venta:onPot', _source)
end)
