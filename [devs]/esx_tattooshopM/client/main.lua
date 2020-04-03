local currentTattoos, cam, CurrentActionData = {}, -1, {}
local HasAlreadyEnteredMarker, CurrentAction, CurrentActionMsg
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('skinchanger:modelLoaded', function()
	ESX.TriggerServerCallback('esx_tattooshop:requestPlayerTattoos', function(tattooList)
		if tattooList then
			for k,v in pairs(tattooList) do
				ApplyPedOverlay(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
			end

			currentTattoos = tattooList
		end
	end)
end)

function OpenShopMenu()
	local elements = {}

	for k,v in pairs(Config.TattooCategories) do
		table.insert(elements, {label= v.name, value = v.value})
	end

	if DoesCamExist(cam) then
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoo_shop', {
		title    = _U('tattoos'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		local currentLabel, currentValue = data.current.label, data.current.value

		if data.current.value then
			elements = {{label = _U('go_back_to_menu'), value = nil}}

			for k,v in pairs(Config.TattooList[data.current.value]) do
				table.insert(elements, {
					label = _U('tattoo_item', k, _U('money_amount', ESX.Math.GroupDigits(v.price))),
					value = k,
					price = v.price
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoo_shop_categories', {
				title    = _U('tattoos') .. ' | '..currentLabel,
				align    = 'bottom-right',
				elements = elements
			}, function(data2, menu2)
				local price = data2.current.price
				if data2.current.value ~= nil then

					ESX.TriggerServerCallback('esx_tattooshop:purchaseTattoo', function(success)
						if success then
							table.insert(currentTattoos, {collection = currentValue, texture = data2.current.value})
						end
					end, currentTattoos, price, {collection = currentValue, texture = data2.current.value})

				else
					OpenShopMenu()
					RenderScriptCams(false, false, 0, 1, 0)
					DestroyCam(cam, false)
					--cleanPlayer()
					TriggerEvent('esx_tattooshop:clearPlayer')
				end

			end, function(data2, menu2)
				menu2.close()
				RenderScriptCams(false, false, 0, 1, 0)
				DestroyCam(cam, false)
				setPedSkin()
			end, function(data2, menu2) -- when highlighted
				if data2.current.value ~= nil then
					drawTattoo(data2.current.value, currentValue)
				end
			end)
		end
	end, function(data, menu)
		menu.close()
		setPedSkin()
	end)
end

Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		local blip = AddBlipForCoord(v)
		SetBlipSprite(blip, 75)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(_U('tattoo_shop'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords, letSleep = GetEntityCoords(PlayerPedId()), true

		for k,v in pairs(Config.Zones) do
			if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v, true) < Config.DrawDistance) then
				DrawMarker(Config.Type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				letSleep = false
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker = false
		local currentZone, LastZone

		for k,v in pairs(Config.Zones) do
			if GetDistanceBetweenCoords(coords, v, true) < Config.Size.x then
				isInMarker  = true
				currentZone = 'TattooShop'
				LastZone    = 'TattooShop'
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_tattooshop:hasEnteredMarker', currentZone)
			TriggerServerEvent('esx_skin:save', skin)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
		end
	end
end)

AddEventHandler('esx_tattooshop:hasEnteredMarker', function(zone)

	if zone == 'TattooShop' then
		CurrentAction     = 'tattoo_shop'
		CurrentActionMsg  = _U('tattoo_shop_prompt')
		CurrentActionData = {zone = zone}
	end
	TriggerServerEvent('esx_skin:save', skin)
end)

AddEventHandler('esx_tattooshop:hasExitedMarker', function(zone)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'tattoo_shop' then
					OpenShopMenu()
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function setPedSkin()
	--ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
	--	TriggerEvent('skinchanger:loadSkin', skin)
	--end)

	Citizen.Wait(1000)

	for k,v in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
	end
end

function drawTattoo(current, collection)
	SetEntityHeading(PlayerPedId(), 297.7296)
	ClearPedDecorations(PlayerPedId())

	for k,v in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
	end

	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent('skinchanger:loadSkin', {
				sex      = 0,
				tshirt_1 = 15,
				tshirt_2 = 0,
				arms     = 15,
				torso_1  = 91,
				torso_2  = 0,
				pants_1  = 14,
				pants_2  = 0
			})
		else
			TriggerEvent('skinchanger:loadSkin', {
				sex      = 1,
				tshirt_1 = 34,
				tshirt_2 = 0,
				arms     = 15,
				torso_1  = 101,
				torso_2  = 1,
				pants_1  = 16,
				pants_2  = 0
			})
		end
	end)

	ApplyPedOverlay(PlayerPedId(), GetHashKey(collection), GetHashKey(Config.TattooList[collection][current].nameHash))

	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
		SetCamRot(cam, 0.0, 0.0, 0.0)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 0, true, true)
		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
	end

	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

	SetCamCoord(cam, x + Config.TattooList[collection][current].addedX, y + Config.TattooList[collection][current].addedY, z + Config.TattooList[collection][current].addedZ)
	SetCamRot(cam, 0.0, 0.0, Config.TattooList[collection][current].rotZ)
end

AddEventHandler('esx_tattooshop:clearPlayer', function()
	--ClearPedDecorations(PlayerPedId())

	--for k,v in pairs(currentTattoos) do
	--	ApplyPedOverlay(PlayerPedId(), GetHashKey(v.collection), GetHashKey(Config.TattooList[v.collection][v.texture].nameHash))
	--end


	TriggerEvent('esx_skin:getLastSkin', function(skin)
	TriggerEvent('skinchanger:loadSkin', skin)
	TriggerEvent('esx_tattooshop:hasExitedMarker', LastZone)
		TriggerEvent('esx_skin:getLastSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		Citizen.Wait(2000)
	end)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin) 
	end)
end)

AddEventHandler('esx_tattooshop:clearPlayer', function()
	ESX.UI.Menu.CloseAll()
	currentAction = nil

	TriggerEvent('esx_skin:getLastSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		Citizen.Wait(2000)
	end)
	end)
end)


function OpenPlayerTattooMenu(playerTattoos)
	local elements = {}

	for k,v in pairs(playerTattoos) do
		table.insert(elements, {label = 'Tattoo '..k, value = k})
	end

	if DoesCamExist(cam) then
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoo_player', {
		title    = _U('tattoos'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value ~= nil then
			table.remove(currentTattoos, data.current.value)
			ESX.TriggerServerCallback('esx_tattooshop:removeTattoo', function(success)
				if success then
					menu.close()
					TriggerEvent('esx:showNotification', '~w~Removiendo tattoo...')
					TriggerServerEvent('esx_ambulancejob:requestBed')
					--cleanPlayer()
					TriggerEvent('esx_tattooshop:clearPlayer')
					setPedSkin()
				else 
					menu.close()
				end
			end, currentTattoos)
		else
			OpenPlayerTattooMenu(currentTattoos)
			RenderScriptCams(false, false, 0, 1, 0)
			DestroyCam(cam, false)
			--cleanPlayer()
			TriggerEvent('esx_tattooshop:clearPlayer')
		end

	end, function(data, menu)
		menu.close()
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
		setPedSkin()
	end, function(data, menu) -- when highlighted
		if data.current.value ~= nil then
			drawTattoo(playerTattoos[data.current.value].texture, playerTattoos[data.current.value].collection)
		end
	end)
end

RegisterNetEvent('esx_tattooshop:openPlayerTattooMenu')
AddEventHandler('esx_tattooshop:openPlayerTattooMenu', function(id, data)
    OpenPlayerTattooMenu(currentTattoos)
end)