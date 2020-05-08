--Pruebas
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

local isFumando = false

RegisterNetEvent('esx_venta:onPot')
AddEventHandler('esx_venta:onPot', function()

	RequestAnimSet("move_m@hipster@a") 
    while not HasAnimSetLoaded("move_m@hipster@a") do
      Citizen.Wait(0)
    end 

    local player = PlayerId()

    if not isFumando then
    	isFumando = true
		TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, 1)
		Citizen.Wait(10000)
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)
		ClearTimecycleModifier()
		SetTimecycleModifier("spectator9")
		ClearPedTasksImmediately(GetPlayerPed(-1))
		ESX.Streaming.RequestAnimSet('move_m@buzzed', function()
			SetPedMovementClipset(PlayerPedId(), 'move_m@buzzed', true)
		end)
		SetPedMotionBlur(GetPlayerPed(-1), true)
		SetPedIsDrunk(GetPlayerPed(-1), true)
		DoScreenFadeIn(1000)
		Citizen.Wait(30000)
		DoScreenFadeOut(1000)
		ESX.Streaming.RequestAnimSet('move_m@buzzed', function()
			SetPedMovementClipset(PlayerPedId(), 'move_m@buzzed', true)
		end)
		Citizen.Wait(3000)
		DoScreenFadeIn(1000)
		Citizen.Wait(60000)
		DoScreenFadeOut(1000)
		Citizen.Wait(2000)
		DoScreenFadeIn(1000)
		ESX.Streaming.RequestAnimSet('move_m@buzzed', function()
			SetPedMovementClipset(PlayerPedId(), 'move_m@buzzed', true)
		end)
		SetRunSprintMultiplierForPlayer(player, 1.0)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		SetTimecycleModifier(GetPlayerPed(-1), "spectator11")
		ResetPedMovementClipset(GetPlayerPed(-1), 0)
		SetPedIsDrunk(GetPlayerPed(-1), false)
		SetPedMotionBlur(GetPlayerPed(-1), false)
		isFumando = false
	end
	if isFumando then
		ESX.ShowNotification("~r~Ya te has fumado uno, espera a que se te pasen los efectos.")
	end
end)
--[[

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