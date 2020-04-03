ESX          = nil
local IsDead = false
local IsAnimated = false
local IsAlreadyDrunk = false
local DrunkLevel     = -1
local xPlayer = {}
local checkStress = false
local countJob = 0
local stressOn = false
local stressVal = 0
local inGasMask = false
local sendEntorno = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	xPlayer = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	countJob = 0
	xPlayer.job = job
end)

AddEventHandler('esx_basicneeds:resetStatus', function()
	TriggerEvent('esx_status:set', 'hunger', 500000)
	TriggerEvent('esx_status:set', 'thirst', 500000)
end)

RegisterNetEvent('esx_basicneeds:healPlayerDead')
AddEventHandler('esx_basicneeds:healPlayerDead', function()
	-- restore hunger & thirst & drunk & stress
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	TriggerEvent('esx_status:set', 'drunk', 0)
	TriggerEvent('esx_status:set', 'stress', 0)

end)

RegisterNetEvent('esx_basicneeds:healPlayer')
AddEventHandler('esx_basicneeds:healPlayer', function()
	-- restore hunger & thirst
	TriggerEvent('esx_status:set', 'hunger', 1000000)
	TriggerEvent('esx_status:set', 'thirst', 1000000)
	TriggerEvent('esx_status:set', 'drunk', 0)
	TriggerEvent('esx_status:set', 'stress', 0)

	-- restore hp
	local playerPed = PlayerPedId()
	SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	if IsDead then
		TriggerEvent('esx_basicneeds:resetStatus')
	end

	IsDead = false
end)

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'hunger', 1000000, '#CFAD0F', function(status)
		return false
	end, function(status)
		status.remove(100)
	end)

	TriggerEvent('esx_status:registerStatus', 'thirst', 1000000, '#0C98F1', function(status)
		return false
	end, function(status)
		status.remove(75)
	end)

	TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5', 
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end, function(status)
      status.remove(3500)
	end)
	
	-- Arnedo5 | Stress system
	TriggerEvent('esx_status:registerStatus', 'stress', 0, '#8F15A5', function(status)
		return false
	end, function(status)
		status.remove(1)
	end)

	checkStress = true
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerPed  = PlayerPedId()
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				if status.val == 0 then
					if prevHealth <= 150 then
						health = health - 5
					else
						health = health - 1
					end
				end
			end)

			-- Derath - Arnedo5 | Sistema de Alcohol
			TriggerEvent('esx_status:getStatus', 'drunk', function(status)

				if status.val > 0 then
				
				  local start = true
				
				  if IsAlreadyDrunk then
					start = false
				  end
				
				  local level = 0
				
				  if status.val >= 150000 then
					level = 0
				  elseif status.val <= 300000 then
					level = 1
				  else
					level = 2
				  end
				
				  if level ~= DrunkLevel then
					Drunk(level, start)
				  end
				
				  IsAlreadyDrunk = true
				  DrunkLevel     = level
				end
				
				if status.val == 0 then
				
				  if IsAlreadyDrunk then
					Reality()
				  end
				
				  IsAlreadyDrunk = false
				  DrunkLevel     = -1
				
				end
				
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed, health)
			end

		end
	end)
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if checkStress == true then

			TriggerEvent('esx_status:getStatus', 'stress', function(status)
				stressVal = status.val
			end)

			-- SUBIENDO STRESS
			-- 1 [Conducción rápida] - Mas de 150KM
			local playerPed = GetPlayerPed(-1)
			local playerCar = GetVehiclePedIsIn(playerPed, false)
			local SpeedKMM = GetEntitySpeed(playerPed)*3.6
			local SpeedKM = math.floor(SpeedKMM)
			local maxSpeed = 150.0 

			if SpeedKM > maxSpeed then
				if IsPedInAnyVehicle(playerPed, false) then
					if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then	

						if stressVal >= 0 and stressVal < 1000000 then 
							UpStress(Config.Stress.Level)
							stressVal = stressVal +  Config.Stress.Level
							Citizen.Wait(900000) -- 15 Minutos
						end		
	
					end
				end
			end

			if SpeedKM > 0 and SpeedKM <= 80 then
				if IsPedInAnyVehicle(playerPed, false) then
					if (GetPedInVehicleSeat(playerCar, -1) == playerPed) then	

						-- BAJANDO STRESS
						-- Conduciendo una bicicleta / motos
						local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
						local vehicleClass = GetVehicleClass(vehicle)
						
						if (vehicleClass == 13 or vehicleClass == 8) and  xPlayer.job.name ~= 'police' and stressVal > 0 then
							TriggerEvent('esx_status:remove', 'stress', 20000)
							TriggerEvent('esx_basicneeds:removeStress')
							Citizen.Wait(60000)
						end
					end
				end
			end

			if SpeedKM >= 180 and xPlayer.job.name ~= 'police' and xPlayer.job.name ~= 'ambulance' then

				-- Send notification police
				DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)

				-- Coords
				local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
				
				-- Vehicle
				local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
				local vehName2 = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
				vehName2 = Config.VehicleType[tostring(GetVehicleClass(veh))] -- Typo de vehiculo en esp

				local plate = GetVehicleNumberPlateText(veh)
				local primary, secondary = GetVehicleColours(veh)
				primary = Config.Colornames[tostring(primary)]
				secondary = Config.Colornames[tostring(secondary)]

				local streetName, crossing = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
				local streetName, crossing = GetStreetNameAtCoord(x, y, z)
				streetName = GetStreetNameFromHashKey(streetName)

				-- Sexo
				local msg = "Se ha visto vehiculo ["..vehName2.."], matrícula ["..plate.."], color ["..primary.."] a altas velocidades, cerca de ["..streetName.."]";
				
				if streetName ~= nil then

					-- Send entorno
					TriggerServerEvent('comprobarEntorno', msg, plyPos.x, plyPos.y, plyPos.z, "NPC RANDOM")

					Citizen.Wait(120000)
				end
			end

		end
	end
