local isHandcuffed = false
local PlayerData, HandcuffTimer, DragStatus = {}, {}
ESX = nil

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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('mancos_arrest:handcuff')
AddEventHandler('mancos_arrest:handcuff', function()
	Citizen.CreateThread(function()
		if isHandcuffed then
			if Config.EnableHandcuffTimer then
				if HandcuffTimer.Active then
					ESX.ClearTimeout(HandcuffTimer.Task)
				end
				StartHandcuffTimer()
			end
		else
			if Config.EnableHandcuffTimer and HandcuffTimer.Active then
				ESX.ClearTimeout(HandcuffTimer.Task)
			end
		end
	end)
end)

RegisterNetEvent('mancos_arrest:unrestrain')
AddEventHandler('mancos_arrest:unrestrain', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false
		TriggerEvent('mancos_arrest:toggleHandcuffed', isHandcuffed)

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

RegisterNetEvent('mancos_arrest:get_arrested')
AddEventHandler('mancos_arrest:get_arrested', function(playerheading, playercoords, playerlocation)
	playerPed = GetPlayerPed(-1)
	local x, y, z = table.unpack(playercoords + playerlocation * 1.0)
	SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	---
	LoadAnimDict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2, 0, 0, 0, 0)
	Citizen.Wait(3760)
	---
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
	
	---
	isHandcuffed = true
	TriggerEvent('mancos_arrest:handcuff')
	TriggerEvent('mancos_arrest:toggleHandcuffed', isHandcuffed)
end)

RegisterNetEvent('mancos_arrest:do_arrested')
AddEventHandler('mancos_arrest:do_arrested', function()
	Citizen.Wait(250)
	LoadAnimDict('mp_arrest_paired')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arrest_paired', 'cop_p2_back_right', 8.0, -8,3750, 2, 0, 0, 0, 0)
	Citizen.Wait(3000)
end)

RegisterNetEvent('mancos_arrest:get_uncuffed')
AddEventHandler('mancos_arrest:get_uncuffed', function(playerheading, playercoords, playerlocation)
	local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	Citizen.Wait(250)
	---
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	---
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
	
	---
	isHandcuffed = false
	TriggerEvent('mancos_arrest:handcuff')
	TriggerEvent('mancos_arrest:toggleHandcuffed', isHandcuffed)
end)

RegisterNetEvent('mancos_arrest:do_uncuffing')
AddEventHandler('mancos_arrest:do_uncuffing', function()
	Citizen.Wait(250)
	LoadAnimDict('mp_arresting')
	TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(GetPlayerPed(-1))
end)

AddEventHandler('playerSpawned', function(spawn)
	TriggerEvent('mancos_arrest:unrestrain')
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('mancos_arrest:unrestrain')
		
		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer.Active then
		ESX.ClearTimeout(HandcuffTimer.Task)
	end

	HandcuffTimer.Active = true

	HandcuffTimer.Task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('mancos_arrest:unrestrain')
		HandcuffTimer.Active = false
	end)
end

function LoadAnimDict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end
