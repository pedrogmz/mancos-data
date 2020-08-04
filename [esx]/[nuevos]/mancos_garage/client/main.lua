ESX = nil

cachedData = {}
inMenu = false

Citizen.CreateThread(function()
	while not ESX do
		--Fetching esx library, due to new to esx using this.

		TriggerEvent("esx:getSharedObject", function(library) 
			ESX = library 
		end)

		Citizen.Wait(0)
	end
	
	if Config.Impound then
		Citizen.Wait(5)
		refreshBlips()
	end

	if Config.VehicleMenu then
		while true do
			Citizen.Wait(5)

			if IsControlJustPressed(0, Config.VehicleMenuButton) then
				ESX.UI.Menu.CloseAll()
				OpenVehicleMenu()
			end
		end
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
	ESX.PlayerData = playerData
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if DoesCamExist(cachedData["cam"]) and (IsControlJustPressed(0, 322) or IsControlJustPressed(0, 73) or IsControlJustPressed(0, 70)) then
			HandleCamera(cachedData["currentGarage"], false)
		end

		if inMenu then
			DisableAllControlActions(0)		
			EnableControlAction(0, 27, true)
			EnableControlAction(0, 70, true)
			EnableControlAction(0, 18, true)
			EnableControlAction(0, 173, true)
			EnableControlAction(0, 177, true)
			EnableControlAction(0, 178, true)
			EnableControlAction(0, 322, true)
		else
			Citizen.Wait(100)
		end
	end
end)

Citizen.CreateThread(function()
	local CanDraw = function(action)
		if action == "vehicle" then
			if IsPedInAnyVehicle(PlayerPedId()) then
				local vehicle = GetVehiclePedIsIn(PlayerPedId())

				if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
					return true
				else
					return false
				end
			else
				return false
			end
		end

		return true
	end

	local GetDisplayText = function(action, garage)
		if not Config.Labels[action] then Config.Labels[action] = action end

		return string.format(Config.Labels[action], action == "vehicle" and GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId())))) or garage)
	end

	for garage, garageData in pairs(Config.Garages) do
		local showBlip = garageData["positions"]["menu"]["blip"]
		if showBlip then
			local garageBlip = AddBlipForCoord(garageData["positions"]["menu"]["position"])

			SetBlipSprite(garageBlip, 357)
			SetBlipDisplay(garageBlip, 4)
			SetBlipScale (garageBlip, 0.8)
			SetBlipColour(garageBlip, 67)
			SetBlipAsShortRange(garageBlip, true)
			BeginTextCommandSetBlipName("STRING")
			if Config.OneBlipName then
				AddTextComponentString(Config.GarageName)
			else
			AddTextComponentString(Config.GarageName .. ": " .. garage)
			end
			EndTextCommandSetBlipName(garageBlip)
		end
	end

	while true do
		local sleepThread = 500

		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)

		for garage, garageData in pairs(Config.Garages) do
			for action, actionData in pairs(garageData["positions"]) do
				local dstCheck = #(pedCoords - actionData["position"])

				if dstCheck <= 10.0 then
					sleepThread = 5

					local draw = CanDraw(action)

					if draw then
						local markerSize = action == "vehicle" and 5.0 or 1.5

						if dstCheck <= markerSize - 0.1 then
							local usable, displayText = not DoesCamExist(cachedData["cam"]), GetDisplayText(action, garage)

							ESX.ShowHelpNotification(usable and displayText or "Select the vehicle.")

							if usable then
								if IsControlJustPressed(0, 38) then
									cachedData["currentGarage"] = garage

									HandleAction(action)
								end
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
			end
		end

		Citizen.Wait(sleepThread)
	end
end)

if Config.Impound then
-- Open Main Menu
function OpenMenuGarage(PointType)
	ESX.UI.Menu.CloseAll()
	
	local elements = {}

		table.insert(elements, {label = 'Return Owned Cars'.." ($"..Config.ImpoundPrice..")", value = 'return_owned_cars'})

	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_menu', {
		title    = 'Impound',
		align    = Config.AlignMenu,
		elements = elements
	}, function(data, menu)
		menu.close()
		local action = data.current.value
		if action == 'return_owned_cars' then
			ReturnOwnedCarsMenu()
		end

		
	end, function (data, menu)
		menu.close()
	end)
