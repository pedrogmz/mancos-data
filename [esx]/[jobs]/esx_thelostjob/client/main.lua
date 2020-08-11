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

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Blips                   = {}

local isBarman                = false
local isInMarker              = false
local isInPublicMarker        = false
local hintIsShowed            = false
local hintToDisplay           = "no hint to display"

ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function IsJobTrue()
		if PlayerData ~= nil then
				local IsJobTrue = false
				if PlayerData.job ~= nil and PlayerData.job.name == 'thelost' then
						IsJobTrue = true
				end
				return IsJobTrue
		end
end


function IsGradeBoss()

		if PlayerData ~= nil then
				local IsGradeBoss = false
				if PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'viceboss' then
						IsGradeBoss = true
				end
				return IsGradeBoss
		end
end

function SetVehicleMaxMods(vehicle)

	local props = {
		modEngine       = 0,
		modBrakes       = 0,
		modTransmission = 0,
		modSuspension   = 0,
		modTurbo        = false,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function cleanPlayer(playerPed)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setClipset(playerPed, clip)
	RequestAnimSet(clip)
	while not HasAnimSetLoaded(clip) do
		Citizen.Wait(0)
	end
	SetPedMovementClipset(playerPed, clip, true)
end

function setUniform(job, playerPed)
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

function OpenCloakroomMenu()

	local playerPed = GetPlayerPed(-1)

	local elements = {
		{ label = _U('citizen_wear'),     value = 'citizen_wear'},
		{ label = "Pandillero",    value = 'pandillero_outfit'},
		{ label = "Teniente",    value = 'teniente_outfit'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			cleanPlayer(playerPed)

			if data.current.value == 'citizen_wear' then

				setUniform("clear_wear", playerped)

				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)

			end

			if  data.current.value == 'pandillero_outfit' or 
					data.current.value == 'teniente_outfit' 
			then
				setUniform(data.current.value, playerPed) -- Arnedo5 | Trajes
			end

			CurrentAction     = 'menu_cloakroom'
			CurrentActionMsg  = _U('open_cloackroom')
			CurrentActionData = {}

		end,
		function(data, menu)
			menu.close()
			CurrentAction     = 'menu_cloakroom'
			CurrentActionMsg  = _U('open_cloackroom')
			CurrentActionData = {}
		end
	)
end

function OpenVaultMenu()

	if Config.EnableVaultManagement then

		local elements = {
			{label = _U('get_weapon'), value = 'get_weapon'},
			{label = _U('put_weapon'), value = 'put_weapon'},
			{label = _U('get_object'), value = 'get_stock'},
			{label = _U('put_object'), value = 'put_stock'}
		}


		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vault',
			{
				title    = _U('vault'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)

				if data.current.value == 'get_weapon' then
					OpenGetWeaponMenu()
				end

				if data.current.value == 'put_weapon' then
					OpenPutWeaponMenu()
				end

				if data.current.value == 'put_stock' then
					 OpenPutStocksMenu()
				end

				if data.current.value == 'get_stock' then
					 OpenGetStocksMenu()
				end

			end,
			
			function(data, menu)

				menu.close()

				CurrentAction     = 'menu_vault'
				CurrentActionMsg  = _U('open_vault')
				CurrentActionData = {}
			end
		)

	end

end

function OpenFridgeMenu()

		local elements = {
			{label = _U('get_object'), value = 'get_stock'},
			{label = _U('put_object'), value = 'put_stock'}
		}
		

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'fridge',
			{
				title    = _U('fridge'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)

				if data.current.value == 'put_stock' then
					 OpenPutFridgeStocksMenu()
				end

				if data.current.value == 'get_stock' then
					 OpenGetFridgeStocksMenu()
				end

			end,
			
			function(data, menu)

				menu.close()

				CurrentAction     = 'menu_fridge'
				CurrentActionMsg  = _U('open_fridge')
				CurrentActionData = {}
			end
		)

end

function OpenSocietyActionsMenu()

	local elements = {}

	table.insert(elements, {label = _U('billing'),    value = 'billing'})
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), '247_actions',
		{
			title    = _U('247'),
			align    = 'top-left',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'billing' then
				OpenBillingMenu()
			end

		end,

		function(data, menu)

			menu.close()

		end
	)

end

