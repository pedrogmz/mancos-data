local JVF = JAM.VehicleFinance
local JVS = JAM.VehicleShop

-- Start Thread

function JVF:Start()
	if not self then return; end
	while not ESX do Citizen.Wait(0); end
	while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
	while not JUtils do Citizen.Wait(0); end
	while not JVS do Citizen.Wait(0); end

	--print("JAM_VehicleFinance:Start() - Succesful")
	self:FinanceCheck()
	Citizen.CreateThread(function(...) self:PlayerUpdate(...); end)
	Citizen.CreateThread(function(...) self:MechanicUpdate(...); end)
end

-- Player Functions

function JVF:FinanceCheck()
	ESX.TriggerServerCallback('JAM_VehicleFinance:PlayerLogin', function(repo)
		if repo then 
			ESX.ShowNotification("Uno de sus vehículos ha sido marcado para recuperar. Haz el pago ahora (con /doRepay cantidad).") 
			TriggerServerEvent('JAM_VehicleFinance:MarkVehicles', repo)
		end
	end)
end

function JVF:PlayerUpdate()
	if not self or not ESX or not JUtils or not JVS then return; end
	local timer = GetGameTimer()
	self.StartTime = ((GetGameTimer() / 1000) / 60)
	while true do
		Citizen.Wait(0)
		self.tick = (self.tick or 0) + 1
		local drawing = self:PositionCheck()
		if drawing then
			if self.LastDrawing then
				if drawing ~= self.LastDrawing then self.Confirming = false; self.LastDrawing = drawing; end
			else self.LastDrawing = drawing; self.Confirming = false; end
			if (IsControlJustPressed(0, JUtils.Keys[self.FinanceKey]) or IsDisabledControlJustPressed(0, JUtils.Keys[self.FinanceKey])) and self.LastVeh and ((GetGameTimer() - timer) > 1000) then
				timer = GetGameTimer()	
				if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
					ESX.TriggerServerCallback('JAM_VehicleFinance:CheckFunds', function(valid, downpay, price)
						if valid then
							if self.Confirming and not JVS.CurBuying then
								JVS.CurBuying = true
								self:PurchaseVehicle(self.LastVeh, downpay, price)
								ESX.ShowNotification("¡Has comprado el vehículo!")
								self.Confrming = false
							else 
								self.Confirming = true
							end
						else ESX.ShowNotification("No tienes suficiente dinero.")
						end
					end, self.FinanceStartingAmount, self.LastVeh)
				end
			elseif (IsControlJustPressed(0, JUtils.Keys["UP"]) or IsDisabledControlJustPressed(0, JUtils.Keys["UP"])) then
				print("Up",self.FinanceStartingAmount)
				self.FinanceStartingAmount = math.min(self.FinanceStartingAmount + 1, self.FinanceMax)
				timer = GetGameTimer()			
			elseif (IsControlJustPressed(0, JUtils.Keys["DOWN"]) or IsDisabledControlJustPressed(0, JUtils.Keys["DOWN"])) then
				print("Down",self.FinanceStartingAmount)
				self.FinanceStartingAmount = math.max(self.FinanceStartingAmount - 1, self.FinanceMin)
				timer = GetGameTimer()			
			elseif (IsControlPressed(0, JUtils.Keys["UP"]) or IsDisabledControlPressed(0, JUtils.Keys["UP"])) and ((GetGameTimer() - timer) > 150)  then
				self.FinanceStartingAmount = math.min(self.FinanceStartingAmount + 1, self.FinanceMax)		
			elseif (IsControlPressed(0, JUtils.Keys["DOWN"]) or IsDisabledControlPressed(0, JUtils.Keys["DOWN"])) and ((GetGameTimer() - timer) > 150) then
				self.FinanceStartingAmount = math.max(self.FinanceStartingAmount - 1, self.FinanceMin)
			end
		end
	end
end

