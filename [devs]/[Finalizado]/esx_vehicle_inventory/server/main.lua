ESX = nil
local arrayWeight = Config.localWeight

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

RegisterServerEvent('esx_truck_inventory:getOwnedVehicule')
AddEventHandler('esx_truck_inventory:getOwnedVehicule', function()
  local vehicules = {}
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  MySQL.Async.fetchAll(
      'SELECT * FROM owned_vehicles WHERE owner = @owner',
   		{
   			['@owner'] = xPlayer.identifier
   		},
    function(result)
      if result ~= nil and #result > 0 then
          for _,v in pairs(result) do
      			local vehicle = json.decode(v.vehicle)
            --print(vehicle.plate)
      			table.insert(vehicules, {plate = vehicle.plate})
      		end
      end
    TriggerClientEvent('esx_truck_inventory:setOwnedVehicule', _source, vehicules)
    end)
end)



function getInventoryWeight(inventory)
  local weight = 0
  local itemWeight = 0

  if inventory ~= nil then
	  for i=1, #inventory, 1 do
	    if inventory[i] ~= nil then
	      itemWeight = Config.DefaultWeight
	      if arrayWeight[inventory[i].name] ~= nil then
	        itemWeight = arrayWeight[inventory[i].name]
	      end
	      weight = weight + (itemWeight * inventory[i].count)
	    end
	  end
  end
  return weight
end

RegisterServerEvent('esx_truck_inventory:getInventory')
AddEventHandler('esx_truck_inventory:getInventory', function(plate)
  local inventory_ = {}
  local _source = source
  MySQL.Async.fetchAll(
    'SELECT * FROM `truck_inventory` WHERE `plate` = @plate',
    {
      ['@plate'] = plate
    },
    function(inventory)
      if inventory ~= nil and #inventory > 0 then
        for i=1, #inventory, 1 do
          table.insert(inventory_, {
            type      = inventory[i].type,
            label     = inventory[i].name,
            name      = inventory[i].item,
            count     = inventory[i].count,
            ammo      = inventory[i].ammo,
          })
        end
      end
    local weight = (getInventoryWeight(inventory_))
    local xPlayer  = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx_truck_inventory:getInventoryLoaded', xPlayer.source, inventory_,weight)
    end)
end)


RegisterServerEvent('esx_truck_inventory:removeInventoryItem')
AddEventHandler('esx_truck_inventory:removeInventoryItem', function(plate, item, count, ammo, type)
  local _source = source

  MySQL.Async.fetchAll('SELECT count FROM truck_inventory WHERE `plate` = @plate AND `item`= @item LIMIT 1', {
    ['@plate'] = plate,
    ['@item'] = item
  }, function(result)

    if result[1] ~= nil then
      if (result[1].count >= 0) then
  
        -- Si hay objetos
        MySQL.Async.fetchAll(
          'UPDATE `truck_inventory` SET `count`= `count` - @qty WHERE `plate` = @plate AND `item`= @item',
          {
            ['@plate'] = plate,
            ['@qty'] = count,
            ['@item'] = item
          },
          function(result)
            local xPlayer  = ESX.GetPlayerFromId(_source)
      
            if xPlayer ~= nil then
      
              if type == 'item_weapon' then
                xPlayer.addWeapon(item, ammo) -- Add weapon
              else
                xPlayer.addInventoryItem(item, count)-- Add object
              end
              
            end
      
            -- Arnedo5 | Eliminamos todos los vacios
            MySQL.Async.fetchAll('DELETE FROM truck_inventory WHERE COUNT = 0',{ },  function(result) end)
      
          end)

      else

        -- En caso de estar a 0 mostramos un mensaje
        TriggerClientEvent('esx_truck_inventory:showNote', _source)

      end

    else 

      -- En caso de estar a 0 mostramos un mensaje
      TriggerClientEvent('esx_truck_inventory:showNote', _source)

    end

  end)


end)

RegisterServerEvent('esx_truck_inventory:addInventoryItem')
AddEventHandler('esx_truck_inventory:addInventoryItem', function(type, plate, count, ammo, item, name, ownedV)

  local _source = source
  MySQL.Async.fetchAll(
    'INSERT INTO truck_inventory (type, item,count, ammo, plate,name,owned) VALUES (@type, @item, @qty, @ammo, @plate,@name,@owned) ON DUPLICATE KEY UPDATE count=count+ @qty',
    {
      ['@type'] = type,
      ['@plate'] = plate,
      ['@qty'] = count,
      ['@ammo'] = ammo,
      ['@item'] = item,
      ['@name'] = name,
      ['@owned'] = ownedV,
    },
    function(result)
      local xPlayer  = ESX.GetPlayerFromId(_source)

      if type == 'item_weapon' then
        xPlayer.removeWeapon(item) -- Remove weapon
      else
        xPlayer.removeInventoryItem(item, count) -- Remove object
      end
      
    end)
end)

-- Arnedo5 | Comprobar ganzúa
ESX.RegisterServerCallback('esx_truck_inventory:lockpick', function(source, cb)

  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(_source); end
  local count = xPlayer.getInventoryItem('lockpick')

  if count.count <= 0 then 
    count = 0 
  else
    xPlayer.removeInventoryItem('lockpick', 1)
    count = 1
  end

  cb(count)

end)
