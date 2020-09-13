local JVS = JAM.VehicleShop

function JVS:Start()
    if not self then return; end
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    while not JUtils do Citizen.Wait(0); end

    self.started = true
    self.tick = 0
    self:GetIPL()
    self:UpdateBlips()
    self:SpawnVehicles()

    while not self.IPLLoaded do Citizen.Wait(0); end
    Citizen.CreateThread(function(...) self:Update(); end)
    Citizen.CreateThread(function(...) self:DealerUpdate(); end)
end

function JVS:UpdateBlips()
    if not self or not self.Blips then return; end

    for key,val in pairs(self.Blips) do
        local blip = AddBlipForCoord(val.Pos.x, val.Pos.y, val.Pos.z)
        SetBlipHighDetail           (blip, true)
        SetBlipSprite               (blip, val.Sprite)
        SetBlipDisplay              (blip, val.Display)
        SetBlipScale                (blip, val.Scale)
        SetBlipColour               (blip, val.Color)
        SetBlipAsShortRange         (blip, true)
        BeginTextCommandSetBlipName ("STRING")
        AddTextComponentString      (val.Zone)
        EndTextCommandSetBlipName   (blip)
    end
end

function JVS:GetIPL()
	RequestIpl('shr_int') -- Load walls and floor
	local interiorID = 7170
	LoadInterior(interiorID)
	EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window
	RefreshInterior(interiorID)
  Citizen.Wait(5000)
  self.IPLLoaded = true
end

function JVS:SpawnVehicles()
  if not self or not ESX or not JUtils then return; end
  while not self.IPLLoaded do Citizen.Wait(0); end
  local range = 20
  SetAllVehicleGeneratorsActiveInArea(vector3(-43.763 - range, -1097.911 - range, 26.422 - range), vector3(-43.763 + range, -1097.911 + range, 26.422 + range), false, false);

  ESX.TriggerServerCallback('mancos_vehshop_premium:GetShopData', function(shopData) self.ShopData = shopData; end)
  while not self.ShopData do Citizen.Wait(0); end

  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)
  local newPos = vector3(plyPos.x, plyPos.y, plyPos.z + 100.0)
	while JUtils:GetVecDist(GetEntityCoords(GetPlayerPed(-1)), self.DealerMarkerPos) > self.SpawnVehDist do Citizen.Wait(500); end
  Citizen.Wait(500)
	self.DisplayVehicles = {}
    for k,v in pairs(self.DisplayPositions) do
        local vehHash = JUtils.GetHashKey(self.ShopData.Displays[k].model)  
        while not HasModelLoaded(vehHash) do Citizen.Wait(10); RequestModel(vehHash); end
        ESX.Game.SpawnLocalVehicle(vehHash, newPos, v.w, function(cbVeh)
            Citizen.Wait(10)
            SetEntityCoords(cbVeh, v.xyz, 0.0, 0.0, 0.0, true)
            SetEntityHeading(cbVeh, v.w)
            SetEntityAsMissionEntity(cbVeh, true, true)
            SetVehicleOnGroundProperly(cbVeh)
            Citizen.Wait(10)
            FreezeEntityPosition(cbVeh, true)
            SetEntityInvincible(cbVeh, true)
            SetVehicleDoorsLocked(cbVeh, 2)
            self.DisplayVehicles[k] = cbVeh
        end)
        SetModelAsNoLongerNeeded(vehHash)
    end

    local veh = self.SmallSpawnVeh
    local vehHash = JUtils.GetHashKey(veh)
    while not HasModelLoaded(vehHash) do Citizen.Wait(10); RequestModel(vehHash); end
    ESX.Game.SpawnLocalVehicle(vehHash, newPos, self.SmallSpawnPos.w, function(cbVeh)
        Citizen.Wait(10)
        SetEntityCoords(cbVeh, self.SmallSpawnPos.xyz, 0.0, 0.0, 0.0, true)
        SetEntityHeading(cbVeh, self.SmallSpawnPos.w)
        SetEntityAsMissionEntity(cbVeh, true, true)
        SetVehicleOnGroundProperly(cbVeh)
        self.SmallDisplay = cbVeh
        Citizen.Wait(10)
        FreezeEntityPosition(cbVeh, true)
        SetEntityInvincible(cbVeh, true)
        SetVehicleDoorsLocked(cbVeh, 2)
    	self.SmallVeh = cbVeh
    end)
    SetModelAsNoLongerNeeded(vehHash)