function JVF:PositionCheck()
	if not JVS or not JVS.DisplayPositions then return; end
	local plyPed = GetPlayerPed(-1)
	local plyPos = GetEntityCoords(plyPed)	

	local nearestDist,nearestVeh,nearestPos,listType,key = JVS:GetNearestDisplay(plyPos)
	if not nearestDist then return; end

	if self.LastVeh and nearestVeh ~= self.LastVeh.veh then 
		self.FinanceStartingAmount = 10 
		self.LastVeh = { dist = nearestDist, veh = nearestVeh, pos = nearestPos, list = listType, key = key } 
	else 
		self.LastVeh = { dist = nearestDist, veh = nearestVeh, pos = nearestPos, list = listType, key  = key } 
	end

	local nearestModel,nearestPrice,nearestProfit
	for k,v in pairs(JVS.ShopData) do 
		for k,v in pairs(v) do
			if v.model == self.LastVeh.veh then
				nearestModel = v.model
				nearestPrice = v.price
				if v.profit then 
					nearestProfit = v.profit / 100
				end
			end
		end
	end

	if nearestDist < JVS.DrawTextDist then
		if self.Confirming then
			if nearestProfit then
				JVS:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.8, "[ "..self.FinanceKey.." ] de nuevo para confirmar. [ ~r~"..self.FinanceStartingAmount.."~s~% Pago Inicial ] : [ $" .. math.floor((nearestPrice + (nearestPrice * nearestProfit)) * (self.FinanceStartingAmount / 100)) .." ]")
				return nearestVeh
			else 				
				JVS:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.8, "[ "..self.FinanceKey.." ] de nuevo para confirmar. [ ~r~"..self.FinanceStartingAmount.."~s~% Pago Inicial ] : [ $" .. math.floor(nearestPrice * (self.FinanceStartingAmount / 100)) .." ]")
				return nearestVeh
			end
		else 
			if nearestProfit then
				JVS:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.8, "[ "..self.FinanceKey.." ] para financiar este vehículo. [ ~r~"..self.FinanceStartingAmount.."~s~% Pago Inicial ] : [ $" .. math.floor((nearestPrice + (nearestPrice * nearestProfit)) * (self.FinanceStartingAmount / 100)) .." ]")
				return nearestVeh
			else 
				if nearestPos and nearestPrice then
					JVS:DrawText3D(nearestPos.x,nearestPos.y,nearestPos.z + 0.8, "[ "..self.FinanceKey.." ] para financiar este vehículo. [ ~r~"..self.FinanceStartingAmount.."~s~% Pago Inicial ] : [ $" .. math.floor(nearestPrice * (self.FinanceStartingAmount / 100)) .." ]")
				end
				return nearestVeh
			end
		end
	else 
		self.FinanceStartingAmount = 10
		return false
	end
end

function JVF:PurchaseVehicle(veh, downpay, price)
	if veh.list == 1 or veh.list == 3 then spawnPos = JVS.PurchasedCarPos; else spawnPos = JVS.PurchasedUtilPos; end
	ESX.Game.SpawnVehicle(veh.veh,spawnPos.xyz, spawnPos.w, function(cbVeh)
		Citizen.Wait(10)
    SetEntityCoords(cbVeh, spawnPos.xyz, 0.0, 0.0, 0.0, true)
    SetEntityHeading(cbVeh, spawnPos.w)
    SetVehicleOnGroundProperly(cbVeh)
    Citizen.Wait(10)
    TaskWarpPedIntoVehicle(GetPlayerPed(-1), cbVeh, -1)
		local vehProps = ESX.Game.GetVehicleProperties(cbVeh)
		TriggerServerEvent('JAM_VehicleFinance:CompletePurchase', vehProps, downpay, price)
		JVS.CurBuying = false
	end)
end

-- Mechanic Functions

