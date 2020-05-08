local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local IsBusy = false
local playerInService = false
local spawnedVehicles, isInShopMenu = {}, false
local PlayerData = {}


-- Revivir camilla
local InAction = false
-- Fin revivir camilla
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


--outfit
function OutfitsMenu()
	ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
		local elements = {}

		for i=1, #dressing, 1 do
			table.insert(elements, {
				label = dressing[i],
				value = i
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
		{
			title    = _U('ropapersonal'),
			align    = 'top-left',
			elements = elements
		}, function(data2, menu2)

			TriggerEvent('skinchanger:getSkin', function(skin)
				ESX.TriggerServerCallback('esx_property:getPlayerOutfit', function(clothes)
					TriggerEvent('skinchanger:loadClothes', skin, clothes)
					TriggerEvent('esx_skin:setLastSkin', skin)

					TriggerEvent('skinchanger:getSkin', function(skin)
						TriggerServerEvent('esx_skin:save', skin)
					end)
				end, data2.current.value)
			end)

		end, function(data2, menu2)
			menu2.close()
		end)
	end)
end

--Baul
function BaulAbrirMenu(station)
	local elements = {
		{label = _U('Dejarobjeto'), value = 'put_stock'},
		{label = _U('Cogerobjeto'), value = 'get_stock'}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('armario'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()

	ESX.TriggerServerCallback('esx_ambulancejob:getStockItems', function(items)

		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('ems_stock'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_ambulancejob:getStockItem', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksMenu()
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)

	end)
end

function OpenPutStocksMenu()

	ESX.TriggerServerCallback('esx_ambulancejob:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('inventory'),
			align    = 'top-left',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_ambulancejob:putStockItems', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)
	end)

end

function OpenAmbulanceActionsMenu()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'},
		{label = _U('ropero'), value = 'ropero'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
		table.insert(elements, {label = _U('Farmacia'), value = 'farmacia'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance_actions2'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'ropero' then
			OutfitsMenu()
		elseif data.current.value == 'farmacia' then
			OpenPharmacyMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenMobileAmbulanceActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-left',
		elements = {
			{label = _U('ems_menu'), value = 'citizen_interaction'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('ems_menu_title'),
				align    = 'top-left',
				elements = {
					{label = _U('ems_menu_revive'), value = 'revive'},
					{label = _U('ems_menu_small'), value = 'small'},
					{label = _U('ems_menu_big'), value = 'big'},
					{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
					{label = _U('ems_menu_out'), value = 'outvehicle'},
					{label = _U('ems_menu_drag'), value = 'drag'}
				}
			}, function(data, menu)
				if IsBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 1.0 then
					ESX.ShowNotification(_U('no_players'))
				else

					if data.current.value == 'revive' then

						IsBusy = true

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local playerPed = PlayerPedId()
								
								ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatusCloset', function(data)
									if Config.EnableESXIdentity then
										if data.isDead == true then
											local playerPed = PlayerPedId()

											ESX.ShowNotification(_U('revive_inprogress'))

											loadAnimDict("mini@cpr@char_a@cpr_str")
											loadAnimDict("mini@cpr@char_a@cpr_def")

											TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_def", "cpr_intro", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
											Citizen.Wait(15000)
											TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, 1.0, -1, 9, 0, 0, 0, 0)
											Citizen.Wait(10000)
											TaskPlayAnim(PlayerPedId(), "mini@cpr@char_a@cpr_def", "cpr_success", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
											
											TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
											TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))

											-- Show revive award?
											if Config.ReviveReward > 0 then
												ESX.ShowNotification(_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
											else
												ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
											end
										else
											ESX.ShowNotification(_U('player_not_unconscious'))
										end
									end
								end,GetPlayerServerId(closestPlayer))
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end

							IsBusy = false

						end, 'medikit')

					elseif data.current.value == 'small' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							end
						end, 'bandage')

					elseif data.current.value == 'big' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

					elseif data.current.value == 'put_in_vehicle' then
						TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
					
					elseif data.current.value == 'drag' then						
						TriggerServerEvent('esx_ambulancejob:drag', GetPlayerServerId(closestPlayer))
					
					elseif data.current.value == 'outvehicle' then						
						TriggerServerEvent('esx_ambulancejob:OutVehicle', GetPlayerServerId(closestPlayer))
					
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function FastTravel(coords, heading)
	local playerPed = PlayerPedId()

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

-- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local letSleep, isInMarker, hasExited = true, false, false
		local currentHospital, currentPart, currentPartNum

		for hospitalNum,hospital in pairs(Config.Hospitals) do

			-- Ambulance Actions
			if hospital.AmbulanceActions ~= nil then
				for k,v in ipairs(hospital.AmbulanceActions) do
					local distance = GetDistanceBetweenCoords(playerCoords, v, true)
	
					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false
					end
	
					if distance < Config.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
					end
				end
			end
			
			--[[-- Pharmacies
			for k,v in ipairs(hospital.Pharmacies) do
				local distance = GetDistanceBetweenCoords(playerCoords, v, true)

				if distance < Config.DrawDistance then
					DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < Config.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Pharmacy', k
				end
			end]]--
			-- Helicopter elevator

			if hospital.FastTravelElevatorhelicopter ~= nil then
				for k,v in ipairs(hospital.FastTravelElevatorhelicopter) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)
	
					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end
	
					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelElevatorhelicopter', k
					end
				end
			end 
			
			-- Elevator down
			if hospital.FastTravelElevatorDown ~= nil then
				for k,v in ipairs(hospital.FastTravelElevatorDown) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)
	
					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end
	
					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelElevatorDown', k
					end
				end
			end 
			
			-- Elevator up
			if hospital.FastTravelElevatorUp ~= nil then
				for k,v in ipairs(hospital.FastTravelElevatorUp) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)
	
					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end
	
					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelElevatorUp', k
					end
				end
			end 
			
			-- baul
			if hospital.Baul ~= nil then
				for k,v in ipairs(hospital.Baul) do
					local distance = GetDistanceBetweenCoords(playerCoords, v, true)
	
					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false
					end
	
					if distance < Config.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Baul', k
					end
				end
			end 
			
			-- tattoo
			if hospital.RemoveTattoo ~= nil then
				for k,v in ipairs(hospital.RemoveTattoo) do
					local distance = GetDistanceBetweenCoords(playerCoords, v, true)

					if distance < Config.DrawDistance then
						DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.1, 1.1, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
						letSleep = false
					end

					if distance < Config.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'RemoveTattoo', k
					end
				end
			end

			-- Vehicle Spawners
			if hospital.Vehicles ~= nil then
				for k,v in ipairs(hospital.Vehicles) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end

					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
					end
				end
			end

			-- Arnedo5 Nuevos markers
			if Config.Zones ~= nil then
				for k,v in pairs(Config.Zones) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.Pos.x, v.Pos.y, v.Pos.z, true)

					if v.Type ~= -1  and distance < Config.DrawDistance then
						DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
					end

					if distance < Config.MarkerSize.x then
						-- isInMarker, currentZone = true, k
						--isInMarker, currentStation, currentPart, currentPartNum = true, k, 'VehicleDeleter', k
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'VehicleDeleter', k
					end
				end
			end

			-- Helicopter Spawners
			if hospital.Helicopters ~= nil then
				for k,v in ipairs(hospital.Helicopters) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.Spawner, true)
	
					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end
	
					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
					end
				end
			end
			

			-- Fast Travels
			if hospital.FastTravels ~= nil then 
				for k,v in ipairs(hospital.FastTravels) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end


					if distance < v.Marker.x then
						FastTravel(v.To.coords, v.To.heading)
					end
				end
			end

			-- Fast Travels (Prompt)
			if hospital.FastTravelsPrompt ~= nil then 
				for k,v in ipairs(hospital.FastTravelsPrompt) do
					local distance = GetDistanceBetweenCoords(playerCoords, v.From, true)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end

					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelsPrompt', k
					end
				end
			end
		end

		-- Logic for exiting & entering markers
		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

			if
				(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
				(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
				TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentHospital, currentPart, currentPartNum)

		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_ambulancejob:hasExitedMarker', LastHospital, LastPart, LastPartNum)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(hospital, part, partNum)
	if part == 'FastTravelElevatorUp' then
		local travelItem = Config.Hospitals[hospital][part][partNum]
		
		CurrentAction = part
		CurrentActionMsg = _U('fast_travel_elevator')
		CurrentActionData = {to = travelItem.To.coords, heading = travelItem.To.heading}

	elseif part == 'FastTravelElevatorDown' then
		local travelItem = Config.Hospitals[hospital][part][partNum]
		
		CurrentAction = part
		CurrentActionMsg = _U('fast_travel_elevator')
		CurrentActionData = {to = travelItem.To.coords, heading = travelItem.To.heading}
	elseif part == 'FastTravelElevatorhelicopter' then
		local travelItem = Config.Hospitals[hospital][part][partNum]
		
		CurrentAction = part
		CurrentActionMsg = _U('fast_travel_elevator')
		CurrentActionData = {to = travelItem.To.coords, heading = travelItem.To.heading}
	end
	
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		if part == 'AmbulanceActions' then
			CurrentAction = part
			CurrentActionMsg = _U('actions_prompt')
			CurrentActionData = {}
		elseif part == 'Outfits' then
			CurrentAction = part
			CurrentActionMsg = _U('actions_outfits')
			CurrentActionData = {}
		elseif part == 'Baul' then
			CurrentAction = part
			CurrentActionMsg = _U('actions_baul')
			CurrentActionData = {}
		elseif part == 'Pharmacy' then
			CurrentAction = part
			CurrentActionMsg = _U('open_pharmacy')
			CurrentActionData = {}
		elseif part == 'Vehicles' then
			CurrentAction = part
			CurrentActionMsg = _U('garage_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'Helicopters' then
			CurrentAction = part
			CurrentActionMsg = _U('helicopter_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'FastTravelsPrompt' then
			local travelItem = Config.Hospitals[hospital][part][partNum]

			CurrentAction = part
			CurrentActionMsg = travelItem.Prompt
			CurrentActionData = {to = travelItem.To.coords, heading = travelItem.To.heading}
		-- Arnedo 5 | Vechicles deleter
		elseif part == 'VehicleDeleter' then
			local playerPed = PlayerPedId()
			local vehicle   = GetVehiclePedIsIn(playerPed, false)
	
			if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
				CurrentAction     = 'delete_vehicle'
				CurrentActionMsg  = _U('store_veh')
				CurrentActionData = { vehicle = vehicle }
			end
		elseif part == 'VehicleDeleterHelicopter' then
			local playerPed = PlayerPedId()
			local vehicle   = GetVehiclePedIsIn(playerPed, false)
	
			if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
				CurrentAction     = 'delete_vehicle'
				CurrentActionMsg  = _U('store_veh')
				CurrentActionData = { vehicle = vehicle }
			end
		end
	end
	if part == 'RemoveTattoo' then
		CurrentAction = part
		CurrentActionMsg = "Pulsa ~INPUT_CONTEXT~ para remover el tattoo."
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'RemoveTattoo' then
					TriggerEvent('esx_tattooshop:openPlayerTattooMenu')
				elseif CurrentAction == 'Baul' then
					BaulAbrirMenu()
				elseif CurrentAction == 'Vehicles' then
					OpenVehicleSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
					OpenHelicopterSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'FastTravelsPrompt' then
					FastTravel(CurrentActionData.to, CurrentActionData.heading)
				elseif CurrentAction == 'FastTravelElevatorUp' then
					OpenUpTpHospital()
				elseif CurrentAction == 'FastTravelElevatorDown' then
					OpenDownTpHospital()				
				elseif CurrentAction == 'FastTravelElevatorhelicopter' then
					OpenHelicopterTpHospital()
				elseif CurrentAction == 'delete_vehicle' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				CurrentAction = nil

			end

		elseif ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and not IsDead then
			if IsControlJustReleased(0, Keys['F6']) then
				OpenMobileAmbulanceActionsMenu()
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

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
				--TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)

				-- Meter un muerto en el vehiculo
				SetPedIntoVehicle(playerPed, vehicle, freeSeat) 
			end
		end
	end
end)

-- don't show dispatches if the player isn't in service
AddEventHandler('esx_phone:cancelMessage', function(dispatchNumber)
	if type(PlayerData.job.name) == 'string' and PlayerData.job.name == 'ambulance' and PlayerData.job.name == dispatchNumber then
		-- if esx_service is enabled
		if Config.MaxInService ~= -1 and not playerInService then
			CancelEvent()
		end
	end
end)

function OpenCloakroomMenu()
	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name
	local elements = {
		{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
		--{label = _U('ems_clothes_ems'), value = 'ambulance_wear'},
	}

	if grade == 'practicas' then
		table.insert(elements, {label = 'Ropa de practicas', value = 'practicas_wear'})
	elseif grade == 'paramedico' then
		table.insert(elements, {label = 'Ropa de paramedico', value = 'paramedico_wear'})
	elseif grade == 'medico' then
		table.insert(elements, {label = 'Ropa de medico', value = 'medico_wear'})
	elseif grade == 'cirujano' then
		table.insert(elements, {label = 'Ropa de cirujano', value = 'cirujano_wear'})
	elseif grade == 'fisotera' then
		table.insert(elements, {label = 'Ropa de fisioterapeuta', value = 'fisotera_wear'})
	elseif grade == 'pisco' then
		table.insert(elements, {label = 'Ropa de psicologo', value = 'pisco_wear'})
	elseif grade == 'boss' then
		table.insert(elements, {label = 'Ropa de jefe', value = 'boss_wear'})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then

			if Config.MaxInService ~= -1 then

				-- Arnedo 5 | No salimos de servicio
				--[[ 
				ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
					if isInService then

						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')
						TriggerServerEvent('esx_service:disableService', 'ambulance')
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'ambulance')
				]]--
			end
			setUniform("clear_wear", playerPed)
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end
		--Hidita: Por defecto no se entrara de servicio al cambiar de ropa y cambiamos el sistema de ropa por defecto
--[[ 
		elseif Config.MaxInService ~= -1 and data.current.value == 'ambulance_wear' then
			local serviceOk = 'waiting'
			
			ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
				if not isInService then

					ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
						if not canTakeService then
							ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
						else

							serviceOk = true
							playerInService = true

							local notification = {
								title    = _U('service_anonunce'),
								subject  = '',
								msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
								iconType = 1
							}
	
							TriggerServerEvent('esx_service:notifyAllInService', notification, 'ambulance')
							ESX.ShowNotification(_U('service_in'))
						end
					end, 'ambulance')

				else
					serviceOk = true
				end
			end, 'ambulance')

			while type(serviceOk) == 'string' do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not serviceOk then
				return
			end
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
				end
			end)
]]--
			

		if
			data.current.value == 'practicas_wear' or
			data.current.value == 'paramedico_wear' or
			data.current.value == 'medico_wear' or
			data.current.value == 'cirujano_wear' or
			data.current.value == 'fisotera_wear' or
			data.current.value == 'pisco_wear' or
			data.current.value == 'boss_wear'
		then
			--llamar funcion para cambiar de ropa
			setUniform(data.current.value, playerPed)
		end
			
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end
--Hidi: Añadimos función para cambiar la ropa