end)	



-- Arnedo5 | Stress system
-- Como se tienen que comprobar muchas cosas, creamos otro hilo / thread
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if checkStress == true then

			TriggerEvent('esx_status:getStatus', 'stress', function(status)
				stressVal = status.val
			end)

			-- 2 [Trabajo de whitelist]
			if xPlayer.job.name == 'ambulance' or
				xPlayer.job.name == 'police' or
				xPlayer.job.name == 'mechanic' or
				xPlayer.job.name == 'taxi' or
				xPlayer.job.name == 'tender' or
				xPlayer.job.name == 'bar' or
				xPlayer.job.name == 'cardealer' then
					countJob = countJob + 1
				end

			if countJob == 1200 then -- 1200 [20 minutos]

				if stressVal >= 0 and stressVal < 1000000 then 
					UpStress(Config.Stress.LevelJobWhitelist)
					stressVal = stressVal +  Config.Stress.LevelJobWhitelist
				end

				countJob = 0
			end

		end
	end
end)	

-- Disparo + combate cuerpo a cuerpo
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if checkStress == true then

			local playerPed = PlayerPedId()
			
			-- Arnedo5 - Stress System
			TriggerEvent('esx_status:getStatus', 'stress', function(status)
				stressVal = status.val
			end)

			-- Intentar entrar en un vehiculo
			if IsPedTryingToEnterALockedVehicle(playerPed) or IsPedJacking(playerPed)then

				if stressVal < 1000000 then 
					UpStress(Config.Stress.Level)
					stressVal = stressVal +  Config.Stress.Level
				end

				--ESX.ShowNotification(_U('up_level'))
				Citizen.Wait(Config.Stress.Whait)

			elseif IsPedInMeleeCombat(playerPed) then -- Combate a mele

				if stressVal < 1000000 then 
					UpStress(Config.Stress.Level)
					stressVal = stressVal +  Config.Stress.Level
				end

				Citizen.Wait(Config.Stress.Whait)

			elseif IsPedShooting(playerPed) and not IsPedCurrentWeaponSilenced(playerPed) then -- Disparos con arma SIN silenciador

				if stressVal < 1000000 then 
					UpStress(Config.Stress.Level)
					stressVal = stressVal +  Config.Stress.Level
				end

				Citizen.Wait(Config.Stress.Whait)
			end

			-- Vehicles | Entorno + stress
			-- or IsPedJacking(GetPlayerPed(-1))
			--[[ 
			if IsVehicleNeedsToBeHotwired(GetVehiclePedIsIn(GetPlayerPed(-1))) or IsPedTryingToEnterALockedVehicle(GetPlayerPed(-1))  then

				Citizen.Wait(5000)

				if  IsPedInAnyVehicle(GetPlayerPed(-1))then
					DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)

					-- Coords
					local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
					
					-- Vehicle
					local veh = GetVehiclePedIsIn(GetPlayerPed(-1))
					local vehName2 = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
					vehName2 = Config.VehicleType[tostring(GetVehicleClass(veh))] -- Typo de vehiculo en esp

					local plate = GetVehicleNumberPlateText(veh)
					local primary, secondary = GetVehicleColours(veh)
					primary = Config.Colornames[tostring(primary)]
					secondary = Config.Colornames[tostring(secondary)]

					local streetName, crossing = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
					local streetName, crossing = GetStreetNameAtCoord(x, y, z)
					streetName = GetStreetNameFromHashKey(streetName)

					-- Sexo
					local msg = ""
					local male = IsPedMale(GetPlayerPed(-1))

					if male then
						sex = "Hombre"
						msg = "Se ha visto a un "..sex.." robando un@ ["..vehName2.."], matrícula ["..plate.."], color ["..primary.."] cerca de ["..streetName.."]";
					elseif not male then
						sex = "Mujer"
						msg = "Se ha visto a una "..sex.." robando un@ ["..vehName2.."], matrícula ["..plate.."], color ["..colourText.."] cerca de ["..streetName.."]";
					end

					if streetName ~= nil and not sendEntorno then

						-- Send entorno
						TriggerServerEvent('comprobarEntorno', msg, plyPos.x, plyPos.y, plyPos.z, "NPC RANDOM")

						sendEntorno = true
					end
				end

				if stressVal < 1000000 then 
					UpStress(Config.Stress.Level)
					stressVal = stressVal +  Config.Stress.Level
				end

				sendEntorno = false

				Citizen.Wait(Config.Stress.Whait)
			end

			]]---


		end
	end