function JVF:MechanicUpdate()
	while not self.Towables do Citizen.Wait(0); end	
	local closestVeh,closestDist,closestRepo
	local tick = 0
	local timer = GetGameTimer()

	while true do
		Citizen.Wait(0)	
		tick = tick + 1
		if tick % 100 == 1 then
			closestVeh = false
			closestDist = false
			closestRepo = false

			local plyPos = GetEntityCoords(GetPlayerPed(-1))
			local allVehicles = ESX.Game.GetVehiclesInArea(plyPos, 100.0)

			for k,v in pairs(allVehicles) do
				local vehProps = ESX.Game.GetVehicleProperties(v)
				local vehPos = GetEntityCoords(v)
				local dist = JUtils:GetVecDist(plyPos, vehPos)
				if not closestDist or closestDist > dist then
					for key,val in pairs(self.Towables) do
						if val.plate == vehProps.plate then
							closestDist = dist
							closestRepo = v
						end
					end
				end
			end
		end

		if closestRepo and closestDist then
			if closestDist < 50.0 then
				local closestPos = GetEntityCoords(closestRepo)
				DrawMarker(27, closestPos.x, closestPos.y, closestPos.z - 0.4, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 255, 45, 45, 100, false, true, 2, false, false, false, false)
				DrawMarker(29, closestPos.x, closestPos.y, closestPos.z + 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 45, 45, 100, false, true, 2, false, false, false, false)
				self:DrawRepoMarker(closestRepo, timer)
			elseif closestDist > 50.0 then
				closestDist = false
				closestRepo = false
			end
		end
	end
end

function JVF:DrawRepoMarker(closestRepo, timer)
	local plyPos = GetEntityCoords(GetPlayerPed(-1))
	local dist = JUtils:GetVecDist(self.RepoPoint, plyPos)
	if dist < 50.0 then
		DrawMarker(1, self.RepoPoint.x, self.RepoPoint.y, self.RepoPoint.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 45, 45, 100, false, true, 2, false, false, false, false)
		if dist < 5.0 then
			ESX.ShowHelpNotification("~INPUT_PICKUP~ para recuperar el vehículo más cercano.")
			if (IsControlJustPressed(0, 86) or IsDisabledControlJustPressed(0, 86)) and (GetGameTimer() - timer > 200) then
				timer = GetGameTimer()
				local vehProps = ESX.Game.GetVehicleProperties(closestRepo)
				ESX.TriggerServerCallback('JAM_VehicleFinance:RepoVehicleEnd', function(valid, val)
					if valid then 
						local maxPassengers = GetVehicleMaxNumberOfPassengers(closestRepo)
				    for seat = -1,maxPassengers-1,1 do
				      local ped = GetPedInVehicleSeat(closestRepo,seat)
				    if ped and ped ~= 0 then TaskLeaveVehicle(ped,closestRepo,16); end
				    end 
						ESX.Game.DeleteVehicle(closestRepo)
						ESX.ShowNotification('Ganaste $~g~'..val..'~s~ por la recuperación.')
						table.remove(self.Towables,k)
					else
						ESX.ShowNotification("No puedes recuperar este vehículo.")
					end
				end, vehProps)
			end
		end
	end
end

-- Repo Events

RegisterNetEvent('JAM_VehicleFinance:RemoveRepo')
AddEventHandler('JAM_VehicleFinance:RemoveRepo', function(vehicle)
	if not JVF or not JVF.Towables or not JVF.Towables[1] then return; end
	for k,v in pairs(JVF.Towables) do
		if v.plate == vehicle then
			table.remove(JVF.Towables,k)
		end	
	end
end)

RegisterNetEvent('JAM_VehicleFinance:MarkForRepo')
AddEventHandler('JAM_VehicleFinance:MarkForRepo', function(vehicles)
	while not ESX do Citizen.Wait(0); end
	while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
	local plyData = ESX.GetPlayerData()
	if plyData.job.name ~= JVF.TowDriverJob then return; end
	JVF.Towables = JVF.Towables or {}
	for k,v in pairs(vehicles) do table.insert(JVF.Towables, v); end
end)

-- Repay Commands

