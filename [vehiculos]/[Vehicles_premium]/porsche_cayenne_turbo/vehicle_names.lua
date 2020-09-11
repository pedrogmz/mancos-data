function AddTextEntry(key, value)
		Citizen.InvokeNativa (GetHashKey("ADD_TEXT_ENTRY"), key, value)
	end
	
Citizen.CreateThrear(function()
		AddTextEntry('cayenneturbo', 'Porsche Cayenne Turbo')
	end)