function OpenBillingMenu()

	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'billing',
		{
			title = _U('billing_amount')
		},
		function(data, menu)
		
			local amount = tonumber(data.value)
			local player, distance = ESX.Game.GetClosestPlayer()

			if player ~= -1 and distance <= 3.0 then

				menu.close()
				if amount == nil then
						ESX.ShowNotification(_U('amount_invalid'))
				else
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_247', _U('billing'), amount)
				end

			else
				ESX.ShowNotification(_U('no_players_nearby'))
			end

		end,
		function(data, menu)
				menu.close()
		end
	)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_thelostjob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = 'The Lost Stock',
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

					-- todo: refresh on callback
					TriggerServerEvent('esx_thelostjob:getStockItem', itemName, count)
					Citizen.Wait(1000)
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
	ESX.TriggerServerCallback('esx_thelostjob:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard', -- not used
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

					-- todo: refresh on callback
					TriggerServerEvent('esx_thelostjob:putStockItems', itemName, count)
					Citizen.Wait(1000)
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

function OpenGetFridgeStocksMenu()

	ESX.TriggerServerCallback('esx_thelostjob:getFridgeStockItems', function(items)

		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'fridge_menu',
			{
				title    = _U('247_fridge_stock'),
				elements = elements
			},
			function(data, menu)

				local itemName = data.current.value

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'fridge_menu_get_item_count',
					{
						title = _U('quantity')
					},
					function(data2, menu2)

						local count = tonumber(data2.value)

						if count == nil then
							ESX.ShowNotification(_U('invalid_quantity'))
						else
							menu2.close()
							menu.close()
							OpenGetStocksMenu()

							TriggerServerEvent('esx_thelostjob:getFridgeStockItem', itemName, count)
						end

					end,
					function(data2, menu2)
						menu2.close()
					end
				)

			end,
			function(data, menu)
				menu.close()
			end
		)

	end)

end

function OpenPutFridgeStocksMenu()

ESX.TriggerServerCallback('esx_thelostjob:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do

			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
			end

		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'fridge_menu',
			{
				title    = _U('fridge_inventory'),
				elements = elements
			},
			function(data, menu)

				local itemName = data.current.value

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'fridge_menu_put_item_count',
					{
						title = _U('quantity')
					},
					function(data2, menu2)

						local count = tonumber(data2.value)

						if count == nil then
							ESX.ShowNotification(_U('invalid_quantity'))
						else
							menu2.close()
							menu.close()
							OpenPutFridgeStocksMenu()

							TriggerServerEvent('esx_thelostjob:putFridgeStockItems', itemName, count)
						end

					end,
					function(data2, menu2)
						menu2.close()
					end
				)

			end,
			function(data, menu)
				menu.close()
			end
		)

	end)

end

function OpenGetWeaponMenu()

	ESX.TriggerServerCallback('esx_thelostjob:getVaultWeapons', function(weapons)

		local elements = {}

		for i=1, #weapons, 1 do

				table.insert(elements, {
					-- label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), 
					label = ESX.GetWeaponLabel(weapons[i].name) .. ' [' .. weapons[i].ammo .. ']',
					type  = 'item_weapon',
					value = weapons[i].name,
					ammo  = weapons[i].ammo
				})
		 
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vault_get_weapon',
			{
				title    = _U('get_weapon_menu'),
				align    = 'top-left',
				elements = elements,
			},
			function(data, menu)

				menu.close()

				ESX.TriggerServerCallback('esx_thelostjob:removeVaultWeapon', function()
				 
					ESX.SetTimeout(300, function()
						OpenVaultMenu()
					end)
				end, data.current.type, data.current.value, data.current.ammo)

			end,
			function(data, menu)
				menu.close()
			end
		)

	end)

end

function OpenPutWeaponMenu()

	local elements   = {}
	local playerPed  = GetPlayerPed(-1)
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do

		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
			-- table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
			table.insert(elements, {
				label = weaponList[i].label .. ' [' .. ammo .. ']',
				type  = 'item_weapon',
				value = weaponList[i].name,
				ammo  =  ammo
			})

		end

	end

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vault_put_weapon',
		{
			title    = _U('put_weapon_menu'),
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			menu.close()

			-- Arnedo5 | Nuevo sistema para guardar armas [esx_casas]
			if data.current.type == 'item_weapon' then

				ESX.TriggerServerCallback('esx_thelostjob:addVaultWeapon', function()
					ESX.SetTimeout(300, function()
						OpenVaultMenu()
					end)
				end, data.current.type, data.current.value, data.current.ammo)
	
			end

		end,
		function(data, menu)
			menu.close()
		end
	)

end

function OpenShopMenu(zone)

		local elements = {}
		for i=1, #Config.Zones[zone].Items, 1 do

				local item = Config.Zones[zone].Items[i]

				table.insert(elements, {
						label     = item.label .. ' - <span style="color:red;">$' .. item.price .. ' </span>',
						realLabel = item.label,
						value     = item.name,
						price     = item.price
				})

		end

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), '247_shop',
				{
						title    = _U('shop'),
						elements = elements
				},
				function(data, menu)
						TriggerServerEvent('esx_thelostjob:buyItem', data.current.value, data.current.price, data.current.realLabel)
				end,
				function(data, menu)
						menu.close()
				end
		)

