ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local server = GetConvar("server_number", "1")

RegisterServerEvent('comprobarAuxilio')
AddEventHandler('comprobarAuxilio', function(msg, x, y, z, name, ped)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	local xPlayer = ESX.GetPlayerFromId(source)
	local ped = GetPlayerPed(_source)
	
	TriggerEvent('es:getPlayers', function(players)
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'ambulance' then
				TriggerClientEvent('auxilio:setBlip', xPlayers[i], name, x, y, z)
				TriggerClientEvent('chat:addMessage', xPlayers[i], { args = {"^1AUXILIO ", tonumber(_source) .. " ^1" .. msg} }) --Hidita: Se añade el contenido del mensaje en el chat
				TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'EMS', '', '~r~Alerta EMS ~n~~w~'.. tonumber(_source) .. ' - ' .. msg, 'CHAR_CHAT_CALL', 1)
			end
		end
	end)
	TriggerClientEvent("sendProximityMessageAuxilio", -1, _source)
	TriggerEvent('DiscordBot:ToDiscord', 'chat', name .. ' [ID: ' .. source .. '] Server: '..server, '**AUXILIO: **' .. msg, 'steam', true, source)
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
	