function setUniform(job,playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.Uniforms[job].female then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end


function OpenVehicleSpawnerMenu(hospital, partNum)

	local playerCoords = GetEntityCoords(PlayerPedId())
	PlayerData = ESX.GetPlayerData()
	local shopElements = {}

	local shopCoords = Config.Hospitals[hospital].Vehicles[partNum].InsideShop
	local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade_name]

	if #Config.AuthorizedVehicles.Shared > 0 then
		for k,vehicle in ipairs(Config.AuthorizedVehicles.Shared) do
			table.insert(shopElements, {
				label = vehicle.label,
				name  = vehicle.label,
				model = vehicle.model,
				type  = 'car'
			})
		end
	end

	if authorizedVehicles ~=  nil then
		if #authorizedVehicles > 0 then
			for k,vehicle in ipairs(authorizedVehicles) do
				table.insert(shopElements, {
					label = vehicle.label,
					name  = vehicle.label,
					model = vehicle.model,
					type  = 'car'
				})
			end
		else
			if #Config.AuthorizedVehicles.Shared == 0 then
				return
			end
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage',
	{
		title		= _U('spawn_veh'),
		align		= 'top-left',
		elements	= shopElements
	}, function(data, menu)
		
		menu.close()
		DeleteSpawnedVehicles()
	
		print(partNum)
		local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Vehicles', partNum)

		if foundSpawn then

			if data.current.model == 'firetruk' then
				coords =  spawnPoint.firetruk
			else 
				coords = spawnPoint.coords
			end

			ESX.Game.SpawnVehicle(data.current.model, coords, spawnPoint.heading, function(vehicle)
				table.insert(spawnedVehicles, vehicle)
				local playerPed = PlayerPedId()
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
		end
	
	
	end, function(data, menu)
		CurrentAction     = 'vehicle_garage'
		CurrentActionMsg  = _U('spawner_prompt')
		CurrentActionData = {}

		menu.close()
	end)


	-------------------
	--[[ 
	local playerCoords = GetEntityCoords(PlayerPedId())
	local elements = {
		{label = _U('garage_storeditem'), action = 'garage'},
		{label = _U('garage_storeitem'), action = 'store_garage'},
		{label = _U('garage_buyitem'), action = 'buy_vehicle'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'buy_vehicle' then
			local shopCoords = Config.Hospitals[hospital].Vehicles[partNum].InsideShop
			local shopElements = {}

			local authorizedVehicles = Config.AuthorizedVehicles[ESX.PlayerData.job.grade_name]

			if #authorizedVehicles > 0 then
				for k,vehicle in ipairs(authorizedVehicles) do
					table.insert(shopElements, {
						label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
						name  = vehicle.label,
						model = vehicle.model,
						price = vehicle.price,
						type  = 'car'
					})
				end
			else
				return
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('esx_vehicleshop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = _U('garage_title'),
						align    = 'top-left',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Vehicles', partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)

									TriggerServerEvent('esx_vehicleshop:setJobVehicleState', data2.current.vehicleProps.plate, false)
									ESX.ShowNotification(_U('garage_released'))
								end)
							end
						else
							ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)

				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, 'car')

		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)
	]]--

