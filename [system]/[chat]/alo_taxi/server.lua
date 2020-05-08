ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local server = GetConvar("server_number", "1")

RegisterServerEvent('comprobarTaxi')
AddEventHandler('comprobarTaxi', function(msg, x, y, z, name, ped)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(source)
	local ped = GetPlayerPed(_source)
	
	TriggerEvent('es:getPlayers', function(players)
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'taxi' then
				TriggerClientEvent('taxi:setBlip', xPlayers[i], name, x, y, z)
				TriggerClientEvent('chat:addMessage', xPlayers[i], { args = {"^1TAXI ", tonumber(_source) .. " ^3" .. msg} }) --Hidita: Se añade el contenido del mensaje en el chat
				TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'TAXI', '', '~r~Alerta TAXI ~n~~w~'.. tonumber(_source) .. ' - ' .. msg, 'CHAR_TAXI', 1)

				TriggerClientEvent('esx_aviso:sendElement', xPlayers[i], xPlayer.identifier, tonumber(_source), 'taxi', msg, x, y, z) -- Arnedo 5 | Nuevo aviso policia
			end
		end
	end)
	TriggerClientEvent("sendProximityMessageTaxi", -1, _source)
	TriggerEvent('DiscordBot:ToDiscord', 'chat', name .. ' [ID: ' .. source .. '] Server: '..server, '**TAXI: **' .. msg, 'steam', true, source)
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
	