--Pruebas
--[[
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local plyCoords = GetEntityCoords(PlayerPedId())
		local dstCheckEnter = GetDistanceBetweenCoords(plyCoords, -1763.9, -496.24, 39.35, true)
		local playerPed = PlayerPedId()

		DrawMarker(-1, -1763.9, -496.24, 39.35, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.50, 0.50, 0.25, 124, 252, 119, 100, true, true, 2, false, false, false, false)
		if dstCheckEnter <= 1.5 then
			ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para hacer porros.")
			if IsControlJustPressed(0, 38) then
				TriggerServerEvent('esx_venta:hacerPorros')
			end
		end
	end
end)
]]