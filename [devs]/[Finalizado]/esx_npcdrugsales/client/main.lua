ESX             = nil
local myJob     = nil
local selling   = false
local has       = false
--local inZoneBarrioNegro, inZonePier, inZoneZonaRica    = false, false, false
local inZoneBarrioNegro, inZonePier    = false, false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)



--Zonas
Citizen.CreateThread(function()
  while true do
    Wait(10)
    local plyCoords = GetEntityCoords(PlayerPedId())
    local dstCheckEnter = GetDistanceBetweenCoords(plyCoords, -1488.81, -1337.68, 53.26, true)
    local player = GetPlayerPed(-1)
    local playerLoc = GetEntityCoords(player)
      DrawMarker(1, -1488.81, -1337.68, 53.26, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 300.00, 300.00, 0.25, 124, 252, 119, 100, false, true, 2, false, false, false, false)
      if dstCheckEnter <= 150.00 then
        inZoneBarrioNegro = true
        DrawTxt("~y~Estás en zona de trapicheo...", 0.85, 0.96)
        end
      if dstCheckEnter >= 150.00 then
        inZoneBarrioNegro = false
      end
    end
end)

Citizen.CreateThread(function()
  while true do
    Wait(10)
    local plyCoords = GetEntityCoords(PlayerPedId())
    local dstCheckEnter = GetDistanceBetweenCoords(plyCoords, -1637.23, -1044.42, 13.15, true)
    local player = GetPlayerPed(-1)
    local playerLoc = GetEntityCoords(player)
      DrawMarker(-1, -1637.23, -1044.42, 13.15, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 280.00, 280.00, 0.25, 124, 252, 119, 100, false, true, 2, false, false, false, false)
      if dstCheckEnter <= 140.00 then
        inZonePier = true
        DrawTxt("~y~Estás en zona con gente de gustos raros...", 0.80, 0.95)
        end
      if dstCheckEnter >= 140.00 then
        inZonePier = false
      end
    end
end)

--[[
Citizen.CreateThread(function()
  while true do
    Wait(10)
    local plyCoords = GetEntityCoords(PlayerPedId())
    local dstCheckEnter = GetDistanceBetweenCoords(plyCoords, -979.77, 169.08, 65.00, true)
    local player = GetPlayerPed(-1)
    local playerLoc = GetEntityCoords(player)
      DrawMarker(1, -979.77, 169.08, 65.45, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 240.00, 250.00, 0.25, 124, 250, 250, 150, false, true, 2, false, false, false, false)
      if dstCheckEnter <= 120.00 then
        inZoneZonaRica = true
        DrawTxt("~y~Estás en zona con gente muy sensible...", 0.80, 0.95)
        end
      if dstCheckEnter >= 120.00 then
        inZoneZonaRica = false
      end
    end
end)
]]

function DrawTxt(text, x, y)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextScale(0.0, 0.55)
  SetTextDropshadow(1, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x, y)
end

currentped = nil


Citizen.CreateThread(function()
while true do
  Wait(10)
  local player = GetPlayerPed(-1)
  local playerloc = GetEntityCoords(player, 0)
  local handle, ped = FindFirstPed()
  repeat
    success, ped = FindNextPed(handle)
    local pos = GetEntityCoords(ped)
    local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
    --if inZoneBarrioNegro or inZonePier or inZoneZonaRica then
    if inZoneBarrioNegro or inZonePier then
      if distance <= 1 and ped  ~= GetPlayerPed(-1) and ped ~= oldped then
        if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
          if DoesEntityExist(ped)then
            if IsPedInAnyVehicle(ped) == false then
              local pedType = GetPedType(ped)
              if pedType ~= 28 and IsPedAPlayer(ped) == false then
                currentped = pos
                  TriggerServerEvent('checkD')
                if has == true then
                  ESX.ShowHelpNotification("Presiona ~INPUT_CONTEXT~ para vender.")
                  if IsControlJustPressed(1, 86) then
                      oldped = ped
                      SetEntityAsMissionEntity(ped)
                      TaskStandStill(ped, 9.0)
                      pos1 = GetEntityCoords(ped)
                      if inZoneBarrioNegro then
                        TriggerServerEvent('drugs:triggerBarrioNegro')
                        Citizen.Wait(2500)
                        TriggerEvent('sellBarrioNegro')
                      end
                      if inZonePier then
                        TriggerServerEvent('drugs:triggerPier')
                        Citizen.Wait(2500)
                        TriggerEvent('sellPier')
                      end
                      --[[
                      if inZoneZonaRica then
                        TriggerServerEvent('drugs:triggerZonaRica')
                        Citizen.Wait(2500)
                        TriggerEvent('sellZonaRica')
                      end
                      ]]
                      Citizen.Wait(3500)
                      SetPedAsNoLongerNeeded(oldped)
                  end
                end
              end
            end
          end
        end
      end
    end
  until not success
  EndFindPed(handle)
end
end)


RegisterNetEvent('sellBarrioNegro')
AddEventHandler('sellBarrioNegro', function()
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player, 0)
    local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    local percent = math.random(0, 5)

	if inZoneBarrioNegro then
	  if percent == 0 or percent == 1 or percent == 2 or percent == 3 or percent == 5 then
	  	TriggerServerEvent('drugs:sellBarrioNegro')
	  end
	  if percent == 4 then
	  	TriggerServerEvent('sell_dis')
	end
end
end)

RegisterNetEvent('sellPier')
AddEventHandler('sellPier', function()
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player, 0)
    local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    local percent = math.random(1, 5)

	if inZonePier then
	  if percent == 1 or percent == 2 or percent == 3 then
	  	TriggerServerEvent('drugs:sellPier')
	  end
	  if percent == 4 or percent == 5 then
	  	TriggerServerEvent('sell_dis')
	end
end
end)
--[[
RegisterNetEvent('sellZonaRica')
AddEventHandler('sellZonaRica', function()
    local player = GetPlayerPed(-1)
    local playerloc = GetEntityCoords(player, 0)
    local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    local percent = math.random(1, 5)

	if inZoneZonaRica then
	  if percent == 1 or percent == 2 or percent == 3 then
	  	TriggerServerEvent('drugs:sellZonaRica')
	  end
	  if percent == 4 or percent == 5 then
	  	TriggerServerEvent('sell_dis')
	end
end
end)
]]



RegisterNetEvent('checkR')
AddEventHandler('checkR', function(test)
  has = test
end)

RegisterNetEvent('notifyc')
AddEventHandler('notifyc', function()

    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
    local streetName, crossing = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
    local streetName, crossing = GetStreetNameAtCoord(x, y, z)
    streetName = GetStreetNameFromHashKey(streetName)
	   crossing = GetStreetNameFromHashKey(crossing)
	
    if crossing ~= nil then

      local coords      = GetEntityCoords(GetPlayerPed(-1))

      TriggerServerEvent('esx_phone:send', "police", 'Una persona me está intentando vender drogas en ' .. streetName .. " y " .. crossing, true, {
        x = coords.x,
        y = coords.y,
        z = coords.z
      })
    else
      TriggerServerEvent('esx_phone:send', "police", "Una persona me está intentado vender drogas en " .. streetName, true, {
        x = coords.x,
        y = coords.y,
        z = coords.z
      })
    end
end)

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

RegisterNetEvent('animation')
AddEventHandler('animation', function()
  local pid = PlayerPedId()
  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
  while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
    --TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
    playAnim('mp_common', 'givetake1_a', 2500)
    Wait(2500)
    StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
      SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
