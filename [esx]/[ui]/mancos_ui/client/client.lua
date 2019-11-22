ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	TriggerEvent('es:setMoneyDisplay', 0.0)
	ESX.UI.HUD.SetDisplay(0.0)
end)

emsonline = 0
policeonline = 0
taxionline = 0
mecanoonline = 0
barmanonline = 0
cardeleronline = 0
tenderonline = 0

-- Get jobs data every 10 secconds
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)

		TriggerServerEvent('mancosui:getusers')

		--[[

		ESX.TriggerServerCallback('esx_service:getInServiceCount', function(inServiceCount)
			policeonline = inServiceCount['police']
			emsonline = inServiceCount['ambulance']
			taxionline = inServiceCount['taxi']
			mechaniconline = inServiceCount['mechanic']
			barmanonline = inServiceCount['barman']
			cardeleronline = inServiceCount['cardealer']
			tenderonline = inServiceCount['unemployed']

		end)
		
		SendNUIMessage({
			action = "updateJobsOnline", 
			emsonline = emsonline, 
			policeonline = policeonline, 
			taxionline = taxionline, 
			mechaniconline = mechaniconline,
			barmanonline = barmanonline,
			cardeleronline = cardeleronline,
			tenderonline = unemployedonline
		})
		]]--
	end
end)

RegisterNetEvent('mancosui:sendjobs')
AddEventHandler('mancosui:sendjobs', function(data)

	SendNUIMessage({
		action = "updateJobsOnline", 
		emsonline = data.emsonline, 
		policeonline = data.policeonline, 
		taxionline = data.taxionline, 
		mechaniconline = data.mechaniconline,
		barmanonline = data.barmanonline,
		cardeleronline = data.cardeleronline,
		tenderonline = data.tenderonline
	})

end)


Citizen.CreateThread(function()
    while true do
		Citizen.Wait(100)
		if IsPedInAnyVehicle(PlayerPedId(), true) then
			if ((GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId())) then
				SendNUIMessage({action = "toggle_watermark", show = false})
			end
		else
			SendNUIMessage({action = "toggle_watermark", show = true})
		end
		if IsPauseMenuActive() then
			SendNUIMessage({action = "toggle", show = false})
		else
			SendNUIMessage({action = "toggle", show = true})
		end
		local status = {}
		status['health'] = GetEntityHealth(GetPlayerPed(-1)) - 100
		status['stamina'] = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
		SendNUIMessage({action = "updateHealth", status = status})
	end
end)

-- Get player data on load
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local accounts = data.accounts
	for k,v in pairs(accounts) do
		local account = v
		if account.name == "coins" then
			SendNUIMessage({action = "setValue", key = "coins", value = account.money})
		end
	end

	-- Job
	local job = data.job
	
	SendNUIMessage({action = "setValue", key = "job", value = job.grade_label, icon = job.name})

	-- Money
	SendNUIMessage({action = "setValue", key = "money", value = data.money.."€"})
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "coins" then
		SendNUIMessage({action = "setValue", key = "coins", value = account.money})
	end
end)



RegisterNetEvent('mancos_ui:openMenu')
AddEventHandler('mancos_ui:openMenu', function(menu)
print(menu)
  SendNUIMessage({action = "openMenu", menu = menu})
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  SendNUIMessage({action = "setValue", key = "job", value = job.grade_label, icon = job.name})
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({action = "setValue", key = "money", value = e.."€"})
end)

RegisterNetEvent('mancos_ui:updateStatus')
AddEventHandler('mancos_ui:updateStatus', function(status)
	SendNUIMessage({action = "updateStatus", status = status})
end)

RegisterNetEvent('mancos_ui:toggle')
AddEventHandler('mancos_ui:toggle', function(show)
	SendNUIMessage({action = "toggle", show = show})
end)
