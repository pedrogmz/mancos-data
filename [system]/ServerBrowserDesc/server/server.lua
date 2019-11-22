Citizen.CreateThread(function()
	local uptimeMinute, uptimeHour, uptime = 0, 0, ''

	while true do
		Citizen.Wait(1000 * 60) -- every minute
		uptimeMinute = uptimeMinute + 1

		if uptimeMinute == 60 then
			uptimeMinute = 0
			uptimeHour = uptimeHour + 1
		end

		uptime = string.format("%02dh %02dm", uptimeHour, uptimeMinute)
		SetConvarServerInfo('Uptime', uptime)
		SetConvarServerInfo('Discord', 'https://discord.mancos.games')
		SetConvarServerInfo('Description', 'Para reportar errores, unete a nuestro discord!')
		SetConvarServerInfo('Website', 'https://rp.mancos.games')
		SetConvarServerInfo('Foro', 'https://rp.mancos.games/foro/')
		SetConvarServerInfo('Twitter', '@MancosGames')

		SetMapName("La Isla de las Sombras")
		SetGameType("Roleplay")

		TriggerClientEvent('uptime:tick', -1, uptime)
		TriggerEvent('uptime:tick', uptime)
	end
end)