end)	

-- Arnedo5 - Zonas de descanso
local HasAlreadyEnteredMarker         		= false
local isInStressZone, hasExitedStressZone 	= false
local currentZone                     		= nil
local currentZoneName                 		= nil

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(500)
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		isInStressZone, hasExitedStressZone = false;
		
		for k,v in pairs(Config.Zones) do
			local distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
	  
			if distance < v.Dist then
			  currentZone, currentZoneName = v, k
			  isInStressZone = true
			end
		end

		-- Enter zone
		if isInStressZone and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true	
		end

		 -- Exit zoone
		 if not hasExitedStressZone and not isInStressZone and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			currentZoneName = nil
		 end

	end
end)

Citizen.CreateThread(function()

	while true do 
		Citizen.Wait(500)

		if HasAlreadyEnteredMarker == true and currentZoneName  ~= nil and stressVal > 0 then

			-- 2 [Trabajo de whitelist]			
			if stressVal >= 10000 then
				TriggerEvent('esx_status:remove', 'stress', Config.Zones[currentZoneName].Stress)
				TriggerEvent('esx_basicneeds:removeStress')
				Citizen.Wait(Config.Zones[currentZoneName].Whait)
			elseif stressVal < 10000 then
				TriggerEvent('esx_status:remove', 'stress', Config.Zones[currentZoneName].Stress)
				TriggerEvent('esx_basicneeds:removeStress')
				Citizen.Wait(Config.Zones[currentZoneName].Whait)
			end	
		end

	end

end)

