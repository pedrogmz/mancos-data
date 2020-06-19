local RechargePoints = {
	{x = 298.76, y = -793.82, z = 28.48},
	{x = 441.32, y = -987.99, z = 29.69},
	{x = 316.53, y = -588.55, z = 42.29},
	{x = -338.10, y = -142.34, z = 38.01},
	{x = 903.24, y = -166.90, z = 73.08},
	{x = -34.32, y = -1106.94, z = 25.42},
	{x = -700.47, y = -917.58, z = 18.21},
	{x = -553.57, y = 289.80, z = 81.18},
	{x = -1073.90, y = -398.17, z = 35.96},
	{x = 58.91, y = -1734.00, z = 28.31},
}

batteryLevel = 100
charging = false

colorbat = "~w~"
if batteryLevel >= 60 then
	colorbat = "~g~"
elseif batteryLevel < 60 and batteryLevel > 20 then
	colorbat = "~y~"
elseif batteryLevel <= 20 then
	colorbat = "~r~"
end

RegisterNetEvent("gcPhone:batteryLevel")
AddEventHandler("gcPhone:batteryLevel", function(_batteryLevel)
	batteryLevel = _batteryLevel
	SendNUIMessage({event = 'updateBatteryLevel', batteryLevel = batteryLevel})
end)

function ShowNoBatteryWarning()
	ESX.ShowNotification("No te queda ~r~batería~s~ en el teléfono.")
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		
		if not hasPhone then
			return
		end
		
		if charging then
			Citizen.Wait(1000)
			batteryLevel = batteryLevel+1
		else
			if batteryLevel >= 1 and movilon then
				Citizen.Wait(DischargeTime)
				batteryLevel = batteryLevel - 1
			end
		end
		TriggerEvent("gcPhone:batteryLevel", batteryLevel)
		TriggerServerEvent("gcPhone:batteryLevel", batteryLevel)
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		
		if not hasPhone then
			return
		end
		
		for _,v in pairs(RechargePoints) do
			local ped = GetPlayerPed(-1)
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, x, y, z, 1)
			
			if distance <= 5 then
				if batteryLevel < 100 and distance <= 1.3 then
					ESX.ShowNotification("[~g~Batería del teléfono~w~]~n~Cargando... Bateria: "..colorbat..""..batteryLevel.."%~w~")
					charging = true
				else
					charging = false
				end
				draw3DText(v.x, v.y, v.z, "[~g~Zona de carga~w~] ~n~Entra dentro del ~b~circulo~w~ ~n~para recargar tu ~y~teléfono~w~", 4, 0.15, 0.10, 255, 255, 255, 255)
				DrawMarker(27, v.x, v.y, v.z + 0.2, 0, 0, 0, 0, 0, 0, 0.5,0.5,0.5, 0, 232, 255, 155, 0, 0, 0, 0, 0, 0, 0)
			end
		end
	end
end)

function draw3DText(x,y,z,textInput,fontId,scaleX,scaleY,r, g, b, a)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*14
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(r, g, b, a)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+1, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end