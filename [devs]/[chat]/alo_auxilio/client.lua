ESX 							= nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

blip = nil
blips = {}

displayTime = 300 -- Tiempo para que desaparezca el blip (en segundos)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/auxilio', 'Envia una llamada de auxilio a EMS', {
    { name="Suceso", help="Escribe detalladamente lo que ha sucedido" }
})
end)

RegisterNetEvent('auxilio:setBlip')
AddEventHandler('auxilio:setBlip', function(name, x, y, z)
	blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, 304)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 1)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Llamada de auxilio - ' .. name)
	EndTextCommandSetBlipName(blip)
	table.insert(blips, blip)
	Wait(displayTime * 1000)
	for i, blip in pairs(blips) do 
		RemoveBlip(blip)
	end
end)

RegisterCommand('auxilio', function(source, args)
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local msg = table.concat(args, ' ')
    if args[1] == nil then
        TriggerEvent('chatMessage', '^5Auxilio', {255,255,255}, ' ^7Por favor, escribe lo sucedido detalladamente.')
    else
        TriggerServerEvent('comprobarAuxilio', msg, x, y, z, name)
    end
end)

RegisterNetEvent('sendProximityMessageAuxilio')
AddEventHandler('sendProximityMessageAuxilio', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
		TriggerEvent('chatMessage', "(OOC) " .. id .. "", {128, 128, 128}, "^7 Se ha enviado una llamada de rol de auxilio a EMS")
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chatMessage', "(OOC) " .. id .. "", {128, 128, 128}, "^7 Se ha enviado una llamada de rol de auxilio a EMS")
  end
end)

