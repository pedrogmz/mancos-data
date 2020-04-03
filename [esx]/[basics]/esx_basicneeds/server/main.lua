ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--SHOPS
ESX.RegisterUsableItem('cigarrett', function(source) --Cigarro
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cigarrett', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', -200000)
	TriggerClientEvent('esx_basicneeds:OnSmokeCigarett', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_cigar'))

	-- Stress system
	TriggerClientEvent('esx_status:remove', source, 'stress', 100000)
	TriggerClientEvent('esx_basicneeds:removeStress', source)
end)


ESX.RegisterUsableItem('bread', function(source)  -- Pan
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 150000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
end)

ESX.RegisterUsableItem('potatoes', function(source)  -- Patatas
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('potatoes', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_potatoes'))
end)

ESX.RegisterUsableItem('sopa', function(source) -- Sopa 
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sopa', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_sopa'))
end)

ESX.RegisterUsableItem('hamburger', function(source)  -- Hamburguesa
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hamburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 750000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_hamburger'))
end)

ESX.RegisterUsableItem('pasteldecarne', function(source)  -- Pastel de carne
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('pasteldecarne', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 750000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
end)


ESX.RegisterUsableItem('water', function(source)  -- Agua
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_water'))
end)

ESX.RegisterUsableItem('ecola', function(source)  -- Ecola
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('ecola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 750000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_ecola'))
end)

ESX.RegisterUsableItem('sprunk', function(source) -- Sprunk
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sprunk', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 750000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_sprunk'))
end)

-- Alcohol
ESX.RegisterUsableItem('whisky', function(source) -- Whisky

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
    TriggerClientEvent('esx_status:remove', source, 'hunger', 10000)
    TriggerClientEvent('esx_status:remove', source, 'thirst', 70000)
    TriggerClientEvent('esx_basicneeds:onDrinkAlcohol', source) -- Animaciómn de beber alcohol
	TriggerClientEvent('esx:showNotification', source, _U('used_whisky'))

	-- Stress system
	TriggerClientEvent('esx_status:remove', source, 'stress', 150000)
	TriggerClientEvent('esx_basicneeds:removeStress', source)
end)

-- Arnedo5 | Adrenaline
ESX.RegisterUsableItem('adrenaline_shot', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('adrenaline_shot', 1)
	TriggerClientEvent('esx:showNotification', source, _U('used_adrenaline'))
	TriggerClientEvent('esx_basicneeds:onAdrenaline', source)
end)

-- Arnedo5 | Gas Mask
ESX.RegisterUsableItem('gas_mask', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

	-- xPlayer.removeInventoryItem('used_gas_mask', 1) -- En este caso no eliminamos el item
	TriggerClientEvent('esx:showNotification', source, _U('used_gas_mask'))
	TriggerClientEvent('esx_basicneeds:onGasMask', source)
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
				TriggerClientEvent('chat:addMessage', source, { args = { '^5HEAL', 'Has sido curado.' } })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'El jugador no esta online' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Id de jugador no valida.' } })
		end
	else
		print(('esx_basicneeds: %s healed self'):format(GetPlayerIdentifier(source, 0)))
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Permisos insuficientes.' } })
end, {help = 'Cura a un jugador o a ti mismo: restaura la sed, el hambre y la salud.', params = {{name = 'playerId', help = '(Opcional) player id'}}})