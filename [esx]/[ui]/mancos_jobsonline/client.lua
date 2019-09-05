ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
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
