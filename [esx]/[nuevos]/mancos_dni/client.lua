local open = false

RegisterNetEvent('mancos_dni:setIdentity')
AddEventHandler('mancos_dni:setIdentity', function(data)
	SendNUIMessage({
		action = "setData",
		array  = data,
		type   = nil
	})
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local job = data.job
	
	SendNUIMessage({action = "setJob", job = job.name, grade = job.grade_label})
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  SendNUIMessage({action = "setJob", job = job.name, grade = job.grade_label})
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 57) and not open then
			SendNUIMessage({
				action = "open"
			})
			open = true
		elseif IsControlJustReleased(0, 57) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)