end

function animsAction(animObj)
		Citizen.CreateThread(function()
				if not playAnim then
						local playerPed = GetPlayerPed(-1);
						if DoesEntityExist(playerPed) then -- Check if ped exist
								dataAnim = animObj

								-- Play Animation
								RequestAnimDict(dataAnim.lib)
								while not HasAnimDictLoaded(dataAnim.lib) do
										Citizen.Wait(0)
								end
								if HasAnimDictLoaded(dataAnim.lib) then
										local flag = 0
										if dataAnim.loop ~= nil and dataAnim.loop then
												flag = 1
										elseif dataAnim.move ~= nil and dataAnim.move then
												flag = 49
										end

										TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
										playAnimation = true
								end

								-- Wait end animation
								while true do
										Citizen.Wait(0)
										if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
												playAnim = false
												TriggerEvent('ft_animation:ClFinish')
												break
										end
								end
						end -- end ped exist
				end
		end)
end


AddEventHandler('esx_thelostjob:hasEnteredMarker', function(zone)
 
		if zone == 'BossActions' and IsGradeBoss() then
			CurrentAction     = 'menu_boss_actions'
			CurrentActionMsg  = _U('open_bossmenu')
			CurrentActionData = {}
		end

		if zone == 'Cloakrooms' then
			CurrentAction     = 'menu_cloakroom'
			CurrentActionMsg  = _U('open_cloackroom')
			CurrentActionData = {}
		end

		if Config.EnableVaultManagement then
			if zone == 'Vaults' then
				CurrentAction     = 'menu_vault'
				CurrentActionMsg  = _U('open_vault')
				CurrentActionData = {}
			end
		end

		if zone == 'Vehicles' then
				CurrentAction     = 'menu_vehicle_spawner'
				CurrentActionMsg  = _U('vehicle_spawner')
				CurrentActionData = {}
		end

		if zone == 'VehicleDeleters' then

			local playerPed = GetPlayerPed(-1)

			if IsPedInAnyVehicle(playerPed,  false) then

				local vehicle = GetVehiclePedIsIn(playerPed,  false)

				CurrentAction     = 'delete_vehicle'
				CurrentActionMsg  = _U('store_vehicle')
				CurrentActionData = {vehicle = vehicle}
			end

		end
--[[ 
		if Config.EnableHelicopters then
				if zone == 'Helicopters' then

					local helicopters = Config.Zones.Helicopters

					if not IsAnyVehicleNearPoint(helicopters.SpawnPoint.x, helicopters.SpawnPoint.y, helicopters.SpawnPoint.z,  3.0) then

						ESX.Game.SpawnVehicle('swift2', {
							x = helicopters.SpawnPoint.x,
							y = helicopters.SpawnPoint.y,
							z = helicopters.SpawnPoint.z
						}, helicopters.Heading, function(vehicle)
							SetVehicleModKit(vehicle, 0)
							SetVehicleLivery(vehicle, 0)
						end)

					end

				end

				if zone == 'HelicopterDeleters' then

					local playerPed = GetPlayerPed(-1)

					if IsPedInAnyVehicle(playerPed,  false) then

						local vehicle = GetVehiclePedIsIn(playerPed,  false)

						CurrentAction     = 'delete_vehicle'
						CurrentActionMsg  = _U('store_vehicle')
						CurrentActionData = {vehicle = vehicle}
					end

				end
		end
]]--

end)

AddEventHandler('esx_thelostjob:hasExitedMarker', function(zone)

		CurrentAction = nil
		ESX.UI.Menu.CloseAll()

end)

