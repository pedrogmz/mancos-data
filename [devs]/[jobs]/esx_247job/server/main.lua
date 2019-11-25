ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'tender', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'tender', _U('247_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'tender', 'tender', 'society_247', 'society_247', 'society_247', {type = 'private'})


-- almacen
RegisterServerEvent('esx_247job:getStockItem')
AddEventHandler('esx_247job:getStockItem', function(itemName, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_247', function(inventory)

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

ESX.RegisterServerCallback('esx_247job:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_247', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('esx_247job:putStockItems')
AddEventHandler('esx_247job:putStockItems', function(itemName, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_247', function(inventory)

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
RegisterServerEvent('esx_247job:getFridgeStockItem')
AddEventHandler('esx_247job:getFridgeStockItem', function(itemName, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_247_fridge', function(inventory)

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

ESX.RegisterServerCallback('esx_247job:getFridgeStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_247_fridge', function(inventory)
    cb(inventory.items)
  end)

end)

RegisterServerEvent('esx_247job:putFridgeStockItems')
AddEventHandler('esx_247job:putFridgeStockItems', function(itemName, count)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_247_fridge', function(inventory)

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


RegisterServerEvent('esx_247job:buyItem')
AddEventHandler('esx_247job:buyItem', function(itemName, price, itemLabel)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local limit = xPlayer.getInventoryItem(itemName).limit
    local qtty = xPlayer.getInventoryItem(itemName).count
    local societyAccount = nil

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_247', function(account)
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


RegisterServerEvent('esx_247job:craft247')
AddEventHandler('esx_247job:craft247', function(itemValue)

    local _source = source
    local _itemValue = itemValue
    TriggerClientEvent('esx:showNotification', _source, _U('assembling_cocktail'))

    if _itemValue == 'tender' then
        SetTimeout(10000, function()        

            local xPlayer           = ESX.GetPlayerFromId(_source)

            local alephQuantity     = xPlayer.getInventoryItem('bread').count
            local bethQuantity      = xPlayer.getInventoryItem('steak').count
            local gimelQuantity     = xPlayer.getInventoryItem('cheese').count

            if alephQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('bread') .. '~w~')
            elseif bethQuantity < 1 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('steak') .. '~w~')
            elseif gimelQuantity < 2 then
                TriggerClientEvent('esx:showNotification', _source, _U('not_enough') .. _U('cheese') .. '~w~')
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= Config.MissCraft then
                    TriggerClientEvent('esx:showNotification', _source, _U('craft_miss'))
                    xPlayer.removeInventoryItem('bread', 2)
                    xPlayer.removeInventoryItem('steak', 1)
                    xPlayer.removeInventoryItem('cheese', 2)
                else
                    TriggerClientEvent('esx:showNotification', _source, _U('craft') .. _U('247') .. ' ~w~!')
                    xPlayer.removeInventoryItem('bread', 2)
                    xPlayer.removeInventoryItem('steak', 1)
                    xPlayer.removeInventoryItem('cheese', 2)
                    xPlayer.addInventoryItem('tender', 1)
                end
            end

        end)
    end

end)

-- almacen armas
ESX.RegisterServerCallback('esx_247job:getVaultWeapons', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_247', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_247job:addVaultWeapon', function(source, cb, weaponName)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  xPlayer.removeWeapon(weaponName)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_247', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = weapons[i].count + 1
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 1
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('esx_247job:removeVaultWeapon', function(source, cb, weaponName)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  xPlayer.addWeapon(weaponName, 1000)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_247', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 0
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('esx_247job:getPlayerInventory', function(source, cb)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local items      = xPlayer.inventory

  cb({
    items      = items
  })

end)
