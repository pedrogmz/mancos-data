ESX = nil

local cachedData = {}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)
if Config.RebootRestore then
MySQL.ready(function()
	ReturnCars()
end)
end

function ReturnCars()
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE `stored` = @stored', {
		['@stored']      = false
	}, function (rowsChanged)
		if rowsChanged > 0 then
			print(('mancos_garage: %s vehicle(s) have been returned to their garage!'):format(rowsChanged))
		end
	end)
end


ESX.RegisterServerCallback("garage:fetchPlayerVehicles", function(source, callback, garage)
	local player = ESX.GetPlayerFromId(source)

	if player then
		local sqlQuery = [[
			SELECT
				plate, vehicle
			FROM
				owned_vehicles
			WHERE
				owner = @cid
		]]

		if garage then
			if Config.Impound then
				if Config.LockGarage then
					sqlQuery = [[
						SELECT
							plate, vehicle
						FROM
							owned_vehicles
						WHERE
							owner = @cid and garage = @garage and `stored`='1'
					]]
				else
						sqlQuery = [[
						SELECT
							plate, vehicle
						FROM
							owned_vehicles
						WHERE
							owner = @cid and `stored`='1'
					]]
				end

			else
			 	if Config.LockGarage then
					sqlQuery = [[
						SELECT
							plate, vehicle
						FROM
							owned_vehicles
						WHERE
							owner = @cid and garage = @garage
					]]
				else
			sqlQuery = [[
						SELECT
							plate, vehicle
						FROM
							owned_vehicles
						WHERE
							owner = @cid
					]]
				end
		end



		end

		MySQL.Async.fetchAll(sqlQuery, {
			["@cid"] = player["identifier"],
			["@garage"] = garage
		}, function(responses)
			local playerVehicles = {}

			for key, vehicleData in ipairs(responses) do
				table.insert(playerVehicles, {
					["plate"] = vehicleData["plate"],
					["props"] = json.decode(vehicleData["vehicle"])
				})
			end

			callback(playerVehicles)
		end)
	else
		callback(false)
	end
end)

ESX.RegisterServerCallback("garage:validateVehicle", function(source, callback, vehicleProps, garage)
	local player = ESX.GetPlayerFromId(source)

	if player then
		local sqlQuery = [[
			SELECT
				owner
			FROM
				owned_vehicles
			WHERE
				plate = @plate
		]]

		MySQL.Async.fetchAll(sqlQuery, {
			["@plate"] = vehicleProps["plate"]
		}, function(responses)
			if responses[1] then
				UpdateGarage(source, vehicleProps, garage)

				callback(true)
			else
				callback(false)
			end
		end)
	else
		callback(false)
	end
end)

RegisterServerEvent('garage:takecar')
AddEventHandler('garage:takecar', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)
	local src = source
			if Config.EnableLogs then
				msg = GetPlayerName(src) .. " ha sacado el vehiculo con placa: " .. plate
				sendToDiscord(Config.GarageWebhook, Config.ColourInfo, Config.GarageName, msg, " ")
			end
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
			if Config.ImpoundAutoBan then
				TriggerEvent('EasyAdmin:banPlayer', src, Config.AutoBanMessage, 10444633200, "Failed Modder")
			else
				print(('garage: %s exploited the garage!'):format(xPlayer.identifier))
				if Config.EnableLogs then
				msg = xPlayer.identifier .. " intento aprovecharse de un bug."
				sendToDiscord(Config.ImpoundWebhook, Config.ColourExploit, Config.ImpoundName, msg, " ")
			end
			end
		end
	end)
end)



-- Fetch impounded Cars
ESX.RegisterServerCallback('garage:getOutOwnedCars', function(source, cb)
	local ownedCars = {}
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND Type = @Type AND `stored` = @stored', {
		['@owner'] = GetPlayerIdentifiers(source)[1],
		['@Type']   = 'car',
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedCars, vehicle)
		end
		cb(ownedCars)
	end)
end)







-- Check Money for impounded Cars
ESX.RegisterServerCallback('garage:checkMoneyCars', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getAccount('bank').money >= Config.ImpoundPrice then
		cb(true)
	else
		cb(false)
	end
end)

-- Pay for Pounded Cars
RegisterServerEvent('garage:payCar')
AddEventHandler('garage:payCar', function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.EnableLogs then
		msg = GetPlayerName(source) .. " has recovered " .. plate .. " from the impound " 
		sendToDiscord(Config.ImpoundWebhook, Config.ColourInfo, Config.ImpoundName, msg, " ")
	end
	xPlayer.removeAccountMoney('bank', Config.ImpoundPrice)
	TriggerClientEvent('esx:showNotification', source, 'You have paid $' .. Config.ImpoundPrice)
end)


--logging

function sendToDiscord(webhook, color, name, message, footer)
  local embed = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }

  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end
