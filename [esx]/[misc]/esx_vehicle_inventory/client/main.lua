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


ESX                           = nil
local GUI      = {}
local PlayerData                = {}
local lastVehicle = nil
local lastOpen = false
GUI.Time                      = 0
local vehiclePlate = {}
local arrayWeight = Config.localWeight
local vehFront = false
local vehOpen = false

function getItemyWeight(item)
	local weight = 0
	local itemWeight = 0

	if item ~= nil then
		itemWeight = Config.DefaultWeight
		if arrayWeight[item] ~= nil then
			itemWeight = arrayWeight[item]
		end
	end
	return itemWeight
end


Citizen.CreateThread(function()
while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
PlayerData = xPlayer
TriggerServerEvent("esx_truck_inventory:getOwnedVehicule")
end)

RegisterNetEvent('esx_truck_inventory:setOwnedVehicule')
AddEventHandler('esx_truck_inventory:setOwnedVehicule', function(vehicle)
vehiclePlate = vehicle
end)

function VehicleInFront()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, result = GetRaycastResult(rayHandle)
	return result
end

-- Key controls
Citizen.CreateThread(function()
while true do

	Wait(0)
	-- 246
	if IsControlPressed(0, Keys['E']) and IsControlPressed(0, Keys['LEFTSHIFT'])  and (GetGameTimer() - GUI.Time) > 150 then
		local vehFront = VehicleInFront()
		local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
		local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)

		if vehFront > 0 and closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) then
			lastVehicle = vehFront
			local model = GetDisplayNameFromVehicleModel(GetEntityModel(closecar))
			local locked = GetVehicleDoorLockStatus(closecar)
			local class = GetVehicleClass(vehFront)

			ESX.UI.Menu.CloseAll()
			if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'inventory') then
				SetVehicleDoorShut(vehFront, 5, false)
			else

				if locked ~= 0 then

					if locked == 1 or class == 15 or class == 16 or class == 14 then

						FreezeEntityPosition(GetPlayerPed(-1),true) -- Congelamos al jugador
						TriggerEvent('dmpemotes:emote', "mechanic4") -- Animación abrir vehiculo
						Citizen.Wait(1500)
						TriggerEvent('dmpemotes:cancel')
						FreezeEntityPosition(GetPlayerPed(-1),false) -- Congelamos al jugador

						SetVehicleDoorOpen(vehFront, 5, false, false) -- Abrir maletero
						ESX.UI.Menu.CloseAll()
						TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(vehFront)) -- Abnrir inventario / vehiculo


						vehOpen = true
					else

						-- Arnedo5 | Forzamos el vehiculo [Ganzula]
						ESX.TriggerServerCallback('esx_truck_inventory:lockpick', function(count)
						if count > 0 then
							FreezeEntityPosition(GetPlayerPed(-1),true) -- Congelamos al jugador

							TriggerEvent('dmpemotes:emote', "mechanic3")
							Citizen.Wait(2850)

							SetNuiFocus(true,true) -- Abrimos minijuego
							SendNUIMessage({
								action = "opengame",
							})

						else
							ESX.ShowNotification('No tienes ~r~Ganzúa~w~ para forzar la cerradura')
						end
						end)


					end
				end
			end
		else
			ESX.ShowNotification('Ningún ~r~vehículo~w~ cercano')
		end
		lastOpen = true
		GUI.Time  = GetGameTimer()
	elseif lastOpen and IsControlPressed(0, Keys["BACKSPACE"]) and (GetGameTimer() - GUI.Time) > 150 then
		lastOpen = false

		ESX.UI.Menu.CloseAll()

		if lastVehicle ~= nil then
			if lastVehicle > 0 then
				SetVehicleDoorShut(lastVehicle, 5, false)
				lastVehicle = 0
			end
		end

		GUI.Time  = GetGameTimer()
	end
end
end)