end

function StoreNearbyVehicle(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do

			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				table.insert(vehiclePlates, {
					vehicle = v,
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				})
			end
		end
	else
		ESX.ShowNotification(_U('garage_store_nearby'))
		return
	end

	ESX.TriggerServerCallback('esx_ambulancejob:storeNearbyVehicle', function(storeSuccess, foundNum)
		if storeSuccess then
			local vehicleId = vehiclePlates[foundNum]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId.vehicle)
			IsBusy = true

			Citizen.CreateThread(function()
				while IsBusy do
					Citizen.Wait(0)
					drawLoadingText(_U('garage_storing'), 255, 255, 255, 255)
				end
			end)

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId.vehicle) do
				Citizen.Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for k,v in ipairs(vehicles) do
						if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							ESX.Game.DeleteVehicle(v)
							break
						end
					end
				end
			end

			IsBusy = false
			ESX.ShowNotification(_U('garage_has_stored'))
		else
			ESX.ShowNotification(_U('garage_has_notstored'))
		end
	end, vehiclePlates)
end

function GetAvailableVehicleSpawnPoint(hospital, part, partNum)
	local spawnPoints = Config.Hospitals[hospital][part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('garage_blocked'))
		return false
	end
end

function OpenHelicopterSpawnerMenu(hospital, partNum)

	local playerCoords = GetEntityCoords(PlayerPedId())
	PlayerData = ESX.GetPlayerData()
	local shopElements = {}

	local shopCoords = Config.Hospitals[hospital].Vehicles[partNum].InsideShop
	local authorizedVehicles = Config.AuthorizedHelicopters[PlayerData.job.grade_name]

	if #Config.AuthorizedHelicopters.Shared > 0 then
		for k,vehicle in ipairs(Config.AuthorizedHelicopters.Shared) do
			table.insert(shopElements, {
				label = vehicle.label,
				name  = vehicle.label,
				model = vehicle.model,
				type  = 'car'
			})
		end
	end

	if authorizedVehicles ~=  nil then
		if #authorizedVehicles > 0 then
			for k,vehicle in ipairs(authorizedVehicles) do
				table.insert(shopElements, {
					label = vehicle.label,
					name  = vehicle.label,
					model = vehicle.model,
					type  = 'car'
				})
			end
		else
			if #Config.AuthorizedHelicopters.Shared == 0 then
				return
			end
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage',
	{
		title		= _U('spawn_veh'),
		align		= 'top-left',
		elements	= shopElements
	}, function(data, menu)

		menu.close()
		DeleteSpawnedVehicles()
	
		local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Helicopters', partNum)

		if foundSpawn then
			--menu.close()

			ESX.Game.SpawnVehicle(data.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
				table.insert(spawnedVehicles, vehicle)
				local playerPed = PlayerPedId()
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
		end
	
	
	end, function(data, menu)
		CurrentAction     = 'vehicle_garage'
		CurrentActionMsg  = _U('spawner_prompt')
		CurrentActionData = {}

		menu.close()
	end)




