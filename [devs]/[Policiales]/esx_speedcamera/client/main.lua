-- BELOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE! --
-----------------------------------------------------------------------------------------------------------------
-- ABOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE!  --
ESX = nil

local hasBeenCaught = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local useBilling = true -- OPTIONS: (true/false)
local useCameraSound = true -- OPTIONS: (true/false)
local authorized_vehicles = { -- Arnedo5 | Vehiculos permitidos
	"POLICE",
	"POLICE2",
	"POLICE3",
	"POLICE4",
	"POLICEB",
	"POLICET",
	"FIRETRUK",
	"AMBULAN"
}

local Speedcamera80Zone = {
    {x = 317.28,y = 1003.25,z = 210.1},
    {x = -2009.67,y = 143.79,z = 103.79},
    {x = -329.96,y = 248.63,z = 85.97},
    {x = -256.11,y = -662.55,z = 32.82},
    {x = 262.56,y = -587.35,z = 42.85}
}

local Speedcamera120Zone = {
    {x = 689.96,y = -164.38,z = 48.06},
    {x = 738.28,y = -622.07,z = 35.81},
    {x = 1573.24,y = -983.49,z = 59.35},
    {x = -1875.64,y = 713.92,z = 128.83},
    {x = 1157.24,y = 2683.18,z = 37.68},
    {x = 2064.01,y = 3721.86,z = 32.61},
    {x = 280.66,y = 6568.55,z = 29.77},
    {x = -440.67,y = -2306.76,z = 63.37},
    {x = -2223.73,y = -345.41,z = 12.98}
}
-----------------------------------------------------------------------------------------------------------------

function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

AddEventHandler('outlawNotify', function(alert)
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
            Notify(alert)
        end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- 80 ZONE (START)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(Speedcamera80Zone) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera80Zone[k].x, Speedcamera80Zone[k].y, Speedcamera80Zone[k].z)

            if dist <= 30.0 then
				local playerPed = GetPlayerPed(-1)
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKMM = GetEntitySpeed(playerPed)*3.6
				local SpeedKM = math.floor(SpeedKMM)
				local maxSpeed = 85.0 -- THIS IS THE MAX SPEED IN KM/H
				local maxSpeed2 = 125.0
				local plate = GetVehicleNumberPlateText(veh) 						-- Nurambo | Obtenemos la matrícula
				local vehicle = GetDisplayNameFromVehicleModel(GetEntityModel(veh)) -- Arnedo5 | modelo del vehiculo

				if SpeedKM > maxSpeed then

					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then					
							if hasBeenCaught == false then

								if SpeedKM > maxSpeed2 then 
									-- Nothing
								else 
									-- Check vehicle
									for i=1, #authorized_vehicles, 1 do
										if vehicle == authorized_vehicles[i] then
											return
										end
									end

									Citizen.Wait(15000)
									TriggerServerEvent('esx_speedcamera:insert', GetPlayerServerId(PlayerId()), 'Exceso de velocidad en zona de 80 Km/h (de 80 a 120)', 100, 0 , plate, SpeedKM, 80)
									
									hasBeenCaught = true
									Citizen.Wait(15000) -- This is here to make sure the player won't get fined over and over again by the same camera!

								end
							
							end
						end
					end
					
					hasBeenCaught = false
				end

				if SpeedKM > maxSpeed2 then
						
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then					
							if hasBeenCaught == false then

								for i=1, #authorized_vehicles, 1 do
									if vehicle == authorized_vehicles[i] then
										return
									end
								end

								Citizen.Wait(15000)

								TriggerServerEvent('esx_speedcamera:insert', GetPlayerServerId(PlayerId()), 'Exceso de velocidad en zona de 80 Km/h (Sobrepasando los 120)', 250, 5 , plate, SpeedKM, 80 )

								hasBeenCaught = true

								Citizen.Wait(15000) -- This is here to make sure the player won't get fined over and over again by the same camera!

							end
						end
					end
					
					hasBeenCaught = false
				end

            end
        end
    end
end)

-- 80 ZONE (END)

