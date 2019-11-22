RegisterServerEvent('deaths')
AddEventHandler('deaths', function()
	local timer = 600
	TriggerClientEvent('deatht', source, timer)
end)

RegisterServerEvent('deathans')
AddEventHandler('deathans', function()
	TriggerClientEvent('deadan', source)
end)