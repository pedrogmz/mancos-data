local MFS = MF_BMSales

function MFS:Awake(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    self.PlayerData = ESX.GetPlayerData()
    ESX.TriggerServerCallback('MF_BMSales:GetStartData', function(retVal) self.dS = true; self.cS = retVal; self:Start(); end)
end

function MFS:Start(...)
  if self.ShowBlip then self:DoBlips(); end
  if self.dS and self.cS then self:Update(); end
end

function MFS:DoBlips()
  local blip = AddBlipForCoord(self.HintLocation.x, self.HintLocation.y, self.HintLocation.z)
  SetBlipSprite               (blip, 205)
  SetBlipDisplay              (blip, 3)
  SetBlipScale                (blip, 1.0)
  SetBlipColour               (blip, 4)
  SetBlipAsShortRange         (blip, false)
  SetBlipHighDetail           (blip, true)
  BeginTextCommandSetBlipName ("STRING")
  AddTextComponentString      ("Shady Backalley")
  EndTextCommandSetBlipName   (blip)
end

function MFS:Update(...)
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
        Utils.DrawText3D(p.x,p.y,p.z, "[~r~E~s~] para llamar a la puerta.")
        if IsControlJustPressed(0, Keys["E"]) and GetGameTimer() - timer > 150 then    
          ESX.TriggerServerCallback('MF_BMSales:GetCops',function(count)
            if count and count >= self.MinPoliceOnline then
              timer = GetGameTimer()
              TaskGoStraightToCoord(plyPed, p.x, p.y, p.z, 10.0, 10, p.w, 0.5)
              Wait(3000)
              ClearPedTasksImmediately(plyPed)

              while not HasAnimDictLoaded("timetable@jimmy@doorknock@") do RequestAnimDict("timetable@jimmy@doorknock@"); Citizen.Wait(0); end
              TaskPlayAnim( plyPed, "timetable@jimmy@doorknock@", "knockdoor_idle", 8.0, 8.0, -1, 4, 0, 0, 0, 0 )     
              Citizen.Wait(0)
              while IsEntityPlayingAnim(plyPed, "timetable@jimmy@doorknock@", "knockdoor_idle", 3) do Citizen.Wait(0); end          

              Citizen.Wait(1000)

              TriggerEvent('chat:addMessage', {color = { 255, 0, 0}, multiline = true, args = {"Me", "Lee la nota que has recibido por debajo de la puerta."}})
              ClearPedTasksImmediately(plyPed)

              local randNum = math.random(1,#self.SalesLocations)
              local spawnLoc = self.SalesLocations[randNum]
              local nearStreet = GetStreetNameFromHashKey(GetStreetNameAtCoord(spawnLoc.x,spawnLoc.y,spawnLoc.z))
              noteTemplate.text = "Encuentra al vendedor "..nearStreet..".\nNo tardes."

              self.MissionStarted = spawnLoc

              SetNewWaypoint(spawnLoc.x,spawnLoc.y)

              local timer = GetGameTimer()
              while (GetGameTimer() - timer) < (self.NotificationTime * 1000) do
                Citizen.Wait(0)
                DrawSprite("commonmenu","", 0.5,0.53, 0.2,0.1,0.0, 125,125,125,200)
                Utils.DrawText(noteTemplate)
              end
              self:MissionStart()
            else
              ESX.ShowNotification("Parece que no hay nadie dentro. ~r~¡Lárgate de aquí!~w~")
            end
          end)
        end
      end
    end
  end
end

function MFS:MissionStart()
  local plyPed = GetPlayerPed(-1)
  local pPos = GetEntityCoords(plyPed)
  local tPos = self.MissionStarted
  local distToDropoff = CalculateTravelDistanceBetweenPoints(tPos.x,tPos.y,tPos.z, pPos.x,pPos.y,pPos.z)
  while not distToDropoff or (distToDropoff >= 10000 or distToDropoff <= 1000) do distToDropoff = CalculateTravelDistanceBetweenPoints(tPos.x,tPos.y,tPos.z, pPos.x,pPos.y,pPos.z); pPos = GetEntityCoords(GetPlayerPed(-1)); Citizen.Wait(10); end
  local textTemplate = Utils.DrawTextTemplate()
  local prices = {}
  for k,v in pairs(self.DrugItems) do 
    prices[v] = math.floor(self.DrugPrices[v]*(math.random(100.0-self.MaxPriceVariance,100.0+self.MaxPriceVariance)/100.0))
  end
  textTemplate.x = 0.8
  textTemplate.y = 0.8
  local startTime = GetGameTimer()
  local startDist = distToDropoff
  local timer = ((startDist / 1000) * 60) * 1000
  while ((GetGameTimer() - startTime) < math.floor(timer) and not self.MissionCompleted) or (self.MissionCompleted and distToDropoff < (self.DrawTextDist*2.0)) do
    Citizen.Wait(0)   
    plyPed = GetPlayerPed(-1)
    pPos = GetEntityCoords(plyPed)
    distToDropoff = Utils.GetVecDist(tPos,pPos)
    if not self.MissionCompleted then
      textTemplate.text = 'Tiempo restante : '..math.floor((((startDist / 1000) * 60) * 1000 - (GetGameTimer() - startTime))/1000)..' segundos.'
      Utils.DrawText(textTemplate)
    end
    if distToDropoff < 50.0 then
      if not self.PedSpawned then
        local hash = GetHashKey(self.DealerPed)
        while not HasModelLoaded(hash) do RequestModel(hash); Citizen.Wait(0); end
        self.PedSpawned = CreatePed(4, hash, tPos.x,tPos.y,tPos.z,tPos.w, true,true)
        SetEntityAsMissionEntity(self.PedSpawned,true,true)
        SetModelAsNoLongerNeeded(hash)
      end
      if distToDropoff < self.DrawTextDist then
        if not self.MissionCompleted then 
          startTime = 0
          self.MissionCompleted = true
          ESX.ShowNotification("¡Has encontrado al comprador!")
        end
        Utils.DrawText3D(tPos.x,tPos.y,tPos.z, "[~r~E~s~] para hablar.")
        if IsControlJustPressed(0,38) then
          
          -- Arnedo5 | De momento lo comentamos
          self:PoliceNotifyTimer(tPos)

          ESX.TriggerServerCallback('MF_BMSales:GetDrugCount', function(counts)
            ESX.UI.Menu.CloseAll()
            local elements = {}
            for k,v in pairs(self.DrugItems) do 
              drugPrice = prices[v]
              table.insert(elements, {label = k..' : $'..drugPrice, val = v, price = drugPrice})
            end
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Drug_Dealer',{ title = "Traficante", align = 'left', elements = elements },
              function(data,menu) 
                local count = false 
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'How_Much', {title = "¿Cuánto quieres vender? [Max : "..counts[data.current.val].."]"}, 
                  function(data2, menu2)
                    local quantity = tonumber(data2.value)

                    if quantity == nil then
                      ESX.ShowNotification("Cantidad no válida.")
                    else
                      count = quantity
                      menu2.close()
                    end
                  end, 
                  function(data2, menu2)
                    menu2.close()
                  end
                )
                while not count do Citizen.Wait(0); end
                if tonumber(count) > tonumber(counts[data.current.val]) then 
                  ESX.ShowNotification("No tienes tantos "..data.current.val..".")
                else 
                  ESX.ShowNotification("Has vendido "..tonumber(count).." "..data.current.val.." por $"..tonumber(count)*tonumber(data.current.price)..".")
                  TriggerServerEvent('MF_BMSales:Sold',data.current.val,data.current.price,count)
                  menu.close()
                  Citizen.Wait(1500)
                end
              end,
              function(data,menu)
                menu.close()
              end
            )
          end)
        end
      end
    end
  end

  if not self.MissionCompleted then
    ESX.ShowNotification("Se te ha acabado el tiempo y el comprador se ha ido.")
    if self.PedSpawned then 
      DeletePed(self.PedSpawned)
    end
    self.MissionCompleted = false 
    self.MissionStarted = false
    self.PedSpawned = false
  else
    ESX.ShowNotification("El comprador se ha ido del lugar.")
    if self.PedSpawned then 
      DeletePed(self.PedSpawned)
    end
    self.MissionCompleted = false 
    self.MissionStarted = false
    self.PedSpawned = false
  end