end


function JVS:Update()
	if not self or not JUtils then return; end
  while not self.IPLLoaded do Citizen.Wait(0); end

  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)
  local plyData = ESX.GetPlayerData()
  local lastJobCheck = GetGameTimer()

  local nearestDist,nearestVeh,nearestPos,listType = self:GetNearestDisplay(plyPos)
	while true do
		Citizen.Wait(0)
		self.tick = (self.tick or 0) + 1
		local plyPed = GetPlayerPed(-1)
		local plyPos = GetEntityCoords(plyPed)
		local dist = JUtils:GetVecDist(plyPos, self.DealerMarkerPos)
		if dist < self.SpawnVehDist then
      nearestDist,nearestVeh,nearestPos,listType = self:GetNearestDisplay(plyPos)
      if (GetGameTimer() - lastJobCheck) > ((1 * 60) * 1000) then
        lastJobCheck = GetGameTimer()
        plyData = ESX.GetPlayerData()
      end

			if nearestDist < self.DrawTextDist then
				local vehName = ""
				local vehPrice = ""
				local extraStr = ""				
				local plyJob = plyData.job.name
				if listType == 1 then
					for k,v in pairs(self.ShopData.Displays) do 
						if v.model == nearestVeh then 
							vehName = v.name
							vehPrice = tostring(v.price)
							nearestModel = v.model
							nearestPrice = v.price
							nearestProfit = v.profit
							extraStr = v.profit
						end
					end
				elseif listType == 2 or listType == 3 then
					for k,v in pairs(self.ShopData.Vehicles) do 
						if v.model == nearestVeh then 
							vehName = v.name
							vehPrice = tostring(v.price)
							extraStr = "[ G ] para cambiar de vehículo."
							nearestModel = v.model
							nearestPrice = v.price
						end
					end
				end
				if (IsControlJustPressed(0, JUtils.Keys["E"], IsDisabledControlJustPressed(0, JUtils.Keys["E"]))) then 
					local istrue = true
					local timer = GetGameTimer()
					while istrue do
						Citizen.Wait(0)
						local plyPos = GetEntityCoords(GetPlayerPed(-1))
						local nearestDistB,nearestVehB,nearestPosB,listTypeB = self:GetNearestDisplay(plyPos)
						if (nearestDistB < self.DrawTextDist and nearestVehB == nearestVeh) then 
							self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.9, "[ E ] para confirmar tu compra.")
              if type(extraStr) == "number" then
                if plyJob == self.CarDealerJobLabel then
                  self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ C" .. math.floor(vehPrice + (extraStr * vehPrice) / 100) .. " ] : [ "..extraStr.."% ]")
                else
                  self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ C" .. math.floor(vehPrice + (extraStr * vehPrice) / 100) .. " ]")
                end
              else            
                if plyJob == self.CarDealerJobLabel then
                  self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ C" .. vehPrice .. " ] : " .. extraStr)
                else
                  self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ C" .. vehPrice .. " ]")
                end
              end
							if (IsControlJustPressed(0, JUtils.Keys["E"], IsDisabledControlJustPressed(0, JUtils.Keys["E"]))) and (GetGameTimer() - timer > 500) and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not self.CurBuying then
								timer = GetGameTimer()
								ESX.TriggerServerCallback('mancos_vehshop_premium:PurchaseVehicle', function(valid)
                  self.CurBuying = true
									if valid then 
										local closest,closestDist
										for k,v in pairs(self.DisplayVehicles) do
											local dist = JUtils:GetVecDist(GetEntityCoords(v), GetEntityCoords(GetPlayerPed(-1)))
											if not dist or not closest or dist < closestDist then closest = v; closestDist = dist; end
										end
										ESX.ShowNotification('¡Has comprado el vehículo!')
										local spawnPos
										if listType == 1 or listType == 3 then spawnPos = self.PurchasedCarPos; else spawnPos = self.PurchasedUtilPos; end
										ESX.Game.SpawnVehicle(nearestModel,spawnPos.xyz, spawnPos.w, function(cbVeh)
											Citizen.Wait(10)
									        SetEntityCoords(cbVeh, spawnPos.xyz, 0.0, 0.0, 0.0, true)
									        SetEntityHeading(cbVeh, spawnPos.w)
											SetVehicleOnGroundProperly(cbVeh)

											TriggerEvent('persistent-vehicles/register-vehicle', cbVeh)
											
									        Citizen.Wait(10)
									        TaskWarpPedIntoVehicle(GetPlayerPed(-1), cbVeh, -1)
											local vehProps = ESX.Game.GetVehicleProperties(cbVeh)
											TriggerServerEvent('mancos_vehshop_premium:CompletePurchase', vehProps)
                      self.CurBuying = false
										end)
									else
										ESX.ShowNotification("No tienes suficiente dinero para comprarlo.")
                    Citizen.CreateThread(function()
                      Wait(1000)
                      JVS.CurBuying = false
                    end)
									end
									istrue = false
								end, nearestModel,nearestPrice)
							end
						else istrue = false
						end						
					end
				elseif (IsControlJustPressed(0, JUtils.Keys["G"], IsDisabledControlJustPressed(0, JUtils.Keys["G"]))) then 
					if listType == 3 then self:OpenSalesMenu(); end
					if listType == 2 then self:OpenUtilityMenu(); end
				elseif (IsControlJustPressed(0, JUtils.Keys["F"], IsDisabledControlJustPressed(0, JUtils.Keys["F"]))) and plyJob == self.CarDealerJobLabel then 
					self:TestDriveVehicle(nearestModel,listType)
				else
					if type(extraStr) == "number" then
						if plyJob == self.CarDealerJobLabel then
							self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ C" .. math.floor(vehPrice + (extraStr * vehPrice) / 100) .. " ]")
							self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.9, "[ E ] para comprar. [ F ] para probarlo.")
						else
							self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ C" .. math.floor(vehPrice + (extraStr * vehPrice) / 100) .. " ]")
							self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.9, "[ E ] para comprarlo")
						end
					else						
						if plyJob == self.CarDealerJobLabel then
							self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ C" .. vehPrice .. " ] : " .. extraStr)
							self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.9, "[ E ] para comprar. [ F ] para probarlo.")
						else
							self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 1.0, "[ "..vehName.." ] : [ C" .. vehPrice .. " ]")
							self:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.9, extraStr .. " [ E ] para comprarlo.")
						end
					end
				end
			end
		end
	end