--[[ 

	local playerCoords = GetEntityCoords(PlayerPedId())
	ESX.PlayerData = ESX.GetPlayerData()
	local elements = {
		{label = _U('helicopter_garage'), action = 'garage'},
		{label = _U('helicopter_store'), action = 'store_garage'},
		{label = _U('helicopter_buy'), action = 'buy_helicopter'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_spawner', {
		title    = _U('helicopter_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'buy_helicopter' then
			local shopCoords = Config.Hospitals[hospital].Helicopters[partNum].InsideShop
			local shopElements = {}

			local authorizedHelicopters = Config.AuthorizedHelicopters[ESX.PlayerData.job.grade_name]

			if #authorizedHelicopters > 0 then
				for k,helicopter in ipairs(authorizedHelicopters) do
					table.insert(shopElements, {
						label = ('%s - <span style="color:green;">%s</span>'):format(helicopter.label, _U('shop_item', ESX.Math.GroupDigits(helicopter.price))),
						name  = helicopter.label,
						model = helicopter.model,
						price = helicopter.price,
						type  = 'helicopter'
					})
				end
			else
				ESX.ShowNotification(_U('helicopter_notauthorized'))
				return
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('esx_vehicleshop:retrieveJobVehicles', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_garage', {
						title    = _U('helicopter_garage_title'),
						align    = 'top-left',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Helicopters', partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)

									TriggerServerEvent('esx_vehicleshop:setJobVehicleState', data2.current.vehicleProps.plate, false)
									ESX.ShowNotification(_U('garage_released'))
								end)
							end
						else
							ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)

				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, 'helicopter')

		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)
]]--
end