-- Arnedo5 - Eventos de stress
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if stressVal >= 900000 then
			Citizen.Wait(3000)
			
			SetTimecycleModifier("spectator9")

			ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 0.30) -- Nivel Alto

			RequestAnimSet("move_m@drunk@a")
			SetPedMovementClipset(playerPed, "move_m@drunk@a", true)

			stressOn = true
		elseif stressVal >= 850000 then

			SetTimecycleModifier("spectator5")
			Citizen.Wait(4000)
			ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 0.25) -- Nivel Medio alto

			RequestAnimSet("move_m@drunk@a")
			SetPedMovementClipset(playerPed, "move_m@drunk@a", true)

			stressOn = true
		elseif stressVal >= 750000 then
			Citizen.Wait(5000)
			ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 0.15) -- Nivel Medio

			ClearTimecycleModifier()

			RequestAnimSet("move_m@drunk@a")
			SetPedMovementClipset(playerPed, "move_m@drunk@a", true)

			stressOn = true
		elseif stressVal >= 700000 then
			Citizen.Wait(6000)
			ShakeGameplayCam('LARGE_EXPLOSION_SHAKE', 0.05) -- Nivel básico de estres

			ClearTimecycleModifier()

			RequestAnimSet("move_m@drunk@a")
			SetPedMovementClipset(playerPed, "move_m@drunk@a", true)

			stressOn = true
		else 

			if stressOn == true then

				local player = PlayerId()

				ClearTimecycleModifier()

				ResetPedMovementClipset(PlayerPedId())
				stressOn = false
			end
			
		end
	end
end)


AddEventHandler('esx_basicneeds:isEating', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('esx_basicneeds:onEat')
AddEventHandler('esx_basicneeds:onEat', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_inteat@burger', function()
				TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:onDrink')
AddEventHandler('esx_basicneeds:onDrink', function(prop_name)
	if not IsAnimated then
		prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true

		Citizen.CreateThread(function()
			local playerPed = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
			local boneIndex = GetPedBoneIndex(playerPed, 18905)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

			ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
				TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

				Citizen.Wait(3000)
				IsAnimated = false
				ClearPedSecondaryTask(playerPed)
				DeleteObject(prop)
			end)
		end)

	end
end)

RegisterNetEvent('esx_basicneeds:OnSmokeCigarett')
AddEventHandler('esx_basicneeds:OnSmokeCigarett', function()
	
	prop_name = prop_name or 'ng_proc_cigarette01a' ---used cigarett prop for now. Tired of trying to place object.
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped, true))
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
	local boneIndex = GetPedBoneIndex(ped, 64017)
	
	

    if not IsEntityPlayingAnim(ped, "amb@world_human_smoking@male@male_b@idle_a", "idle_a", 3) then
        RequestAnimDict("amb@world_human_smoking@male@male_b@idle_a")
        while not HasAnimDictLoaded("amb@world_human_smoking@male@male_b@idle_a") do
            Citizen.Wait(100)
        end

		Wait(100)
		AttachEntityToEntity(prop, ped, boneIndex, 0.015, 0.0100, 0.0250, 0.024, -100.0, 40.0, true, true, false, true, 1, true)
        TaskPlayAnim(ped, 'amb@world_human_smoking@male@male_b@idle_a', 'idle_a', 8.0, 8.0, -1, 49, 0, 0, 0, 0)
		Wait(2000)
	
        while IsEntityPlayingAnim(ped, "amb@world_human_smoking@male@male_b@idle_a", "idle_a", 3) do
            Wait(1)
			if IsControlPressed(0, 73) then
				
				Citizen.Wait(3000)--5 secondes				
				ClearPedSecondaryTask(ped)
				DeleteObject(prop)
				 
            end
        end
    end
