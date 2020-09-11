ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Puntos donde canjear horas jugadas
RewardPoints = {
    ["Bennys"] = {
        ["position"] = vector3(-203.74, -1331.07, 33.89),
    },
}

DrawScriptMarker = function(markerData)
	DrawMarker(markerData["type"] or 1, 
		markerData["pos"] or vector3(0.0, 0.0, 0.0), 
		0.0, 0.0, 0.0, 
		(markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, 
		markerData["sizeX"] or 1.0, 
		markerData["sizeY"] or 1.0, 
		markerData["sizeZ"] or 1.0, 
		markerData["r"] or 1.0, 
		markerData["g"] or 1.0, 
		markerData["b"] or 1.0, 
		100, false, true, 2, false, false, false, false)
end

Citizen.CreateThread(function()
	while true do
		local sleepThread = 500

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		for action, actionData in pairs(RewardPoints) do
			local dstCheck = #(pedCoords - actionData["position"])

			if dstCheck <= 10.0 then
				sleepThread = 5

				local markerSize = 1.5

				if dstCheck <= markerSize - 0.1 then

					ESX.ShowHelpNotification("Presiona E para cambiar tus horas jugadas en coins")

					if IsControlJustPressed(0, 38) then
						ChangeCoins()
					end
				end
				
				DrawScriptMarker({
					["type"] = 6,
					["pos"] = actionData["position"] - vector3(0.0, 0.0, 0.985),
					["sizeX"] = markerSize,
					["sizeY"] = markerSize,
					["sizeZ"] = markerSize,
					["rotate"] = -180.0,
					["r"] = 0,
					["g"] = 150,
					["b"] = 150
				})
			end
		end

		Citizen.Wait(sleepThread)
	end
end)

function ChangeCoins()

	local elements = {}

	ESX.TriggerServerCallback('RewardCoins:getPlayTime', function(playTime)
		playedHours = math.floor(playTime / 3600)
		print("Horas online: "..playedHours)
	end)

	while playedHours == nil do
		Citizen.Wait(100)
	end

	table.insert(elements, {
		label = "Horas jugadas - <span style='color: green;'>" .. playedHours .. "</span> horas",
		value = "exchange_hours"
	})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'exchange_hours', {
		title = "Canjear horas jugadas",
		align = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'exchange_hours' then
			menu.close()
			TriggerServerEvent('RewardCoins:exchangeHours')
		end

	end, function(data, menu)
		menu.close()
	end)
end