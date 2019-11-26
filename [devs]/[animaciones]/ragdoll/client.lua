
local death = false
local deathrelease = false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if DoesEntityExist(GetPlayerPed(-1)) then
			SetEntityInvincible(GetPlayerPed(-1), false)
			SetPedCanBeTargetted(GetPlayerPed(-1), true)
			SetPlayerWantedLevel(PlayerId(), 0, false)
			SetPlayerWantedLevelNow(PlayerId(), false)
			SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedBeingStunned(GetPlayerPed(-1)) then
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsEntityPlayingAnim(GetPlayerPed(-1), "dead", "dead_e", 3) then
			SetPedCanRagdoll(GetPlayerPed(-1), true)
			GivePlayerRagdollControl(PlayerId(), false)
		end
	end
end)



-- Respawn
Citizen.CreateThread(function()
    while true do
        Wait(500)
		local ped = GetPlayerPed(-1)
		local plyPos = GetEntityCoords(ped,  true)
        if IsEntityDead(ped) then
			NetworkResurrectLocalPlayer(plyPos, true, true, false)
			ClearPedTasks(ped)
			Citizen.Wait(500)			
			TriggerEvent('deadan', ped)
			-- TriggerServerEvent("deaths")
        	TriggerEvent("chatMessage", "[System]", { 255,0,0}, "Has muerto.")
        	
		end
	end
	
end)


-- Animacion de morir
RegisterNetEvent("deadan")
AddEventHandler("deadan", function()
	
	local playerPed = GetPlayerPed(-1)
	
	if DoesEntityExist(playerPed) then
		Citizen.CreateThread(function()
			
			loadAnimDict("dead")
			SetPlayerInvincible(playerPed, true)
			print(SetPlayerInvincible(playerPed, true))
			print(ClearPedSecondaryTask(playerPed))
			--TaskPlayAnim(PlayerPedId(), "dead", "dead_e", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
			--Citizen.Wait(15000)
			
			--loadAnimDict("dead")

			--TaskPlayAnim(playerPed, "dead", "dead_e", 1.0, 0.0, -1, 9, 9, 1, 1, 1)
			GivePlayerRagdollControl(PlayerId(), false)
			
			while not HasAnimDictLoaded("dead") do
				Citizen.Wait(100)
			end
			
			if IsEntityPlayingAnim(playerPed, "dead", "dead_e", 3) then
				ClearPedSecondaryTask(playerPed)
			else
				TaskPlayAnim(PlayerPedId(), "dead", "dead_e", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
				GivePlayerRagdollControl(PlayerId(), false)
			end		
			
		end)
	end
end)

-- Animacion lock de morir


RegisterNetEvent("deatht")
AddEventHandler("deatht", function(timer)
	if death == true then
		return
	end
	local ped = GetPlayerPed(-1)
	if DoesEntityExist(ped) then
	
		Citizen.CreateThread(function()
			death = true
			deathrelease = false
			while timer > 0 and not deathrelease do
				ped = GetPlayerPed(-1)
				-- RemoveAllPedWeapons(ped, true)
				-- SetEntityHealth(playerPed, 1)
				SetEntityInvincible(ped, true)
				TriggerEvent("deadan")
				if timer % 30 == 0 then
					TriggerEvent("chatMessage", "[System]", { 255,0,0}, timer .. " ")
				end
				Citizen.Wait(500)
				timer = timer - 0.5
			end
			--SetEntityCoords(ped, 295.946, -1446.82, 29.9666)
			--TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." has been revived.")
			death = false
			SetEntityInvincible(ped, false)
			ClearPedTasksImmediately(ped)
		end)
	end
end)


function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end