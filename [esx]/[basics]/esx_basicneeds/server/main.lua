ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--SHOPS
ESX.RegisterUsableItem('cigarrett', function(source) --Cigarro
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cigarrett', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', -10000)
	TriggerClientEvent('esx_basicneeds:OnSmokeCigarett', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_cigar'))
end)


ESX.RegisterUsableItem('bread', function(source)  -- pan
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 150000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
end)

ESX.RegisterUsableItem('potatoes', function(source)  -- patatas
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('potatoes', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_potatoes'))
end)

ESX.RegisterUsableItem('sopa', function(source) -- sopa 
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sopa', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_sopa'))
end)

ESX.RegisterUsableItem('hamburger', function(source)  -- hamburguesa
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hamburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 750000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_hamburger'))
end)

ESX.RegisterUsableItem('pasteldecarne', function(source)  -- pastel de carne
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('pasteldecarne', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 750000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
end)


ESX.RegisterUsableItem('water', function(source)  -- agua
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_water'))
end)
ESX.RegisterUsableItem('ecola', function(source)  -- ecola
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('ecola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 750000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_ecola'))
end)

ESX.RegisterUsableItem('sprunk', function(source) -- sprunk
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sprunk', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 750000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_sprunk'))
end)

-- Alcohol


ESX.RegisterUsableItem('whisky', function(source) -- whisky
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
    TriggerClientEvent('esx_status:remove', source, 'hunger', 10000)
    TriggerClientEvent('esx_status:remove', source, 'thirst', 70000)
    TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_whisky'))
end)

TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local playerId = tonumber(args[1])

		-- is the argument a number?
		if playerId then
			-- is the number a valid player?
			if GetPlayerName(playerId) then
				print(('esx_basicneeds: %s healed %s'):format(GetPlayerIdentifier(source, 0), GetPlayerIdentifier(playerId, 0)))
				TriggerClientEvent('esx_basicneeds:healPlayer', playerId)
				TriggerClientEvent('chat:addMessage', source, { args = { '^5HEAL', 'You have been healed.' } })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player id.' } })
		end
	else
		print(('esx_basicneeds: %s healed self'):format(GetPlayerIdentifier(source, 0)))
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', params = {{name = 'playerId', help = '(optional) player id'}}})