function OpenShopMenu(elements, restoreCoords, shopCoords)
	local playerPed = PlayerPedId()
	isInShopMenu = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = _U('vehicleshop_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
			title    = _U('vehicleshop_confirm', data.current.name, data.current.price),
			align    = 'top-left',
			elements = {
				{ label = _U('confirm_no'), value = 'no' },
				{ label = _U('confirm_yes'), value = 'yes' }
			}
		}, function(data2, menu2)

			if data2.current.value == 'yes' then
				local newPlate = exports['esx_vehicleshop']:GeneratePlate()
				local vehicle  = GetVehiclePedIsIn(playerPed, false)
				local props    = ESX.Game.GetVehicleProperties(vehicle)
				props.plate    = newPlate

				ESX.TriggerServerCallback('esx_ambulancejob:buyJobVehicle', function (bought)
					if bought then
						ESX.ShowNotification(_U('vehicleshop_bought', data.current.name, ESX.Math.GroupDigits(data.current.price)))

						isInShopMenu = false
						ESX.UI.Menu.CloseAll()
				
						DeleteSpawnedVehicles()
						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)
				
						ESX.Game.Teleport(playerPed, restoreCoords)
					else
						ESX.ShowNotification(_U('vehicleshop_money'))
						menu2.close()
					end
				end, props, data.current.type)
			else
				menu2.close()
			end

		end, function(data2, menu2)
			menu2.close()
		end)

		end, function(data, menu)
		isInShopMenu = false
		ESX.UI.Menu.CloseAll()

		DeleteSpawnedVehicles()
		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)

		ESX.Game.Teleport(playerPed, restoreCoords)
	end, function(data, menu)
		DeleteSpawnedVehicles()

		WaitForVehicleToLoad(data.current.model)
		ESX.Game.SpawnLocalVehicle(data.current.model, shopCoords, 0.0, function(vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
		end)
	end)

	WaitForVehicleToLoad(elements[1].model)
	ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, 0.0, function(vehicle)
		table.insert(spawnedVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInShopMenu then
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)

			DisableControlAction(0, Keys['TOP'], true)
			DisableControlAction(0, Keys['DOWN'], true)
			DisableControlAction(0, Keys['LEFT'], true)
			DisableControlAction(0, Keys['RIGHT'], true)
			DisableControlAction(0, 176, true) -- ENTER key
			DisableControlAction(0, Keys['BACKSPACE'], true)

			drawLoadingText(_U('vehicleshop_awaiting_model'), 255, 255, 255, 255)
		end
	end
