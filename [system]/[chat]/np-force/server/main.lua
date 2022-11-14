-- Framework

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Job Events 

RegisterServerEvent('np-force:getJob')
AddEventHandler('np-force:getJob',function()
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayers[i] == source then
			TriggerClientEvent('np-force:setJob', xPlayers[i], xPlayer.job.name)
		end
	end
end)

-- Events

RegisterServerEvent('np-force:sendNotify')
AddEventHandler('np-force:sendNotify', function(model, color, street)
    mytype = 'police'
    data = {["code"] = '10-28', ["name"] = 'Robo de ' ..model.. ', color ' ..color.. '.', ["loc"] = street}
    length = 5000
    TriggerClientEvent('np-force:sendNotify', -1, mytype, data, length)
end, false)