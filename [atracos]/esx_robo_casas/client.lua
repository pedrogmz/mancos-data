ESX                           = nil
local ESXLoaded = false
local hacha = GetHashKey("WEAPON_HATCHET")
local palanca = GetHashKey("WEAPON_CROWBAR")
local bate = GetHashKey("WEAPON_BAT")
local PlayerData = {}

blip = nil
blips = {}
displayTime = 300 --- Tiempo en segundos del blip
Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
    
    ESXLoaded = true
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('loffe_burglary:setFrozen')
AddEventHandler('loffe_burglary:setFrozen', function(house, status)
    Config.Burglary[house].Door.Frozen = status
    local door = GetClosestObjectOfType(Config.Burglary[house].Door.Coords, 2.0, GetHashKey(Config.Burglary[house].Door.Object), false, 0, 0)
    FreezeEntityPosition(door, status)
end)

RegisterNetEvent('loffe_burglary:setHealth')
AddEventHandler('loffe_burglary:setHealth', function(house, health)
    Config.Burglary[house].Door.Health = health
    local door = GetClosestObjectOfType(Config.Burglary[house].Door.Coords, 2.0, GetHashKey(Config.Burglary[house].Door.Object), false, 0, 0)
    SetEntityHealth(door, health)
end)

RegisterNetEvent('loffe_burglary:text')
AddEventHandler('loffe_burglary:text', function(text, x, y, time)
    drawSub(text, 4, 1, x, y, 0.5, 255, 255, 255, 255, time)
end)

RegisterNetEvent('loffe_burglary:setItems')
AddEventHandler('loffe_burglary:setItems', function(house, furniture, items)
    Config.Burglary[house].MultipleSearch[furniture].Items = items
end)

RegisterNetEvent('loffe_burglary:helpTimed')
AddEventHandler('loffe_burglary:helpTimed', function(text, time)
    local faketimer = time
    while faketimer >= 0 do
        faketimer = faketimer - 1
        Wait(0)
        BeginTextCommandDisplayHelp('STRING')
        AddTextComponentSubstringPlayerName(text)
        EndTextCommandDisplayHelp(0, false, true, -1)
    end
end)

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function drawSub(text,font,centre,x,y,scale,r,g,b,a, time)
	local timesdone = 0
    while timesdone <= time/10 do
        drawTxt(text, font, centre, x, y, scale, r, g, b, a)
		Wait(0)
		timesdone = timesdone + 1
	end
end

