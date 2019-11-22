ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


--[[
############################################################################
############################################################################
                                EVENTOS
############################################################################
############################################################################
]]

RegisterNetEvent('hidi:chatProximidadMe')
AddEventHandler('hidi:chatProximidadMe', function(id,nombre,mensaje)
    local _id = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == id then
        TriggerEvent('chatMessage', "", {255, 0, 0}, "^6[ME]^0 " .. nombre ..": ".."^6 " .. mensaje)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(_id)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
        TriggerEvent('chatMessage', "", {255, 0, 0}, "^6[ME]^0 " .. nombre ..": ".."^6 " .. mensaje)
    end
end)

RegisterNetEvent('hidi:chatProximidadDo')
AddEventHandler('hidi:chatProximidadDo', function(id,nombre,mensaje)
    local _id = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == id then
        TriggerEvent('chatMessage', "", {255, 0, 0}, "^3[DO]^0 " .. nombre ..": ".."^3 " .. mensaje)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(_id)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
        TriggerEvent('chatMessage', "", {255, 0, 0}, "^3[DO]^0 " .. nombre ..": ".."^3 " .. mensaje)
    end
end)

RegisterNetEvent('hidi:chatProximidadOoc')
AddEventHandler('hidi:chatProximidadOoc', function(id,nombre,mensaje)
    local _id = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == id then
        TriggerEvent('chatMessage', "", {255, 0, 0}, "^4[OOC]^0 " .. nombre ..": ".."^0 " .. mensaje)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(_id)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
        TriggerEvent('chatMessage', "", {255, 0, 0}, "^4[OOC]^0 " .. nombre ..": ".."^0 " .. mensaje)
    end
end)

--[[
############################################################################
############################################################################
                                COMANDOS
############################################################################
############################################################################
]]

RegisterCommand('f', function(source, args)
    if args[1] then
        local mensaje = table.concat(args, ' ')
        TriggerServerEvent('hidi:chatFaccion', mensaje,source)
    else
        TriggerEvent('chatMessage', '^5SYSTEM: ', {128, 128, 128}, 'Chat de facción.')
    end
end, false)

RegisterCommand('empl', function(source, args)
    if args[1] then
        local mensaje = table.concat(args,' ')
        TriggerServerEvent('hidi:PoliEms', mensaje,source)
    else
        TriggerEvent('chatMessage', '^5SYSTEM: ', {128, 128, 128}, 'Chat coorporativo EMS & LSPD.')
    end
end,false)


--[[
############################################################################
############################################################################
                                FUNCIONES
############################################################################
############################################################################
]]


