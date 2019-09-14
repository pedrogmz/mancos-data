local policeDog = false
ESX = nil
local PlayerData = {}
local spawned_ped = nil

local searching = false

Citizen.CreateThread(function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    PlayerData = ESX.GetPlayerData()
    if Config.Command then
        RegisterCommand(Config.Command, function()
            TriggerEvent('esx_policedog:openMenu')
        end)
    end
    while true do
        local sleep = 250
        if DoesEntityExist(policeDog) then
            sleep = 0
            if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) >= Config.TpDistance and not IsEntityPlayingAnim(policeDog, Config.Sit.dict, Config.Sit.anim, 3) then
                SetEntityCoords(policeDog, GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -1.0, -0.98))
            end
            if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) >= 3.0 and not IsEntityPlayingAnim(policeDog, Config.Sit.dict, Config.Sit.anim, 3) and IsPedStill(policeDog) then
                TaskGoToCoordAnyMeans(policeDog, GetEntityCoords(PlayerPedId()), 5.0, 0, 0, 786603, 0xbf800000)
                sleep = 500
            end
        end
        Wait(sleep)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent('esx_policedog:openMenu')
AddEventHandler('esx_policedog:openMenu', function()
    mainMenu()
end)

RegisterNetEvent('esx_policedog:hasDrugs')
AddEventHandler('esx_policedog:hasDrugs', function(hadIt)
    if hadIt then
        ESX.ShowNotification(Strings['drugs_found'])
        loadDict('missfra0_chop_find')
        TaskPlayAnim(policeDog, 'missfra0_chop_find', 'chop_bark_at_ballas', 8.0, -8, -1, 0, 0, false, false, false)
    else
        ESX.ShowNotification(Strings['no_drugs'])
    end
end)

-- Gets Local Ped
function GetLocalPed()
    return GetPlayerPed(PlayerId())
end

-- Gets Vehicle Ahead Of Player
function GetVehicleAheadOfPlayer()
    local lPed = GetLocalPed()
    local lPedCoords = GetEntityCoords(lPed, alive)
    local lPedOffset = GetOffsetFromEntityInWorldCoords(lPed, 0.0, 3.0, 0.0)
    local rayHandle = StartShapeTestCapsule(lPedCoords.x, lPedCoords.y, lPedCoords.z, lPedOffset.x, lPedOffset.y, lPedOffset.z, 1.2, 10, lPed, 7)
    local returnValue, hit, endcoords, surface, vehicle = GetShapeTestResult(rayHandle)

    if hit then
        return vehicle
    else
        return false
    end
end

-- Gets Closest Door To Player
function GetClosestVehicleDoor(vehicle)
    local plyCoords = GetEntityCoords(GetLocalPed(), false)
	local backleft = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_dside_r"))
	local backright = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_pside_r"))
	local bldistance = GetDistanceBetweenCoords(backleft['x'], backleft['y'], backleft['z'], plyCoords.x, plyCoords.y, plyCoords.z, 1)
    local brdistance = GetDistanceBetweenCoords(backright['x'], backright['y'], backright['z'], plyCoords.x, plyCoords.y, plyCoords.z, 1)

    local found_door = false

    if (bldistance < brdistance) then
        found_door = 1
    elseif(brdistance < bldistance) then
        found_door = 2
    end

    return found_door
end

-- Toggles Dog In and Out of Vehicles
RegisterNetEvent("esx_policedog:ToggleVehicle")
 AddEventHandler("esx_policedog:ToggleVehicle", function(isRestricted, vehList)
    if not searching then
        if IsPedInAnyVehicle(policeDog, false) then
                TaskLeaveVehicle(policeDog, GetVehiclePedIsIn(policeDog, false), 256)
                --Notification(tostring(k9_name .. " " .. language.exit))
            else
                if not IsPedInAnyVehicle(playerPed, true) then
                    local plyCoords = GetEntityCoords(GetLocalPed(), false)
                    local vehicle = GetVehicleAheadOfPlayer()
                    local door = GetClosestVehicleDoor(vehicle)
                    if door ~= false then
                        if isRestricted then
                            if CheckVehicleRestriction(vehicle, vehList) then
                                TaskEnterVehicle(policeDog, vehicle, -1, door, 2.0, 1, 0)
                                --Notification(tostring(k9_name .. " " .. language.enter))
                            end
                        else
                            TaskEnterVehicle(policeDog, vehicle, -1, door, 2.0, 1, 0)
                            --Notification(tostring(k9_name .. " " .. language.enter))
                        end
                    end
                else
                    local vehicle = GetVehiclePedIsIn(playerPed, true)
                    local door = 1
                    if isRestricted then
                        if CheckVehicleRestriction(vehicle, vehList) then
                            TaskEnterVehicle(policeDog, vehicle, -1, door, 2.0, 1, 0)
                            --Notification(tostring(k9_name .. " " .. language.enter))
                        end
                    else
                        TaskEnterVehicle(policeDog, vehicle, -1, door, 2.0, 1, 0)
                        --Notification(tostring(k9_name .. " " .. language.enter))
                    end
                end
            end
        end
    end)

