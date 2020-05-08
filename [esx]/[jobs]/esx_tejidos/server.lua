

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent("Farmcyc:recoleccion2")
AddEventHandler("Farmcyc:recoleccion2", function()

	-- Arnedo5 | Subimos stress
	TriggerClientEvent('esx_status:add', source, 'stress', 5000)

    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	local recoleccionsuerte = math.random(1,100)
	local algodon = xPlayer.getInventoryItem('algodon').count	
	local lino = xPlayer.getInventoryItem('lino').count	
-- recolecta
         if recoleccionsuerte < 50 then

         	   if xPlayer.getInventoryItem('algodon').count >= 40 then
         	TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas algodon')
else 

         	xPlayer.addInventoryItem("algodon", math.random(1,2)) 
         
              end

         elseif recoleccionsuerte > 51 then 
         	
         	if xPlayer.getInventoryItem('lino').count >= 40 then
         	TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas lino')
else 

            xPlayer.addInventoryItem("lino", math.random(1,2)) 
        end

            end 
		
end)


-- procesado plastico - algodon (lana)

ESX.RegisterServerCallback('Farmcyc:empaquetado:algodon', function (source, cb)

	
	
	local _source = source
	
	local xPlayer  = ESX.GetPlayerFromId(_source)
			
			if xPlayer.getInventoryItem('lana').count >= 10 then

			TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas ~y~Lana~w~')

else

				if xPlayer.getInventoryItem('algodon').count >= 4 then


 
					xPlayer.removeInventoryItem('algodon', 4) 
					Citizen.Wait(1000)
					xPlayer.addInventoryItem('lana', 1) 

					-- Arnedo5 | Subimos stress
	--TriggerClientEvent('esx_status:add', source, 'stress', 100000)

					cb(true)

				else
				TriggerClientEvent('esx:showNotification', source, '~r~No tienes ~y~Algodón~w~')
				cb(false)
				end
			
      		end

end)

-- procesado metal - lino (tela)

ESX.RegisterServerCallback('Farmcyc:empaquetado:lino', function (source, cb)


	
	local _source = source
	
	local xPlayer  = ESX.GetPlayerFromId(_source)
			
			if xPlayer.getInventoryItem('tela').count >= 10 then

			TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas ~y~Tela~w~')

else

				if xPlayer.getInventoryItem('lino').count >= 4 then


 
					xPlayer.removeInventoryItem('lino', 4) 
					Citizen.Wait(1000)
					xPlayer.addInventoryItem('tela', 1) 

						-- Arnedo5 | Subimos stress
	--TriggerClientEvent('esx_status:add', source, 'stress', 100000)

					cb(true)

				else
				TriggerClientEvent('esx:showNotification', source, '~r~No tienes ~y~Lino~w~')
				cb(false)
				end
			
      		end

end)

-- venta metal - lino (tela)

RegisterNetEvent('Ventadelino')
AddEventHandler('Ventadelino', function()


	local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local lino = xPlayer.getInventoryItem('tela').count
    local PrecioLino = Config.PLino
   

if lino > 0 then


    xPlayer.removeInventoryItem('tela', 1)
	xPlayer.addMoney(PrecioLino)
	
		-- Arnedo5 | Subimos stress
		--TriggerClientEvent('esx_status:add', source, 'stress', 100000)

elseif lino < 1 then
	TriggerClientEvent('esx:showNotification', source, '~r~No tienes ~y~Tela~w~ para vender')

end

end) 

-- venta plastico - algodón (lana)

RegisterNetEvent('Ventadealgodon')
AddEventHandler('Ventadealgodon', function()


	local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local algodon = xPlayer.getInventoryItem('lana').count
    local PrecioAlgodon = Config.PAlgodon

if algodon > 0 then


    xPlayer.removeInventoryItem('lana', 1)
    Citizen.Wait(500)
	xPlayer.addMoney(PrecioAlgodon)
	
	-- Arnedo5 | Subimos stress
	--TriggerClientEvent('esx_status:add', source, 'stress', 100000)

elseif algodon < 1 then
	TriggerClientEvent('esx:showNotification', source, '~r~No tienes ~y~Lana~w~ para vender')

end

end)
