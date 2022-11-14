-- Framework

ESX = nil

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

-- Locales 

local NP = {}
local time = 120
local job = nil

blip = nil 
blips = {}

-- Job Events 

AddEventHandler('playerSpawned', function(spawn)
	TriggerServerEvent('np-force:getJob')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  	TriggerServerEvent('np-force:getJob')
end)

TriggerServerEvent('np-force:getJob')

RegisterNetEvent('np-force:setJob')
AddEventHandler('np-force:setJob',function(jobResult)
	job = jobResult
end)

-- Events

RegisterNetEvent('np-force:sendNotify')
AddEventHandler('np-force:sendNotify', function(type, data, length)
	if job == 'police' then 
		SendNUIMessage({action = 'display', style = type, info = data, length = length})
		PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
	end
end)

RegisterNetEvent('np-force:setBlip')
AddEventHandler('np-force:setBlip', function(x, y, z)
	if job == 'police' then 
		blip = AddBlipForCoord(x, y, z)
        SetBlipSprite(blip, 523)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 2)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Robo de vehiculo')
        EndTextCommandSetBlipName(blip)
        table.insert(blips, blip)
        Wait(time * 1000)
        for i, blip in pairs(blips) do 
            RemoveBlip(blip)
		end
	end
end)

RegisterCommand('forzar', function()
	local ply = PlayerPedId()
	local plyv = GetVehiclePedIsIn(ply)
	local plyl = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(ply, true))))
	local x, y, z = table.unpack(GetEntityCoords(ply, true))
	local vehc = GetVehicleColours(plyv)
	vehc = Config.Colors[tostring(vehc)]
	local vehm = GetDisplayNameFromVehicleModel(GetEntityModel(plyv))
	if IsPedInAnyVehicle(ply) then 
		TriggerServerEvent('np-force:sendNotify', vehm, vehc, plyl)
		TriggerEvent('np-force:setBlip', x, y, z)
		print("enviado")
	else 
		print("debes estar en un vehículo")
		ESX.ShowNotification('Debes estar en un vehículo')
	end
end)