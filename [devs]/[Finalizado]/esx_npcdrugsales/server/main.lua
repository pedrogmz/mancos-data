ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local selling = false
	local success = false
	local copscalled = false
	local notintrested = false
  local CopsConnected = 0

function CountCops()

  local xPlayers = ESX.GetPlayers()

  CopsConnected = 0

  for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    if xPlayer.job.name == 'police' then
      CopsConnected = CopsConnected + 1
    end
  end

  SetTimeout(5000, CountCops)

end

CountCops()

  RegisterNetEvent('drugs:triggerBarrioNegro')
  AddEventHandler('drugs:triggerBarrioNegro', function()
	selling = true
	    if selling == true then
			TriggerEvent('pass_or_failBarrioNegro')
 	end
end)

    RegisterNetEvent('drugs:triggerPier')
  AddEventHandler('drugs:triggerPier', function()
	selling = true
	    if selling == true then
			TriggerEvent('pass_or_failPier')
 	end
end)
--[[
    RegisterNetEvent('drugs:triggerZonaRica')
  AddEventHandler('drugs:triggerZonaRica', function()
	selling = true
	    if selling == true then
			TriggerEvent('pass_or_failZonaRica')
 	end
end)
]]


RegisterNetEvent('drugs:sellBarrioNegro')
AddEventHandler('drugs:sellBarrioNegro', function()
    local xPlayer = ESX.GetPlayerFromId(source)
  local porros = xPlayer.getInventoryItem('porros').count
  local paymentPorros = math.random (300,400)

  local cantidadPorrosBarrioNegro = math.random (1,5)
    if CopsConnected > 0 then
      if porros >= cantidadPorrosBarrioNegro and success == true then
        TriggerClientEvent("animation", source)
        xPlayer.removeInventoryItem('porros', cantidadPorrosBarrioNegro)
          xPlayer.addMoney(paymentPorros * cantidadPorrosBarrioNegro)
          selling = false
        end
    end
end)

RegisterNetEvent('drugs:sellPier')
AddEventHandler('drugs:sellPier', function()
    local xPlayer = ESX.GetPlayerFromId(source)
  local porros = xPlayer.getInventoryItem('porros').count
  local paymentPorros = math.random (600,800)

  local cantidadPorrosPier = math.random (1,5)
    if CopsConnected > 0 then
      if porros >= cantidadPorrosPier and success == true then
        TriggerClientEvent("animation", source)
        xPlayer.removeInventoryItem('porros', cantidadPorrosPier)
          xPlayer.addMoney(paymentPorros * cantidadPorrosPier)
          selling = false
        end
    end
end)

--[[
RegisterNetEvent('drugs:sellZonaRica')
AddEventHandler('drugs:sellZonaRica', function()
  	local xPlayer = ESX.GetPlayerFromId(source)
	local porros = xPlayer.getInventoryItem('porros').count
	local paymentPorros = math.random (400,600)

  local cantidadPorrosZonaRica = math.random (1,5)
    if CopsConnected > 0 then
  		if porros >= cantidadPorrosZonaRica and success == true then
  			TriggerClientEvent("animation", source)
  			xPlayer.removeInventoryItem('porros', cantidadPorrosZonaRica)
          xPlayer.addMoney(paymentPorros * cantidadPorrosZonaRica)
    			selling = false
    		end
    end
end)
]]

RegisterNetEvent('pass_or_failBarrioNegro')
AddEventHandler('pass_or_failBarrioNegro', function()
      success = true
      notintrested = false
end)

RegisterNetEvent('pass_or_failPier')
AddEventHandler('pass_or_failPier', function()
  		success = true
      notintrested = false
end)
--[[
RegisterNetEvent('pass_or_failZonaRica')
AddEventHandler('pass_or_failZonaRica', function()
  		success = true
      notintrested = false
end)
]]

RegisterNetEvent('sell_dis')
AddEventHandler('sell_dis', function()
		TriggerClientEvent("notifyc", source)
end)

RegisterNetEvent('checkD')
AddEventHandler('checkD', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local porros = xPlayer.getInventoryItem('porros').count

	if porros >= 1 then
		TriggerClientEvent("checkR", source, true)
	else
		TriggerClientEvent("checkR", source, false)
	end

end)
