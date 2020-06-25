local ragdoll = false
local shownHelp = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ragdoll then
            SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
        end
    end
end)

RegisterNetEvent('dixi_ragdoll:toggle')
AddEventHandler('dixi_ragdoll:toggle', function()
    ragdoll = not ragdoll
    if not ragdoll then
        shownHelp = false
    end
end)

RegisterNetEvent('dixi_ragdoll:set')
AddEventHandler('dixi_ragdoll:set', function(value)
    ragdoll = value
    if not ragdoll then
        shownHelp = false
    end
end)


RegisterCommand("suelop", function (src, args, raw)
    TriggerEvent("dixi_ragdoll:toggle")
end, false)