-- 120 ZONE (START)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(Speedcamera120Zone) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Speedcamera120Zone[k].x, Speedcamera120Zone[k].y, Speedcamera120Zone[k].z)

            if dist <= 30.0 then
				local playerPed = GetPlayerPed(-1)
				local playerCar = GetVehiclePedIsIn(playerPed, false)
				local veh = GetVehiclePedIsIn(playerPed)
				local SpeedKMM = GetEntitySpeed(playerPed)*3.6
				local SpeedKM = math.floor(SpeedKMM)
				local maxSpeed = 122.0 -- THIS IS THE MAX SPEED IN KM/H
				local maxSpeed2= 162.0
				local plate = GetVehicleNumberPlateText(veh) 						-- Nurambo | Obtenemos la matrícula
				local vehicle = GetDisplayNameFromVehicleModel(GetEntityModel(veh)) -- Arnedo5 | modelo del vehiculo
				
				if SpeedKM > maxSpeed then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then 
							if hasBeenCaught == false then

								if SpeedKM > maxSpeed2 then 
									-- Nothing
								else 
									-- Check vehicle
									for i=1, #authorized_vehicles, 1 do
										if vehicle == authorized_vehicles[i] then
											return
										end
									end

									Citizen.Wait(15000)

									TriggerServerEvent('esx_speedcamera:insert', GetPlayerServerId(PlayerId()), 'Exceso de velocidad en zona de 120 Km/h (de 120 a 160)', 100, 0, plate, SpeedKM, 120 )

									hasBeenCaught = true

									Citizen.Wait(15000) -- This is here to make sure the player won't get fined over and over again by the same camera!
								end

							end
						end
					end
					
					hasBeenCaught = false
				end


				if SpeedKM > maxSpeed2 then
					if IsPedInAnyVehicle(playerPed, false) then
						if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then 
							if hasBeenCaught == false then

								-- Check vehicle
								for i=1, #authorized_vehicles, 1 do
									if vehicle == authorized_vehicles[i] then
										return
									end
								end

								Citizen.Wait(15000)

								TriggerServerEvent('esx_speedcamera:insert', GetPlayerServerId(PlayerId()), 'Exceso de velocidad en zona de 120 Km/h (Sobrepasando los 160)', 250, 5, plate, SpeedKM, 120 );
	
								hasBeenCaught = true
								
								Citizen.Wait(15000) -- This is here to make sure the player won't get fined over and over again by the same camera!

							end
						end
					end
					
					hasBeenCaught = false
				end

            end
        end
    end
end)

-- 120 ZONE (END)

RegisterNetEvent('esx_speedcamera:openGUI')
AddEventHandler('esx_speedcamera:openGUI', function()
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openSpeedcamera'})
end)   

RegisterNetEvent('esx_speedcamera:closeGUI')
AddEventHandler('esx_speedcamera:closeGUI', function()
    SendNUIMessage({type = 'closeSpeedcamera'})
end)

RegisterNetEvent("ex_speedcamera:shownotification")
AddEventHandler("ex_speedcamera:shownotification", function(zone, SpeedKM, total, term)


	if zone == 80 then

		drawNotification("~g~Has sido atrapado por un radar a ~r~ ".. SpeedKM.." Km/H ~g~ en una zona de ~r~ 80 Km/H!")

		if term > 0 then
			drawNotification("~g~Has sido multado con ~r~"..total.."$ ~g~ y ~r~ 5 Meses ~g~ de cárcel por exceso de velocidad")
		else
			drawNotification("~g~Has sido multado con ~r~"..total.."$ ~g~ por exceso de velocidad")
		end

	else

		drawNotification("~g~Has sido atrapado por un radar a ~r~ ".. SpeedKM.." Km/H ~g~ en una zona de ~r~ 120 Km/H!")
		
		if term > 0 then
			drawNotification("~g~Has sido multado con ~r~"..total.."$ ~g~ y ~r~ 5 Meses ~g~ de cárcel por exceso de velocidad")
		else 
			drawNotification("~g~Has sido multado con ~r~"..total.."$ ~g~ por exceso de velocidad")
		end

	end

end) 

-- Arnedo 5 | Entrando en zona de radar
local HasAlreadyEnteredMarker         = false
local isInRadarZone, hasExitedRadarZone = false
local currentZone                     = nil
local currentZoneName                 = nil

Citizen.CreateThread(function()

	while true do
	  Citizen.Wait(500)
  
	  local playerPed = PlayerPedId()
	  local coords    = GetEntityCoords(playerPed)
	  local playerPed = GetPlayerPed(-1)
	  local playerCar = GetVehiclePedIsIn(playerPed, false)
	  isInRadarZone, hasExitedRadarZone = false;
  
	  for k,v in pairs(Speedcamera80Zone) do
		local distance = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
  
		if distance < 100 then
		  currentZone, currentZoneName = v, "80"
		  isInRadarZone = true
		end
	  end

	  for k,v in pairs(Speedcamera120Zone) do
		local distance = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
  
		if distance < 100 then

		  currentZone, currentZoneName = v, "120"
		  isInRadarZone = true
		end
	  end
  
	  -- Enter zone
	  
	  if isInRadarZone and not HasAlreadyEnteredMarker then
		HasAlreadyEnteredMarker = true
  
		ESX.TriggerServerCallback('esx_speedcamera:checkDetector', function(hasRadar)
		 
			if hasRadar == true then
				if IsPedInAnyVehicle(playerPed, false) then
					if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then 
						ESX.ShowNotification("~g~Entrando~w~ en zona de radar de tramo: máx ~r~"..currentZoneName.."km/h")
					end
				end
			end
		
		end)
  
  
	  end
  
	  -- Exit zoone
	  if not hasExitedRadarZone and not isInRadarZone and HasAlreadyEnteredMarker then
		HasAlreadyEnteredMarker = false
  
		ESX.TriggerServerCallback('esx_speedcamera:checkDetector', function(hasRadar)			  
		  
			if hasRadar == true then
				if IsPedInAnyVehicle(playerPed, false) then
					if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then 
						ESX.ShowNotification("~r~Saliendo~w~ en zona de radar de tramo.")
					end
				end
			  end
			  
		end)
  
	  end
  
	end
  
  end)