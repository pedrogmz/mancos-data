local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}


--- action functions
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil


--- esx
local GUI = {}
ESX                           = nil
GUI.Time                      = 0
local PlayerData              = {}


Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
    PlayerData = ESX.GetPlayerData()
  end
end)

AddEventHandler("playerSpawned", function()
  
  local playerData = ESX.GetPlayerData()

  if string.match(playerData.job.name, "off") then 

  else -- En caso de estar en servicio volvemos a dejar en fuera de servicio
    TriggerServerEvent('duty:service', playerData.job.name, playerData.job.grade)
  end
 
end)


AddEventHandler('playerDropped', function (reason) -- Arnedo5 | Al desconectarse el usuario
 
  local playerData = ESX.GetPlayerData()

  TriggerServerEvent('duty:service', PlayerData.job.name, PlayerData.job.grade)

  if string.match(playerData.job.name, "off") then 
    
    if (PlayerData.job.name == "offambulance")  then  EndService("ambulance") end
    if (PlayerData.job.name == "offpolice")  then  EndService("police") end
    if (PlayerData.job.name == "offmechanic")  then  EndService("mechanic") end
    if (PlayerData.job.name == "offtaxi")  then  EndService("taxi") end
    if (PlayerData.job.name == "offtender")  then  EndService("tender") end
    if (PlayerData.job.name == "offbar")  then  EndService("bar") end
    if (PlayerData.job.name == "offcardealer")  then  EndService("cardealer") end
    if (PlayerData.job.name == "offbahamas")  then  EndService("bahamas") end

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

----markers
AddEventHandler('esx_duty:hasEnteredMarker', function (zone)
  if zone == 'AmbulanceDuty' then
    CurrentAction     = 'ambulance_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end
  if zone == 'PoliceDuty' then
    CurrentAction     = 'police_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end
  if zone == 'MecanicoDuty' then
    CurrentAction     = 'mechanic_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end
  if zone == 'TaxistaDuty' then
    CurrentAction     = 'taxi_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end
  if zone == 'TenderoDuty' then
    CurrentAction     = 'tendero_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end
  if zone == 'BarmanDuty' then
    CurrentAction     = 'barman_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end
  if zone == 'CardealerDuty' then
    CurrentAction     = 'cardealer_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end
  if zone == 'BahamasDuty' then
    CurrentAction     = 'bahamas_duty'
    CurrentActionMsg  = _U('duty')
    CurrentActionData = {}
  end


  
end)

AddEventHandler('esx_duty:hasExitedMarker', function (zone)
  CurrentAction = nil
end)


--keycontrols
Citizen.CreateThread(function ()
  while true do
    Citizen.Wait(0)

      local playerPed = GetPlayerPed(-1)

    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0, Keys['E']) then

        if CurrentAction == 'ambulance_duty' then
          if PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'offambulance' then
            
            TriggerServerEvent('duty:service', PlayerData.job.name, PlayerData.job.grade)
            --TriggerServerEvent('duty:ambulance')

          if PlayerData.job.name == 'ambulance' then
            sendNotification(_U('offduty'), 'success', 2500)
            EndService('ambulance')
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            EnterService('ambulance')
            Wait(1000)
          end
        else
          sendNotification(_U('notamb'), 'error', 5000)
          Wait(1000)
        end
      end

        if CurrentAction == 'police_duty' then
          if PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' then

            TriggerServerEvent('duty:service', PlayerData.job.name, PlayerData.job.grade)
            --TriggerServerEvent('duty:police')
          if PlayerData.job.name == 'police' then
            sendNotification(_U('offduty'), 'success', 2500)
            EndService('police')
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            EnterService('police')
            Wait(1000)
          end
        else
          sendNotification(_U('notpol'), 'error', 5000)
          Wait(1000)
          end
        end
		
        if CurrentAction == 'mechanic_duty' then
          if PlayerData.job.name == 'mechanic' or PlayerData.job.name == 'offmechanic' then

            TriggerServerEvent('duty:service', PlayerData.job.name, PlayerData.job.grade)
            --TriggerServerEvent('duty:mechanic')
          if PlayerData.job.name == 'mechanic' then
            sendNotification(_U('offduty'), 'success', 2500)
            EndService('mechanic')
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            EnterService('mechanic')
            Wait(1000)
          end
        else
          sendNotification(_U('notmec'), 'error', 5000)
          Wait(1000)
          end
        end
		
        if CurrentAction == 'taxi_duty' then
          if PlayerData.job.name == 'taxi' or PlayerData.job.name == 'offtaxi' then
            TriggerServerEvent('duty:service', PlayerData.job.name, PlayerData.job.grade)
          if PlayerData.job.name == 'taxi' then
            sendNotification(_U('offduty'), 'success', 2500)
            EndService('taxi')
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            EnterService('taxi')
            Wait(1000)
          end
        else
          sendNotification(_U('nottax'), 'error', 5000)
          Wait(1000)
          end
        end

        -- Arnedo5 | Nuevo trabajo [Tendero 247]
        if CurrentAction == 'tendero_duty' then

          local job = PlayerData.job.name
          local grade = PlayerData.job.grade

          if PlayerData.job.name == 'tender' or PlayerData.job.name == 'offtender' then
    
            TriggerServerEvent('duty:service', job, grade)
          if PlayerData.job.name == 'tender' then
            sendNotification(_U('offduty'), 'success', 2500)
            EndService('tender')
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            EnterService('tender')
            Wait(1000)
          end
        else
          sendNotification(_U('notten'), 'error', 5000)
          Wait(1000)
          end
        end

        -- Arnedo5 | Nuevo trabajo [Barman]
        if CurrentAction == 'barman_duty' then

          local job = PlayerData.job.name
          local grade = PlayerData.job.grade

          if PlayerData.job.name == 'bar' or PlayerData.job.name == 'offbar' then

            TriggerServerEvent('duty:service', job, grade)

          if PlayerData.job.name == 'bar' then
            sendNotification(_U('offduty'), 'success', 2500)
            EndService('bar')
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            EnterService('bar')
            Wait(1000)
          end
        else
          sendNotification(_U('notten'), 'error', 5000)
          Wait(1000)
          end
        end

        -- Arnedo5 | Nuevo trabajo [Cardealer]
        if CurrentAction == 'cardealer_duty' then

          local job = PlayerData.job.name
          local grade = PlayerData.job.grade

          if PlayerData.job.name == 'cardealer' or PlayerData.job.name == 'offcardealer' then
    
            TriggerServerEvent('duty:service',  job, grade)

          if PlayerData.job.name == 'cardealer' then
            sendNotification(_U('offduty'), 'success', 2500)
            EndService('cardealer')
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            EnterService('cardealer')
            Wait(1000)
          end
          
        else
          sendNotification(_U('notten'), 'error', 5000)
          Wait(1000)
          end
        end
		
		-- bahamas
		if CurrentAction == 'bahamas_duty' then

          local job = PlayerData.job.name
          local grade = PlayerData.job.grade

          if PlayerData.job.name == 'bahamas' or PlayerData.job.name == 'offbahamas' then

            TriggerServerEvent('duty:service', job, grade)

          if PlayerData.job.name == 'bahamas' then
            sendNotification(_U('offduty'), 'success', 2500)
            EndService('bahamas')
            Wait(1000)
          else
            sendNotification(_U('onduty'), 'success', 2500)
            EnterService('bahamas')
            Wait(1000)
          end
        else
          sendNotification(_U('notbah'), 'error', 5000)
          Wait(1000)
          end
        end

      end
    end
  end       
end)

