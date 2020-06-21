--BY BNJ--
ESX = nil
cooldown = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		if cooldown then
			Citizen.Wait(Config.cooldown * 60000)
			cooldown = false
		end
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

-- Blip & marker
Citizen.CreateThread(function()
	if Config.blipEnabled then
		PokazBlip()
	end
end)

-- Ped
Citizen.CreateThread(function()
	RequestModel(GetHashKey(Config.pedName))
	while not HasModelLoaded(GetHashKey(Config.pedName)) do
		Citizen.Wait(1)
	end
	local ped = CreatePed(4, Config.pedHash, Config.pedCoords.x, Config.pedCoords.y, Config.pedCoords.z - 1, Config.pedHeading, false, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
end)

-- cmd
RegisterNetEvent('foka_tablice:command')
AddEventHandler('foka_tablice:command', function()
	Tablica()
end)


Citizen.CreateThread(function()
	while true do
	Citizen.Wait(2000)
		local ped = GetPlayerPed(-1)
		local coords = GetEntityCoords(ped, true)
		while GetDistanceBetweenCoords(coords, Config.pedCoords.x, Config.pedCoords.y, Config.pedCoords.z, false) < 10 do
			Citizen.Wait(0)
			coords = GetEntityCoords(ped, true)
			if GetDistanceBetweenCoords(coords, Config.pedCoords.x, Config.pedCoords.y, Config.pedCoords.z, false) < 3 then
				Notify('~INPUT_PICKUP~ ~g~' .. Config.money .. '$~w~ y te cambio la matrícula. (¡Deja el coche frente a mi!)')
				--EN-->	Notify('To push on ~INPUT_PICKUP~ to paint the license plate. (~g~' .. Config.money .. '$~w~)')
				if IsControlJustReleased(0, 38) then
					Tablica()
				end
			end
		end
	end
end)

-- BNJ_plaque
function Tablica()
	if cooldown then
		ESX.ShowNotification('No tengo más matrículas para cambiar')
		--EN--> ESX.ShowNotification('You have to wait ' .. Config.cooldown .. ' seconds, to hide the plate again!' )
	end
	if not cooldown then
		cooldown = true
		local ped = GetPlayerPed(-1)
		local veh = GetVehiclePedIsIn(ped, true)
		local plateText = GetVehicleNumberPlateText(veh)
		local plateNew = ' '
		TriggerServerEvent('foka_tablice:pay')
		 TriggerServerEvent('InteractSound_SV:PlayOnAll', 'peinture', 1.0)
		ESX.ShowNotification('Matrícula ~g~OCULTADA~w~ ' .. Config.czas .. ' minutos') 
		--EN--> ESX.Scaleform.ShowFreemodeMessage('~g~The plate is now hidden', '', 5) 
			 TriggerEvent("dqP:shownotif",'~r~Duración: ~w~~g~ ' .. Config.czas .. ' ~w~minutos!',18)
	    --EN--> TriggerEvent("dqP:shownotif",'~r~duration :~w~~g~ ' .. Config.czas .. ' ~w~minutes!',18)
		SetVehicleNumberPlateText(veh, plateNew)
		Citizen.Wait(Config.czas * 60000)
		SetVehicleNumberPlateText(veh, plateText)
		ESX.ShowNotification('La matricula ya es ~r~VISIBLE~w~')
        --EN--> ESX.ShowNotification('he plate is now ~g~visible~w~!')
	end
end

function Notify (text)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, 0, true, -1)
end


function PokazBlip()
  local blip = AddBlipForCoord(Config.coords.x, Config.coords.y, Config.coords.z)
  SetBlipSprite(blip, Config.blipSprite)
  SetBlipColour(blip, Config.blipColour)
  SetBlipDisplay(blip, 6)
  SetBlipScale(blip, Config.blipScale)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING");
  AddTextComponentString(Config.blipName)
  EndTextCommandSetBlipName(blip)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end