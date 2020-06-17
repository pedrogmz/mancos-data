Citizen.CreateThread(function()
	while true do Citizen.Wait(100)
		if IsPedInAnyPoliceVehicle(PlayerPedId(), -1) or IsPedInAnyHeli(PlayerPedId()) then
			DisablePlayerVehicleRewards(PlayerPedId())
		end
	end
end)