-- Display markers
Citizen.CreateThread(function()
		while true do

				Wait(0)
				if IsJobTrue() then
						local coords = GetEntityCoords(GetPlayerPed(-1))

						for k,v in pairs(Config.Zones) do
								if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
										DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 23, false, false, false, false)
								end
						end
				end

		end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
		while true do

				Wait(0)
				if IsJobTrue() then

						local coords      = GetEntityCoords(GetPlayerPed(-1))
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
								TriggerEvent('esx_thelostjob:hasEnteredMarker', currentZone)
						end

						if not isInMarker and HasAlreadyEnteredMarker then
								HasAlreadyEnteredMarker = false
								TriggerEvent('esx_thelostjob:hasExitedMarker', LastZone)
						end

				end
			end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, Keys['E']) and IsJobTrue() then

				if CurrentAction == 'menu_cloakroom' then
					OpenArmarioMenu()
				end

				if CurrentAction == 'menu_vault' then
					OpenVaultMenu()
				end

				if CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu()
				end

				if CurrentAction == 'delete_vehicle' then

					if Config.EnableSocietyOwnedVehicles then

						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'thelost', vehicleProps)

					else

						if GetEntityModel(vehicle) == GetHashKey('rentalbus') then
							TriggerServerEvent('esx_service:disableService', 'thelost')
						end

					end

					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				if CurrentAction == 'menu_boss_actions' and IsGradeBoss() then

					local options = {
						wash = Config.EnableMoneyWash,
						black_money = Config.EnableBlackMoney
					}

					ESX.UI.Menu.CloseAll()

					TriggerEvent('esx_society:openBossMenu', 'thelost', function(data, menu)

						menu.close()
						CurrentAction = 'menu_boss_actions'
						CurrentActionMsg = _U('open_bossmenu')
						CurrentActionData = {}

					end, options)

				end

				CurrentAction = nil

			end

		end

		-- if IsControlJustReleased(0,  Keys['F6']) and IsJobTrue() and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), '247_actions') then
		-- OpenSocietyActionsMenu()
		-- end

	end
end)



-----------------------
----- TELEPORTERS -----

AddEventHandler('esx_thelostjob:teleportMarkers', function(position)
	SetEntityCoords(GetPlayerPed(-1), position.x, position.y, position.z)
end)

-- Show top left hint
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if hintIsShowed == true then
			SetTextComponentFormat("STRING")
			AddTextComponentString(hintToDisplay)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
		end
	end
end)

-- Arnedo5 | Display teleport markers warehouse
Citizen.CreateThread(function()
	while true do
		Wait(0)

		--if IsJobTrue() then

				local coords = GetEntityCoords(GetPlayerPed(-1))
				for k,v in pairs(Config.Warehouse) do
					if(v.Marker ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
						DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
					end
				end

		--end

	end
end)

-- Activate teleport marker

Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local position    = nil
		local zone        = nil
		local status        = nil

		--if IsJobTrue() then

				for k,v in pairs(Config.Warehouse) do
					if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
						isInPublicMarker = true
						position = v.Teleport
						zone = v
						status = v.Status
						break
					else
						isInPublicMarker  = false
					end
				end

				if IsControlJustReleased(0, Keys["E"]) and isInPublicMarker then

					if status == 'in'  then

						ESX.TriggerServerCallback('esx_thelostjob:keycount', function(count)
							if count > 0 then
								TriggerEvent('esx_thelostjob:teleportMarkers', position)
							else 
								ESX.ShowNotification("No tienes acceso. Necesitas una llave de acceso.")
							end
						end)

					else 
						TriggerEvent('esx_thelostjob:teleportMarkers', position)
					end
				
				end

				-- hide or show top left zone hints
				if isInPublicMarker then

					if status == 'in' then
						hintToDisplay = _U('warehouse_in')
					else 
						hintToDisplay = _U('warehouse_out')
					end
				 
					hintIsShowed = true
				else
					if not isInMarker then
						hintToDisplay = "No hay pistas para mostrar"
						hintIsShowed = false
					end
				end

		--end

	end
end)

------- New -------
function OpenArmarioMenu()
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
			title    = _U('cloakroom'),
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

local spawnedVehicles = {}

function OpenVehicleSpawnerMenu()

	local spawnPoint = Config.Zones.Vehicles.SpawnPoint
	ESX.UI.Menu.CloseAll()

	local elements = {}

	for i = 1, #Config.AuthorizedVehicles, 1 do
		local vehicle = Config.AuthorizedVehicles[i]
		table.insert(elements, {
			label = vehicle.label,
			value = vehicle.name
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
		title = _U('vehicle_menu'),
		align = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()
		local model = data.current.value
		DeleteSpawnedVehicles()

		ESX.Game.SpawnVehicle(model, {x = spawnPoint.x, y = spawnPoint.y, z = spawnPoint.z}, spawnPoint.h, function(vehicle)
			NetworkFadeInEntity(vehicle, true, true)
			SetModelAsNoLongerNeeded(model)
			TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
			SetEntityAsMissionEntity(vehicle, true, true)
			table.insert(spawnedVehicles, vehicle)
		end)

	end, function(data, menu)
		menu.close()
		CurrentAction = 'menu_vehicle_spawner'
		CurrentActionMsg = _U('vehicle_spawner')
		CurrentActionData = {}
	end)

end

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end