end)

RegisterNetEvent('esx_basicneeds:onDrinkAlcohol')
AddEventHandler('esx_basicneeds:onDrinkAlcohol', function()
  
  local playerPed = GetPlayerPed(-1)
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(playerPed)

end)

RegisterNetEvent('esx_basicneeds:removeStress')
AddEventHandler('esx_basicneeds:removeStress', function()
	ESX.ShowNotification(_U('down_level'))
end)

-- Arnedo5 | Adrenaline
RegisterNetEvent("esx_basicneeds:onAdrenaline")
AddEventHandler("esx_basicneeds:onAdrenaline", function()

    local lib, anim = 'fbi_3_int-0', 'cs_fib3_syringe-0'  -- animación de uso 
	local playerPed = PlayerPedId()
	
    ESX.Streaming.RequestAnimDict(lib, function()
        --TaskPlayAnim(playerPed, lib, anim, 8.0, 8.0, -1, 0, 0, false, false, false)
        Citizen.Wait(500)
        while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
            Citizen.Wait(0)
            DisableAllControlActions(0)
        end
        TriggerEvent('esx_basicneeds:adrenaline') -- below effect
    end)
end)

-- Arnedo5 | Gas Mask
local durDmg = false

RegisterNetEvent("esx_basicneeds:onGasMask")
AddEventHandler("esx_basicneeds:onGasMask", function()


	inGasMask = not inGasMask
	local playerPed = GetPlayerPed(-1)


		if inGasMask then
			RequestAnimDict("clothingspecs")
			while not HasAnimDictLoaded("clothingspecs") do
				Citizen.Wait(100)
			end
			ClearPedTasks(playerPed)
			Citizen.Wait(200)
			SetEntityHeading(playerPed, 177.48)
			TaskPlayAnim(playerPed, "clothingspecs", "put_on", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0) -- Sorry couldn't find a better anim // Daha iyi animasyon bulamadım
			Citizen.Wait(2000)
			SetPedPropIndex(playerPed, 1, 26, 7, true)

			hasMask = true
		else
			ClearPedTasks(playerPed)
			ClearAllPedProps(playerPed)	
		end


		--ESX.ShowNotification(_U('cancel_use_gas_mask'))

	

end)



-------------EFEKTLER---------------
local hizliKos = false -- ¿Velocidad rápida?
local yavasKos = false -- ¿Correr lento?

Citizen.CreateThread(function()           -- Comprobar si la ejecución lenta está activada
    while true do
      Citizen.Wait(16)
      if yavasKos then
        SetPedMoveRateOverride(PlayerPedId(), 0.9) -- you can edit this ratio : values above 1.0 make charater move faster / values belowe 1.0 make charater slower / 1.0 is default speed - This makes characters movement faster, which means even your walking speed
      end
      if hizliKos then
        SetPedMoveRateOverride(PlayerPedId(), 1.015) -- you can edit this ratio : values above 1.0 make charater move faster / values belowe 1.0 make charater slower / 1.0 is default speed - This makes characters movement faster, which means even your walking speed
      end
    end
  end)

