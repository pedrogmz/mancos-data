ESX 							= nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

blip = nil
blips = {}

displayTime = 300 -- Tiempo para que desaparezca el blip (en segundos)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/grua', 'Pide un grua a tu ubicación', {
    { name="Ubicación", help="Pide un grua a tu ubicación" }
})
end)

RegisterNetEvent('grua:setBlip')
AddEventHandler('grua:setBlip', function(name, x, y, z)
	blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, 304)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 7)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Llamada de grua - ' .. name)
	EndTextCommandSetBlipName(blip)
	table.insert(blips, blip)
	Wait(displayTime * 1000)
	for i, blip in pairs(blips) do 
		RemoveBlip(blip)
	end
end)

RegisterCommand('grua', function(source, args)
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local msg = table.concat(args, ' ')
    if args[1] == nil then
        TriggerEvent('chatMessage', '^5Grua', {w,255,255}, ' ^7Pide un grua a tu ubicación.')
    else
        TriggerServerEvent('comprobarGrua', msg, x, y, z, name)
    end
end)

RegisterNetEvent('sendProximityMessageGrua')
AddEventHandler('sendProximityMessageGrua', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
		TriggerEvent('chatMessage', "(OOC) " .. id .. "", {128, 128, 128}, "^7 Se ha enviado una llamada a la Grua")
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chatMessage', "(OOC) " .. id .. "", {128, 128, 128}, "^7 Se ha enviado una llamada a la Grua")
  end
end)

