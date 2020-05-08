
RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, playerName, playerRank, message)
  	local myId = PlayerId()
  	local pid = GetPlayerFromServerId(id)
  	if pid == myId then
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> {0} {1}:<br> {2}</div>',
			args = { playerRank, playerName, message }
		})
  	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"> {0} {1}:<br> {2}</div>',
			args = { playerRank, playerName, message }
		})
  	end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^2* " .. name .."  ".."^2  " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^2* " .. name .."  ".."^2  " .. message)
  end
end)

RegisterNetEvent('sendProximityMessageRoll')
AddEventHandler('sendProximityMessageRoll', function(id, name, num)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    if num > 5 then
    TriggerEvent("chatMessage", "", {255,0,0}, "^2" .. name .. " intento hacer la acción y la consiguió.")
    end
    if num < 5 then
    TriggerEvent("chatMessage", "", {255,0,0}, "^1" .. name .. "^1 intento hacer la acción y la falló.")
    end
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    if num > 5 then
    TriggerEvent("chatMessage", "", {255,0,0}, "^2" .. name .. " ^2 intento hacer la accion y la consiguió.")
    end
    if num < 5 then
    TriggerEvent("chatMessage", "", {255,0,0}, "^1" .. name .. "^1 intento hacer la accion y la falló.")
    end
  end
end)