--Agresif ve Sınırsız Stamina
RegisterNetEvent("esx_basicneeds:adrenaline")
AddEventHandler("esx_basicneeds:adrenaline", function()
    local count = 0

    Citizen.Wait(1000)
    SetPedMotionBlur(GetPlayerPed(-1), true) -- Adds very little blur effect
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    SetTimecycleModifier("underwater_deep")  -- Display filter to make it funnier and realistic
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.35)   -- This ratio is for sprinting speed not movement speed so it will only effective when your character sprints, max is 1.49 / aboe 1.49 won't effect speed
    hizliKos = true  -- activites fast movement (not sprinting speed but overall speed)

    DoScreenFadeIn(1000)
	repeat  -- Start of the cycle
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.3)   -- Shaking cam effect
    RestorePlayerStamina(PlayerId(), 1.0)   -- This is for resetting stamina
    Citizen.Wait(2000)
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.3)
    Citizen.Wait(2000)
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.3)
    Citizen.Wait(2000)
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.3)
    Citizen.Wait(2000)
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.3)
    Citizen.Wait(2000)
		count = count  + 1
	until count == 15  -- One cycle takes 10 seconds, if you put 15 in this value adrenaline effect will take 150 seconds
    hizliKos = false  -- deactivates speed
    DoScreenFadeOut(1000)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    ClearTimecycleModifier() -- clears display filter
    SetRunSprintMultiplierForPlayer(PlayerId(),1.0) -- sets sprint speed to defualt
    SetPedMotionBlur(GetPlayerPed(-1), false) -- removes blur
    count = 0  -- sets cylce count to 0 for next usage
    ESX.ShowNotification('Disminuyes la velocidad y te cansas ...') -- sends notification when effect is over // English : "You are exhausted, slowing down..."
    yavasKos = true  -- sets speed to very slow to animiate exhausting effect
    Citizen.Wait(30000)  -- this values determines how long the exhausting effect // value is in miliseconds
    yavasKos = false -- removes slow speed
	ESX.ShowNotification('Se te han pasado los efectos ...') -- show notification that you are now feeling okay // English : "You are feeling okay."
	
	-- Añadimos 30 stress
	UpStress(300000)
end)

-- Derath - Arnedo5 - Alcohol system
function Drunk(level, start)

	Citizen.CreateThread(function()

		local playerPed = GetPlayerPed(-1)

		if start then
		DoScreenFadeOut(800)
		Wait(1000)
		end

		if level == 0 then

		RequestAnimSet("move_m@drunk@slightlydrunk")
		
		while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
			Citizen.Wait(0)
		end

		SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)

		elseif level == 1 then

		RequestAnimSet("move_m@drunk@moderatedrunk")
		
		while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
			Citizen.Wait(0)
		end

		SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)

		elseif level == 2 then

		RequestAnimSet("move_m@drunk@verydrunk")
		
		while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
			Citizen.Wait(0)
		end

		SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)

		end

		SetTimecycleModifier("spectator5")
		SetPedMotionBlur(playerPed, true)
		SetPedIsDrunk(playerPed, true)

		if start then
		DoScreenFadeIn(800)
		end

	end)

end

function Reality()

	Citizen.CreateThread(function()
  
	  local playerPed = GetPlayerPed(-1)
  
	  DoScreenFadeOut(800)
	  Wait(1000)
  
	  ClearTimecycleModifier()
	  ResetScenarioTypesEnabled()
	  ResetPedMovementClipset(playerPed, 0)
	  SetPedIsDrunk(playerPed, false)
	  SetPedMotionBlur(playerPed, false)
  
	  DoScreenFadeIn(800)
  
	end)
  
end

function UpStress(level) 
	TriggerEvent('esx_status:add', 'stress', level)
	--ESX.ShowNotification(_U('up_level'))

	--TriggerEvent('dmpemotes:emote', "facepalm")

	--Citizen.Wait(3850)

	--TriggerEvent('dmpemotes:cancel')
end


-- Mostrar Zonas de Venta [For Deevs]
Citizen.CreateThread(function()

	if Config.EnableBlipCircle == true then

		for k,zone in pairs(Config.Zones) do
		CreateBlipCircle(zone.Coords, k, zone.Dist, 24, 120)
		end

	end
end)

function CreateBlipCircle(coords, text, radius, color, sprite)
	local blip = AddBlipForRadius(coords, radius)

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 5)
	SetBlipAlpha (blip, 128)

	-- create a blip in the middle
	blip = AddBlipForCoord(coords)

	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)

end