end

function JVS:TestDriveVehicle(model, listtype)
	if self.TestingCar then return; end
	self.TestingCar = true
	if listtype == 2 then
		ESX.Game.SpawnVehicle(model, self.PurchasedUtilPos.xyz, self.PurchasedUtilPos.w, function(cbVeh)
			Citizen.Wait(10)
	        SetEntityCoords(cbVeh, self.PurchasedUtilPos.xyz, 0.0, 0.0, 0.0, true)
	        SetEntityHeading(cbVeh, self.PurchasedUtilPos.w)
	        SetVehicleOnGroundProperly(cbVeh)
	        Citizen.Wait(10)
	        TaskWarpPedIntoVehicle(GetPlayerPed(-1), cbVeh, -1)
	        SetVehicleNumberPlateText(cbVeh, "TESTCAR")
	        self.TestingCar = cbVeh
	        self.TestingList = listtype
		end)
	elseif listtype == 1 or listtype == 3 then
		ESX.Game.SpawnVehicle(model, self.PurchasedCarPos.xyz, self.PurchasedCarPos.w, function(cbVeh)
			Citizen.Wait(10)
	        SetEntityCoords(cbVeh, self.PurchasedCarPos.xyz, 0.0, 0.0, 0.0, true)
	        SetEntityHeading(cbVeh, self.PurchasedCarPos.w)
	        SetVehicleOnGroundProperly(cbVeh)
	        Citizen.Wait(10)
	        TaskWarpPedIntoVehicle(GetPlayerPed(-1), cbVeh, -1)
	        SetVehicleNumberPlateText(cbVeh, "TESTCAR")
	        self.TestingCar = cbVeh
	        self.TestingList = listtype
	    end)
	end
end