-- Arnedo5 | Al alejarse del vehiculo, cerramos el maletero y el menú
Citizen.CreateThread(function()
while true do
	Citizen.Wait(0)

	local vehFront = VehicleInFront()
	local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true)) -- Coordenadas jugador
	local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)

	-- Si hay vehiculo delante
	if vehFront > 0 and closecar ~= nil and GetPedInVehicleSeat(closecar, -1) ~= GetPlayerPed(-1) then

		local coords = GetWorldPositionOfEntityBone(vehFront, GetEntityBoneIndexByName(vehFront, 'boot')) -- Maletero vehiculo
		local distance = GetDistanceBetweenCoords(coords, vector3(x, y, z), true) -- Distancia entre jugador - vehiculo


		if (distance < 3) then -- Arnedo5 | Distancia entre el juador y el maletero

			local locked = GetVehicleDoorLockStatus(closecar)
			local class = GetVehicleClass(vehFront)

			if locked ~= 0 then
				if locked == 1 or class == 15 or class == 16 or class == 14 then
					DrawText3Ds(coords, "[~g~Shift + E~w~] para abrir", 0.35)

				else
					DrawText3Ds(coords, "[~r~Shift + E~w~] para forzar", 0.35)
				end
			end

		end
	end


	if lastVehicle ~= nil then -- En caso de wque el jugador se aleje demasiado
		if lastVehicle > 0 then

			local coords = GetWorldPositionOfEntityBone(lastVehicle, GetEntityBoneIndexByName(lastVehicle, 'boot')) -- Maletero vehiculo
			local distance = GetDistanceBetweenCoords(coords, vector3(x, y, z), true) -- Distancia entre jugador - vehiculo

			if (distance > 3) then

				SetVehicleDoorShut(lastVehicle, 5, false) -- Cerramos maletero
				--ESX.UI.Menu.CloseAll() -- Cerramos todos los menus
				lastOpen = false
				lastVehicle = 0
			end

		end
	end

end
end)


-- Abrimos inventario del vehiculo
RegisterNetEvent('esx_truck_inventory:getInventoryLoaded')
AddEventHandler('esx_truck_inventory:getInventoryLoaded', function(inventory, weight)

	local elements = {}
	local vehFrontBack = VehicleInFront()
	TriggerServerEvent("esx_truck_inventory:getOwnedVehicule")

	table.insert(elements, {
		label = 'Depositar',
		count = 0,
		value = 'deposit'
	})

	if inventory ~= nil and #inventory > 0 then
		for i = 1, #inventory, 1 do
			if inventory[i].count > 0 then

				if inventory[i].type == 'item_weapon' then
					table.insert(elements, {
						label = inventory[i].label .. ' x' .. inventory[i].count .. ' [' .. inventory[i].ammo .. ']',
						count = inventory[i].count,
						value = inventory[i].name,
						type = inventory[i].type,
						ammo = inventory[i].ammo
					})

				else
					table.insert(elements, {
						label = inventory[i].label .. ' x' .. inventory[i].count,
						count = inventory[i].count,
						value = inventory[i].name,
						type = inventory[i].type,
						ammo = 0
					})
				end

			end

		end
	end

	-- Peso actual + Total
	local totalweight = tonumber(weight)
	vehFront = VehicleInFront()
	local typeVeh = GetVehicleClass(vehFront)
	local Kgweight = totalweight / 1000
	local MaxVh = (tonumber(Config.VehicleLimit[typeVeh]) / 1000)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inventory_deposit', {
		title = 'Maletero ' .. "[" .. Kgweight .. " / " .. math.floor(MaxVh) .. "]",
		align = 'bottom-right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'deposit' then -- DEPOSIT

			local elem = {}
			PlayerData = ESX.GetPlayerData()

			-- Arnedo5 | Objetos
			for i = 1, #PlayerData.inventory, 1 do
				if PlayerData.inventory[i].count > 0 then
					table.insert(elem, {
						label = PlayerData.inventory[i].label .. ' x' .. PlayerData.inventory[i].count,
						count = PlayerData.inventory[i].count,
						type = 'item_object',
						value = PlayerData.inventory[i].name,
						name = PlayerData.inventory[i].label,
						limit = PlayerData.inventory[i].limit,
						ammo = 0
					})
				end
			end
			-- END Objetos

			-- Arnedo5 | Armas
			local weaponList = ESX.GetWeaponList()
			local playerPed = GetPlayerPed(-1)

			for i = 1, #weaponList, 1 do

				local weaponHash = GetHashKey(weaponList[i].name)

				if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
					local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
					-- table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
					table.insert(elem, {
						label = weaponList[i].label .. ' [' .. ammo .. ']',
						count = 1,
						type = 'item_weapon',
						value = weaponList[i].name,
						name = weaponList[i].label,
						limit = weaponList[i].limit,
						ammo = ammo
					})

				end

			end
			-- END armas

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inventory_player', {
				title = 'Inventario.',
				align = 'bottom-right',
				elements = elem
			}, function(data3, menu3)

				-- Arnedo5 | En caso de armas
				if (data3.current.type == 'item_weapon') then

					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'inventory_item_count_give', {
						title = 'Cantidad'
					}, function(data4, menu4)
						menu4.close()
						AddObject(data3.current.type, 1, data3.current.value, data3.current.name, data3.current.ammo, data3.current.count, weight)
					end, function(data4, menu4)
						SetVehicleDoorShut(vehFrontBack, 5, false)
						ESX.UI.Menu.CloseAll()
					end)

					--AddObject(data3.current.type, 1, data3.current.value, data3.current.name, data3.current.ammo, data3.current.count, weight)
				else

					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'inventory_item_count_give', {
						title = 'Cantidad'
					}, function(data4, menu4)

						menu4.close()

						AddObject(data3.current.type, data4.value, data3.current.value, data3.current.name,
							data3.current.ammo, data3.current.count, weight)

					end, function(data4, menu4)
						SetVehicleDoorShut(vehFrontBack, 5, false)
						ESX.UI.Menu.CloseAll()
					end)

				end

			end)

		else -- REMOVE ITEM

			if data.current.type == 'item_weapon' then -- Retirar arma

				RemoveObject(1, data.current.value, data.current.count, data.current.ammo, data.current.type, weight)

			else -- Retirar arma

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'inventory_item_count_give', {
					title = 'Cantidad'
				}, function(data2, menu2)

					menu2.close()

					RemoveObject(data2.value, data.current.value, data.current.count, data.current.ammo,
						data.current.type, weight)

				end, function(data2, menu2)
					SetVehicleDoorShut(vehFrontBack, 5, false)
					ESX.UI.Menu.CloseAll()
				end)

			end

		end
	end)
