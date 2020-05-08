ESX = nil
local PlayerData		= {}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-430.17, 260.61, 83.01)

	SetBlipSprite (blip, 102)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour  (blip, 47)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Camillas")
	EndTextCommandSetBlipName(blip)
end)


Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coordenadasPlayer = GetEntityCoords(PlayerPedId())
		local distanciaMarker1 = GetDistanceBetweenCoords(coordenadasPlayer, -430.17, 260.61, 83.00, true)
		local distanciaMarker2 = GetDistanceBetweenCoords(coordenadasPlayer, -458.74, 284.8, 77.50, true)
		local ped = PlayerPedId()


		DrawMarker(1, -430.17, 260.61, 82.00, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.50, 0.50, 0.25, 124, 252, 119, 100, false, true, 2, false, false, false, false)
		if distanciaMarker1 <= 1.5 then
			ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para entrar")
			if IsControlJustPressed(0, 38) then
				SetEntityCoords(ped, -458.790, 284.750, 78.521)
			end
		end
		DrawMarker(1, -458.74, 284.8, 77.50, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.50, 0.50, 0.25, 124, 252, 119, 100, false, true, 2, false, false, false, false)
		if distanciaMarker2 <= 1.5 then
			ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para salir")
			if IsControlJustPressed(0, 38) then
				SetEntityCoords(ped, -430.142, 261.665, 83.005)
			end
		end
	end
end)