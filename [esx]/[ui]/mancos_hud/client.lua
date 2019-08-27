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

-- Get jobs data every 10 secconds
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		ESX.TriggerServerCallback('esx_service:getInServiceCount', function(inServiceCount)
			policeonline = inServiceCount['police']
			emsonline = inServiceCount['ambulance']
			taxionline = inServiceCount['taxi']
			mechaniconline = inServiceCount['mechanic']
		end)
		SendNUIMessage({action = "updateJobsOnline", emsonline = emsonline, policeonline = policeonline, taxionline = taxionline, mechaniconline = mechaniconline})
	end
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
	SendNUIMessage({action = "setValue", key = "job", value = job.label.." - "..job.grade_label, icon = job.name})

	-- Money
	SendNUIMessage({action = "setValue", key = "money", value = data.money.."€"})
	
	--Mugshot
	local url = exports["mugshot"]:getMugshotUrl(GetPlayerPed(-1))
	SendNUIMessage({action = "setMugshot", value = url})
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "coins" then
		SendNUIMessage({action = "setValue", key = "coins", value = account.money})
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  SendNUIMessage({action = "setValue", key = "job", value = job.label.." - "..job.grade_label, icon = job.name})
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({action = "setValue", key = "money", value = e.."€"})
end)

RegisterNetEvent('mancos_hud:updateStatus')
AddEventHandler('mancos_hud:updateStatus', function(status)
	SendNUIMessage({action = "updateStatus", status = status})
end)

RegisterNetEvent('mancos_hud:toggle')
AddEventHandler('mancos_hud:toggle', function(show)
	SendNUIMessage({action = "toggle", show = show})
end)

RegisterNetEvent('mancos_hud:updateMugshot')
AddEventHandler('mancos_hud:updateMugshot', function(show)
	--Mugshot
	--local url = exports["mugshot"]:getMugshotUrl(GetPlayerPed(-1))
	--SendNUIMessage({action = "setMugshot", value = url})
end)