Citizen.CreateThread(function()
	local self = JVS
	while true do
		Citizen.Wait(10)
		if self.TestingCar and self.TestingList then
			local plyPed = GetPlayerPed(-1)
			local plyPos = GetEntityCoords(plyPed)
			if self.TestingList == 2 then
				if JUtils:GetVecDist(plyPos, self.PurchasedUtilPos.xyz) < self.VehRetDist then
					ESX.ShowHelpNotification('~INPUT_PICKUP~ para regresar a la prueba.')
					if (IsControlJustPressed(0, JUtils.Keys["E"], IsDisabledControlJustPressed(0, JUtils.Keys["E"]))) then 

						local maxPassengers = GetVehicleMaxNumberOfPassengers(self.TestingCar)
				    for seat = -1,maxPassengers-1,1 do
				        local ped = GetPedInVehicleSeat(self.TestingCar,seat)
				        if ped and ped ~= 0 then TaskLeaveVehicle(ped,self.TestingCar,16); end
				    end
            print(maxPassengers,self.TestingCar)
						ESX.Game.DeleteVehicle(self.TestingCar)
            if DoesEntityExist(self.TestingCar) then SetVehicleUndriveable(self.TestingCar, true); end
						ESX.ShowNotification("Has devuelto el vehículo de prueba.")
						self.TestingCar = false
						self.TestingList = false
					end
				end
			else
				if JUtils:GetVecDist(plyPos, self.PurchasedCarPos.xyz) < self.VehRetDist then
					ESX.ShowHelpNotification('~INPUT_PICKUP~ para regresar a la prueba.')
					if (IsControlJustPressed(0, JUtils.Keys["E"], IsDisabledControlJustPressed(0, JUtils.Keys["E"]))) then
						local maxPassengers = GetVehicleMaxNumberOfPassengers(self.TestingCar)
				    for seat = -1,maxPassengers-1,1 do
				        local ped = GetPedInVehicleSeat(self.TestingCar,seat)
				        if ped and ped ~= 0 then TaskLeaveVehicle(ped,self.TestingCar,16); end
				    end 
            print(maxPassengers,self.TestingCar)
						ESX.Game.DeleteVehicle(self.TestingCar)
						ESX.ShowNotification("Has devuelto el vehículo de prueba.")
            if DoesEntityExist(self.TestingCar) then SetVehicleUndriveable(self.TestingCar, true); end
						self.TestingCar = false
						self.TestingList = false
					end
				end
			end
		end
	end
end)

function JVS:OpenUtilityMenu()
	local elements = {}
	for k,v in pairs(self.ShopData.Vehicles) do if v.category == "utility" then table.insert(elements, {label = v.name .. " : [$"..v.price.."]", model = v.model, price = v.price}); end; end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Utility_Menu", { title = "PDM Ventas", align = 'left', elements = elements }, 
		function(data,menu)
			menu.close()
			self:OpenUtilPurchase(data.current)
		end,		
		function(data,menu)
			menu.close()
			ESX.UI.Menu.CloseAll()
		end
	)
end	

function JVS:PurchaseHeavyVehicle(veh)
	ESX.TriggerServerCallback('mancos_vehshop_premium:PurchaseVehicle', function(valid)
		if valid then 
			ESX.ShowNotification('¡Has comprado el vehículo!')

			ESX.Game.SpawnVehicle(veh.model, self.PurchasedUtilPos.xyz, self.PurchasedUtilPos.w, function(cbVeh)
				Citizen.Wait(10)
		        SetEntityCoords(cbVeh, self.PurchasedUtilPos.xyz, 0.0, 0.0, 0.0, true)
		        SetEntityHeading(cbVeh, self.PurchasedUtilPos.w)
		        SetVehicleOnGroundProperly(cbVeh)
		        Citizen.Wait(10)
		        TaskWarpPedIntoVehicle(GetPlayerPed(-1), cbVeh, -1)
				local vehProps = ESX.Game.GetVehicleProperties(cbVeh)
				TriggerServerEvent('mancos_vehshop_premium:CompletePurchase', vehProps)
			end)
		else
			ESX.ShowNotification("No tienes suficiente dinero para comprarlo.")
		end
		istrue = false
	end, veh.model, veh.price)
end


function JVS:OpenSalesMenu()
	local elements = {}
	for k,v in pairs(self.ShopData.Categories) do if v.name ~= "utility" then table.insert(elements, { label = v.label, name = v.name } ); end; end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Sales_Menu", { title = "PDM Ventas", align = 'left', elements = elements }, 
		function(data,menu)
			menu.close()
			self:OpenCategoryMenu(data.current)
		end,		
		function(data,menu)
			menu.close()
			ESX.UI.Menu.CloseAll()
		end
	)
