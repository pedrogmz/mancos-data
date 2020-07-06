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

ESX = nil

local handcuffed                = false
local IsDragged                 = false
local CopPed                    = 0
local IsAbleToSearch            = false


Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
	
	PlayerData = ESX.GetPlayerData()
end)


function IsAbleToSteal(targetSID, err)
    ESX.TriggerServerCallback('esx_thief:getValue', function(result)
        local result = result
    	if result.value then
    		err(false)
    	else
    		err(_U('no_hands_up'))
    	end
    end, targetSID)
end

---- MENU

function OpenCuffMenu()

	TriggerEvent('mancos_ui:openMenu', 'social')

	local elements = {
		--{label = 'Ropa', value = 'clothes'},
        {label = 'Saco', value = 'headbag'},
        {label = _U('cuff'), value = 'cuff'},
        {label = _U('uncuff'), value = 'uncuff'}, 
        {label = _U('drag'), value = 'drag'},
		{label = "Meter en el vehiculo", value = 'put_in_vehicle'},
		{label = "Sacar del vehiculo", value = 'out_the_vehicle'},
		{label = _U('search'), value = 'search'},
		{label = "Ver DNI", value = 'ver_dni'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cuffing', {
		title    = _U('handcuffs'),
		align    = 'top-left',
		elements = elements
	}, function(data2, menu2)
		--if data2.current.value == 'clothes' then
			--TriggerEvent('smerfikubrania:openMenu')
		--end
			
		if data2.current.value == 'headbag' then
			ESX.TriggerServerCallback('esx_thief:getItemQ', function(quantity)
				if quantity > 0 then
					TriggerEvent('esx_worek:naloz')
				else 
					ESX.ShowNotification("No tienes el saco")
				end
			end, 'blindfold')
		end
		
		if data2.current.value == 'ver_dni' then
			TriggerEvent('mancos_dni:show_dni')
		end
			
		local player, distance = ESX.Game.GetClosestPlayer()
		if distance ~= -1 and distance <= 3.0 then
			if data2.current.value == 'put_in_vehicle' then
				TriggerServerEvent('esx_robar:putInVehicle', GetPlayerServerId(player))
			end
			if data2.current.value == 'out_the_vehicle' then
				TriggerServerEvent('esx_robar:OutVehicle', GetPlayerServerId(player))
			end
				
			if data2.current.value == 'cuff' then
				if Config.EnableItems then
					local target_id = GetPlayerServerId(player)
                    IsAbleToSteal(target_id, function(err)
                        if not err then
                            ESX.TriggerServerCallback('esx_thief:getItemQ', function(quantity)
                                if quantity > 0 then
                                    IsAbleToSearch = true
                                    ---
									playerheading = GetEntityHeading(GetPlayerPed(-1))
									playerlocation = GetEntityForwardVector(PlayerPedId())
									playerCoords = GetEntityCoords(GetPlayerPed(-1))
									handcuffed = true
									---
									
									TriggerServerEvent('mancos_arrest:request_arrest', target_id, playerheading, playerCoords, playerlocation)
                                else
                                    ESX.ShowNotification(_U('no_handcuffs'))
                                end
                            end, 'handcuffs')
                        else
                            ESX.ShowNotification(err)
                        end
                    end)
                else
					IsAbleToSearch = true
					TriggerServerEvent('cuffServer', GetPlayerServerId(player))
                end
			end
			if data2.current.value == 'uncuff' then
				if Config.EnableItems then
                    ESX.TriggerServerCallback('esx_thief:getItemQ', function(quantity)
                        if quantity > 0 then
                            IsAbleToSearch = false
                            ---
							playerheading = GetEntityHeading(GetPlayerPed(-1))
							playerlocation = GetEntityForwardVector(PlayerPedId())
							playerCoords = GetEntityCoords(GetPlayerPed(-1))
							target_id = GetPlayerServerId(closestPlayer)
							handcuffed = false
							---
							
							TriggerServerEvent('mancos_arrest:requestrelease', target_id, playerheading, playerCoords, playerlocation)
                        else
                            ESX.ShowNotification(_U('no_handcuffs'))
                        end
                    end, 'handcuffs')
                else
                    IsAbleToSearch = false
                    TriggerServerEvent('cuffServer', GetPlayerServerId(player))
                end
			end
			if data2.current.value == 'drag' then
                if Config.EnableItems then
                    ESX.TriggerServerCallback('esx_thief:getItemQ', function(quantity)
                        if quantity > 0 then
                            IsAbleToSearch = false
                            TriggerServerEvent('dragServer', GetPlayerServerId(player))
                        else
                            ESX.ShowNotification(_U('no_rope'))
                        end
                    end, 'rope')
                else
                    TriggerServerEvent('dragServer', GetPlayerServerId(player))
                end
			end  
			if data2.current.value == 'search' then
                local ped = PlayerPedId()
                if IsPedArmed(ped, 7) then
					if IsAbleToSearch then
                        local target, distance = ESX.Game.GetClosestPlayer()
                        if target ~= -1 and distance ~= -1 and distance <= 2.0 then
                            local target_id = GetPlayerServerId(target)
                        OpenStealMenu(target, target_id)
                        elseif distance < 20 and distance > 2.0 then
                            ESX.ShowNotification(_U('too_far'))
                        else
                            ESX.ShowNotification(_U('no_players_nearby'))
                        end
                    else
                        ESX.ShowNotification(_U('not_cuffed'))
                    
                    end
                else
                    ESX.ShowNotification(_U('not_armed'))
                end
			end
		else
			ESX.ShowNotification(_U('no_players_nearby'))
		end
	end, function(data2, menu2)
		menu2.close()
		TriggerEvent('mancos_ui:openMenu', 'social')
	end)