-- Arnedo5 IN service OUT service notification
function EnterService (job) 

  ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)

    local notification = {
      title    = _U('service_anonunce'),
      subject  = '',
      msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
      iconType = 1
    }

    TriggerServerEvent('esx_service:notifyAllInService', notification, job)
    ESX.ShowNotification(_U('service_in'))

  end, job)
end

function EndService (job) 

	local notification = {
    title    = _U('service_anonunce'),
    subject  = '',
    msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
    iconType = 1
  }

  TriggerServerEvent('esx_service:notifyAllInService', notification, job)

  TriggerServerEvent('esx_service:disableService', job)
  ESX.ShowNotification(_U('service_out'))
end


-- Display markers
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords = GetEntityCoords(GetPlayerPed(-1))

    for k,v in pairs(Config.Zones) do
      if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
        DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
      end
    end
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
  while true do
    Wait(0)

    local coords      = GetEntityCoords(GetPlayerPed(-1))
    local isInMarker  = false
    local currentZone = nil

    for k,v in pairs(Config.Zones) do
      if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
        isInMarker  = true
        currentZone = k
      end
    end

    if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
      HasAlreadyEnteredMarker = true
      LastZone                = currentZone
      TriggerEvent('esx_duty:hasEnteredMarker', currentZone)
    end

    if not isInMarker and HasAlreadyEnteredMarker then
      HasAlreadyEnteredMarker = false
      TriggerEvent('esx_duty:hasExitedMarker', LastZone)
    end
  end
end)

--notification
function sendNotification(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "duty",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end