end

function JVS:OpenCategoryMenu(category)
	local elements = {}
	for k,v in pairs(self.ShopData.Vehicles) do if v.category == category.name then table.insert(elements, { label = v.name .. " : [C"..v.price.."]", model = v.model, price = v.price }); end; end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Category_Menu", { title = "PDM : "..category.label, align = 'left', elements = elements }, 
		function(data,menu)
			menu.close()
			self:ChangeSpawnedVehicle(data.current, category)
		end,
		function(data,menu)
			menu.close()
			self:OpenSalesMenu()
		end
	)
end

function JVS:ChangeSpawnedVehicle(vehicle, category)
	ESX.Game.DeleteVehicle(self.SmallVeh)
	ESX.Game.SpawnLocalVehicle(vehicle.model, self.SmallSpawnPos.xyz, self.SmallSpawnPos.w, function(cbVeh)
		Citizen.Wait(10)
		SetEntityCoords(cbVeh, self.SmallSpawnPos.xyz, 0.0, 0.0, 0.0, true)
		SetEntityHeading(cbVeh, self.SmallSpawnPos.w)
		SetEntityAsMissionEntity(cbVeh, true, true)
		SetVehicleOnGroundProperly(cbVeh)
		Citizen.Wait(10)
		FreezeEntityPosition(cbVeh, true)
		SetVehicleDoorsLocked(cbVeh, 2)
    	Citizen.Wait(10)
    	self.SmallVeh = cbVeh
    	self.SmallSpawnVeh = vehicle.model
	end)
end

function JVS:PurchaseVehicle(vehicle)
	ESX.TriggerServerCallback('mancos_vehshop_premium:PurchaseVehicle', function(valid)
		if valid then 
			ESX.ShowNotification('¡Has comprado el vehículo!')

			ESX.Game.SpawnVehicle(vehicle.model, self.PurchasedCarPos.xyz, self.PurchasedCarPos.w, function(cbVeh)
				Citizen.Wait(10)
		        SetEntityCoords(cbVeh, self.PurchasedCarPos.xyz, 0.0, 0.0, 0.0, true)
		        SetEntityHeading(cbVeh, self.PurchasedCarPos.w)
		        SetVehicleOnGroundProperly(cbVeh)
		        Citizen.Wait(10)
		        TaskWarpPedIntoVehicle(GetPlayerPed(-1), cbVeh, -1)
				local vehProps = ESX.Game.GetVehicleProperties(cbVeh)
				TriggerServerEvent('mancos_vehshop_premium:CompletePurchase', vehProps)
			end)
		else
			ESX.ShowNotification("No tienes suficiente dinero para comprarlo.")
		end
		istrue = false
	end, vehicle.model,vehicle.price)
end

function JVS:DealerUpdate()
	if not self or not ESX then return; end
	local plyData = ESX.GetPlayerData()
	if plyData.job.name ~= self.CarDealerJobLabel then return; end
	while true do
		Citizen.Wait(0)
		local plyPed = GetPlayerPed(-1)
		local plyPos = GetEntityCoords(plyPed)
		local dist = JUtils:GetVecDist(plyPos, self.DealerMarkerPos)

		if dist < self.MenuUseDist and not self.MenuOpen then
			ESX.ShowHelpNotification("~INPUT_PICKUP~ para acceder al menú PDM.")
			if (IsControlJustPressed(0, JUtils.Keys["E"]) or IsDisabledControlJustPressed(0, JUtils.Keys["E"])) then
				self.MenuOpen = true
				self:OpenDealerMenu()
			end
		end

		if dist < self.SpawnVehDist then 
			DrawMarker(1, self.DealerMarkerPos.x, self.DealerMarkerPos.y, self.DealerMarkerPos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 57, 141, 255, 80, false, true, 2, false, false, false, false)
			
			local nearestDist,nearestVeh,nearestPos,listType,key = self:GetNearestDisplay(plyPos)
			if nearestDist < self.DrawTextDist and listType == 1 then
				if (IsControlJustPressed(0, JUtils.Keys["LEFT"]) or IsDisabledControlJustPressed(0, JUtils.Keys["LEFT"])) then
					self:ChangeComission(nearestVeh, -1,key)
				elseif (IsControlJustPressed(0, JUtils.Keys["RIGHT"]) or IsDisabledControlJustPressed(0, JUtils.Keys["RIGHT"])) then
					self:ChangeComission(nearestVeh, 1,key)
				end
			end
		end
	end
