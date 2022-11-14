ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_outlawalert:carJackInProgress')
AddEventHandler('esx_outlawalert:carJackInProgress', function(targetCoords, streetName, vehicleLabel, playerGender)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_outlawalert:outlawNotify', -1, _U('carjack', playerGender, vehicleLabel, streetName))

	local xPlayers = ESX.GetPlayers()	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('entorno:setBlip', xPlayers[i], name, x, y, z)
			TriggerClientEvent('esx_aviso:sendElement', xPlayers[i], xPlayer.identifier, tonumber(source), 'police', _U('carjack', playerGender, vehicleLabel, streetName), targetCoords.x, targetCoords.y, targetCoords.z) -- Arnedo 5 | Nuevo aviso policia
		end
	end
	--TriggerClientEvent('esx_outlawalert:carJackInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:combatInProgress')
AddEventHandler('esx_outlawalert:combatInProgress', function(targetCoords, streetName)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_outlawalert:outlawNotify', -1, _U('combat', streetName))

	local xPlayers = ESX.GetPlayers()	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('entorno:setBlip', xPlayers[i], name, x, y, z)
			TriggerClientEvent('esx_aviso:sendElement', xPlayers[i], xPlayer.identifier, tonumber(source), 'police', _U('combat', streetName))
		end
	end
	--TriggerClientEvent('esx_outlawalert:combatInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:gunshotInProgress')
AddEventHandler('esx_outlawalert:gunshotInProgress', function(targetCoords, streetName, playerGender)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_outlawalert:outlawNotify', -1, _U('gunshot', playerGender, streetName))

	local xPlayers = ESX.GetPlayers()	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('entorno:setBlip', xPlayers[i], name, x, y, z)
			TriggerClientEvent('esx_aviso:sendElement', xPlayers[i], xPlayer.identifier, tonumber(source), 'police', _U('gunshot', playerGender, streetName))
		end
	end
	--TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:drugsaleInProgress')
AddEventHandler('esx_outlawalert:drugsaleInProgress', function(targetCoords, streetName)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_outlawalert:outlawNotify', -1, _U('drugsale', streetName))

	local xPlayers = ESX.GetPlayers()	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('entorno:setBlip', xPlayers[i], name, x, y, z)
			TriggerClientEvent('esx_aviso:sendElement', xPlayers[i], xPlayer.identifier, tonumber(source), 'police', _U('drugsale', streetName))
		end
	end
	--TriggerClientEvent('esx_outlawalert:drugsaleInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:AtmHackInProgress')
AddEventHandler('esx_outlawalert:AtmHackInProgress', function(targetCoords, streetName)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_outlawalert:outlawNotify', -1, _U('atmhack', streetName))

	local xPlayers = ESX.GetPlayers()	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('entorno:setBlip', xPlayers[i], name, x, y, z)
			TriggerClientEvent('esx_aviso:sendElement', xPlayers[i], xPlayer.identifier, tonumber(source), 'police', _U('atmhack', streetName))
		end
	end
	--TriggerClientEvent('esx_outlawalert:AtmHackInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:TruckRobberyInProgress')
AddEventHandler('esx_outlawalert:TruckRobberyInProgress', function(targetCoords, streetName)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_outlawalert:outlawNotify', -1, _U('truckrobbery', streetName))
	TriggerClientEvent('esx_outlawalert:TruckRobberyInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:RobNPCInProgress')
AddEventHandler('esx_outlawalert:RobNPCInProgress', function(targetCoords, streetName)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_outlawalert:outlawNotify', -1, _U('robnpc', streetName))

	local xPlayers = ESX.GetPlayers()	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('entorno:setBlip', xPlayers[i], name, x, y, z)
			TriggerClientEvent('esx_aviso:sendElement', xPlayers[i], xPlayer.identifier, tonumber(source), 'police', _U('robnpc', streetName))
		end
	end
	--TriggerClientEvent('esx_outlawalert:RobNPCInProgress', -1, targetCoords)
end)

RegisterServerEvent('esx_outlawalert:HoldUpInProgress')
AddEventHandler('esx_outlawalert:HoldUpInProgress', function(targetCoords, streetName)
	if playerGender == 0 then
		playerGender = _U('male')
	else
		playerGender = _U('female')
	end

	TriggerClientEvent('esx_outlawalert:outlawNotify', -1, _U('holdup', streetName))
	TriggerClientEvent('esx_outlawalert:HoldUpInProgress', -1, targetCoords)
end)

ESX.RegisterServerCallback('esx_outlawalert:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)
