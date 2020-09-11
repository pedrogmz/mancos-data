ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bread', function(source) --Pan
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has comido ~y~1x~s~ ~b~Pan~s~')
end)

ESX.RegisterUsableItem('potatoes', function(source)  -- Patatas
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('potatoes', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', 'Has comido ~y~1x~s~ ~b~Patatas fritas~s~')
end)

ESX.RegisterUsableItem('sopa', function(source) -- Sopa 
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sopa', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has tomado ~y~1x~s~ ~b~Sopa~s~')
end)

ESX.RegisterUsableItem('hamburger', function(source)  -- Hamburguesa
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hamburger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 750000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has comido ~y~1x~s~ ~b~Hamburguesa~s~')
end)

ESX.RegisterUsableItem('pasteldecarne', function(source)  -- Pastel de carne
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('pasteldecarne', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 750000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has comido ~y~1x~s~ ~b~Pastel de Carne~s~')
end)

ESX.RegisterUsableItem('water', function(source) -- Agua
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Botella de agua~s~')
end)

ESX.RegisterUsableItem('ecola', function(source)  -- Ecola
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('ecola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 750000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Ecola~s~')
end)

ESX.RegisterUsableItem('sprunk', function(source) -- Sprunk
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sprunk', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 750000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Sprunk~s~')
end)

ESX.RegisterUsableItem('jagerbomb', function(source) -- Jagerbomb
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jagerbomb', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Jaguerbomb~s~')
end)
ESX.RegisterUsableItem('golem', function(source) -- golem
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('golem', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Golem~s~')
end)
ESX.RegisterUsableItem('whiskycoca', function(source) -- whiskycoca
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whiskycoca', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 550000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Whisky cola~s~')
end)
ESX.RegisterUsableItem('vodkaenergy', function(source) --vodkaenergy
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodkaenergy', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 450000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Vodka-energy~s~')
end)
ESX.RegisterUsableItem('vodkafruit', function(source) -- vodkafruit
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodkafruit', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Vodka con Zumo de Frutas~s~')
end)
ESX.RegisterUsableItem('rhumfruit', function(source) -- rhumfruit
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhumfruit', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Ron con Zuo de Frutas~s~')
end)
ESX.RegisterUsableItem('teqpaf', function(source) -- teqpaf
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('teqpaf', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Chupito de Tequila~s~')
end)
ESX.RegisterUsableItem('rhumcoca', function(source) -- rhumcoca
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhumcoca', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~RonCola~s~')
end)
ESX.RegisterUsableItem('mojito', function(source) -- mojito
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('mojito', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 150000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Mojito~s~')
end)
ESX.RegisterUsableItem('metreshooter', function(source) -- metreshooter
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('metreshooter', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Chupito~s~')
end)
ESX.RegisterUsableItem('jagercerbere', function(source) -- jagercerbere
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jagercerbere', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 150000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Jagercerbere~s~')
end)
ESX.RegisterUsableItem('jager', function(source) -- jager
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jager', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Jager~s~')
end)
ESX.RegisterUsableItem('vodka', function(source) -- vodka
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodka', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 400000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Vodka~s~')
end)
ESX.RegisterUsableItem('rhum', function(source) -- rhum
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhum', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Ron~s~')
end)
ESX.RegisterUsableItem('whisky', function(source) -- whisky
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 500000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Whisky~s~')
end)
ESX.RegisterUsableItem('tequila', function(source) -- tequila
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('tequila', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 400000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Tequila~s~')
end)
ESX.RegisterUsableItem('martini', function(source) -- martini
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('martini', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Martini~s~')
end)
ESX.RegisterUsableItem('soda', function(source) -- soda
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('soda', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 550000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Soda~s~')
end)
ESX.RegisterUsableItem('jusfruit', function(source) -- jusfruit
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('jusfruit', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 550000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Zumo de frutas~s~')
end)
ESX.RegisterUsableItem('icetea', function(source) -- icetea
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('icetea', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 550000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Té Helado~s~')
end)
ESX.RegisterUsableItem('energy', function(source) -- energy
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('energy', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 450000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Bebida energética~s~')
end)
ESX.RegisterUsableItem('drpepper', function(source) -- drpepper
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('drpepper', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 750000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Dr.Pepper~s~')
end)
ESX.RegisterUsableItem('limonade', function(source) --limonade
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('limonade', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 650000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Has bebido ~y~1x~s~ ~b~Limonada~s~')
end)
-- Solidos
ESX.RegisterUsableItem('mixapero', function(source) --mixapero
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('mixapero', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_status:remove', source, 'thirst', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has comido ~y~1x~s~ ~b~Frutos Secos~s~')
end)
ESX.RegisterUsableItem('bolcacahuetes', function(source) --bolcacahuetes
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bolcacahuetes', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_status:remove', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has comido ~y~1x~s~ ~b~Cacahuetes~s~')
end)
ESX.RegisterUsableItem('bolnoixcajou', function(source) --bolnoixcajou
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bolnoixcajou', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_status:remove', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has comido ~y~1x~s~ ~b~Anacardos~s~')
end)
ESX.RegisterUsableItem('bolpistache', function(source) --bolpistache
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bolpistache', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_status:remove', source, 'thirst',350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has comido ~y~1x~s~ ~b~Pistachos~s~')
end)
ESX.RegisterUsableItem('bolchips', function(source) --bolchips
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bolchips', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_status:remove', source, 'thirst', 300000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has comido ~y~1x~s~ ~b~Patatas Bahamas~s~')
end)
ESX.RegisterUsableItem('saucisson', function(source) --saucisson
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('saucisson', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has comido ~y~1x~s~ ~b~Salchichón~s~')
end)
ESX.RegisterUsableItem('grapperaisin', function(source) --grapperaisin
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('grapperaisin', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has comido ~y~1x~s~ ~b~Rácimo de Uvas~s~')
end)
ESX.RegisterUsableItem('ice', function(source) --ice
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('ice', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has usado ~y~1x~s~ ~b~Hielo~s~')
end)
ESX.RegisterUsableItem('menthe', function(source) --menthe
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('menthe', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_status:remove', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Has usado ~y~1x~s~ ~b~Menta~s~')
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
				TriggerClientEvent('chat:addMessage', source, { args = { '^5HEAL', 'Te has curado!.' } })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Jugador desconectado.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'ID inválida.' } })
		end
	else
		print(('esx_basicneeds: %s healed self'):format(GetPlayerIdentifier(source, 0)))
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Permisos insuficientes.' } })
end, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', params = {{name = 'playerId', help = '(optional) player id'}}})