Citizen.CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(0)
    end
    while not ESXLoaded do
        Wait(0)
    end
    Wait(50)
    for i = 1, #Config.Burglary do
        ESX.TriggerServerCallback('loffe_burglary:getDoorFreezeStatus', function(frozen)            
            Config.Burglary[i].Door.Frozen = frozen
            local door = GetClosestObjectOfType(Config.Burglary[i].Door.Coords, 2.0, GetHashKey(Config.Burglary[i].Door.Object), false, 0, 0)
            FreezeEntityPosition(door, Config.Burglary[i].Door.Frozen)
        end, i)
        ESX.TriggerServerCallback('loffe_burglary:getDoorHealth', function(health)
            Config.Burglary[i].Door.Health = health
            local door = GetClosestObjectOfType(Config.Burglary[i].Door.Coords, 2.0, GetHashKey(Config.Burglary[i].Door.Object), false, 0, 0)
            SetEntityHealth(door, health)
        end, i)
    end
    while true do
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        for i = 1, #Config.Burglary do
            Wait(0)
            local v = Config.Burglary[i]
            local d = v.Door
            local door = GetClosestObjectOfType(d.Coords, 2.0, GetHashKey(d.Object), false, 0, 0)
            if door ~= nil then
                FreezeEntityPosition(door, d.Frozen)
                if d.Frozen then
                    SetEntityHeading(door, d.Heading)
                end
            end
            if GetDistanceBetweenCoords(coords, d.Coords, true) <= 2.0 and d.Frozen and ESX.PlayerData.job.name ~= 'police' then
                TriggerEvent('loffe_burglary:text', '~r~Puerta~w~: ' .. math.floor(d.Health)/10 .. '%' , 0.5, 0.97, 75)
                if d.Health ~= GetEntityHealth(door) then
                    if GetSelectedPedWeapon(player) == GetHashKey("WEAPON_CROWBAR") or 
		                GetSelectedPedWeapon(player) == GetHashKey("WEAPON_BAT") or
		                GetSelectedPedWeapon(player) == GetHashKey("WEAPON_HATCHET") then
                        TriggerServerEvent('loffe_burglary:setDoorHealth', i, GetEntityHealth(door))
                        if GetEntityHealth(door) <= 0.0 then
                            --TriggerServerEvent('esx_phone:send', 'police', 'Inbrott', true, {x = d.Coords.x, y = d.Coords.y, z = d.Coords.z}, true)
                            --TriggerServerEvent('roboCasaProgressPos', d.Coords.x, d.Coords.y, d.Coords.z)
                            --blipEntornoRoboHouse(d.Coords.x, d.Coords.y, d.Coords.z)

                            -- Arnedo5 | Notify cops
                            TriggerServerEvent('comprobarEntorno', "Alguien ha visto un sujeto intentanto forzar la cerradura de una casa.", d.Coords.x, d.Coords.y, d.Coords.z, "NPC RANDOM")
                            
                            TriggerServerEvent('roboCasaProgress', d.Coords)
                            if v.Type == 'ghetto' then
                                for j = 1, #v.Peds do
                                    print(j)
                                    local randomPed = Config.GhettoPeds[math.random(1, #Config.GhettoPeds)]
                                    RequestModel(randomPed)
                                    while not HasModelLoaded(randomPed) do
                                        Wait(0)
                                    end
                                    local ped = CreatePed(4, randomPed, v.Peds[j], 0.0, true, false)

                                    local randomWeaponChance = math.random(1, 100)
                                    if randomWeaponChance <= Config.WeaponChance then
                                        local randomWeapon = math.random(1, #Config.GhettoWeapons)
                                        GiveWeaponToPed(ped, GetHashKey(Config.GhettoWeapons[randomWeapon]), math.random(1, 5000), false, true)
                                    end

                                    TaskCombatPed(ped, player, 0, 16)
                                    SetEntityAsMissionEntity(ped, true, true)
                                    SetPedHearingRange(ped, 15.0)
                                    SetPedSeeingRange(ped, 15.0)
                                    SetPedAlertness(ped, 15.0)
                                    SetPedFleeAttributes(ped, 0, 0)
                                    SetPedCombatAttributes(ped, 46, true)
                                    SetPedFleeAttributes(ped, 0, 0)

                                end
                            end
                        end
                    else
                        SetEntityHealth(door, d.Health)
                        sendNotification('¡Así nunca vas a romper la puerta!', 'error', 2500)
                    end
                end
                if GetEntityHealth(door) <= 0.0 then
                    TriggerServerEvent('loffe_burglary:setDoorFreezeStatus', i, false)
                end
            elseif ESX.PlayerData.job.name == 'police' and not d.Frozen and GetDistanceBetweenCoords(coords, d.Coords, true) <= 2.0 then
                TriggerEvent('loffe_burglary:helpTimed', '~INPUT_CONTEXT~ Arregla la cerradura', 25)
                if IsControlPressed(0, 38) then
                    local finished = true
                    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                    FreezeEntityPosition(PlayerPedId(), true)
                    for i = 1, 100 do
                        TriggerEvent('loffe_burglary:helpTimed', '~INPUT_JUMP~ Deja de arreglar la cerradura', 250)
                        drawSub('Cambio de cerradura: ~b~' .. i .. '%', 4, 1, 0.5, 0.97, 0.5, 255, 255, 255, 255, 250)
                        if IsControlPressed(0, 22) then
                            ClearPedTasks(PlayerPedId())
                            finished = false
                            break
                        end
                    end
                    FreezeEntityPosition(PlayerPedId(), false)
                    if finished then
                        TriggerServerEvent('loffe_burglary:setDoorFreezeStatus', i, true)
                    end
                    ClearPedTasks(PlayerPedId())
                end
            end
        end
        Wait(50)
    end
end)

Citizen.CreateThread(function()
    while not ESXLoaded do
        Wait(0)
    end
    while true do
        for k, v in pairs(Config.Burglary) do
            for i = 1, #v.MultipleSearch do
                local player = PlayerPedId()
                local coords = GetEntityCoords(player)
                if GetDistanceBetweenCoords(coords, v.MultipleSearch[i].Position, true) <= 1.0 and not v.Door.Frozen then
                    TriggerEvent('loffe_burglary:helpTimed', '~INPUT_CONTEXT~ Buscar en ' .. v.MultipleSearch[i].Name, 25)
                    if IsControlPressed(0, 38) then
                        local elements = {}
                        for j = 1, v.MultipleSearch[i].Items do
                            table.insert(elements, {label = v.MultipleSearch[i].Text .. ' ' .. j, value = j})
                        end
                        local selected = false
                        ESX.UI.Menu.CloseAll()
                        ESX.UI.Menu.Open('default', GetCurrentResourceName(), '_' .. v.MultipleSearch[i].Name,
                        {
                            title    = v.MultipleSearch[i].Name,
                            align    = 'bottom-right',
                            elements = elements
                        }, function(data, menu)
                            selected = true
                            ESX.UI.Menu.CloseAll()
                        end, function(data, menu)
                            menu.close()
                        end)
                        while not selected do
                            if IsControlPressed(0, 177) then
                                break
                            end
                            Wait(0)
                        end
                        if selected and v.MultipleSearch[i].Items >= 1 and GetDistanceBetweenCoords(GetEntityCoords(player), v.MultipleSearch[i].Position, true) <= 1.0 then
                            TriggerServerEvent('loffe_burglary:loot', k, i)
                            SetEntityHeading(player, v.MultipleSearch[i].Heading)
                            FreezeEntityPosition(player, true)
                            TaskStartScenarioInPlace(player, "PROP_HUMAN_BUM_BIN", 0, true)
                            Wait(5000)
                            ClearPedTasks(player)
                            Wait(2500)
                            FreezeEntityPosition(player, false)
                        end
                    end
                end
            end
        end
        Wait(50)
    end
end)

function sendNotification(message, messageType, messageTimeout)
    print(message, messageType, messageTimeout)
    TriggerEvent("pNotify:SendNotification", {
        text = message,
        type = messageType,
        queue = "lmfao",
        timeout = messageTimeout,
        layout = "bottomCenter"
    })
end

Citizen.CreateThread(function ()
    local lockCounter = 0
    local player = PlayerPedId()
    local coords = GetEntityCoords(player)
        for i = 1, #Config.Burglary do
          Wait(0)
           local v = Config.Burglary[i]
           local d = v.Door
           local door = GetClosestObjectOfType(d.Coords, 2.0, GetHashKey(d.Object), false, 0, 0)
                while GetEntityHealth(door) <= 0.0 do
                Wait(5000) --This is where you adjust how long to wait before auto repairing door in miliseconds * 100
                lockCounter = lockCounter + 1
                if lockCounter == 100 then
                TriggerServerEvent('loffe_burglary:setDoorFreezeStatus', i, true)
                lockCounter = 0
            end
    
                end
                end
    
    end)

    -- Entorno a la policia
--GetPlayerName()
RegisterNetEvent('roboHouseEntorno')
AddEventHandler('roboHouseEntorno', function(alert)
		if ESX.PlayerData.job.name ~= nil and ESX.PlayerData.job.name == 'police' then
            Notify(alert)
        end
end)

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

--RegisterNetEvent('roboPlace')
--[[AddEventHandler('roboPlace', 
function blipEntornoRoboHouse(tx, ty, tz)
    print(tx..ty..tz.."coords")
	if ESX.PlayerData.job.name == 'police' then
		local transT = 250
		local Blip = AddBlipForCoord(tx, ty, tz)
		SetBlipSprite(Blip,  10)
		SetBlipColour(Blip,  1)
		SetBlipAlpha(Blip,  transT)
		SetBlipAsShortRange(Blip,  false)
		while transT ~= 0 do
			Wait(blipTime * 4)
			transT = transT - 1
			SetBlipAlpha(Blip,  transT)
			if transT == 0 then
				SetBlipSprite(Blip,  2)
				return
			end
		end
	end
end
]]--
-- BLIP
RegisterNetEvent('roboPlace')
AddEventHandler('roboPlace', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Un suspechoso acaba de romper la puerta de entrada a una casa. ¡Es un ladrón!')
	  EndTextCommandSetBlipName(blipRobbery)
    
    table.insert(blips, blipRobbery)    
    Wait(displayTime * 1000)
    for i, blipRobbery in pairs(blips) do 
      RemoveBlip(blipRobbery)
      
    end
end)