end

function MFS:PoliceNotifyTimer(pos)
  Citizen.CreateThread(function(...)
    Citizen.Wait(self.PoliceNotifyCountdown * 60 * 1000)
    TriggerServerEvent('MF_BMSales:NotifyPolice',pos)
    --TriggerServerEvent('MF_Trackables:Notify','911',coordsHere,'police')
    --TriggerServerEvent('MF_Trackables:Notify','Actividad sospechosa.',GetEntityCoords(GetPlayerPed(-1)),'police')
    --local nearStreet = GetStreetNameFromHashKey(GetStreetNameAtCoord(pos.x,pos.y,pos.z))
    --ESX.ShowNotification("La policía ha sido alertada de actividad sospechosa "..nearStreet..".")
  end)
end

function MFS:DoNotifyPolice(pos)
  Citizen.CreateThread(function(...)
    local timer = GetGameTimer()
    local street = GetStreetNameAtCoord(pos.x,pos.y,pos.z)
    local coords      = GetEntityCoords(GetPlayerPed(-1))

    -- Arnedo5 | Avisar policia
    if street then
      local nearStreet = GetStreetNameFromHashKey(street)
      ESX.ShowNotification("Alguien ha reportado actividad sospechosa en "..nearStreet..".")
    else
      ESX.ShowNotification("Alguien ha reportado actividad sospechosa.")
    end

    TriggerEvent('esx_status:add', 'stress', 100000) -- Subimos 30 de estres

    local blip = AddBlipForRadius(pos.x,pos.y,pos.z, 100.0)
    SetBlipHighDetail(blip, fa)
    SetBlipColour(blip, 1)
    SetBlipAlpha (blip, 128)
    while GetGameTimer() - timer < self.NotifyPoliceTimer * 1000 do
      if IsControlJustPressed(0, 57) then SetNewWaypoint(pos.x,pos.y); end
      Citizen.Wait(0)
    end
    RemoveBlip(blip)
  end)
end

function MFS:SetJob(job)
  local lastJob = self.PlayerData.job
  if lastJob.name == self.PoliceJobName and job.name ~= self.PoliceJobName then
    TriggerServerEvent('MF_BMSales:RemoveCop')
    self.PlayerData.job = job
  elseif lastJob.name ~= self.PoliceJobName and job.name == self.PoliceJobName then
    TriggerServerEvent('MF_BMSales:SetCop')
    self.PlayerData.job = job
  end
end

RegisterNetEvent('MF_BMSales:DoNotify')
AddEventHandler('MF_BMSales:DoNotify', function(pos) MFS:DoNotifyPolice(pos); end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) MFS:SetJob(job); end)

Citizen.CreateThread(function(...) MFS:Awake(...); end)