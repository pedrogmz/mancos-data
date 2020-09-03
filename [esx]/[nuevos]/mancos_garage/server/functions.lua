ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


UpdateGarage = function(source, vehicleProps, newGarage)
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.EnableLogs then
		msg = GetPlayerName(source) .. " guardo el vehiculo con placa: " .. vehicleProps["plate"] .. " en el garage: " .. newGarage 
		sendToDiscord(Config.GarageWebhook, Config.ColourInfo, Config.GarageName, msg, " ")
	end
	local sqlQuery = [[
		UPDATE
			owned_vehicles
		SET
			garage = @garage, vehicle = @newVehicle, `stored`='1', modelo = @modelo
		WHERE
			plate = @plate
	]]

	MySQL.Async.execute(sqlQuery, {
		["@plate"] = vehicleProps["plate"],
		["@modelo"] = vehicleProps["modelo"],
		["@garage"] = newGarage,
		["@newVehicle"] = json.encode(vehicleProps)
	}, function(rowsChanged)

		if rowsChanged > 0 then
			
		end
	end)
end