mainMenu = function()
    if PlayerData.job.name == Config.Job then
        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'buy_storage',
            {
                title = Strings['menu_title'],
                align = 'top-left',
                elements = {{label = Strings['take_out_remove'], value = 'take_out_remove'}, {label = Strings['sit_stand'], value = 'sit_stand'}, {label = Strings['search_drugs'], value = 'search_drugs'}, {label = Strings['attack_closest'], value = 'attack_closest'}, {label = Strings['toggle_vehicle'], value = 'toggle_vehicle'}}
            },
            function(data, menu)
                if data.current.value == 'take_out_remove' then
                    if not DoesEntityExist(policeDog) then
                        RequestModel(Config.Model)
                        while not HasModelLoaded(Config.Model) do Wait(0) end
                        policeDog = CreatePed(4, Config.Model, GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, -0.98), 0.0, true, false)
                        SetEntityAsMissionEntity(policeDog, true, true)
                        ESX.ShowNotification(Strings['spawned_dog'])
                    else
                        ESX.ShowNotification(Strings['deleted_dog'])
                        DeleteEntity(policeDog)
                    end
                elseif data.current.value == 'attack_closest' then
                    if DoesEntityExist(policeDog) then
                        if not IsPedDeadOrDying(policeDog) then
                            if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                                local player, distance = ESX.Game.GetClosestPlayer()
                                if distance ~= -1 then
                                    if distance <= 3.0 then
                                        local playerPed = GetPlayerPed(player)
                                        if not IsPedInCombat(policeDog, playerPed) then
                                            if not IsPedInAnyVehicle(playerPed, true) then
                                                TaskCombatPed(policeDog, playerPed, 0, 16)
                                            end
                                        else
                                            ClearPedTasksImmediately(policeDog)
                                        end
                                    end
                                end
                            end
                        else
                            ESX.ShowNotification(Strings['dog_dead'])
                        end
                    else
                        ESX.ShowNotification(Strings['no_dog'])
                    end
                elseif data.current.value == 'sit_stand' then
                    if DoesEntityExist(policeDog) then
                        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(policeDog), true) <= 5.0 then
                            if IsEntityPlayingAnim(policeDog, Config.Sit.dict, Config.Sit.anim, 3) then
                                ClearPedTasks(policeDog)
                            else
                                loadDict('rcmnigel1c')
                                TaskPlayAnim(PlayerPedId(), 'rcmnigel1c', 'hailing_whistle_waive_a', 8.0, -8, -1, 120, 0, false, false, false)
                                Wait(2000)
                                loadDict(Config.Sit.dict)
                                TaskPlayAnim(policeDog, Config.Sit.dict, Config.Sit.anim, 8.0, -8, -1, 1, 0, false, false, false)
                            end
                        else
                            ESX.ShowNotification(Strings['dog_too_far'])
                        end
                    else
                        ESX.ShowNotification(Strings['no_dog'])
                    end
				elseif data.current.value == 'toggle_vehicle' then
					--if DoesEntityExist(policeDog) then
						--if not IsPedDeadOrDying(policeDog) then
					--test
						--end
						TriggerServerEvent("esx_policedog:RequestVehicleToggle")
					--end
                elseif data.current.value == 'search_drugs' then
                    if DoesEntityExist(policeDog) then
                        if not IsPedDeadOrDying(policeDog) then
                            if GetDistanceBetweenCoords(GetEntityCoords(policeDog), GetEntityCoords(PlayerPedId()), true) <= 3.0 then
                                local player, distance = ESX.Game.GetClosestPlayer()
                                if distance ~= -1 then
                                    if distance <= 3.0 then
                                        local playerPed = GetPlayerPed(player)
                                        if not IsPedInAnyVehicle(playerPed, true) then
                                            TriggerServerEvent('esx_policedog:hasClosestDrugs', GetPlayerServerId(player))
                                        end
                                    end
                                end
                            end
                        else
                            ESX.ShowNotification(Strings['dog_dead'])
                        end
                    else
                        ESX.ShowNotification(Strings['no_dog'])
                    end
                end
            end,
        function(data, menu)
            menu.close()
        end)
    else
        ESX.ShowNotification(Strings['not_police'])
    end
end

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end