end

RegisterNetEvent('esx_robar:putInVehicle')
AddEventHandler('esx_robar:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not handcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				IsDragged = false
			end
		end
	end
end)

RegisterNetEvent('esx_robar:OutVehicle')
AddEventHandler('esx_robar:OutVehicle', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)


RegisterNetEvent('cuffClient')
AddEventHandler('cuffClient', function()
	local pP = GetPlayerPed(-1)
	RequestAnimDict('mp_arresting')
	while not HasAnimDictLoaded('mp_arresting') do
		Citizen.Wait(100)
	end
	TaskPlayAnim(pP, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
	SetEnableHandcuffs(pP, true)
	SetCurrentPedWeapon(pP, GetHashKey('WEAPON_UNARMED'), true)
	DisablePlayerFiring(pP, true)
    ESX.ShowNotification(_U('cuffed'))
	--FreezeEntityPosition(pP, true)
	handcuffed = true
end)

RegisterNetEvent('unCuffClient')
AddEventHandler('unCuffClient', function()
	local pP = GetPlayerPed(-1)
	ClearPedSecondaryTask(pP)
	SetEnableHandcuffs(pP, false)
	SetCurrentPedWeapon(pP, GetHashKey('WEAPON_UNARMED'), true)
  ESX.ShowNotification(_U('uncuffed'))
	--FreezeEntityPosition(pP, false)
	handcuffed = false
end)

RegisterNetEvent('cuffs:OpenMenu')
AddEventHandler('cuffs:OpenMenu', function()
	OpenCuffMenu()
end)

RegisterNetEvent('cuffscript:drag')
AddEventHandler('cuffscript:drag', function(cop)
  --TriggerServerEvent('esx:clientLog', 'starting dragging')
  IsDragged = not IsDragged
  CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    if handcuffed then
      if IsDragged then
        local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
        local myped = GetPlayerPed(-1)
        AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
      else
        DetachEntity(GetPlayerPed(-1), true, false)
      end
    end
  end
end)

-- Handcuff
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)
    if handcuffed then
	DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(2, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?

			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen
			DisableControlAction(2, Keys['Z'], true) -- Reload
		    DisableControlAction(2, Keys['X'], true) -- Reload
            DisableControlAction(2, Keys['U'], true) -- Reload
            DisableControlAction(2, Keys['G'], true) -- Reload

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
    else
      Citizen.Wait(1000)
    end
  end
end)


---- END MENU


function OpenStealMenu(target, target_id)

	TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(target), GetPlayerName(target))

end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

            local ped = PlayerPedId()

            if IsControlJustPressed(1, Keys['M']) and not IsEntityDead(ped) and not IsPedInAnyVehicle(ped, true) then -- OPEN CUFF MENU
                OpenCuffMenu()
            end
    end
end)

