-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFM = MF_MobileMeth
local stressVal = 0

function MFM:Awake(...)
  while not ESX do Citizen.Wait(0); end
  while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
  RequestStreamedTextureDict("commonmenu",true)
  self.PlayerData = ESX.GetPlayerData()
  ESX.TriggerServerCallback('MF_MobileMeth:GetStartData', function(retVal) self.dS = true; self.cS = retVal; self:Start(); end)
end

function MFM:Start(...)
  while not ESX do Citizen.Wait(0); end
  while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
  self.PoliceCount = self.PoliceCount or 0
  if self.ShowBlip then self:DoBlips(); end
  if self.dS and self.cS then self:Update(); end
end

function MFM:DoBlips()
  local blip = AddBlipForCoord(self.HintLocation.x, self.HintLocation.y, self.HintLocation.z)
  SetBlipSprite               (blip, 205)
  SetBlipDisplay              (blip, 3)
  SetBlipScale                (blip, 1.0)
  SetBlipColour               (blip, 4)
  SetBlipAsShortRange         (blip, false)
  SetBlipHighDetail           (blip, true)
  BeginTextCommandSetBlipName ("STRING")
  AddTextComponentString      ("Callejon Sombreado")
  EndTextCommandSetBlipName   (blip)
end

function MFM:Update(...)
  local noteTemplate = Utils.DrawTextTemplate()
  noteTemplate.x = 0.5
  noteTemplate.y = 0.5
  local timer = 0
  while self.dS and self.cS do
    Citizen.Wait(0)
    local plyPed = GetPlayerPed(-1)
    local plyPos = GetEntityCoords(plyPed)
    if not self.MissionStarted then
      local dist = Utils.GetVecDist(plyPos, self.HintLocation)
      if dist < self.DrawTextDist then
        local p = self.HintLocation
        Utils.DrawText3D(p.x,p.y,p.z, "[~g~E~s~] para buscar ~y~drogas~w~")
        if IsControlJustPressed(0, Keys["E"]) and GetGameTimer() - timer > 150 then    
          ESX.TriggerServerCallback('MF_MobileMeth:GetCops',function(count)
            if count and count >= self.MinPolCount then 
              timer = GetGameTimer()
              TaskGoStraightToCoord(plyPed, p.x, p.y, p.z, 10.0, 10, p.w, 0.5)
              Wait(3000)
              ClearPedTasksImmediately(plyPed)

              while not HasAnimDictLoaded("anim@heists@prison_heiststation@cop_reactions") do RequestAnimDict("anim@heists@prison_heiststation@cop_reactions"); Citizen.Wait(0); end
              TaskPlayAnim( plyPed, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 8.0, 8.0, -1, 4, 0, 0, 0, 0 )     
              Citizen.Wait(0)
              while IsEntityPlayingAnim(plyPed, "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", 3) do Citizen.Wait(0); end          

              Citizen.Wait(1000)

              TriggerEvent('chat:addMessage', {color = { 255, 0, 0}, multiline = true, args = {"Deep Web", "¡Has visto una web donde enseñan a fabricar Meta."}})
              ClearPedTasksImmediately(plyPed)

              local randNum = math.random(1,#self.TruckLocations)
              local spawnLoc = self.TruckLocations[randNum]
              local nearStreet = GetStreetNameFromHashKey(GetStreetNameAtCoord(spawnLoc.x,spawnLoc.y,spawnLoc.z))
              noteTemplate.text = "El vehículo está cerca de "..nearStreet..".\nNo tardes."

              self.MissionStarted = {
                TruckLoc = spawnLoc,
                Dropoff  = self.DropoffLocations[math.random(1,#self.DropoffLocations)],
                Count    = 0,
              }

              SetNewWaypoint(spawnLoc.x,spawnLoc.y)

              local timer = GetGameTimer()
              while (GetGameTimer() - timer) < (self.NotificationTime * 1000) do
                Citizen.Wait(0)
                DrawSprite("commonmenu","", 0.5,0.53, 0.2,0.1,0.0, 125,125,125,200)
                Utils.DrawText(noteTemplate)
              end
            else
              ESX.ShowNotification("No hay nada de información. ~r~Tan vez más tarde...~w~")
            end
          end)          
        end
      end
    else
      if not self.TruckSpawned and self.MissionStarted then
        local dist = Utils.GetVecDist(plyPos,self.MissionStarted.TruckLoc)
        if dist < self.TruckSpawnDist then
          local randNum = math.random(1,#self.TruckModels)
          local vehModel = self.TruckModels[randNum]

          local hash = GetHashKey(vehModel)
          while not HasModelLoaded(hash) do RequestModel(hash); Citizen.Wait(0); end

          local pos = self.MissionStarted.TruckLoc
          local veh = CreateVehicle(hash, pos.x, pos.y, pos.z, pos.w, true, false)
          SetEntityAsMissionEntity(veh,true,true)
          self.TruckSpawned = veh
        end
      else
        if IsPedInAnyVehicle(plyPed) then
          local veh = GetVehiclePedIsIn(plyPed,false)
          if veh == self.TruckSpawned then
            if not self.WaypointSet then
              self.WaypointSet = true
              SetNewWaypoint(self.MissionStarted.Dropoff.x,self.MissionStarted.Dropoff.y)
              ESX.ShowNotification("Busca un ~r~compañero~w~ y que monte atrás para empezar a cocinar.")
            end

            if not self.MethCook then
              local foundCook = false
              for k=1,4,1 do
                if not foundCook and not IsVehicleSeatFree(self.TruckSpawned,k) then 
                  local passenger = GetPedInVehicleSeat(self.TruckSpawned,k)
                  if passenger ~= -1 and passenger ~= GetPlayerPed(-1) and DoesEntityExist(passenger) then foundCook = passenger; end
                end
              end
              if foundCook and foundCook ~= GetPlayerPed(-1) then
                if GetEntitySpeed(self.TruckSpawned) * 3.6 > self.MinSpeedForCook then 
                  ESX.ShowNotification("Tu compañero ha empezado a cocinar la meta.")
                  self.MethCook = NetworkGetPlayerIndexFromPed(foundCook)
                  TriggerServerEvent('MF_MobileMeth:BeginCooking', GetPlayerServerId(self.MethCook))
                else
                  if not self.DidNotify then ESX.ShowNotification("Conduce a partir de ~g~15~w~ Km/h para empezar a cocinar."); self.DidNotify = true; end
                end
              end
            else
              if not self.SmokeActive then
                TriggerServerEvent('MF_MobileMeth:SyncSmoke', NetworkGetNetworkIdFromEntity(self.TruckSpawned))
                self.SmokeActive = true
              end

              if self.CookFinished then
                local dist = Utils.GetVecDist(plyPos, self.MissionStarted.Dropoff)
                if dist < self.DrawTextDist*2 then
                  local pos = self.MissionStarted.Dropoff
                  Utils.DrawText3D(pos.x,pos.y,pos.z, "[~r~E~s~] para entregar la meta.", 200)
                  if dist < self.DrawTextDist and IsControlJustPressed(0, Keys["E"]) and GetGameTimer() - timer > 150 then
                    timer = GetGameTimer()
                    local vehicle = self.TruckSpawned
                    local maxPassengers = GetVehicleMaxNumberOfPassengers(vehicle)
                    for seat = -1,maxPassengers-1,1 do
                      local ped = GetPedInVehicleSeat(vehicle,seat)
                      if ped and ped ~= 0 then TaskLeaveVehicle(ped,vehicle,16); end
                    end
                    TriggerServerEvent('MF_MobileMeth:RewardPlayers', GetPlayerServerId(self.MethCook))
                    TriggerServerEvent('MF_MobileMeth:RemoveTruck',  NetworkGetNetworkIdFromEntity(self.TruckSpawned))
                    Citizen.Wait(0)                    
                    DeleteVehicle(vehicle)
                    self.MissionStarted = false
                    self.TruckSpawned = false
                    self.WaypointSet = false
                    self.MethCook = false
                    self.SmokeActive = false
                    self.DidNotify = false
                    ESX.ShowNotification("Has ~g~entregado~w~ la meta.")
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

function MFM:BeginCooking(driver)
  if self.MissionStarted or self.Driver then ESX.ShowNotification("Ya tienes una tanda ~r~acitva~w~."); return; end
  ESX.ShowNotification("Has ~g~empezado~w~ a cocinar la meta")
  self.Driver = driver
  self.Truck = GetVehiclePedIsIn(GetPlayerPed(-1))
  local doCont = true
  Citizen.CreateThread(function(...)
    while self.Driver do
      Citizen.Wait(0)
      local doBreak,driverMsg
      local plyPed = GetPlayerPed(-1)
      local vehicle = GetVehiclePedIsIn(plyPed,false)
      if not IsPedInAnyVehicle(plyPed) then 
        doBreak = "Has perdido al ~r~conductor~w~." 
        driverMsg = "El cocinero te ha ~r~perdido~w~."
      else
        if GetEntitySpeed(vehicle) * 3.6 < self.MinSpeedForCook then
          if not self.CurrentlyStopped then
            self.CanCont = false
            self.CurrentlyStopped = true
            Citizen.CreateThread(function(...)
              local timer = GetGameTimer()
              while (GetGameTimer() - timer) < self.MaxVehicleStopTime * 1000 do Citizen.Wait(0); end
              if GetEntitySpeed(vehicle) * 3.6 < self.MinSpeedForCook then 
                self.CanCont = true
                --doBreak = "El vehículo está conduciendo muy lento para continuar." 
                --driverMsg = "El vehículo está conduciendo muy lento para continuar." 

                ESX.ShowNotification('Alguien te ha denunciado. ¡~r~Muevete~w~!.')
                
                Citizen.Wait(1000)

                -- Arnedo5 | Avisamos a la policia

                local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
                local streetName, crossing = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
                streetName = GetStreetNameFromHashKey(streetName)
                local coords      = GetEntityCoords(GetPlayerPed(-1))

                -- Send entorno
                TriggerServerEvent('comprobarEntorno', "Hay un vehiculo circulando en ".. streetName.." soltando mucho humo...", coords.x, coords.y, coords.z, "NPC RANDOM")

                TriggerEvent('esx_status:getStatus', 'stress', function(status)
                  stressVal = status.val
                end)
                
                if stressVal >= 0 then
                  TriggerEvent('esx_status:add', 'stress', 100000)
                end

                --TriggerServerEvent('MF_MobileMeth:NotifyPolice', GetEntityCoords(GetPlayerPed(-1)))
                --TriggerServerEvent('MF_Trackables:Notify','911',coordsHere,'police')
                --TriggerServerEvent('MF_Trackables:Notify','Actividad sospechosa en proceso.',GetEntityCoords(GetPlayerPed(-1)),'police')
              else
                self.CanCont = true
                self.CurrentlyStopped = false
              end
            end)
          end
        else          
          if self.CanCont then self.CurrentlyStopped = false; end
        end
      end
      if doBreak then
        ESX.ShowNotification(doBreak)
        TriggerServerEvent('MF_MobileMeth:RemoveTruck', NetworkGetNetworkIdFromEntity(self.Truck))
        TriggerServerEvent('MF_MobileMeth:FinishCook', self.Driver, false, driverMsg)

        self.Driver = false   
        self.Truck = false
        doCont = false
        self.CurrentlyStopped = false
        exports['progressBars']:closeUI()  
      end
    end
  end)

  exports['progressBars']:startUI(math.floor(self.CookTimerA * 60 * 1000), "Preparando ingredientes")
  Citizen.Wait(math.floor(self.CookTimerA * 60 * 1000) + 5000)

  if doCont then
    exports['progressBars']:startUI(math.floor(self.CookTimerB * 60 * 1000), "Cocinando la meta")
    Citizen.Wait(math.floor(self.CookTimerB * 60 * 1000) + 5000)
  else return; end

  if doCont then
    exports['progressBars']:startUI(math.floor(self.CookTimerC * 60 * 1000), "Enfriando la meta")
    Citizen.Wait(math.floor(self.CookTimerC * 60 * 1000) + 5000)
  else return; end

  if doCont then
    exports['progressBars']:startUI(math.floor(self.CookTimerD * 60 * 1000), "Empaquetando la meta")
    Citizen.Wait(math.floor(self.CookTimerD * 60 * 1000) + 5000)
  else return; end

  if doCont then
    ESX.ShowNotification("Has ~g~terminado~w~ de empaquetar la meta, ya puedes ir al ~r~destino~w~.")
    TriggerServerEvent('MF_MobileMeth:FinishCook', self.Driver, true, "Has ~g~terminado~w~ de empaquetar la meta, ya puedes ir al ~r~destino~w~.")
    self.Driver = false
  end
end

MFM.SmokingTrucks = {}
function MFM:SyncSmoke(netId)
  self.SmokingTrucks[netId] = false
end

MFM.SmokeSpawnDist = 50.0
function MFM:SmokeTracker(...)
  while true do
    Citizen.Wait(1000)
    local plyPed = GetPlayerPed(-1)
    local plyPos = GetEntityCoords(plyPed)
    local removeList = {}
    for k,v in pairs(self.SmokingTrucks) do
      local doesExist = NetworkDoesEntityExistWithNetworkId(k)
      local ent
      if doesExist then ent = NetworkGetEntityFromNetworkId(k); end
      if not v then
        if DoesEntityExist(ent) then
          local pos = GetEntityCoords(ent)
          local dist = Utils.GetVecDist(pos,plyPos)
          if dist < self.SmokeSpawnDist then
            print("[ MF_MobileMeth ] Added smoking truck to the list (in range, should begin smoking).")
            if not HasNamedPtfxAssetLoaded("core") then RequestNamedPtfxAsset("core"); end
            while not HasNamedPtfxAssetLoaded("core") do Citizen.Wait(0); end    
            SetPtfxAssetNextCall("core")
            StartNetworkedParticleFxLoopedOnEntity("exp_grd_grenade_smoke", ent, 0.0,0.0,0.5, 0.0,0.0,0.0, 1.0, false,false,false)
            self.SmokingTrucks[k] = true
          end
        end
      else
        if (not ent and self.SmokingTrucks[k]) or (ent and not DoesEntityExist(ent)) then 
          print("[ MF_MobileMeth ] Removed smoking truck from list (out of range).")
          self.SmokingTrucks[k] = false
        end
      end
    end
  end
end

Citizen.CreateThread(function(...) MFM:SmokeTracker(...); end)

function MFM:FinishCooking(result,msg)
  if result then
    ESX.ShowNotification(msg)
    self.CookFinished = true
  else
    ESX.ShowNotification(msg)
    self.MethCook = false
    self.DidNotify = false
  end
end

function MFM:NotifyPolice(pos,msg)
  ESX.ShowNotification(msg)
  local blip = AddBlipForRadius(pos.x, pos.y, pos.z, 50.0)
  SetBlipHighDetail(blip, true)
  SetBlipColour(blip, 1)
  SetBlipAlpha (blip, 80)
  local timer = GetGameTimer()
  while GetGameTimer() - timer < self.TrackableNotifyTimer * 1000 do 
    Citizen.Wait(0)
    if IsControlJustPressed(0, 36) then
      SetNewWaypoint(pos.x,pos.y)
    end
  end
  RemoveBlip(blip)
end

function MFM:RemoveTruck(netId)
  if not netId then return; end
  self.SmokingTrucks[netId] = nil
  Citizen.CreateThread(function()
    local doesExist = NetworkDoesEntityExistWithNetworkId(netId)
    local ent
    if doesExist then
      Citizen.Wait(60000)
      ent = NetworkGetEntityFromNetworkId(netId)
      DeleteVehicle(ent)
      DeleteEntity(ent)
    end
  end)
end

function MFM:SetJob(job)
  local lastJob = self.PlayerData.job
  if lastJob.name == self.PoliceJobName and job.name ~= self.PoliceJobName then
    TriggerServerEvent('MF_MobileMeth:RemoveCop')
    self.PlayerData.job = job
  elseif lastJob.name ~= self.PoliceJobName and job.name == self.PoliceJobName then
    TriggerServerEvent('MF_MobileMeth:SetCop')
    self.PlayerData.job = job
  end
end

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) MFM:SetJob(job); end)

RegisterNetEvent('MF_MobileMeth:BeginCooking')
AddEventHandler('MF_MobileMeth:BeginCooking', function(...) MFM:BeginCooking(...); end)

RegisterNetEvent('MF_MobileMeth:FinishCook')
AddEventHandler('MF_MobileMeth:FinishCook', function(...) MFM:FinishCooking(...); end)

RegisterNetEvent('MF_MobileMeth:SyncSmoke')
AddEventHandler('MF_MobileMeth:SyncSmoke', function(...) MFM:SyncSmoke(...); end)

RegisterNetEvent('MF_MobileMeth:NotifyCops')
AddEventHandler('MF_MobileMeth:NotifyCops', function(pos,msg) Citizen.CreateThread(function() MFM:NotifyPolice(pos,msg); end); end)

RegisterNetEvent('MF_MobileMeth:RemoveSmoke')
AddEventHandler('MF_MobileMeth:RemoveSmoke', function(netId) MFM:RemoveTruck(netId); end)

Citizen.CreateThread(function(...) MFM:Awake(...); end)