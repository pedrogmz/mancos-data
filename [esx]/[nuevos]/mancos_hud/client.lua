local toghud = true
local toggps = false

RegisterNetEvent('mancos_hud:updateStatus')
AddEventHandler('mancos_hud:updateStatus', function(status)
	SendNUIMessage({action = "updateStatus", status = status})
end)

RegisterCommand('gps', function(source, args, rawCommand)
    if toggps then 
        toggps = false
    else
        toggps = true
    end
end)

RegisterCommand('hud', function(source, args, rawCommand)
    if toghud then 
        toghud = false
    else
        toghud = true
    end
end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)
    if show == true then
        toghud = true
    else
        toghud = false
    end
end)

Citizen.CreateThread(function()
    while true do
        if toghud == true or toggps == true then
            if toggps == false and (not IsPedInAnyVehicle(PlayerPedId(), false) ) then
                DisplayRadar(0)
            else
                DisplayRadar(1)
            end
        else
            DisplayRadar(0)
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
        local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 2.5

        SendNUIMessage({
            action = 'updateStatusHud',
            show = toghud, health = health, armour = armor, oxygen = oxy,
        })
        Citizen.Wait(200)
    end
end)