end)


-- Arnedo5 | Float text
DrawText3Ds = function(coords, text, scale)
	local x,y,z = coords.x, coords.y, coords.z - 0.65
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)
	local factor = (string.len(text)) / 280

	DrawRect(_x, _y + 0.0115, 0.032 + factor, 0.033, 41, 11, 41, 100)
end

-- Arnedo5 | Minijuego de forzar cerradura

-- NUI that get triggered on success
RegisterNUICallback('RobSuccess', function()
	SetNuiFocus(false, false)
	ClearPedTasks(GetPlayerPed(-1))
	FreezeEntityPosition(GetPlayerPed(-1),false)

	SetVehicleDoorOpen(lastVehicle, 5, false, false) -- Abrir maletero
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(lastVehicle)) -- Abnrir inventario / vehiculo

	vehOpen = true
end)

		-- NUI that get triggered on fail
		RegisterNUICallback('RobFailed', function()
		SetNuiFocus(false, false)
		ClearPedTasks(GetPlayerPed(-1))
		FreezeEntityPosition(GetPlayerPed(-1),false)

		ESX.ShowNotification('~r~Se ha roto la Ganzúa~w~')

		-- Activamos la alarma del coche 1 min
		SetVehicleAlarm(lastVehicle, true)
		SetVehicleAlarmTimeLeft(lastVehicle, 60 * 1000)


		-- Mandamos entorno a la policía
		local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
		local streetName, crossing = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
		streetName = GetStreetNameFromHashKey(streetName)
		local coords      = GetEntityCoords(GetPlayerPed(-1))

		TriggerServerEvent('comprobarEntorno', "Se ha visto alguien intentando forzar un maletero en: ".. streetName, coords.x, coords.y, coords.z, "NPC RANDOM")

		end)


