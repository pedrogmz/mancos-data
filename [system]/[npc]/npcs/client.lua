-- Remove weapon drops on NPC death
local pedindex = {}

function SetWeaponDrops()
    local handle, ped = FindFirstPed()
    local finished = false
    repeat 
        if not IsEntityDead(ped) then
			pedindex[ped] = {}
        end
        finished, ped = FindNextPed(handle)
    until not finished
    EndFindPed(handle)

    for peds,_ in pairs(pedindex) do
        if peds ~= nil then 
            SetPedDropsWeaponsWhenDead(peds, false) 
        end
    end
end

-- Set relations
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))

--	  LosOceanic_TA =  Traffic / Pedestrian / Parked Cars Adjuster		--
--	Every 5 Minutes, count player total and update the calculation		--
--		By DK - 2019...	Dont forget your Bananas!			--
------------------------------------------------------------------------------
------------------------------------------------------------------------------

-- The math is, (( Config.PopulationNumber - (Config.Players * 2.25 )) / Config.1000)  =  0.3880 or less
-- The deal is to reduce the overal feel of the city as the player population is introduced.
		
-- The natives take a .0 as nothing, 1 as normal, 2 as doubled etc value. 
-- So why not make it like 0.10 @ 128 Players??

------------------------------------------------------------------------------
-- Threads														--
------------------------------------------------------------------------------

Citizen.CreateThread(function()
	local iPlayer = GetEntityCoords(PlayerPedId())	-- Your Ped as an Entity. Vector3 (x,y,z)
	local iPlayerID = GetPlayerServerId()			-- Your Ped's ID.
	
	DisablePlayerVehicleRewards(iPlayerID)		-- Call it once.
	
	while true do				-- Call it all...
		
		for i = 0, 15 do						-- For all gangs and emergancy services.	
			EnableDispatchService(i, Config.Dispatch)		-- Disable responding/dispatch.
		end

		---local npcDensity = (Config.TrafficX - Config.iPlayers) / Config.Divider

		local npcDensity = (Config.TrafficX - Config.iPlayers) / Config.Divider

		--if NetworkIsHost() then
			--SetVehicleDensityMultiplierThisFrame((Config.TrafficX - Config.iPlayers) / Config.Divider)
			--SetPedDensityMultiplierThisFrame(npcDensity)
			--SetRandomVehicleDensityMultiplierThisFrame((Config.TrafficX - Config.iPlayers) / Config.Divider)
			--SetParkedVehicleDensityMultiplierThisFrame(0.0)
			--SetScenarioPedDensityMultiplierThisFrame(npcDensity, npcDensity)
		--else
			
		--end
		
		SetPedDensityMultiplierThisFrame(0.0)
			SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
			SetVehicleDensityMultiplierThisFrame(0.0)
			SetRandomVehicleDensityMultiplierThisFrame(0.0)
			SetParkedVehicleDensityMultiplierThisFrame(0.0)

		ClearAreaOfCops(iPlayer.x, iPlayer.y, iPlayer.z, 5000.0)
		SetCreateRandomCops(false) -- disable random cops walking/driving around.
		SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
		SetCreateRandomCopsOnScenarios(false) -- stop random cops (in a scenario) from spawning.
		RemoveVehiclesFromGeneratorsInArea(iPlayer.x - 500.0, iPlayer.y - 500.0, iPlayer.z - 500.0, iPlayer.x + 500.0, iPlayer.y + 500.0, iPlayer.z + 500.0);
		--SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
		SetGarbageTrucks(0)
		SetRandomBoats(0)

		SetWeaponDrops()
		RemoveAllPickupsOfType(0xDF711959)
		RemoveAllPickupsOfType(0xF9AFB48F)
		RemoveAllPickupsOfType(0xA9355DCD)

		--print('npcs density changed: ' .. npcDensity)

		Citizen.Wait(0)							-- Every Frame!
	end
end)

Citizen.CreateThread(function()
    while true do
		Config.Switch = false
		local Multiplier = 0		-- Player Count.

		for _,i in ipairs(GetActivePlayers()) do
			local iPed = GetPlayerPed(i)

			if DoesEntityExist(iPed) then
				Multiplier = Multiplier + 1
			end
		end
			
		if Multiplier ~= 0 then
			Config.iPlayers = Config.Static * Multiplier
		end	

		Wait(100)
		Config.Switch = true
		
		--print('player counted: '.. Config.iPlayers)
		--Citizen.Wait(5000)
	end
end)