end

function JVS:openBilling()

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing_bennys', {
		title    = 'Bennys',
		align    = 'top-left',
		elements = {
			{ label = "Cobrar cambio de matricula",   value = 'billing' }
		}
	}, function(data, menu)
		if data.current.value == 'billing' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing_change_plate', {
				title = "Cantidad a cobrar"
			}, function(data, menu)
				local amount = tonumber(data.value)
				if amount == nil then
					ESX.ShowNotification("Cantidad invalida")
				else
					menu.close()
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification("No hay jugadores cerca")
					else
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mancosclub', 'Cambio de matricula', amount)
						ESX.ShowNotification("Factura enviada")
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()
		ESX.UI.Menu.CloseAll()
		self.MenuOpen = false
	end)
end

function JVS:OpenDealerMenu()
	local plyData = ESX.GetPlayerData()
	if plyData.job.grade >= 3 then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Dealer_Menu", { title = "Comerciante PDM", align = 'left', elements = { [1] = {label = "Reorganizar Vehículos"}, [2] = {label = "Cuenta de concesionario"} } }, 
			function(data,menu)
				menu.close()
				if data.current.label == "Reorganizar Vehículos" then self:OpenRearrangeMenu()
				else self:OpenDealerInventory()
				end
			end,
			function(data,menu)
				menu.close()
				ESX.UI.Menu.CloseAll()
				self.MenuOpen = false
			end
		)
	else		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Dealer_Menu", { title = "Comerciante PDM", align = 'left', elements = { [1] = {label = "Reorganizar Vehículos"} } }, 
			function(data,menu)
				menu.close()
				self:OpenRearrangeMenu()
			end,
			function(data,menu)
				menu.close()
				ESX.UI.Menu.CloseAll()
				self.MenuOpen = false
			end
		)
	end
end

function JVS:ChangeComission(veh, val, key)
	if not veh or not val then return; end
	TriggerServerEvent('mancos_vehshop_premium:ChangeComission', veh, val,key)
end

function JVS:OpenDealerMenu()
	local plyData = ESX.GetPlayerData()
	if plyData.job.grade >= 3 then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Dealer_Menu", { title = "Comerciante PDM", align = 'left', elements = { [1] = {label = "Reorganizar Vehículos"}, [2] = {label = "Cuenta de concesionario"} } }, 
			function(data,menu)
				menu.close()
				if data.current.label == "Reorganizar Vehículos" then self:OpenRearrangeMenu()
				else self:OpenDealerInventory()
				end
			end,
			function(data,menu)
				menu.close()
				ESX.UI.Menu.CloseAll()
				self.MenuOpen = false
			end
		)
	else		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Dealer_Menu", { title = "Comerciante PDM", align = 'left', elements = { [1] = {label = "Reorganizar Vehículos"} } }, 
			function(data,menu)
				menu.close()
				self:OpenRearrangeMenu()
			end,
			function(data,menu)
				menu.close()
				ESX.UI.Menu.CloseAll()
				self.MenuOpen = false
			end
		)
	end
end

