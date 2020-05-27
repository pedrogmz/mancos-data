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

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/f', 'Chat de faccion.', {
    { name="Mensaje", help="Envia un mensaje a todos los de tu faccion." }})
    TriggerEvent('chat:addSuggestion', '/empl', 'Chat privado entre Medicos y Policias.', {
        { name="Mensaje", help="Envia un mensaje a todos los Policias y Medicos" }})
    TriggerEvent('chat:addSuggestion', '/a', 'Chat de ayuda.', {
        { name="Mensaje", help="Uso exclusivo para solicitar ayuda fuera de rol." }})
    TriggerEvent('chat:addSuggestion', '/msg', '[id_player] [mensaje].', {
        { name="Chat privado entre dos personas", help="[id_player] [mensaje]." }})
end)