end

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title    = _U('pharmacy_menu_title'),
		align    = 'top-left',
		elements = {
			{label = _U('pharmacy_take', _U('medikit')), value = 'medikit'},
			{label = _U('pharmacy_take', _U('bandage')), value = 'bandage'},			
			{label = _U('pharmacy_take', _U('water')), value = 'water'},
			{label = _U('pharmacy_take', _U('bread')), value = 'bread'},
--			{label = _U('pharmacy_take', 'Taser'), value = 'WEAPON_STUNGUN'},
		}
	}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end


function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		ESX.ShowNotification(_U('no_vehicles'))
	end
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)

-- Revivir camilla
Citizen.CreateThread(function()
    while true do

        Citizen.Wait(5)

        for i=1, #Config.BedList do
            local bedID   = Config.BedList[i]
            local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), bedID.objCoords.x, bedID.objCoords.y, bedID.objCoords.z, true)
			local ped = GetPlayerPed(-1)
			local isdeadparam = 'autores' 
            if distance < Config.MaxDistance and InAction == false then

                ESX.Game.Utils.DrawText3D({ x = bedID.objCoords.x, y = bedID.objCoords.y, z = bedID.objCoords.z + 1 }, bedID.text, 0.6)
				ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
					if IsControlJustReleased(0, Keys['E']) and isDead == false then
						bedActive(bedID.objCoords.x, bedID.objCoords.y, bedID.objCoords.z, bedID.heading, bedID)
					elseif IsControlJustReleased(0, Keys['E']) and isDead == true then                    						
						TriggerServerEvent('esx_ambulancejob:checkemsservicerevive',ped,isdeadparam)						
					end
				end)

            end
        end
    end
