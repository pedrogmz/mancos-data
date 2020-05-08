ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

-- BILLS WITHOUT ESX_BILLING (START)

RegisterServerEvent('esx_speedcamera:PayBill60Zone')
AddEventHandler('esx_speedcamera:PayBill60Zone', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeMoney(500)
end)

RegisterServerEvent('esx_speedcamera:PayBill80Zone')
AddEventHandler('esx_speedcamera:PayBill80Zone', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeMoney(1000)	
end)

RegisterServerEvent('esx_speedcamera:PayBill120Zone')
AddEventHandler('esx_speedcamera:PayBill120Zone', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeMoney(1500)
end)

-- BILLS WITHOUT ESX_BILLING (END)
function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end


-- INSERT INTO BILLING / TABLET_NPENAL
RegisterServerEvent('esx_speedcamera:insert')
AddEventHandler('esx_speedcamera:insert', function(id, description, total, term, plate, SpeedKM, zone)

	local _source = source
    local xPlayerRun = ESX.GetPlayerFromId(id)
	
	-- Calculate date
	local date_table = os.date("*t")
	local ms = string.match(tostring(os.clock()), "%d%.(%d+)")
	local hour, minute, second = date_table.hour, date_table.min, date_table.sec
	local year, month, day = date_table.year, date_table.month, date_table.wday
	local format_date = string.format("%d-%d-%d %d:%d", year, month, day, hour, minute)
   
	if (plate) then

		MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
			['@plate'] = plate
		}, function(result)
			if result[1] ~= nil then

				local xPropertyVehicle =  result[1].owner

				MySQL.Async.execute("INSERT INTO billing (id, identifier, sender, target_type, target, label, amount, term) VALUES (NULL, @identifier, @sender, 'society', 'society_police', @description, @amount, @term)", {
					['@identifier'] = xPropertyVehicle,  -- Propietario dle vehiculo
					['@sender'] = xPropertyVehicle, 		-- Propietario dle vehiculo
					['@description'] = description,
					['@amount'] = total,
					['@term'] = term
				}, function (rowsChanged)
		
					if (rowsChanged >= 1) then

						-- Obtenemos la id del registro insertado
						MySQL.Async.fetchAll("SELECT id FROM billing WHERE identifier = @identifier AND sender = @sender AND amount = @amount AND target = 'society_police' ORDER BY id DESC LIMIT 1", {
							['@identifier'] = xPropertyVehicle,  -- Propietario dle vehiculo
							['@sender'] = xPropertyVehicle,  -- Propietario dle vehiculo
							['@amount'] = total
						}, function(result)

							MySQL.Async.execute("INSERT INTO tablet_npenal (id, TABNIDPENAL, TABNIDENTIFIER, TABNDESCRIPTION, TABNLASTUPDATE, TABNPAID) VALUES (NULL, @id, @sender, @note, @date, 0)", {
								['@id'] = result[1].id,
								['@sender'] = xPropertyVehicle,  -- Propietario del vehiculo
								['@note'] = 'Multa de Radar 50%',
								['@date'] = format_date
							}, function (rowsChanged)
								
								-- Show notification
								TriggerClientEvent("ex_speedcamera:shownotification", _source,  zone, SpeedKM, total * 2, term)

								-- Show notification to owner vehicle
								local xPlayers = ESX.GetPlayers()

								for i=1, #xPlayers, 1 do
									local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

									if xPlayer.identifier == xPropertyVehicle and xPlayerRun.identifier ~=  xPlayer.identifier then

										TriggerClientEvent('esx:showNotification', xPlayers[i], "Si vehiculo con matrícula ["..plate.."] ha sido atrapado por exceso de velocidad.")
									end
									
							   end

							end)
		
						end)
		
					end
				end)

			else
				-- Coche robado o matricula no encontrada
			end
		end)

		

	end

end)


-- Arnedo5 | Detector de radares
ESX.RegisterServerCallback('esx_speedcamera:checkDetector', function(source, cb)
	
	local xPlayer = ESX.GetPlayerFromId(source)
	local total = xPlayer.getInventoryItem('radar_detector').count

	if total >= 1 then
		cb(true)
	else
		cb(false)
	end

end)