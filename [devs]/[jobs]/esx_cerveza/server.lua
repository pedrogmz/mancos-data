

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




RegisterServerEvent("Farmcyc:recoleccion")
AddEventHandler("Farmcyc:recoleccion", function()

    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	local recoleccionsuerte = math.random(1,100)
	local trigo = xPlayer.getInventoryItem('trigo').count	
	local cebada = xPlayer.getInventoryItem('cebada').count	
-- recolecta
         if recoleccionsuerte < 50 then

         	   if xPlayer.getInventoryItem('trigo').count >= 40 then
         	TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas trigo')
else 

         	xPlayer.addInventoryItem("trigo", math.random(1,2)) 
         
              end

         elseif recoleccionsuerte > 51 then 
         	
         	if xPlayer.getInventoryItem('cebada').count >= 40 then
         	TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas cebada')
else 

            xPlayer.addInventoryItem("cebada", math.random(1,2)) 
        end

            end 
		
end)


-- procesado trigo

ESX.RegisterServerCallback('Farmcyc:empaquetado:trigo', function (source, cb)
	
	local _source = source
	
	local xPlayer  = ESX.GetPlayerFromId(_source)
			
			if xPlayer.getInventoryItem('cajadetrigo').count >= 10 then

			TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas ~y~Cervezas Rubias~w~')

else

				if xPlayer.getInventoryItem('trigo').count >= 4 then


 
					xPlayer.removeInventoryItem('trigo', 4) 
					Citizen.Wait(1000)
					xPlayer.addInventoryItem('cajadetrigo', 1) 

					cb(true)

				else
				TriggerClientEvent('esx:showNotification', source, '~r~No tienes trigo')
				cb(false)
				end
			
      		end

end)

-- procesado cebada

ESX.RegisterServerCallback('Farmcyc:empaquetado:cebada', function (source, cb)
	
	local _source = source
	
	local xPlayer  = ESX.GetPlayerFromId(_source)
			
			if xPlayer.getInventoryItem('cajadecebada').count >= 10 then

			TriggerClientEvent('esx:showNotification', source, '~r~No puedes llevar mas ~y~Cervezas Negras~w~')

else

				if xPlayer.getInventoryItem('cebada').count >= 4 then


 
					xPlayer.removeInventoryItem('cebada', 4) 
					Citizen.Wait(1000)
					xPlayer.addInventoryItem('cajadecebada', 1) 

					cb(true)

				else
				TriggerClientEvent('esx:showNotification', source, '~r~No tienes cebada')
				cb(false)
				end
			
      		end

end)

-- venta cebada

RegisterNetEvent('Ventadecebada')
AddEventHandler('Ventadecebada', function()
	local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local cebada = xPlayer.getInventoryItem('cajadecebada').count
    local PrecioCebada = Config.PCebada
   

if cebada > 0 then


    xPlayer.removeInventoryItem('cajadecebada', 1)
    xPlayer.addMoney(PrecioCebada)
elseif cebada < 1 then
	TriggerClientEvent('esx:showNotification', source, '~r~No tienes Cerveza Negra para vender')

end

end) 

-- venta trigo

RegisterNetEvent('Ventadetrigo')
AddEventHandler('Ventadetrigo', function()
	local _source = source 
    local xPlayer = ESX.GetPlayerFromId(_source)
    local trigo = xPlayer.getInventoryItem('cajadetrigo').count
    local PrecioTrigo = Config.PTrigo

if trigo > 0 then


    xPlayer.removeInventoryItem('cajadetrigo', 1)
    Citizen.Wait(500)
    xPlayer.addMoney(PrecioTrigo)
elseif trigo < 1 then
	TriggerClientEvent('esx:showNotification', source, '~r~No tienes Cerveza Rubia para vender')

end

end)
