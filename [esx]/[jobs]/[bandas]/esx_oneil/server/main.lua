ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

TriggerEvent('esx_society:registerSociety', 'oneil', 'oneil', 'society_oneil',
	'society_oneil', 'society_oneil', {
		type = 'private'
	})
TriggerEvent('esx_society:registerSociety', 'oneil_black', 'oneil_black', 'society_oneil_black',
	'society_oneil', 'society_oneil', {
		type = 'private'
	})

-- almacen
RegisterServerEvent('esx_oneil:getStockItem')
AddEventHandler('esx_oneil:getStockItem', function(itemName, count)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_oneil', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_oneil:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_oneil', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_oneil:putStockItems')
AddEventHandler('esx_oneil:putStockItems', function(itemName, count)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_oneil', function(inventory)

		local item = inventory.getItem(itemName)
		local playerItemCount = xPlayer.getInventoryItem(itemName).count

		if item.count >= 0 and count <= playerItemCount then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

	end)

end)

-- frigorifico
RegisterServerEvent('esx_oneil:getFridgeStockItem')
AddEventHandler('esx_oneil:getFridgeStockItem', function(itemName, count)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_oneil_fridge', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_removed') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('esx_oneil:getFridgeStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_oneil_fridge', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('esx_oneil:putFridgeStockItems')
AddEventHandler('esx_oneil:putFridgeStockItems', function(itemName, count)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_oneil_fridge', function(inventory)

		local item = inventory.getItem(itemName)
		local playerItemCount = xPlayer.getInventoryItem(itemName).count

		if item.count >= 0 and count <= playerItemCount then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)

	end)

end)

RegisterServerEvent('esx_oneil:buyItem')
AddEventHandler('esx_oneil:buyItem', function(itemName, price, itemLabel)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local limit = xPlayer.getInventoryItem(itemName).limit
	local qtty = xPlayer.getInventoryItem(itemName).count
	local societyAccount = nil

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_oneil', function(account)
		societyAccount = account
	end)

	if societyAccount ~= nil and societyAccount.money >= price then
		if qtty < limit then
			societyAccount.removeMoney(price)
			xPlayer.addInventoryItem(itemName, 1)
			TriggerClientEvent('esx:showNotification', _source, _U('bought') .. itemLabel)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('max_item'))
		end
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough'))
	end

end)

-- almacen armas
ESX.RegisterServerCallback('esx_oneil:getVaultWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_oneil', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)

	end)

end)

ESX.RegisterServerCallback('esx_oneil:addVaultWeapon', function(source, cb, type, weaponName, count)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	-- xPlayer.removeWeapon(weaponName)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_oneil', function(store)

		local storeWeapons = store.get('weapons') or {}

		table.insert(storeWeapons, {
			name = weaponName,
			-- count = 1,
			ammo = count
		})

		store.set('weapons', storeWeapons)
		xPlayer.removeWeapon(weaponName)

		cb()

	end)

end)

ESX.RegisterServerCallback('esx_oneil:removeVaultWeapon', function(source, cb, type, item, ammo)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	-- xPlayer.addWeapon(weaponName, ammo)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_oneil', function(store)

		local storeWeapons = store.get('weapons') or {}
		local weaponName = nil
		local ammo = nil

		for i = 1, #storeWeapons, 1 do
			if storeWeapons[i].name == item then
				weaponName = storeWeapons[i].name
				-- count      = 0
				ammo = storeWeapons[i].ammo

				table.remove(storeWeapons, i)
				break
			end
		end

		store.set('weapons', storeWeapons)
		xPlayer.addWeapon(weaponName, ammo)

		cb()

	end)

end)

ESX.RegisterServerCallback('esx_oneil:getPlayerInventory', function(source, cb)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local items = xPlayer.inventory

	cb({
		items = items
	})

end)

ESX.RegisterServerCallback('esx_oneil:keycount', function(source, cb)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	while not xPlayer do
		Citizen.Wait(0);
		xPlayer = ESX.GetPlayerFromId(_source);
	end
	local count = xPlayer.getInventoryItem('key_oneil')

	if count.count == 0 then
		count = xPlayer.getInventoryItem('key_orden')
	end

	if count then
		count = count.count;
	end

	cb(count)

end)

