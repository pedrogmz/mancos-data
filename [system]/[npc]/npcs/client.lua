-- Remove weapon drops on NPC death
local pedindex = {}

function SetWeaponDrops() -- This function will set the closest entity to you as the variable entity.
    local handle, ped = FindFirstPed()
    local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
    repeat 
        if not IsEntityDead(ped) then
			pedindex[ped] = {}
        end
        finished, ped = FindNextPed(handle) -- first param returns true while entities are found
    until not finished
    EndFindPed(handle)

    for peds,_ in pairs(pedindex) do
        if peds ~= nil then -- set all peds to not drop weapons on death.
            SetPedDropsWeaponsWhenDead(peds, false) 
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetWeaponDrops()
		RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
		RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
		RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
    end
end)

-- Set relations
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_HILLBILLY"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_BALLAS"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("AMBIENT_GANG_MEXICAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("FIREMAN"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("MEDIC"), GetHashKey('PLAYER'))
SetRelationshipBetweenGroups(1, GetHashKey("COP"), GetHashKey('PLAYER'))

-- Remove vehicles and NPC from map
Citizen.CreateThread(function()
	local iPlayer = GetEntityCoords(PlayerPedId())	-- Your Ped as an Entity. Vector3 (x,y,z)
	local iPlayerID = GetPlayerServerId()			-- Your Ped's ID.
	
	DisablePlayerVehicleRewards(iPlayerID)		-- Call it once.
	
	while true do				-- Call it all...
		Citizen.Wait(1)							-- Every Frame!
		for i = 0, 15 do						-- For all gangs and emergancy services.	
			EnableDispatchService(i, Config.Dispatch)		-- Disable responding/dispatch.
		end			
		SetVehicleDensityMultiplierThisFrame(0.0)
		SetPedDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0)
		ClearAreaOfCops(iPlayer.x, iPlayer.y, iPlayer.z, 5000.0)
		ClearAreaOfVehicles(iPlayer.x, iPlayer.y, iPlayer.z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(iPlayer.x - 500.0, iPlayer.y - 500.0, iPlayer.z - 500.0, iPlayer.x + 500.0, iPlayer.y + 500.0, iPlayer.z + 500.0);
		SetGarbageTrucks(0)
		SetRandomBoats(0)
	end
end)
