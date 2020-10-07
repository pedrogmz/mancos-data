-- Action
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local HasAlreadyEnteredMarker = false
local LastZone = nil

-- ESX
ESX = nil
--local PlayerData = {}
local inService = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

--[[RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)]]

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- Markers
AddEventHandler('esx_duty:hasEnteredMarker', function(zone)
	if zone == ESX.PlayerData.job.name then
		CurrentAction = ESX.PlayerData.job.name..'_duty'
		CurrentActionMsg = _U('duty')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_duty:hasExitedMarker', function(zone)
	CurrentAction = nil
end)

-- Keycontrols
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = GetPlayerPed(-1)

		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0, 38) then

				if CurrentAction == ESX.PlayerData.job.name..'_duty' then
					if inService then
						sendNotification(_U('offduty'), 'success', 2500)
						EndService(ESX.PlayerData.job.name)
						Wait(1000)
					else
						sendNotification(_U('onduty'), 'success', 2500)
						EnterService(ESX.PlayerData.job.name)
						Wait(1000)
					end
				end
			end
		end
	end
end)

function EnterService(job)

	ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

		local notification = {
			title = _U('service_anonunce'),
			subject = '',
			msg = _U('service_in_announce', GetPlayerName(PlayerId())),
			iconType = 1
		}

		TriggerServerEvent('esx_service:notifyAllInService', notification, job)
		ESX.ShowNotification(_U('service_in'))

		inService = true

	end, job)
end

function EndService(job)

	local notification = {
		title = _U('service_anonunce'),
		subject = '',
		msg = _U('service_out_announce', GetPlayerName(PlayerId())),
		iconType = 1
	}

	TriggerServerEvent('esx_service:notifyAllInService', notification, job)

	inService = false

	TriggerServerEvent('esx_service:disableService', job)
	ESX.ShowNotification(_U('service_out'))
end

-- Display markers
Citizen.CreateThread(function()
	while true do
		Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k, v in pairs(Config.Zones) do
			if ESX.PlayerData.job.name == k and (v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z,
					v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker = false
		local currentZone = nil

		for k, v in pairs(Config.Zones) do
			if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('esx_duty:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_duty:hasExitedMarker', LastZone)
		end
	end
end)

-- notification
function sendNotification(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "duty",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end
