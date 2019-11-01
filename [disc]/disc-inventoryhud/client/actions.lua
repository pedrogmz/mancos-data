RegisterNUICallback('UseItem', function(data)
    TriggerServerEvent('disc-inventoryhud:notifyImpendingRemoval', data.item, 1)
    TriggerServerEvent("esx:useItem", data.item.id)
    TriggerEvent('disc-inventoryhud:refreshInventory')
end)

local keys = {
    157, 158, 160, 164, 165
}

function UseItem(slot)
    ESX.TriggerServerCallback('disc-inventoryhud:UseItemFromSlot', function(item)
        if item then
            TriggerServerEvent('disc-inventoryhud:notifyImpendingRemoval', item, 1)
            TriggerServerEvent("esx:useItem", item.id)
        end
    end
    , slot)
end