RegisterCommand('checkRepay', function(source, args)
	if not ESX then return; end
	local plyPed = GetPlayerPed(-1)
	if not IsPedInAnyVehicle(plyPed, false) then ESX.ShowNotification('Sube a un vehículo primero.'); return; end
	local plyVeh = GetVehiclePedIsIn(plyPed, true)
	local vehProps = ESX.Game.GetVehicleProperties(plyVeh)

	ESX.TriggerServerCallback('JAM_VehicleFinance:GetOwnedVehicles', function(data)
		if not data then ESX.ShowNotification("No posees ningún vehículo.") return; end
		local matched = false
		for k,v in pairs(data) do
			if vehProps.plate == v.plate then 
				matched = true
				print(vehProps.plate,v.plate)
				if v.finance then
					if v.finance < 1 then
						print(v.finance)
						ESX.ShowNotification("Eres dueño de este vehículo.")
					else
						ESX.ShowNotification("Debes $~r~"..v.finance.."~s~. Tienes ~r~"..(v.financetimer).." ~s~ minutos restantes para realizar un reembolso.")
					end
				end
			end
		end
		if not matched then ESX.ShowNotification("No eres dueño de este vehículo."); end
	end)
end)

RegisterCommand('doRepay', function(source, args)
	if not ESX or not ESX.IsPlayerLoaded() then return; end
	if not IsPedInAnyVehicle(GetPlayerPed(-1), false) then ESX.ShowNotification('Sube a un vehículo primero.'); return; end
	if not args then ESX.ShowNotification("Necesitas poner una cantidad válida.") return; end
	local repayAmount = tonumber(args[1])
	if not repayAmount or repayAmount == nil or repayAmount < 1 then ESX.ShowNotification("Necesitas poner una cantidad válida."); end
	
	local plyPed = GetPlayerPed(-1)
	local plyVeh = GetVehiclePedIsIn(plyPed, true)
	local vehProps = ESX.Game.GetVehicleProperties(plyVeh)

	local lowestAmount
	local vehPrice
	for k,v in pairs(JVS.ShopData) do for k,v in pairs(v) do
		if GetHashKey(v.model)%0x100000000 == vehProps.model%0x100000000 then 
			lowestAmount = (v.price / JVF.MaxRepayments)
			vehPrice = v.price
		end
	end; end

	ESX.TriggerServerCallback('JAM_VehicleFinance:GetOwnedVehicles', function(data)
		if not data then return; end
		local matched = false
		for k,v in pairs(data) do
			if vehProps.plate == v.plate then 
				matched = true
				if not v.finance or (v.finance and v.finance < 1) then
					ESX.ShowNotification("Este vehículo ya ha sido pagado.")
				else
					local minRepay = 0
					if lowestAmount > v.finance then minRepay = v.finance else minRepay = lowestAmount; end
					if repayAmount < minRepay then 
						ESX.ShowNotification("Debes pagar al menos $~r~"..minRepay.."~s~ de una vez.")
						return 
					else
						ESX.TriggerServerCallback('JAM_VehicleFinance:RepayLoan', function(valid) 
							if valid then 
								ESX.ShowNotification("Has pagado $~g~"..repayAmount.." ~s~del préstamo de este vehículo.")
								TriggerServerEvent('JAM_VehicleFinance:RemoveFromRepoList', vehProps.plate)
								return 
							else 
								ESX.ShowNotification("No tienes suficiente dinero.")
								return
							end
						end, vehProps.plate, repayAmount)
					end
				end
			end
		end
		if not matched then ESX.ShowNotification("Nadie posee este vehículo."); end
	end)
end)

RegisterCommand('checkRepos', function(...) 
	local plyData = ESX.GetPlayerData()
	if plyData.job.name == JVF.TowDriverJob then
		if not JVF.Towables then ESX.ShowNotification("Hay vehículos marcados para la recuperación en este momento."); return; end
		local compString = ''
		for k,v in pairs(JVF.Towables) do
			local str = 'Matrícula : '..v.plate..'\nAdeudado : '..v.finance..'\n'
			print(str)
		end
	end
end)

Citizen.CreateThread(function(...) JVF:Start(); end)