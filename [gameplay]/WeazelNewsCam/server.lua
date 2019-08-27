ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("cam", function(source, args, raw)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'reporter' then
		TriggerClientEvent("Cam:ToggleCam", _source)
	end
end)

RegisterCommand("bmic", function(source, args, raw)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'reporter' then
		TriggerClientEvent("Mic:ToggleBMic", _source)
	end
end)

RegisterCommand("mic", function(source, args, raw)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'reporter' then
		TriggerClientEvent("Mic:ToggleMic", _source)
	end
end)
