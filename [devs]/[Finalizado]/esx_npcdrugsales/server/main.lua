ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local selling = false
	local success = false
	local copscalled = false
	local notintrested = false

RegisterNetEvent('drugs:trigger')
AddEventHandler('drugs:trigger', function()
	selling = true

	if selling == true then
		TriggerEvent('pass_or_fail')
--		TriggerClientEvent("npcgrugsales:shownotification", source, _U('trying_convince')) -- Raspu 
	end
end)

RegisterServerEvent('fetchjob')
AddEventHandler('fetchjob', function()
    local xPlayer  = ESX.GetPlayerFromId(source)
    TriggerClientEvent('getjob', source, xPlayer.job.name)
end)


  RegisterNetEvent('drugs:sell')
  AddEventHandler('drugs:sell', function(currentZone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local totalCops = CountCops()
	local nameDrug  = ""
	local randomSell = math.random (1,3)
	local price = nil

	if totalCops >= 4 then totalCops = 4 end -- En caso de haber + de 4 policias en servicio

	

	for i, name in ipairs(Config.Zones[currentZone].Authorized_drugs) do
		
		local total = xPlayer.getInventoryItem(name).count
		nameDrug = xPlayer.getInventoryItem(name).label

		-- Not interested
		if success == false and notintrested == true and copscalled == false then
			TriggerClientEvent("animation", source, "shrug2")
			TriggerClientEvent("npcgrugsales:shownotification", source, _U('not_interested'))
			selling = false
		
			return
		-- Calls cops
		elseif success == false and notintrested == false and copscalled == true then 

			TriggerClientEvent("animation", source, "shrug2")
			TriggerClientEvent("notifyc", source) -- Avisar a la policía
			TriggerClientEvent("npcgrugsales:shownotification", source, _U('not_interested'))
			-- TriggerClientEvent("npcgrugsales:shownotification", source, "Están llamando a la policía")
			selling = false

			return

		else -- All okey

			if total >= randomSell and total > 0 then
				price = Config.Zones[currentZone].Prices["Police"..totalCops]*randomSell

				TriggerClientEvent("animation", source, "keyfob")
				xPlayer.removeInventoryItem(name, randomSell)
				xPlayer.addAccountMoney('black_money', price)

				TriggerClientEvent("npcgrugsales:shownotification", source, "Has vendido "..randomSell.." de ~y~"..nameDrug.."~w~ por ~g~"..price.."$")
				selling = false

				return
			elseif total > 0 then
				price = Config.Zones[currentZone].Prices["Police"..totalCops]

				TriggerClientEvent("animation", source, "keyfob")
				xPlayer.removeInventoryItem(name, 1)
				xPlayer.addAccountMoney('black_money', price)

				TriggerClientEvent("npcgrugsales:shownotification", source, "Has vendido 1 de ~y~"..nameDrug.."~w~ por ~g~"..price.."$")
				selling = false

				return
			end

		end

	end

end)

RegisterNetEvent('pass_or_fail')
AddEventHandler('pass_or_fail', function()

		local percent = math.random(1, 11)
		  print(percent)
  		if percent == 7 or percent == 8 or percent == 9 then
  			success = false
			notintrested = true
			copscalled = false
  		elseif percent == 2 or percent == 3 or percent == 4 or percent == 5 or percent == 6 then
  			success = true
			notintrested = false
			copscalled = false
		  else
  			notintrested = false
  			success = false
  			copscalled = true
  		end
end)

RegisterNetEvent('sell_dis')
AddEventHandler('sell_dis', function()

	TriggerClientEvent("npcgrugsales:shownotification", source, _U('out'))

end)

ESX.RegisterServerCallback('esx_npcdrugsales:checkDrugs', function(source, cb, currentZone)
	
	local xPlayer = ESX.GetPlayerFromId(source)
	local hasDrugs = false

	for i, name in ipairs(Config.Zones[currentZone].Authorized_drugs) do
		
		local total = xPlayer.getInventoryItem(name).count

		if total >= 1 then
			hasDrugs = true
		end
	end

	cb(hasDrugs)

end)

function CountCops()

	local xPlayers = ESX.GetPlayers()
  
	CopsConnected = 0
  
	for i=1, #xPlayers, 1 do
	  local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	  if xPlayer.job.name == 'police' then
		CopsConnected = CopsConnected + 1
	  end
	end
  
	return CopsConnected
  
  end