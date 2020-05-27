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
  
  local HasAlreadyEnteredMarker = false
  local LastZone                = nil
  local CurrentAction           = nil
  local CurrentActionMsg        = ''
  local CurrentActionData       = {}
  local IsInShopMenu            = false
  local MainCategories              = {}
  local Categories              = {}
  local Vehicles                = {}
  local LastVehicles            = {}
  local CurrentVehicleData      = nil
  local CarDealersOnline = 0
  
  ESX                           = nil
  
  Citizen.CreateThread(function ()
	  while ESX == nil do
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		  Citizen.Wait(0)
	  end
  
	  Citizen.Wait(10000)
  
	  ESX.TriggerServerCallback('esx_premium_carshop:getMainCategories', function (maincategories)
		  MainCategories = maincategories
	  end)
  
	  ESX.TriggerServerCallback('esx_premium_carshop:getCategories', function (categories)
		  Categories = categories
	  end)
  
	  ESX.TriggerServerCallback('esx_premium_carshop:getVehicles', function (vehicles)
		  Vehicles = vehicles
	  end)
  
	  if Config.EnablePlayerManagement then
		  if ESX.PlayerData.job.name == 'cardealer' then
			  Config.Zones.ShopEntering.Type = 1
  
			  if ESX.PlayerData.job.grade_name == 'boss' then
				  Config.Zones.BossActions.Type = 1
			  end
  
		  else
			  Config.Zones.ShopEntering.Type = -1
			  Config.Zones.BossActions.Type  = -1
		  end
	  end
  end)
  
function UpdateCarDealers(connectedPlayers)
  for k,v in pairs(connectedPlayers) do
	  if v.job == 'cardealer' then
		  CarDealersOnline = CarDealersOnline + 1
	  end
  end