function JVS:OpenDealerInventory()
	ESX.TriggerServerCallback('mancos_vehshop_premium:GetDealerMoney', function(money)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Dealer_Menu", { title = "Inventario PDM : $"..money, align = 'left', elements = { [1] = {label = "Depositar"}, [2] = {label = "Retirar"} } }, 
			function(data,menu)
				if data.current.label == "Depositar" then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Inventario de comerciante', {title = "Inventario de comerciante - Deposito"}, 
						function(data2, menu2)
							local quantity = tonumber(data2.value)

							if quantity == nil then
								ESX.ShowNotification("Cantidad inválida.")
							else
								menu2.close()
								ESX.TriggerServerCallback('mancos_vehshop_premium:DepositDealerMoney', function(valid)
									if valid then ESX.ShowNotification("Has depositado $~g~"..quantity.."~s~ en el inventario.")
									else ESX.ShowNotification("Cantidad inválida.")
									end
								end, quantity)
                menu.close()
                self.MenuOpen = false
							end
						end,
						function(data,menu)
							menu.close()
							ESX.UI.Menu.CloseAll()
							self.MenuOpen = false
						end
					)
				elseif data.current.label == "Retirar" then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Inventario de comerciante.', {title = "Inventario de comerciante - Retirar"}, 
						function(data2, menu2)
							local quantity = tonumber(data2.value)

							if quantity == nil then
								ESX.ShowNotification("Cantidad inválida.")
							else
								menu2.close()
								ESX.TriggerServerCallback('mancos_vehshop_premium:WithdrawDealerMoney', function(valid)
									if valid then ESX.ShowNotification("Has retirado $~g~"..quantity.."~s~ del inventario.")
									else ESX.ShowNotification("Cantidad inválida.")
									end
								end, quantity)
                menu.close()
                self.MenuOpen = false
							end
						end,
						function(data,menu)
							menu.close()
							ESX.UI.Menu.CloseAll()
							self.MenuOpen = false
						end
					)
				end
			end,
			function(data,menu)
				menu.close()
				ESX.UI.Menu.CloseAll()
				self.MenuOpen = false
			end
		)
	end)	
end

function JVS:OpenRearrangeMenu()
	local elements = {}
	for k,v in pairs(self.DisplayVehicles) do
		local prefix = ''
		if k == 1 or k == 2 or k == 3 then prefix = "[Car] " else prefix = "[Bike] "; end 
		table.insert(elements, {label = prefix..self.ShopData.Displays[k].name, key = k})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Rearrange_Menu", { title = "Reorganizar vehículos", align = 'left', elements = elements }, 
		function(data,menu)
			menu.close()
			self:OpenSwapMenu(data.current.key)
		end,
		function(data,menu)
			menu.close()
			self:OpenDealerMenu()
		end
	)
end

function JVS:OpenSwapMenu(key)
	local elements = {}
	for k,v in pairs(self.ShopData.Imports) do
		if key == 1 or key == 2 or key == 3 then
			if v.category == "importcars" then
				table.insert(elements, {label = v.name, model = v.model, price = v.price})
			end
		elseif key == 4 or key == 5 or key == 6 then
			if v.category == "importbikes" then
			table.insert(elements, {label = v.name, model = v.model, price = v.price})
			end
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Import_Menu", { title = "Importar vehículos", align = 'left', elements = elements }, 
		function(data,menu)		
			local profitVal = false	
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Porcentaje de beneficio', {title = "Porcentaje de beneficio"}, 
				function(data2, menu2)
					local quantity = tonumber(data2.value)

					if quantity == nil then
						ESX.ShowNotification("Cantidad inválida.")
					else
						profitVal = quantity
						menu2.close()
					end
				end, 
				function(data2, menu2)
					menu2.close()
				end
			)
			while not profitVal do Citizen.Wait(0); end

			TriggerServerEvent('mancos_vehshop_premium:ServerReplace', data.current.model, data.current.label, data.current.price, key, profitVal)
			self.DoOpen = true
			self.MenuOpen = false
			menu.close()
		end,
		function(data,menu)
			menu.close()
			self:OpenRearrangeMenu()
		end
	)
end

RegisterNetEvent('mancos_vehshop_premium:ClientReplace')
AddEventHandler('mancos_vehshop_premium:ClientReplace', function(model, key, docar)
	if not JVS or not ESX or not ESX.IsPlayerLoaded() then return; end
	if docar then JVS:ReplaceDisplayVehicle(model, key)
	else JVS:ReplaceDisplayComission(model,key)
	end
end)

function JVS:ReplaceDisplayComission(model,key)
    ESX.TriggerServerCallback('mancos_vehshop_premium:GetShopData', function(shopData) self.ShopData = shopData; end)
end

