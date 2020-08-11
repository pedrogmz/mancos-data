ESX = nil
local myJob = nil
local selling = false
local has = false
local copsc = false
local HasAlreadyEnteredMarker = false
local isInDrugZone, hasExitedDrugZone = false
local currentZone = nil
local currentZoneName = nil
local inDeal = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
		end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
	TriggerServerEvent('fetchjob')
end)

-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('getjob')
AddEventHandler('getjob', function(jobName)
	myJob = jobName
end)

-- Arnedo5 - Configuración por zonas
Citizen.CreateThread(function()

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		isInDrugZone, hasExitedDrugZone = false;

		for k, v in pairs(Config.Zones) do
			local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)

			if distance < v.Dist then
				-- isInMarker, currentZone = true, k
				-- print (k)
				currentZone, currentZoneName = v, k
				isInDrugZone = true
			end
		end

		-- Enter zone

		if isInDrugZone and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true

			ESX.TriggerServerCallback('esx_npcdrugsales:checkDrugs', function(hasDrugs)

				if hasDrugs == true then
					has = true
					--        ESX.ShowNotification(_U('enter_zone')) -- Raspu
				else
					has = false
				end

			end, currentZoneName)

		end

		-- Exit zoone
		if not hasExitedDrugZone and not isInDrugZone and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false

			ESX.TriggerServerCallback('esx_npcdrugsales:checkDrugs', function(hasDrugs)

				if hasDrugs == true then
					has = true
					--         ESX.ShowNotification(_U('exit_zone')) -- Raspu
				else
					has = false
				end

			end, currentZoneName)

		end

	end

end)

function CreateBlipCircle(coords, text, radius, color, sprite)
	local blip = AddBlipForRadius(coords, radius)

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 5)
	SetBlipAlpha(blip, 128)

	-- create a blip in the middle
	blip = AddBlipForCoord(coords)

	SetBlipHighDetail(blip, true)
	SetBlipSprite(blip, sprite)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)

end

-- Mostrar Zonas de Venta [For Deevs]
Citizen.CreateThread(function()

	if Config.EnableBlipCircle == true then

		for k, zone in pairs(Config.Zones) do
			CreateBlipCircle(zone.Coords, k, zone.Dist, 25, 496)
		end

	end
end)

-- END Arnedo5
currentped = nil
local animacion = false
Citizen.CreateThread(function()

	while true do
		Wait(0)
		local player = GetPlayerPed(-1)
		local playerloc = GetEntityCoords(player, 0)
		local handle, ped = FindFirstPed()
		repeat
			success, ped = FindNextPed(handle)
			local pos = GetEntityCoords(ped)
			local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'],
								 playerloc['z'], true)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
				if DoesEntityExist(ped) then
					if IsPedDeadOrDying(ped) == false then
						if IsPedInAnyVehicle(ped) == false then
							local pedType = GetPedType(ped)
							if pedType ~= 28 and IsPedAPlayer(ped) == false then
								currentped = pos
								if distance <= 3 and ped ~= GetPlayerPed(-1) and ped ~= oldped then

									-- En caso de tener ...
									if has == true and HasAlreadyEnteredMarker then

										drawTxt(0.955, 1.40, 1.0, 1.0, 0.5, _U('sale_drugs'), 255, 255, 255, 255)
										if IsControlJustPressed(1, 86) then
											animacion = true
											oldped = ped
											SetEntityAsMissionEntity(ped)
											TaskStandStill(ped, 9.0)
											pos1 = GetEntityCoords(ped)
											TriggerServerEvent('drugs:trigger')
											exports['progressBars']:startUI(5000, "Acordando precio") -- Raspu añadida barra de progreso durante el intento de venta

											TriggerEvent('dmpemotes:emote', "crossarms2")

											Citizen.Wait(5000) -- Tiempo de espera de venta 5 segundos

											TriggerEvent('dmpemotes:cancel')
											TriggerEvent('sell')
											SetPedAsNoLongerNeeded(oldped)
											animacion = false
										end
									end

								end
							end
						end
					end
				end
			end
		until not success
		EndFindPed(handle)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()

		if animacion then
			DisableControlAction(0, 73, true)
		end
	end
end)

RegisterNetEvent('sell')
AddEventHandler('sell', function()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

	if distance <= 3 then
		TriggerServerEvent('drugs:sell', currentZoneName)
	elseif distance > 4 then
		TriggerServerEvent('sell_dis')
	end
end)

RegisterNetEvent('notifyc')
AddEventHandler('notifyc', function()

	local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
	local plyPos = GetEntityCoords(GetPlayerPed(-1), true)
	local streetName, crossing = Citizen.InvokeNative(0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
	local streetName, crossing = GetStreetNameAtCoord(x, y, z)
	streetName = GetStreetNameFromHashKey(streetName)
	crossing = GetStreetNameFromHashKey(crossing)

	local coords = GetEntityCoords(GetPlayerPed(-1))
	-- Send entorno
	TriggerServerEvent('comprobarEntorno', "Alguien me está ofreciendo drogas en" .. streetName, coords.x, coords.y,
		coords.z, "NPC RANDOM")

end)

-- Animación al vender
RegisterNetEvent('animation')
AddEventHandler('animation', function(type)

	TriggerEvent('dmpemotes:emote', type) -- Arnedo5 | Animación para la tablet
	Wait(1500)
	TriggerEvent('dmpemotes:cancel')

end)

function drawTxt(x, y, width, height, scale, text, r, g, b, a, outline)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	if (outline) then
		SetTextOutline()
	end
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width / 2, y - height / 2 + 0.005)
end

-- Arnedo5 | Mostrar nueva notificación encima del mapa
RegisterNetEvent('npcgrugsales:shownotification')
AddEventHandler('npcgrugsales:shownotification', function(msg)
	ESX.ShowNotification(msg)
end)
