local connected = false

AddEventHandler("playerSpawned", function()
	if not connected then
		TriggerServerEvent("MANCOS:playerConnected")
		connected = true
	end
end)