end

-- Pound Owned Cars Menu
function ReturnOwnedCarsMenu()
	ESX.TriggerServerCallback('garage:getOutOwnedCars', function(ownedCars)
		local elements = {

		}
		
		for _,v in pairs(ownedCars) do
			if Config.UseVehicleNamesLua == true then
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName  = GetLabelText(aheadVehName)
				local labelvehicle
				local plate = v.plate
				
				labelvehicle = '| '..plate..' | '..vehicleName..' | Return |'
				
				table.insert(elements, {label = labelvehicle, value = v})
			else
				local hashVehicule = v.model
				local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
				local labelvehicle
				local plate = v.plate
				
				labelvehicle = '| '..plate..' | '..vehicleName..' | Return |'
				
				table.insert(elements, {label = labelvehicle, value = v})
			end
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_car', {
			title    = 'Car Impound',
			align    = Config.AlignMenu,
			elements = elements
		}, function(data, menu)

	local gameVehicles = ESX.Game.GetVehicles()

	for i = 1, #gameVehicles do
		local vehicle = gameVehicles[i]

        if DoesEntityExist(vehicle) then
			if Config.Trim(GetVehicleNumberPlateText(vehicle)) == Config.Trim(data.current.value.plate) then
				ESX.ShowNotification("This car is out already")

				return
			end
		end
	end
			ESX.TriggerServerCallback('garage:checkMoneyCars', function(hasEnoughMoney)
				if hasEnoughMoney then
					TriggerServerEvent('garage:payCar', data.current.value.plate)
					SpawnPoundedVehicle(data.current.value, data.current.value.plate)
				else
					ESX.ShowNotification('Card Refused! Ensure you have enough money in the bank')
				end
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

-- Entered Marker
AddEventHandler('garage:hasEnteredMarker', function(zone)
	if zone == 'car_pound_point' then
		CurrentAction     = 'car_pound_point'
		CurrentActionMsg  = 'Press ~INPUT_PICKUP~ to access the Impound.'
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('garage:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- impound Draw Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

			-- Car Pounds
			for k,v in pairs(Config.CarPounds) do
				if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.DrawDistance) then
					DrawMarker(Config.MarkerType, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
end)

-- Activate Menu when in Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)
		local isInMarker = false

			-- Car Pounds
		for k,v in pairs(Config.CarPounds) do
			if (GetDistanceBetweenCoords(coords, v.PoundPoint.x, v.PoundPoint.y, v.PoundPoint.z, true) < Config.PoundMarker.x) then
				isInMarker  = true
				this_Garage = v
				currentZone = 'car_pound_point'
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
		hasAlreadyEnteredMarker = true
		LastZone                = currentZone
		TriggerEvent('garage:hasEnteredMarker', currentZone)
		end
		
		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('garage:hasExitedMarker', LastZone)
		end	
			
	end
end)


-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)
			
			if IsControlJustReleased(0, 38) then

				if CurrentAction == 'car_pound_point' then
					OpenMenuGarage('car_pound_point')
				end

				
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)


function refreshBlips()
	local blipList = {}
	local JobBlips = {}
count=0
-- Car Pounds
for k,v in pairs(Config.CarPounds) do
	count= count+1
	print(count)
	table.insert(blipList, {
		coords = { v.PoundPoint.x, v.PoundPoint.y },
		text   = Config.ImpoundName,
		sprite = Config.BlipImpound.Sprite,
		color  = Config.BlipImpound.Color,
		scale  = Config.BlipImpound.Scale
	})
end

	for i=1, #blipList, 1 do
		CreateBlip(blipList[i].coords, blipList[i].text, blipList[i].sprite, blipList[i].color, blipList[i].scale)
	end


end

function CreateBlip(coords, text, sprite, color, scale)
	local blip = AddBlipForCoord( table.unpack(coords) )

	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, scale)
	SetBlipColour(blip, color)

	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandSetBlipName(blip)
--	table.insert(JobBlips, blip)
end

-- Spawn Pound Cars
function SpawnPoundedVehicle(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = this_Garage.SpawnPoint.x,
		y = this_Garage.SpawnPoint.y,
		z = this_Garage.SpawnPoint.z + 1
	}, this_Garage.SpawnPoint.h, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
	end)
end


end