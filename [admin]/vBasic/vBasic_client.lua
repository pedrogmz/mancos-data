cars_blacklist = {
	"akula",
	"alphaz1",
	"annihilator",
	"apc",
	"avenger",
	"avenger2",
	"barrage",
	"besra",
	"blazer5",
	"blimp",
	"blimp2",
	"bombushka",
	"buzzard",
	"caracara",
	"cargobob",
	"cargobob2",
	"cargobob3",
	"cargobob4",
	"cargoplane",
	"cerberus",
	"cerberus2",
	"cerberus3",
	"chernobog",
	"deluxo",
	"halftrack",
	"howard",
	"hunter",
	"hydra",
	"insurgent",
	"insurgent2",
	"insurgent3",
	"jet",
	"khanjali",
	"lazer",
	"menacer",
	"molotok",
	"nokota",
	"oppressor",
	"oppressor2",
	"rhino",
	"rogue",
	"ruiner2",
	"savage",
	"scramjet",
	"skylift",
	"starling",
	"strikeforce",
	"tampa3",
	"technical",
	"technical2",
	"technical3",
	"titan",
	"trailersmall",
	"trailersmall2",
	"tula",
	"vigilante",
	"volatol",
	"voltic2",
	"ghispo2",
	"srt8police",
	"inem_vwcrafter",
	"2015polstang",
	"priustaxi"
} 

Citizen.CreateThread(function()
	while true do
		SetVehicleDensityMultiplierThisFrame(0.0)
		SetPedDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		
		local playerPed = GetPlayerPed(-1)
		local pos = GetEntityCoords(playerPed) 
		RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
		
		SetGarbageTrucks(0)
		SetRandomBoats(0)
		
		EnableDispatchService(1,false)
		EnableDispatchService(2,false)
		EnableDispatchService(3,false)
		EnableDispatchService(4,false)
		EnableDispatchService(5,false)
		EnableDispatchService(6,false)
		EnableDispatchService(7,false)
		EnableDispatchService(8,false)
		EnableDispatchService(9,false)
		EnableDispatchService(10,false)
		EnableDispatchService(11,false)
		EnableDispatchService(12,false)
		EnableDispatchService(13,false)
		EnableDispatchService(14,false)
		EnableDispatchService(15,false)
		SetWeaponDrops()
		Citizen.Wait(1)
	end
end)

-- Borrar NPCs sacados por programas de terceros
Citizen.CreateThread(function()
	while true do
		local handle, ped = FindFirstPed()
		local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
		repeat
			if not IsPedAPlayer(ped) then
				SetEntityAsMissionEntity(ped,true,true)
				SetEntityAsNoLongerNeeded(ped)
				model = GetEntityModel(ped)
				SetModelAsNoLongerNeeded(model)
				SetEntityAsMissionEntity(ped,true,true)
				DeleteEntity(ped)
			end
			finished, ped = FindNextPed(handle) -- first param returns true while entities are found
			if not IsPedAPlayer(ped) then
				SetEntityAsMissionEntity(ped,true,true)
				SetEntityAsNoLongerNeeded(ped)
				model = GetEntityModel(ped)
				SetModelAsNoLongerNeeded(model)
				SetEntityAsMissionEntity(ped,true,true)
				DeleteEntity(ped)
			end
		until not finished
		EndFindPed(handle)
		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		local handle, veh = FindFirstVehicle()
		local finished = false -- FindNextPed will turn the first variable to false when it fails to find another ped in the index
		repeat
			model = GetEntityModel(veh)
			if isCarBlacklisted(model) then
				SetEntityAsNoLongerNeeded(veh)
				SetModelAsNoLongerNeeded(model)
				SetEntityAsMissionEntity(veh,true,true)
				DeleteEntity(veh)
			end
			local finished, veh = FindNextVehicle(handle) -- first param returns true while entities are found
			model = GetEntityModel(veh)
			if isCarBlacklisted(model) then
				SetEntityAsMissionEntity(veh,true,true)
				SetEntityAsNoLongerNeeded(veh)
				SetModelAsNoLongerNeeded(model)
				SetEntityAsMissionEntity(veh,true,true)
				DeleteEntity(veh)
			end
		until not finished
		EndFindVehicle(handle)
		Citizen.Wait(1000)
	end
end)

--https://github.com/HackerGeo-sp1ne/HG_AntiCheat/blob/master/client.lua

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(cars_blacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end

--https://raw.githubusercontent.com/ESX-PUBLIC/ESX-Snippet/master/gameplay/NoMoreWeaponsOnNPC.lua

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