end
  
  ---- Timer para limitar compras de coches a 1 compra por minuto
  Citizen.CreateThread(function()
	  timer = Config.BuyTimer * 1000
	  time = 0
	  while true do
		  Wait(1000)
		  time = time + 1000
	  end
  end)
  
  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
	  ESX.PlayerData = xPlayer
  
	  if Config.EnablePlayerManagement then
		  if ESX.PlayerData.job.name == 'cardealer' then
			  Config.Zones.ShopEntering.Type = 1
  
			  if ESX.PlayerData.job.grade_name == 'boss' then
				  Config.Zones.BossActions.Type = 1
			  end
  
		  else
			  Config.Zones.ShopEntering.Type = -1
			  Config.Zones.BossActions.Type  = -1
		  end
	  end
  end)
  
  RegisterNetEvent('esx_premium_carshop:sendMainCategories')
  AddEventHandler('esx_premium_carshop:sendMainCategories', function (maincategories)
	  MainCategories = maincategories
  end)
  
  RegisterNetEvent('esx_premium_carshop:sendCategories')
  AddEventHandler('esx_premium_carshop:sendCategories', function (categories)
	  Categories = categories
  end)
  
  RegisterNetEvent('esx_premium_carshop:sendVehicles')
  AddEventHandler('esx_premium_carshop:sendVehicles', function (vehicles)
	  Vehicles = vehicles
  end)
  
  function DeleteShopInsideVehicles()
	  while #LastVehicles > 0 do
		  local vehicle = LastVehicles[1]
  
		  ESX.Game.DeleteVehicle(vehicle)
		  table.remove(LastVehicles, 1)
	  end
  end
  
  function ReturnVehicleProvider()
  
	  ESX.TriggerServerCallback('esx_premium_carshop:getCommercialVehicles', function (vehicles)
		  local elements = {}
		  local returnPrice
		  for i=1, #vehicles, 1 do
			  returnPrice = ESX.Math.Round(vehicles[i].price * 0.75)
  
			  table.insert(elements, {
				  label = ('%s [<span style="color:orange;">%s</span>]'):format(vehicles[i].name, _U('generic_shopitem', ESX.Math.GroupDigits(returnPrice))),
				  value = vehicles[i].name
			  })
		  end
	  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_provider_menu',
		  {
			  title    = _U('return_provider_menu'),
			  align    = 'top-left',
			  elements = elements
		  }, function (data, menu)
			  TriggerServerEvent('esx_premium_carshop:returnProvider', data.current.value)
  
			  Citizen.Wait(300)
			  menu.close()
  
			  ReturnVehicleProvider()
		  end, function (data, menu)
			  menu.close()
		  end)
	  end)
  
  end
  
  function StartShopRestriction()
  
	  Citizen.CreateThread(function()
		  while IsInShopMenu do
			  Citizen.Wait(1)
	  
			  DisableControlAction(0, 75,  true) -- Disable exit vehicle
			  DisableControlAction(27, 75, true) -- Disable exit vehicle
		  end
	  end)
  
  end
  
  function OpenSubCategoryMenu(parent_cat)
  
	  IsInShopMenu = true
  
	  StartShopRestriction()
  
	  local playerPed = PlayerPedId()
  
	  FreezeEntityPosition(playerPed, true)
	  SetEntityVisible(playerPed, false)
	  SetEntityCoords(playerPed, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z)
  
	  local vehiclesByCategory = {}
	  local elements = {}
	  local firstVehicleData = nil
  
	  ESX.UI.Menu.CloseAll()
	  
	  for i=1, #Categories, 1 do
		  vehiclesByCategory[Categories[i].name] = {}
	  end
  
	  for i=1, #Vehicles, 1 do
		  if IsModelInCdimage(GetHashKey(Vehicles[i].model)) then
			  table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
		  else
			  print(('esx_premium_carshop: vehicle "%s" does not exist'):format(Vehicles[i].model))
		  end
	  end
	  
	  for i=1, #Categories, 1 do
		  local category         = Categories[i]
		  
		  if parent_cat == Categories[i].parent_id  then
  
			  local categoryVehicles = vehiclesByCategory[Categories[i].name]
			  local options          = {}
			  
			  for j=1, #categoryVehicles, 1 do
				  local vehicle = categoryVehicles[j]
				  
				  if j == 1 then
					  firstVehicleData = vehicle
				  end
			  
				  table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
			  end
			  
			  table.insert(elements, {
				  name    = category.name,
				  label   = category.label,
				  value   = 0,
				  type    = 'slider',
				  max     = #Categories[i],
				  options = options
			  })
		  end
  
	  end
	  
	  -- OLD
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_premium',
	  {
		  title    = _U('car_dealer'),
		  align    = 'top-left',
		  elements = elements
	  }, function (data, menu)
		  local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			  title = _U('buy_vehicle_shop', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			  align = 'top-left',
			  elements = {
				  {label = _U('no'),  value = 'no'},
				  {label = _U('yes'), value = 'yes'}
			  }
		  }, function(data2, menu2)
			  if data2.current.value == 'yes' then
					ESX.TriggerServerCallback('esx_premium_carshop:buyVehicle', function (hasEnoughMoney)

						if hasEnoughMoney then
							IsInShopMenu = false

							menu2.close()
							menu.close()

							DeleteShopInsideVehicles()

							ESX.Game.SpawnVehicle(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
								TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

								local newPlate     = GeneratePlate()
								local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
								vehicleProps.plate = newPlate
								SetVehicleNumberPlateText(vehicle, newPlate)

								if Config.EnableOwnedVehicles then
									TriggerServerEvent('esx_premium_carshop:setVehicleOwned', vehicleProps)
								end
							
								ESX.ShowNotification(_U('vehicle_purchased'))
								time = 0
							end)

							FreezeEntityPosition(playerPed, false)
							SetEntityVisible(playerPed, true)
						else
							ESX.ShowNotification(_U('not_enough_money'))
						end

					end, vehicleData.model)
			  elseif data2.current.value == 'no' then
  
			  end
  
		  end, function (data2, menu2)
			  menu2.close()
		  end)
  
	  end, function (data, menu)
		  -- Cancel
		  menu.close()
  
		  DeleteShopInsideVehicles()
  
  
		  local playerPed = PlayerPedId()
  
		  CurrentAction     = 'shop_menu'
		  CurrentActionMsg  = _U('shop_menu')
		  CurrentActionData = {}
  
		  FreezeEntityPosition(playerPed, false)
		  SetEntityVisible(playerPed, true)
		  SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)
  
		  IsInShopMenu = false
  
	  end, function (data, menu)
		  -- Change
		  local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		  local playerPed   = PlayerPedId()
  
		  DeleteShopInsideVehicles()
		  WaitForVehicleToLoad(vehicleData.model)
  
		  ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
			  table.insert(LastVehicles, vehicle)
			  TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			  FreezeEntityPosition(vehicle, true)
			  SetModelAsNoLongerNeeded(vehicleData.model)
		  end)
	  end)
	  
	  DeleteShopInsideVehicles()
	  WaitForVehicleToLoad(firstVehicleData.model)
  
	  ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
		  table.insert(LastVehicles, vehicle)
		  TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		  FreezeEntityPosition(vehicle, true)
		  SetModelAsNoLongerNeeded(firstVehicleData.model)
	  end)
  
  end
  
  function OpenShopMenu()
  
	  local elementsMainCategories = {}
	  
	  for i=1, #MainCategories, 1 do
		  local category = MainCategories[i]
  
		  table.insert(elementsMainCategories, {
			  name    = category.name,
			  label   = category.label,
			  value   = category.id
		  })
	  end
	  
	  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_categories_premium',
	  {
		  title    = _U('car_dealer'),
		  align    = 'top-left',
		  elements = elementsMainCategories
	  }, function (data3, menu3)
		  
		  OpenSubCategoryMenu(data3.current.value)
		  
	  end, function (data3, menu3)
		  -- Cancel
		  menu3.close()
  
		  DeleteShopInsideVehicles()
  
		  local playerPed = PlayerPedId()
  
		  CurrentAction     = 'shop_menu'
		  CurrentActionMsg  = _U('shop_menu')
		  CurrentActionData = {}
  
		  FreezeEntityPosition(playerPed, false)
		  SetEntityVisible(playerPed, true)
		  SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)
  
		  IsInShopMenu = false
	  end)
  
  end
  
  function WaitForVehicleToLoad(modelHash)
	  modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))
  
	  if not HasModelLoaded(modelHash) then
		  RequestModel(modelHash)
  
		  while not HasModelLoaded(modelHash) do
			  Citizen.Wait(1)
  
			  DisableControlAction(0, Keys['TOP'], true)
			  DisableControlAction(0, Keys['DOWN'], true)
			  DisableControlAction(0, Keys['LEFT'], true)
			  DisableControlAction(0, Keys['RIGHT'], true)
			  DisableControlAction(0, 176, true) -- ENTER key
			  DisableControlAction(0, Keys['BACKSPACE'], true)
  
			  drawLoadingText(_U('shop_awaiting_model'), 255, 255, 255, 255)
		  end
	  end
  end
  
  function OpenPopVehicleMenu()
	  ESX.TriggerServerCallback('esx_premium_carshop:getCommercialVehicles', function (vehicles)
		  local elements = {}
  
		  for i=1, #vehicles, 1 do
			  table.insert(elements, {
				  label = ('%s [MSRP <span style="color:green;">%s</span>]'):format(vehicles[i].name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicles[i].price))),
				  value = vehicles[i].name
			  })
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'commercial_vehicles',
		  {
			  title    = _U('vehicle_dealer'),
			  align    = 'top-left',
			  elements = elements
		  }, function (data, menu)
			  local model = data.current.value
  
			  DeleteShopInsideVehicles()
  
			  ESX.Game.SpawnVehicle(model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
				  table.insert(LastVehicles, vehicle)
  
				  for i=1, #Vehicles, 1 do
					  if model == Vehicles[i].model then
						  CurrentVehicleData = Vehicles[i]
						  break
					  end
				  end
			  end)
		  end, function (data, menu)
			  menu.close()
		  end)
	  end)
  end
  
  function OpenRentedVehiclesMenu()
	  ESX.TriggerServerCallback('esx_premium_carshop:getRentedVehicles', function (vehicles)
		  local elements = {}
  
		  for i=1, #vehicles, 1 do
			  table.insert(elements, {
				  label = ('%s: %s - <span style="color:orange;">%s</span>'):format(vehicles[i].playerName, vehicles[i].name, vehicles[i].plate),
				  value = vehicles[i].name
			  })
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rented_vehicles', {
			  title    = _U('rent_vehicle'),
			  align    = 'top-left',
			  elements = elements
		  }, nil, function (data, menu)
			  menu.close()
		  end)
	  end)
  end
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function (job)
	  ESX.PlayerData.job = job
  
	  if Config.EnablePlayerManagement then
		  if ESX.PlayerData.job.name == 'cardealer' then
			  Config.Zones.ShopEntering.Type = 1
  
			  if ESX.PlayerData.job.grade_name == 'boss' then
				  Config.Zones.BossActions.Type = 1
			  end
  
		  else
			  Config.Zones.ShopEntering.Type = -1
			  Config.Zones.BossActions.Type  = -1
		  end
	  end
  end)
  
  AddEventHandler('esx_premium_carshop:hasEnteredMarker', function (zone)
	  if zone == 'ShopEntering' then
		  if Config.EnablePlayerManagement then
			  if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cardealer' then
				  CurrentAction     = 'reseller_menu'
				  CurrentActionMsg  = _U('shop_menu')
				  CurrentActionData = {}
			  end
		  else
			  CurrentAction     = 'shop_menu'
			  CurrentActionMsg  = _U('shop_menu')
			  CurrentActionData = {}
		  end
  
	  elseif zone == 'GiveBackVehicle' and Config.EnablePlayerManagement then
  
		  local playerPed = PlayerPedId()
  
		  if IsPedInAnyVehicle(playerPed, false) then
			  local vehicle = GetVehiclePedIsIn(playerPed, false)
  
			  CurrentAction     = 'give_back_vehicle'
			  CurrentActionMsg  = _U('vehicle_menu')
  
			  CurrentActionData = {
				  vehicle = vehicle
			  }
		  end
  
	  elseif zone == 'ResellVehicle' then
  
		  local playerPed = PlayerPedId()
  
		  if IsPedSittingInAnyVehicle(playerPed) then
  
			  local vehicle     = GetVehiclePedIsIn(playerPed, false)
			  local vehicleData, model, resellPrice, plate
  
			  if GetPedInVehicleSeat(vehicle, -1) == playerPed then
				  for i=1, #Vehicles, 1 do
					  if GetHashKey(Vehicles[i].model) == GetEntityModel(vehicle) then
						  vehicleData = Vehicles[i]
						  break
					  end
				  end
	  
				  resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.ResellPercentage)
				  model = GetEntityModel(vehicle)
				  plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
	  
				  CurrentAction     = 'resell_vehicle'
				  CurrentActionMsg  = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))
	  
				  CurrentActionData = {
					  vehicle = vehicle,
					  label = vehicleData.name,
					  price = resellPrice,
					  model = model,
					  plate = plate
				  }
			  end
  
		  end
  
	  elseif zone == 'BossActions' and Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cardealer' and ESX.PlayerData.job.grade_name == 'boss' then
  
		  CurrentAction     = 'boss_actions_menu'
		  CurrentActionMsg  = _U('shop_menu')
		  CurrentActionData = {}
  
	  end
  end)
  
  AddEventHandler('esx_premium_carshop:hasExitedMarker', function (zone)
	  CurrentAction = nil
  end)
  
  AddEventHandler('onResourceStop', function(resource)
	  if resource == GetCurrentResourceName() then
		  if IsInShopMenu then
			  ESX.UI.Menu.CloseAll()
  
			  DeleteShopInsideVehicles()
  
			  local playerPed = PlayerPedId()
  
			  FreezeEntityPosition(playerPed, false)
			  SetEntityVisible(playerPed, true)
			  SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)
		  end
	  end
  end)
  
  -- Create Blips
  Citizen.CreateThread(function ()
	  local blip = AddBlipForCoord(Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)
  
	  SetBlipSprite (blip, 326)
	  SetBlipDisplay(blip, 4)
	  SetBlipScale  (blip, 1.0)
	  SetBlipColour(blip, 1)
	  SetBlipAsShortRange(blip, true)
  
	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString(_U('car_dealer'))
	  EndTextCommandSetBlipName(blip)
  end)
  
  -- Display markers
  Citizen.CreateThread(function ()
	  while true do
		  Citizen.Wait(0)
  
		  local coords = GetEntityCoords(PlayerPedId())
  
		  for k,v in pairs(Config.Zones) do
			  if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				  DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			  end
		  end
	  end
  end)
  
  -- Enter / Exit marker events
  Citizen.CreateThread(function ()
	  while true do
		  Citizen.Wait(0)
  
		  local coords      = GetEntityCoords(PlayerPedId())
		  local isInMarker  = false
		  local currentZone = nil
  
		  for k,v in pairs(Config.Zones) do
			  if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				  isInMarker  = true
				  currentZone = k
			  end
		  end
  
		  if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			  HasAlreadyEnteredMarker = true
			  LastZone                = currentZone
			  TriggerEvent('esx_premium_carshop:hasEnteredMarker', currentZone)
		  end
  
		  if not isInMarker and HasAlreadyEnteredMarker then
			  HasAlreadyEnteredMarker = false
			  TriggerEvent('esx_premium_carshop:hasExitedMarker', LastZone)
		  end

	  end
  end)
  
  -- Key controls
  Citizen.CreateThread(function()
	  while true do
		  Citizen.Wait(10)
  
		  if CurrentAction == nil then
			  Citizen.Wait(500)
		  else
  
			  ESX.ShowHelpNotification(CurrentActionMsg)
  
			  if IsControlJustReleased(0, Keys['E']) then
				  if CurrentAction == 'shop_menu' then
					  if Config.LicenseEnable then
						  ESX.TriggerServerCallback('esx_license:checkLicense', function(hasDriversLicense)
							  if hasDriversLicense then
								  if(time > timer) then
									  OpenShopMenu()
								  else
									  ESX.ShowNotification("Ya has comprado un vehiculo recientemente. Espera "..(timer / 1000).." segundos antes de comprar otro")
								  end
							  else
								  ESX.ShowNotification(_U('license_missing'))
							  end
						  end, GetPlayerServerId(PlayerId()), 'drive')
  
					  else
						  if(time > timer) then
							  OpenShopMenu()
						  else
							  ESX.ShowNotification("Ya has comprado un vehiculo recientemente. Espera "..(timer / 1000).." segundos antes de comprar otro")
						  end
					  end
				  elseif CurrentAction == 'reseller_menu' then
					  OpenResellerMenu()
				  elseif CurrentAction == 'give_back_vehicle' then
  
					  ESX.TriggerServerCallback('esx_premium_carshop:giveBackVehicle', function(isRentedVehicle)
						  if isRentedVehicle then
							  ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
							  ESX.ShowNotification(_U('delivered'))
						  else
							  ESX.ShowNotification(_U('not_rental'))
						  end
					  end, ESX.Math.Trim(GetVehicleNumberPlateText(CurrentActionData.vehicle)))
  
				  elseif CurrentAction == 'resell_vehicle' then
  
					  ESX.TriggerServerCallback('esx_premium_carshop:resellVehicle', function(vehicleSold)
  
						  if vehicleSold then
							  ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
							  ESX.ShowNotification(_U('vehicle_sold_for', CurrentActionData.label, ESX.Math.GroupDigits(CurrentActionData.price)))
						  else
							  ESX.ShowNotification(_U('not_yours'))
						  end
  
					  end, CurrentActionData.plate, CurrentActionData.model)
  
				  elseif CurrentAction == 'boss_actions_menu' then
					  OpenBossActionsMenu()
				  end
  
				  CurrentAction = nil
			  end
		  end
	  end
  end)
  
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