end)

function bedActive(x, y, z, heading)

    SetEntityCoords(GetPlayerPed(-1), x, y, z + 0.3)
    RequestAnimDict('missfbi5ig_0')
    while not HasAnimDictLoaded('missfbi5ig_0') do
        Citizen.Wait(0)
    end
    TaskPlayAnim(GetPlayerPed(-1), 'missfbi5ig_0' , 'lyinginpain_loop_steve' ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(GetPlayerPed(-1), heading + 180.0)
    InAction = true

	Citizen.CreateThread(function ()
	    Citizen.Wait(5)
	    local health = GetEntityHealth(PlayerPedId())

	    if (health < 200)  then
		TriggerEvent('esx:showNotification', '~g~ Te estan curando, por favor espere.'); 
		Citizen.Wait(5000)
		if InAction == true then
		    while GetEntityHealth(PlayerPedId()) < 200 do
			Citizen.Wait(200)
			SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) + 1)
		    end
		    TriggerEvent('esx:showNotification', '~g~ Ya estas curado.'); 
		end

	    elseif (health == 200) then
		TriggerEvent('esx:showNotification', '~y~ No necesitas atención medica.'); 
	    end
	end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            if InAction == true then
                DrawSub('Pulsa ~g~X~w~ para levantarte.')
                if IsControlJustReleased(0, Keys['X']) then
                    ClearPedTasks(GetPlayerPed(-1))
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    SetEntityCoords(GetPlayerPed(-1), x + 1.0, y, z)
                    InAction = false
                end
            end
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    end
end)

