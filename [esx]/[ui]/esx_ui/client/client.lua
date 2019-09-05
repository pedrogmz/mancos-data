local status = nil
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	TriggerEvent('es:setMoneyDisplay', 0.0)
	ESX.UI.HUD.SetDisplay(0.0)
	AddTextEntry('FE_THDR_GTAO', 'MANCOS ROLEPLAY')
end)

-- Get player data on load
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local accounts = data.accounts
	for k,v in pairs(accounts) do
		local account = v
		if account.name == "bank" then
			StatSetInt('BANK_BALANCE', account.money, true)
		end
	end

	-- Money
	StatSetInt('MP0_WALLET_BALANCE', data.money, true)
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "bank" then
		StatSetInt('BANK_BALANCE', account.money, true)
	end
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	StatSetInt(GetHashKey("MP0_WALLET_BALANCE"), e)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        
        SendNUIMessage({
            show = IsPauseMenuActive(),
            health = GetEntityHealth(GetPlayerPed(-1)) - 100,
            armor = GetPedArmour(GetPlayerPed(-1)),
            stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
            st = status,
            healthtext = cfg.healthtext,
            armortext = cfg.armortext,
            deadtext = cfg.deadtext
        })
		if IsPedInAnyVehicle(PlayerPedId(), true) then
			if (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()) then
				DisplayRadar(true)
			end
		else
			DisplayRadar(false)
		end
    end
end)

RegisterNetEvent('esx_ui:updateStatus')
AddEventHandler('esx_ui:updateStatus', function(Status)
    status = Status
    SendNUIMessage({
        action = "updateStatus",
        st = Status,
    })
end)