function JVS:ReplaceDisplayVehicle(model, key)
	local canCont = false
    ESX.TriggerServerCallback('mancos_vehshop_premium:GetShopData', function(shopData) self.ShopData = shopData; canCont = true; end)
    while not canCont do Citizen.Wait(0); end
	local startPos = GetEntityCoords(GetPlayerPed(-1))
	local newPos = vector3(startPos.x, startPos.y, startPos.z + 100.0)
	local spawnPos = self.DisplayPositions[key]
	local vehHash = JUtils.GetHashKey(model)
  self.DisplayVehicles = self.DisplayVehicles or {}
	if self.DisplayVehicles and self.DisplayVehicles[key] then ESX.Game.DeleteVehicle(self.DisplayVehicles[key]); end
	while not HasModelLoaded(vehHash) do Citizen.Wait(10); RequestModel(vehHash); end
	ESX.Game.SpawnLocalVehicle(vehHash, spawnPos.xyz, spawnPos.w, function(cbVeh)
		Citizen.Wait(10)
		SetEntityCoords(cbVeh, spawnPos.xyz, 0.0, 0.0, 0.0, true)
		SetEntityHeading(cbVeh, spawnPos.w)
		SetEntityAsMissionEntity(cbVeh, true, true)
		SetVehicleOnGroundProperly(cbVeh)
		Citizen.Wait(10)
		FreezeEntityPosition(cbVeh, true)
    SetEntityInvincible(cbVeh, true)
		SetVehicleDoorsLocked(cbVeh, 2)
  	self.DisplayVehicles[key] = cbVeh
  	Citizen.Wait(10)
  	SetModelAsNoLongerNeeded(vehHash)
		if self.DoOpen then self:OpenRearrangeMenu(); self.DoOpen = false; end
	end)
end

function JVS:GetNearestDisplay(plyPos)
	if not self or not self.ShopData then return false; end
	local nearestDist,nearestVeh,nearestPos,listType,key
	for k,v in pairs(self.DisplayPositions) do
		if self.ShopData.Displays[k] then
			local curDist = JUtils:GetVecDist(plyPos, v.xyz)
			if not nearestDist or curDist < nearestDist then
				nearestDist = curDist
				nearestPos = v
				nearestVeh = self.ShopData.Displays[k].model
				listType = 1
				key = k
			end
		end
	end

	local curDistB = JUtils.GetXYDist(plyPos.x, plyPos.y, plyPos.z, self.SmallSpawnPos.x, self.SmallSpawnPos.y, self.SmallSpawnPos.z)
	if not nearestDist or curDistB < nearestDist then
		nearestDist = curDistB
		nearestPos = self.SmallSpawnPos
		nearestVeh = self.SmallSpawnVeh
		listType = 3
	end
	if not nearestDist or not nearestVeh then return false; end
	return nearestDist,nearestVeh,nearestPos,listType,key
end


local color = { r = 220, g = 220, b = 220, alpha = 255 } -- Color of the text 
local font = 4 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local background = { enable = true, color = { r = 35, g = 35, b = 35, alpha = 200 }, }
local chatMessage = true
local dropShadow = false

-- Don't touch
local nbrDisplaying = 1

function JVS:DrawText3D(x,y,z, text)
  if not self.Drawing then
    self.Drawing = true
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*100

    if onScreen then
      -- Formalize the text
      SetTextColour(color.r, color.g, color.b, color.alpha)
      SetTextScale(0.0*scale, 0.40*scale)
      SetTextFont(font)
      SetTextProportional(1)
      SetTextCentre(true)
      if dropShadow then
          SetTextDropshadow(10, 100, 100, 100, 255)
      end

      -- Calculate width and height
      BeginTextCommandWidth("STRING")
      --AddTextComponentString(text)
      local height = GetTextScaleHeight(0.45*scale, font)
      local width = EndTextCommandGetWidth(font)

      -- Diplay the text
      SetTextEntry("STRING")
      AddTextComponentString(text)
      EndTextCommandDisplayText(_x, _y)

      -- if background.enable then
      --     DrawRect(_x, _y+scale/73, width, height, background.color.r, background.color.g, background.color.b , background.color.alpha)
      -- end
    end
    self.Drawing = false
  end
end

Citizen.CreateThread(function(...) JVS:Start(...); end)

-- Key Controls
Citizen.CreateThread(function()
	local self = JVS
	while true do
		Citizen.Wait(0)
		
		if not self or not ESX then return; end
		local plyData = ESX.GetPlayerData()

		if plyData.job ~= nil and plyData.job.name == self.CarDealerJobLabel then
			if IsControlJustReleased(0, JUtils.Keys['F6']) then
				print('Opening facturas Bennys')
				self.MenuOpen = true
				self:openBilling()
			end
		else
			Citizen.Wait(500)
		end
	end
end)