-- Add object to vehicle inventory
function AddObject(data3Type, data4Value, data3Value, data3Name, data3Ammo, data3Count, weight) 

	local quantity = tonumber(data4Value)
	local Itemweight =tonumber(getItemyWeight(data3Value)) * quantity
	local totalweight = tonumber(weight) + Itemweight
	vehFront = VehicleInFront()

	local typeVeh = GetVehicleClass(vehFront)

	if totalweight > Config.VehicleLimit[typeVeh] then
		max = true
	else
		max = false
	end

	ownedV = 0
	
	while vehiclePlate == '' do
		Wait(1000)
	end

	for i=1, #vehiclePlate do
		if vehiclePlate[i].plate == GetVehicleNumberPlateText(vehFront) then
			ownedV = 1
			break
		else
			ownedV = 0
		end
	end

	-- Quantity
	if quantity > 0 and quantity <= tonumber(data3Count) and vehFront > 0  then
		local MaxVh =(tonumber(Config.VehicleLimit[typeVeh])/1000)
		local Kgweight =  totalweight/1000
		if not max then
			local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
			local closecar = GetClosestVehicle(x, y, z, 4.0, 0, 71)

			TriggerServerEvent('esx_truck_inventory:addInventoryItem', data3Type, GetVehicleNumberPlateText(vehFront), tonumber(data4Value), data3Ammo, data3Value, data3Name,  ownedV)

			--TriggerServerEvent('esx_truck_inventory:addInventoryItem', GetVehicleClass(closecar), GetDisplayNameFromVehicleModel(GetEntityModel(closecar)), GetVehicleNumberPlateText(vehFront), data3.current.value, quantity, data3.current.name,ownedV)
			ESX.ShowNotification('Peso en el vehiculo: ~g~'.. Kgweight .. ' Kg / '..MaxVh..' Kg')

			--ESX.UI.Menu.CloseAll()

			Citizen.Wait(1000)
			TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(vehFront)) -- Abnrir inventario / vehiculo
		else
			ESX.ShowNotification('Has alcanzado el límite de ~r~ '..MaxVh..' Kg')

			ESX.UI.Menu.CloseAll()
			TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(vehFront)) -- Abnrir inventario / vehiculo
		end
	else
		ESX.ShowNotification('~r~ Cantidad inválida')
	end
	-- END Quantity

	ESX.UI.Menu.CloseAll()

end

-- Remove object from vehicle inventory
function RemoveObject(data2Value, dataValue, dataCount, ammo, type, weight)

	local quantity = tonumber(data2Value)
	PlayerData = ESX.GetPlayerData()
	vehFront = VehicleInFront()

	local Itemweight =tonumber(getItemyWeight(dataValue)) * quantity
	local poid = weight - Itemweight

	for i=1, #PlayerData.inventory, 1 do

		if PlayerData.inventory[i].name == dataValue then
			if tonumber(PlayerData.inventory[i].limit) < tonumber(PlayerData.inventory[i].count) + quantity and PlayerData.inventory[i].limit ~= -1 then
				max = true
			else
				max = false
			end
		end
	end

	if quantity > 0 and quantity <= tonumber(dataCount) and vehFront > 0 then
		if not max then
			--  VehicleMaxSpeed(vehFront,poid,Config.VehicleLimit[GetVehicleClass(vehFront)])
			TriggerServerEvent('esx_truck_inventory:removeInventoryItem', GetVehicleNumberPlateText(vehFront), dataValue, quantity, ammo, type)

		else
			ESX.ShowNotification('~r~ Has puesto demasiado')
		end
	else
		ESX.ShowNotification('~r~Cantidad invalida')
	end

	ESX.UI.Menu.CloseAll()

	local vehFront = VehicleInFront()
	if vehFront > 0 then
		ESX.SetTimeout(500, function()
		TriggerServerEvent("esx_truck_inventory:getInventory", GetVehicleNumberPlateText(vehFront))
		end)
	else
		SetVehicleDoorShut(vehFrontBack, 5, false)
	end

end

RegisterNetEvent('esx_truck_inventory:showNote')
AddEventHandler('esx_truck_inventory:showNote', function()
	ESX.ShowNotification("El objeto seleccionado ~o~ya no se encuentra disponible")
end)