function DrawSub(msg, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, 1)
end


-- Subir y bajar ascensor
function OpenUpTpHospital()
	local elements = {}
	
	table.insert(elements, { label = 'Subir a la zona de visitas', x = 334.22, y = -569.85, z = 43.32 })
	table.insert(elements, { label = 'Ir al helicoptero', x = 344.74, y = -585.39, z = 74.17, h = 248.76 })

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'teleport_hospital_elevator', {
		title    = _U('teleport_hospital_elevator'),
		align    = 'top-left',
		elements =  elements		
		
		}, 
		function(data, menu)
			local coords = { x = data.current.x,  y = data.current.y, z = data.current.z, h = data.current.h }
			ESX.Game.Teleport(PlayerPedId(), coords)
			menu.close()
		end,
		
		function(data, menu)
			menu.close()
		end
	)
	
end


function OpenDownTpHospital()
	local elements = {}
	
	table.insert(elements, { label = 'Bajar a la zona de operaciones', x = 337.64, y = -594.09, z = 28.79  })
	table.insert(elements, { label = 'Ir al helicoptero', x = 344.74, y = -585.39, z = 74.17, h = 248.76})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'teleport_hospital_elevator', {
		title    = _U('teleport_hospital_elevator'),
		align    = 'top-left',
		elements =  elements
		}, 
		function(data, menu)
			local coords = { x = data.current.x,  y = data.current.y, z = data.current.z}
			ESX.Game.Teleport(PlayerPedId(), coords)
			menu.close()
		end,
		
		function(data, menu)
			menu.close()
		end
	)
end

function OpenHelicopterTpHospital()
	local elements = {}
	
	table.insert(elements, { label = 'Bajar a la zona de operaciones', x = 337.64, y = -594.09, z = 28.79  })
	table.insert(elements, { label = 'Bajar a la zona de visitas', x = 334.22, y = -569.85, z = 43.32 })

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'teleport_hospital_elevator', {
		title    = _U('teleport_hospital_elevator'),
		align    = 'top-left',
		elements =  elements
		}, 
		function(data, menu)
			local coords = { x = data.current.x,  y = data.current.y, z = data.current.z}
			ESX.Game.Teleport(PlayerPedId(), coords)
			menu.close()
		end,
		
		function(data, menu)
			menu.close()
		end
	)
end

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end