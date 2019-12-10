
ESX 							      = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local blips 						  = {} -- Blips actuales en el mapa del jugador


RegisterNetEvent('esx_gps:enable')
AddEventHandler('esx_gps:enable', function(player)

	local currentPlayer = PlayerId() -- Obtenemos el jugador actual

	if player ~= currentPlayer or player == currentPlayer   then 

		local playerPed = GetPlayerPed(player)
		local playerName = GetPlayerName(player)
		
		--RemoveBlip(blips[player])

		local new_blip = AddBlipForEntity(playerPed)

		-- Add player name to blip
		SetBlipNameToPlayerName(new_blip, player)

		-- Make blip white
		SetBlipColour(new_blip, 38)

		-- Enable text on blip
		SetBlipCategory(new_blip, 2)

		-- Set the blip to shrink when not on the minimap
		-- Citizen.InvokeNative(0x2B6D467DAB714E8D, new_blip, true)

		-- Shrink player blips slightly
		SetBlipScale(new_blip, 0.9)

		-- Add nametags above head
		--Citizen.InvokeNative(0xBFEFE3321A3F5015, playerPed, playerName, false, false, '', false)

		-- Record blip so we don't keep recreating it
		blips[player] = new_blip

		if player ~= currentPlayer  then 
			-- Mostrar mensaje
			ESX.ShowNotification("Un agente ha ~g~activado~s~ su localización GPS")
		end
	end

end)

RegisterNetEvent('esx_gps:disable')
AddEventHandler('esx_gps:disable', function(player)
	
	if player ~=  nil then

		RemoveBlip(blips[player])

		local currentPlayer = PlayerId() -- Obtenemos el jugador actual

		if player ~= currentPlayer  then 
			-- Mostrar mensaje
			ESX.ShowNotification("Un agente ha ~r~desactivado~s~ su localización GPS")
		end
	
	end

end)
