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

local elements                 = { -- Array de objetos de todos los entornos
   police = {},
   ambulance = {},
   mechanic = {},
   taxi = {}
} 

local PlayerData              = {}
local DelayTime               = 3000 -- Tiempo de espera para comprobar avisos
local display                 = false
local inRoute                 = false 
local actualRoute             = {x = 0, y = 0, z = 0}

ESX 							      = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function ()
   
   PlayerData = ESX.GetPlayerData()
   
 end)
 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
   PlayerData = xPlayer
end)
 
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
   PlayerData.job = job
end)
 
Citizen.CreateThread(function()

   while true do
      Citizen.Wait(0)

      if inRoute == true then
         if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), actualRoute.x, actualRoute.y, actualRoute.z, true) < 15.0001 then
            RemoveBlip(blip)
            actualRoute             = {x = 0, y = 0, z = 0}
            inRoute = false;

            SendNUIMessage({
               type = "delRoute"
            })
         end
      end
   
      if IsControlJustReleased(0, Keys['F9']) then
         
         local job = PlayerData.job.name

         if job == 'police' or job == 'ambulance' or job == 'mechanic' or job == 'taxi' then

            local tmpElements = elements

            Count = 0
            for Index, Value in pairs( tmpElements[job] ) do
               Count = Count + 1
            end

            if Count > 0 and inRoute == false then -- Si hay elementos marcamos la ruta
               
               table.sort(tmpElements, function(a, b) return a[2] > b[2] end)

               -- Creamos el marker
               blip = AddBlipForCoord(tmpElements[job][1].Pos.x,  tmpElements[job][1].Pos.y, tmpElements[job][1].Pos.z)
               actualRoute             = {x = tmpElements[job][1].Pos.x, y = tmpElements[job][1].Pos.y, z = tmpElements[job][1].Pos.z}
               SetBlipRoute(blip, true)
               SetBlipRouteColour(blip, 83)
               SetBlipSprite(blip,8)
               SetBlipColour(blip,83)

               inRoute = true;

               SendNUIMessage({
                  type = "inRoute"
               })

               if job ~= 'police' then

                  local msg = ""

                  if job == 'ambulance' then msg = "Hemos confirmado su aviso. Un sanitario esta de camino." end
                  if job == 'mechanic' then msg = "Hemos confirmado su aviso. Un mecánico esta de camino." end
                  if job == 'taxi' then msg = "Hemos confirmado su aviso. Un empleado esta de camino." end

                  -- Notificate ped
                  local notification = {
                     title    = "Información de ciudadanía",
                     subject  = '',
                     msg      = msg,
                     iconType = 1
                  }
                  
                  TriggerServerEvent('esx_aviso:notify', notification, tmpElements[job][1].Id)
                  
               end
             
            end

         end     

      end
      
      if IsControlJustReleased(0, Keys['F10']) then

         if inRoute == true then -- En caso de estar en ruta eliminamos el blip
            RemoveBlip(blip)
            actualRoute             = {x = 0, y = 0, z = 0}
            inRoute = false;

            SendNUIMessage({
               type = "delRoute",
               delete = false
            })
         else 
            SendNUIMessage({
               type = "delRoute",
               delete = true
            })
            
         end

         local job = PlayerData.job.name

         if job == 'police' or job == 'ambulance' or job == 'mechanic' or job == 'taxi' then

            local tmpElements = elements

            Count = 0
            for Index, Value in pairs( tmpElements[job] ) do
               Count = Count + 1
            end

            if Count > 0 then

               table.sort(tmpElements, function(a, b) return a[2] > b[2] end)

               delElement(tmpElements[job][1])

               

            end

         end
		
      end
  
   end
end)

-- Display html
function SetDisplay(bool, data, playername)

   --SetNuiFocus(bool, bool)
   SendNUIMessage({
      type = "ui",
      status = bool,
      data = data,
   })

end

-- Send element to html
RegisterNetEvent("esx_aviso:sendElement")
AddEventHandler("esx_aviso:sendElement", function(identifier, id, job, description, x, y, z)

   if job ~=  nil then

      local job = PlayerData.job.name

         ESX.TriggerServerCallback('esx_service:isInService', function(isInService)
            
            if isInService then

               -- En caso de que el usuario sea...
               if job == 'police' or job == 'ambulance' or job == 'mechanic' or job == 'taxi' then

                  local data = {
                     Identifier = identifier,
                     Id  = id,
                     Job = job,
                     Description = description,
                     Pos  = {x = x, y = y, z = z}
                  }

                  SetDisplay(not display, data) -- Mostrar avisos
        
                  table.insert(elements[job], data) -- Guardamos en la tabla
               end

            end
          
         end, job)
        
     
   end

end) 

-- Delete element in table 
RegisterNUICallback("delElement", function(data)

   delElement (data)
   
end)

RegisterNetEvent('esx_service:notifyAllInService')
AddEventHandler('esx_service:notifyAllInService', function(notification, target)
	target = GetPlayerFromServerId(target)
	if target == PlayerId() then return end

	local targetPed = GetPlayerPed(target)
	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(targetPed)

	ESX.ShowAdvancedNotification(notification.title, notification.subject, notification.msg, mugshotStr, notification.iconType)
	UnregisterPedheadshot(mugshot)
end)

function delElement (data) 
   local job = PlayerData.job.name

   for i=#elements[job],1,-1 do -- Buscamos el elemento y lo eliminamos
      local v = elements[job][i]
         if v.Identifier == data.Identifier and v.Id == data.Id and v.Description == data.Description and tostring(v.Pos.x) == tostring(data.Pos.x) and tostring(v.Pos.y) == tostring(data.Pos.y) and tostring(v.Pos.z) == tostring(data.Pos.z) then
         table.remove(elements[job], i)
         end
   end
end