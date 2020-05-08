ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local server = GetConvar("server_number", "1")

RegisterServerEvent('comprobarEntorno')
AddEventHandler('comprobarEntorno', function(msg, x, y, z, name, ped)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(source)
	local ped = GetPlayerPed(_source)
	
	TriggerEvent('es:getPlayers', function(players)
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				TriggerClientEvent('entorno:setBlip', xPlayers[i], name, x, y, z)
				TriggerClientEvent('chat:addMessage', xPlayers[i], { args = {"^1ENTORNO ", tonumber(_source) .. " ^5" .. msg} }) --Hidita: Se añade el contenido del mensaje en el chat
				TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Policía', '', '~r~Alerta policía ~n~~w~'.. tonumber(_source) .. ' - ' .. msg, 'CHAR_CALL911', 1)

				TriggerClientEvent('esx_aviso:sendElement', xPlayers[i], xPlayer.identifier, tonumber(_source), 'police', msg, x, y, z) -- Arnedo 5 | Nuevo aviso policia
			end
		end
	end)
	
	if string.match(msg, "Alguien me está ofreciendo drogas") or string.match(msg, "Hay un vehiculo circulando") or string.match(msg, "Se ha visto alguien") or string.match(msg, "Estan robando") or string.match(msg, "Alguien ha reportado") or string.match(msg, "Alguien ha visto un sujeto") then
		TriggerEvent('DiscordBot:ToDiscord', 'chat', name .. ' [ID: ' .. source .. '] Server: '..server, '**ENTORNO: **' .. msg, 'steam', true, source)
	else 
		TriggerClientEvent("sendProximityMessageEntorno", -1, _source)
		TriggerEvent('DiscordBot:ToDiscord', 'chat', name .. ' [ID: ' .. source .. '] Server: '..server, '**ENTORNO: **' .. msg, 'steam', true, source)
	end
	
end)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
	