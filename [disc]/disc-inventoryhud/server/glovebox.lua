Citizen.CreateThread(function()
    --Player
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
        name = 'glovebox',
        label = 'Glove Box',
        slots = 5
    })
end)