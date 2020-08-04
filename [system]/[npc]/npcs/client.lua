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

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        SetWeaponDrops()
		RemoveAllPickupsOfType(0xDF711959)
		RemoveAllPickupsOfType(0xF9AFB48F)
		RemoveAllPickupsOfType(0xA9355DCD)
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
	local iPlayer = GetEntityCoords(PlayerPedId())
	local iPlayerID = GetPlayerServerId()
	
	DisablePlayerVehicleRewards(iPlayerID)
	
	while true do
		Citizen.Wait(1)
		for i = 0, 15 do
			EnableDispatchService(i, Config.Dispatch)
		end			
		SetVehicleDensityMultiplierThisFrame(0.4)
		SetPedDensityMultiplierThisFrame(0.7)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.4, 0.4)
		ClearAreaOfCops(iPlayer.x, iPlayer.y, iPlayer.z, 5000.0)
		--ClearAreaOfVehicles(iPlayer.x, iPlayer.y, iPlayer.z, 1000, false, false, false, false, false)
		--RemoveVehiclesFromGeneratorsInArea(iPlayer.x - 500.0, iPlayer.y - 500.0, iPlayer.z - 500.0, iPlayer.x + 500.0, iPlayer.y + 500.0, iPlayer.z + 500.0);
		SetGarbageTrucks(0)
		SetRandomBoats(0)
	end
end)
