

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




RegisterServerEvent("Farmcyc:recoleccion1")
AddEventHandler("Farmcyc:recoleccion1", function()

	-- Arnedo5 | Subimos stress
	TriggerClientEvent('esx_status:add', source, 'stress', 5000)


    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	local recoleccionsuerte = math.random(1,100)
	local plastico = xPlayer.getInventoryItem('plastico').count	
	local metal = xPlayer.getInventoryItem('metal').count	
-- recolecta
         if recoleccionsuerte < 50 then

         	   if xPlayer.getInventoryItem('plastico').count >= 40 then
         	TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas plastico')
else 

         	xPlayer.addInventoryItem("plastico", math.random(1,2)) 
         
              end

         elseif recoleccionsuerte > 51 then 
         	
         	if xPlayer.getInventoryItem('metal').count >= 40 then
         	TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas metal')
else 

            xPlayer.addInventoryItem("metal", math.random(1,2)) 
        end

            end 
		
end)


-- procesado plastico

ESX.RegisterServerCallback('Farmcyc:empaquetado:plastico', function (source, cb)
	
	local _source = source
	
	local xPlayer  = ESX.GetPlayerFromId(_source)
			
			if xPlayer.getInventoryItem('cajaconplastico').count >= 10 then

			TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas ~y~Cajas con plastico~w~')

else

				if xPlayer.getInventoryItem('plastico').count >= 4 then


 
					xPlayer.removeInventoryItem('plastico', 4) 
					Citizen.Wait(1000)
					xPlayer.addInventoryItem('cajaconplastico', 1) 

					
	-- Arnedo5 | Subimos stress
	--TriggerClientEvent('esx_status:add', source, 'stress', 100000)

					cb(true)

				else
				TriggerClientEvent('esx:showNotification', source, '~r~No tienes plastico')
				cb(false)
				end
			
      		end

end)

-- procesado metal

ESX.RegisterServerCallback('Farmcyc:empaquetado:metal', function (source, cb)

	
	
	local _source = source
	
	local xPlayer  = ESX.GetPlayerFromId(_source)
			
			if xPlayer.getInventoryItem('cajaconmetal').count >= 10 then

			TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas ~y~Cajas con metal~w~')

else

				if xPlayer.getInventoryItem('metal').count >= 4 then


 
					xPlayer.removeInventoryItem('metal', 4) 
					Citizen.Wait(1000)
					xPlayer.addInventoryItem('cajaconmetal', 1) 

					-- Arnedo5 | Subimos stress
	--TriggerClientEvent('esx_status:add', source, 'stress', 100000)

					cb(true)

				else
				TriggerClientEvent('esx:showNotification', source, '~r~No tienes metal')
				cb(false)
				end
			
      		end

end)

-- venta metal

RegisterNetEvent('Ventademetal')
AddEventHandler('Ventademetal', function()
	local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local metal = xPlayer.getInventoryItem('cajaconmetal').count
    local PrecioMetal = Config.PMetal
   

	-- Arnedo5 | Subimos stress
	--TriggerClientEvent('esx_status:add', source, 'stress', 5000)

if metal > 0 then


    xPlayer.removeInventoryItem('cajaconmetal', 1)
	xPlayer.addMoney(PrecioMetal)
	
		-- Arnedo5 | Subimos stress
		--TriggerClientEvent('esx_status:add', source, 'stress', 100000)
elseif metal < 1 then
	TriggerClientEvent('esx:showNotification', source, '~r~No tienes Cajas con metal para vender')

end

end) 

-- venta plastico

RegisterNetEvent('Ventadeplastico')
AddEventHandler('Ventadeplastico', function()


	local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local plastico = xPlayer.getInventoryItem('cajaconplastico').count
    local PrecioPlastico = Config.PPlastico

if plastico > 0 then


    xPlayer.removeInventoryItem('cajaconplastico', 1)
    Citizen.Wait(500)
	xPlayer.addMoney(PrecioPlastico)
	
		-- Arnedo5 | Subimos stress
		--TriggerClientEvent('esx_status:add', source, 'stress', 100000)
	

elseif plastico < 1 then
	TriggerClientEvent('esx:showNotification', source, '~r~No tienes Cajas con plastico para vender')

end

end)
