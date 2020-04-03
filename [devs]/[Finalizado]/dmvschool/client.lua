maxErrors = 6 -- Change the amount of Errors allowed for the player to pass the driver test, any number above this will result in a failed test
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local options = {
    x = 0.15,
    y = 0.30,
    width = 0.21,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "Instructor",
    menu_subtitle = "Categorias",
    color_r = 0,
    color_g = 128,
    color_b = 255,
}


-- Ubicación PED
local dmvped = {
  {type=4, hash=0x31430342, x=-696.21, y=-1386.63, z=4.5, a=48.09},
}

-- Ubicación interacción PED
local dmvpedpos = {
	{ ['x'] = -696.21, ['y'] = -1386.63, ['z'] = 5.5 },
}

-- Ubicación marked map
local dmvschool_location = {-696.21, -1386.63, 5.5}
local kmh = 3.6
local VehSpeed = 0
local speed_limit_resi = 80.0
local speed_limit_town = 80.0
local speed_limit_freeway = 120
local speed = kmh

local DTutOpen = false

--[[Events]]--

AddEventHandler("playerSpawned", function()
	TriggerServerEvent('dmv:LicenseStatus')	
end)

local TestDone = 0
local IntroDone = false

RegisterNetEvent('dmv:CheckLicStatus')
AddEventHandler('dmv:CheckLicStatus', function(number)

	
	if number == true then -- Examen teórico realizado
		TestDone = 1
		-- ESX.ShowNotification("~r~Permiso de circulación ya obtenido!")
	else -- Examen teórico NO realizado
		TestDone = 0
		-- DIntro()   
	end
end)

--[[Functions]]--

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function DrawMissionText2(m_text, showtime)
    ClearPrints()
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function LocalPed()
	return GetPlayerPed(-1)
end

function GetCar() 
	return GetVehiclePedIsIn(GetPlayerPed(-1),false) 
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

--[[Arrays]]--

onTestEvent = 0
theorylock = 0
onTtest = 0
testblock = 0
DamageControl = 0
SpeedControl = 0
CruiseControl = 0
Error = 0

function startintro()

	if TestDone == 1 then -- Examen teórico realizado
		ESX.ShowNotification("~r~Examen teórico ya obtenido!")
	else  -- Examen teórico NO realizado
		DIntro()  
	end

end

function startttest()

	if theorylock == 3 then
		ESX.ShowNotification("~r~Ya ha intentado una vez realizar el examen teórico. Intentelo mañana nuevamente")	
	else 
		if TestDone == 0 and IntroDone == true then
			TriggerServerEvent('dmv:ttcharge')
		else
			ESX.ShowNotification("~r~Debe pasar la introducción primero.")
		end
	end
	
end

function startptest()

	TriggerServerEvent('dmv:selectlicence')
		
end

RegisterNetEvent('dmv:startptest')
AddEventHandler('dmv:startptest', function(licence)

	if licence == true then -- Ya tiene licencia de conducir

		ESX.ShowNotification("~r~Ya tiene el permiso de circulación.")

	else -- No tiene licencia de conducir
		if theorylock == 3 or TestDone == 0 then
			ESX.ShowNotification("~r~Debe aprovar el examen terórico antes de poder hacer el práctico.")	
		else

		--Arnedo5 | Comprovar si hay coches en la zona
		VehicleSpawnPoint = {
			Pos     = {x = -693.67, y = -1403.83, z = 5.0},
		}

		if not ESX.Game.IsSpawnPointClear(VehicleSpawnPoint.Pos, 5.0) then
			ESX.ShowNotification("¡Hay un vehículo bloqueando el punto de salida!")
			return
		end
			
		TriggerServerEvent('dmv:dtcharge')
			
		end
	end

end)

-- 
RegisterNetEvent('dmv:moneyok')
AddEventHandler('dmv:moneyok', function()

	onTestBlipp = AddBlipForCoord(255.13990783691,-1400.7319335938,30.5374584198)
	N_0x80ead8e2e1d5d52e(onTestBlipp)
	SetBlipRoute(onTestBlipp, 1)
	onTestEvent = 1
	DamageControl = 1
	SpeedControl = 1
	onTtest = 3
	DTut()

end)



function EndDTest()
	if Error >= maxErrors then
		-- drawNotification("You failed\nYou accumulated ".. Error.." ~r~Error Points")
		
		ESX.ShowNotification("~b~Instructor: ~s~Lo siento, as suspendido con ".. Error.." fallos. ")

		EndTestTasks()
	else
		--local licID = 1
		--TriggerServerEvent('ply_prefecture:CheckForLicences', licID)	--Uncomment this if youre using ply_prefecture, also make sure your drivers license has 1 as ID
		--drawNotification("You passed\nYou accumulated ".. Error.." ~r~Error Points")	
		ESX.ShowNotification("~b~Instructor: ~s~Buen trabajo, as aprobado con ".. Error.." fallos. ")
		
		TriggerServerEvent('dmv:insertlicense') -- Insert en la bbdd

		EndTestTasks()
	end
end

function EndTestTasks()
		onTestBlipp = nil
		onTestEvent = 0
		DamageControl = 0
		Error = 0
		TaskLeaveVehicle(GetPlayerPed(-1), veh, 0)
		Wait(1000)
		CarTargetForLock = GetPlayersLastVehicle(GetPlayerPed(-1))
		lockStatus = GetVehicleDoorLockStatus(CarTargetForLock)
		SetVehicleDoorsLocked(CarTargetForLock, 2)
		SetVehicleDoorsLockedForPlayer(CarTargetForLock, PlayerId(), false)
		SetEntityAsMissionEntity(CarTargetForLock, true, true)
		Wait(2000)
		Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( CarTargetForLock ) )
		SpeedControl = 0

end

function SpawnTestCar()
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	local player = PlayerId()
	local vehicle = GetHashKey('blista')

    RequestModel(vehicle)

while not HasModelLoaded(vehicle) do
	Wait(1)
end
colors = table.pack(GetVehicleColours(veh))
extra_colors = table.pack(GetVehicleExtraColours(veh))
plate = math.random(100, 900)
local spawned_car = CreateVehicle(vehicle, -693.67, -1403.83, 5.0, 141.38, true, false)
SetVehicleColours(spawned_car,4,5)
SetVehicleExtraColours(spawned_car,extra_colors[1],extra_colors[2])
--[[SetEntityHeading(spawned_car, 317.64) ]]--
SetVehicleOnGroundProperly(spawned_car)
SetPedIntoVehicle(myPed, spawned_car, - 1)
SetModelAsNoLongerNeeded(vehicle)
Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
CruiseControl = 0
DTutOpen = false
SetEntityVisible(myPed, true)
SetVehicleDoorsLocked(GetCar(), 4)
FreezeEntityPosition(myPed, false)
end

function DIntro()
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	DTutOpen = true
		SetEntityCoords(myPed,173.01181030273, -1391.4141845703, 29.408880233765,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style = 'color: #00baac'> Introducción al DMV </b><br /><br /> La teoría y la práctica son elementos importantes a la hora de conducir<br /> Esta introducción cubrirá los conceptos básicos y garantizará que esté preparado con suficiente información y conocimiento para su prueba.<br /><br /> La información de sus lecciones de teoría combinadas con la experiencia de su lección práctica son vitales para afrontar las situaciones y los dilemas que enfrentará en el camino.<br /><br /> Siéntate y disfruta del paseo mientras comenzamos. Se recomienda que preste atención a cada detalle, la mayoría de estas preguntas pueden existir en su examen teórico.",
            type = "alert",
            timeout = (15000),
            layout = "center",
            queue = "global"
        })
		Citizen.Wait(16500)
		SetEntityCoords(myPed,-428.49026489258, -993.306640625, 46.008815765381,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style = 'color: #00baac'> Accidentes, incidentes y preocupaciones medioambientales </b><br /><br /> <b style = 'color: #00baac'> Obligación de ceder </b><br /> Todos los conductores tienen el deber de obedecer las reglas de la carretera para evitar daños previsibles a los demás. No ceder el derecho de paso cuando lo exija la ley puede generar responsabilidad por cualquier accidente resultante.<br /><br /> Cuando escuche que se acerca una sirena, debe ceder el paso al vehículo de emergencia, simplemente deténgase a su derecha.<br /> Siempre debe detenerse cuando un oficial de tránsito se lo indique.<br /><br /> <b style = 'color: #00baac'> Conducción agresiva </b><br /> Un automóvil que pone en peligro o puede poner en peligro a personas o propiedades se considera una conducción agresiva.<br /> Sin embargo, la conducción agresiva puede provocar accidentes trágicos. Es mucho más inteligente conducir a la defensiva y estar siempre atento al riesgo potencial de accidentes.<br />",
            type = "alert",
            timeout = (15000),
            layout = "center",
            queue = "global"
        })
		Citizen.Wait(16500)
		SetEntityCoords(myPed,-282.55557250977, -282.55557250977, 31.633310317993,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style = 'color: #00baac'> Área residencial </b><br /><br />Mantenga una velocidad adecuada: nunca más rápido que el límite publicado, más lento si hay mucho tráfico.<br /><br />Manténgase centrado en su carril. Nunca conduzca en el área reservada para automóviles estacionados.<br /><br />Mantenga una distancia de seguridad segura: una longitud mínima de 1 automóvil.<br />",
            type = "alert",
            timeout = (15000),
            layout = "center",
            queue = "global"
        })	
		Citizen.Wait(16500)
		SetEntityCoords(myPed,246.35220336914, -1204.3403320313, 43.669715881348,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style='color:#00baac'>Áreas/pueblos urbanizados</b><br/><br/>El límite de 80 km/h generalmente se aplica a todo el tráfico en todas las carreteras con alumbrado público, a menos que se especifique lo contrario.<br />Conducir a velocidades demasiado rápidas para la carretera y las condiciones de conducción pueden ser peligrosas.<br /><br />Siempre debe reducir su velocidad cuando:<br /><br />&bull; Compartiendo el camino con los peatones<br />&bull; Conducir de noche, ya que es más difícil ver a otros usuarios de la carretera.<br />&bull; Las condiciones climáticas hacen que sea más seguro hacerlo<br /><br />Recuerde, los vehículos grandes y las motocicletas necesitan una mayor distancia para detenerse<br />",
            type = "alert",
            timeout = (15000),
            layout = "center",
            queue = "global"
        })
		Citizen.Wait(16500)
		SetEntityCoords(myPed,-138.413, -2498.53, 52.2765,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style = 'color:#00baac'>Autovias / Autopistas</b><br/><br/>El tráfico en las autopistas generalmente viaja más rápido que en otras carreteras, por lo que tiene menos tiempo para reaccionar.<br/>Es especialmente importante usar sus sentidos antes y mirar mucho más adelante que en otras carreteras.<br/><br/>Verifique el tráfico en la autopista y ajuste su velocidad para adaptarse de manera segura al flujo de tráfico en el carril de la izquierda.<br/><br/>El límite de velocidad en un área de autopista / autopista es de 120 km / h.<br/>",
            type = "alert",
            timeout = (15000),
            layout = "center",
            queue = "global"
        })				
		Citizen.Wait(16500)		
		SetEntityCoords(myPed,187.465, -1428.82, 43.9302,true, false, false,true)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style = 'color:#00baac'> Alcohol </b><br/><br/>Beber mientras conduce es muy peligroso, el alcohol y / o las drogas perjudican su criterio. El juicio deteriorado afecta cómo reaccionas a los sonidos y lo que ves.<br/><br/> 0.25 es el límite legal para la concentración de alcohol en la sangre del conductor.<br/>",
            type = "alert",
            timeout = (15000),
            layout = "center",
            queue = "global"
        })				
		Citizen.Wait(16500)			
		--[[SetEntityCoords(myPed,238.756, -1381.65, 32.743,true, false, false,true) ]]--
		SetEntityCoords(myPed,-699.02, -1388.46, 5.15,true, false, false,true)
		SetEntityVisible(myPed, true)
		FreezeEntityPosition(myPed, false)
		DTutOpen = false
		IntroDone = true
end

function DTut()
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	DTutOpen = true
		SetEntityCoords(myPed,-759.74, -1376.31, 9.34, 10.34, false, false,false)
	    SetEntityHeading(myPed, 314.39)
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style = 'color: #00baac'> Instructor </b><br/><br/> Actualmente estamos preparando su vehículo para la prueba, mientras tanto, debe leer algunas líneas importantes.<br/><br/> <b style = 'color: #87CEFA'> Límite de velocidad: </b><br/> - Presta atención al tráfico y mantente por debajo del límite de <b style = 'color: #A52A2A'> </b><br/><br/> - Por ahora, debe conocer los conceptos básicos, sin embargo, intentaremos recordarle cada vez que <b style = 'color: #DAA520'> entre / salga </b> en un área con un límite de velocidad publicado",
            type = "alert",
            timeout = (15000), --15000
            layout = "center",
            queue = "global"
        })
		Citizen.Wait(16500) -- 16500
		TriggerEvent("pNotify:SendNotification",{
            text = "<b style = 'color: #00baac'> Instructor: </b><br/><br/> Use la función <b style = 'color: #DAA520'> Control de velocidad </b> para evitar <b style = 'color: #87CEFA'> exceso de velocidad </b>, actívelo durante la prueba presionando el botón <b style = 'color: #20B2AA'> BLOQ MAYUS </b> en su teclado.<br/><br/> <b style = 'color: # 87CEFA'> Evaluación: </b><br/> - Trate de no chocar el vehículo o superar el límite de velocidad establecido. Recibirá <b style = 'color: #A52A2A'> Puntos de error </b> cada vez que no cumpla con estas reglas<br/><br/> - Demasiados <b style = 'color: #A52A2A'> Puntos de error </b> acumulados resultarán en una prueba <b style = 'color: #A52A2A'> fallida </b>",
            type = "alert",
            timeout = (15000), --15000
            layout = "center",
            queue = "global"
        })
		Citizen.Wait(16500) -- 16500
		SpawnTestCar()
		DTutOpen = false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
		local ped = GetPlayerPed(-1)
		if HasEntityCollidedWithAnything(veh) and DamageControl == 1 then
		TriggerEvent("pNotify:SendNotification",{
            text = "El vehiculo fue <b style='color:#B22222'>dañado!</b><br /><br />¡Tenga cuidado!",
            type = "alert",
            timeout = (2000),
            layout = "bottomCenter",
            queue = "global"
        })			
			Citizen.Wait(1000)
			-- Error = Error + 1	
		elseif(IsControlJustReleased(1, 23)) and DamageControl == 1 then
			ESX.ShowNotification("~b~Instructor: ~s~No puede abandonar el vehículo durante la prueba.")
    	end
		
	if onTestEvent == 1 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -695.69,-1400.86,4.0, true) > 4.0001 then
		   DrawMarker(1,-695.69,-1400.86, 4.0, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-703.28,-1421.46,4.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			ESX.ShowNotification("~b~Instructor: ~s~Dirígase al siguiente punto")
			onTestEvent = 10
		end
	end
	
	if onTestEvent == 10 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-703.28,-1421.46,4.0, true) > 4.0001 then
		   DrawMarker(1,-703.28,-1421.46,4.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-696.98,-1435.79,4.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			ESX.ShowNotification("~b~Instructor: ~s~A continuación vamos a poner a prueba su maniobrabilidad al volante.")
			onTestEvent = 11		
		end
	end

	if onTestEvent == 11 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-696.98,-1435.79,4.0, true) > 4.0001 then
		   DrawMarker(1,-696.98,-1435.79,4.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-701.83,-1467.74,4.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			ESX.ShowNotification("~b~Instructor: ~s~Gire a la derecha.")
			onTestEvent = 12		
		end
	end

	if onTestEvent == 12 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-701.83,-1467.74,4.0, true) > 4.0001 then
		   DrawMarker(1,-701.83,-1467.74,4.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-753.35,-1478.76,4.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			ESX.ShowNotification("~b~Instructor: ~s~Gire a la derecha.")
			onTestEvent = 13		
		end
	end

	if onTestEvent == 13 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-753.35,-1478.76,4.0, true) > 4.0001 then
		   DrawMarker(1,-753.35,-1478.76,4.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-788.11,-1471.27,4.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			ESX.ShowNotification("~b~Instructor: ~r~Tenga cuidado en la siguiente maniobra!")
			onTestEvent = 14		
		end
	end

	if onTestEvent == 14 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-788.11,-1471.27,4.0, true) > 4.0001 then
		   DrawMarker(1,-788.11,-1471.27,4.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-772.56,-1446.7,4.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 15		
		end
	end

	if onTestEvent == 15 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-772.56,-1446.7,4.0, true) > 4.0001 then
		   DrawMarker(1,-772.56,-1446.7,4.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-703.28,-1421.46,4.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 16		
		end
	end

	if onTestEvent == 16 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-703.28,-1421.46,4.0, true) > 4.0001 then
		   DrawMarker(1,-703.28,-1421.46,4.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-668.09,-1364.27,9.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			
			drawNotification("~r~Ve despacio!\n~s~Area de: ~y~Población\n~s~Velocidad máxima: ~y~80 km/h\n~s~Fallos cometidos ~y~".. Error.."/6")
			SpeedControl = 2

			onTestEvent = 17		
		end
	end

	if onTestEvent == 17 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-668.09,-1364.27,9.0, true) > 4.0001 then
		   DrawMarker(1,-668.09,-1364.27,9.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-751.11,-1129.29,9.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			--DrawMissionText2("Make a quick ~r~stop~s~ for pedastrian ~y~crossing", 5000)
			ESX.ShowNotification("~b~Instructor: ~s~Realize una ~r~parada ~s~ para el cruce de ~y~peatones")
			PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true) -- Freeze Entity
			Citizen.Wait(4000)
			FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false) -- Freeze Entity
			-- DrawMissionText2("~g~Great!~s~ lets keep moving!", 5000)

			ESX.ShowNotification("~b~Instructor: ~g~¡Perfecto! ~s~sigamos moviéndonos!")
			onTestEvent = 18	
		end
	end

	if onTestEvent == 18 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-751.11,-1129.29,9.0, true) > 4.0001 then
		   DrawMarker(1,-751.11,-1129.29,9.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-1745.19,78.01, 66.5)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			--DrawMissionText2("Watch the traffic ~y~lights~s~ !", 5000)
			ESX.ShowNotification("~b~Instructor: ~s~Mira las ~y~luces~s~ de tráfico!")
			onTestEvent = 19		
		end
	end

	if onTestEvent == 19 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1745.19,78.01, 66.5, true) > 4.0001 then
		   DrawMarker(1,-1745.19,78.01, 66.5,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-1598.92,154.89, 58.5)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			ESX.ShowNotification("~b~Instructor: ~s~Vamos a proceder a circular por una zona muy concurrida. ~r~¡Tenga cuidado!")
			onTestEvent = 20		
		end
	end

	if onTestEvent == 20 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1598.92,154.89, 58.5, true) > 4.0001 then
		   DrawMarker(1,-1598.92,154.89, 58.5,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-1071.68, 418.12, 69.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 21		
		end
	end

	if onTestEvent == 21 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1071.68, 418.12, 69.0, true) > 4.0001 then
		   DrawMarker(1,-1071.68, 418.12, 69.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-1133.04, 556.55, 101.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 222		
		end
	end

	if onTestEvent == 222 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1133.04, 556.55, 101.0, true) > 4.0001 then
		   DrawMarker(1,-1133.04, 556.55, 101.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-796.48, 259.85, 82.5)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 23		
		end
	end


	--[[ 
	if onTestEvent == 22 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1245.3, 482.78, 92.5, true) > 4.0001 then
		   DrawMarker(1,-1245.3, 482.78, 92.5,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-796.48, 259.85, 82.5)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 23		
		end
	end]]--

	if onTestEvent == 23 then -- Rampa
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-796.48, 259.85, 82.5, true) > 4.0001 then
		   DrawMarker(1,-796.48, 259.85, 82.5,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-859.91, 68.09, 51.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 24		
		end
	end

	if onTestEvent == 24 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-859.91, 68.09, 51.0, true) > 4.0001 then
			DrawMarker(1,-859.91, 68.09, 51.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-667.13, -469.95, 33.5)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 25		
		end
	end

	if onTestEvent == 25 then -- Entrada autovia
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-667.13, -469.95, 33.5, true) > 4.0001 then
		   DrawMarker(1,-667.13, -469.95, 33.5,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-2012.12, -415.38, 10.5)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			ESX.ShowNotification("~b~Instructor: ~s~Es hora de salir a la carretera, ver su velocidad y no chocar. ¡Adelante!")

			PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
			drawNotification("Area: ~y~Autopista / autovía\n~s~Velocidad máxima: ~y~120 km/h\n~s~Fallos cometidos: ~y~".. Error.."/6")
			
			SpeedControl = 3
			onTestEvent = 26		
		end
	end

	if onTestEvent == 26 then -- Saliendo de la autovia
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-2012.12, -415.38, 10.5, true) > 4.0001 then
		   DrawMarker(1,-2012.12, -415.38, 10.5,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-1680.22, -566.91, 33.5)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)

			ESX.ShowNotification("~b~Instructor: ~s~Entrando en población, vigile su velocidad.")

			drawNotification("~r~Ve despacio!\n~s~Area de: ~y~Población\n~s~Velocidad máxima: ~y~80 km/h\n~s~Fallos cometidos ~y~".. Error.."/6")
			SpeedControl = 2
			onTestEvent = 27		
		end
	end

	if onTestEvent == 27 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1680.22, -566.91, 33.5, true) > 4.0001 then
		   DrawMarker(1,-1680.22, -566.91, 33.5,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-1100.6, -1314.48, 4.5)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 28		
		end
	end

	if onTestEvent == 28 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-1100.6, -1314.48, 4.5, true) > 4.0001 then
		   DrawMarker(1,-1100.6, -1314.48, 4.5,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-737.61, -1183.83, 10.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)
			onTestEvent = 29		
		end
	end

	if onTestEvent == 29 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-737.61, -1183.83, 10.0, true) > 4.0001 then
		   DrawMarker(1,-737.61, -1183.83, 10.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			onTestBlipp = AddBlipForCoord(-709.57,-1406.6,4.0)
			N_0x80ead8e2e1d5d52e(onTestBlipp)
			SetBlipRoute(onTestBlipp, 1)

			ESX.ShowNotification("~b~Instructor: ~s~Buen trabajo, ahora volvamos!")
			drawNotification("~r~Ve despacio!\n~s~Area de: ~y~Población\n~s~Velocidad máxima: ~y~80 km/h\n~s~Fallos cometidos ~y~".. Error.."/6")
			SpeedControl = 2
			onTestEvent = 30	
		end
	end

	if onTestEvent == 30 then
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),-709.57,-1406.6,4.0, true) > 4.0001 then
			DrawMarker(1,-709.57,-1406.6,4.0,0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
		else
		    if onTestBlipp ~= nil and DoesBlipExist(onTestBlipp) then
				Citizen.InvokeNative(0x86A652570E5F25DD,Citizen.PointerValueIntInitialized(onTestBlipp))
		    end
			EndDTest()
		end
	end	

	
end
end)

----Theory Test NUI Operator

-- ***************** Open Gui and Focus NUI
RegisterNetEvent('dmv:openGui')
AddEventHandler('dmv:openGui', function()
	
	openGui()
	Menu.hidden = not Menu.hidden
	
end)


function openGui()
  onTtest = 1
  SetNuiFocus(true)
  SendNUIMessage({openQuestion = true})
end

-- ***************** Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false)
  SendNUIMessage({openQuestion = false})
end

-- ***************** Disable controls while GUI open

--[[ 
Citizen.CreateThread(function()
  while true do
    if onTtest == 1 then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end
    end
    Citizen.Wait(0)
  end
end)]]--

-- ***************** NUI Callback Methods
-- Callbacks pages opening
RegisterNUICallback('question', function(data, cb)
  SendNUIMessage({openSection = "question"})
  cb('ok')
end)

-- Callback actions triggering server events
RegisterNUICallback('close', function(data, cb) -- Examen teórico aprovado
  closeGui()
  cb('ok')
  TriggerServerEvent('dmv:success')
  ESX.ShowNotification("~s~Examen teórico aprovado! Ahora puedes acceder al exámen práctico.")
  TestDone = 1
  theorylock = 0
  onTtest = 3
end)

RegisterNUICallback('kick', function(data, cb) -- Examen teórico NO aprovado
    closeGui()
    cb('ok')
	ESX.ShowNotification("~r~Fallastes el examen teórico. Intentalo de nuevo otro dia")
	TestDone = 0
    onTtest = 0
	theorylock = 3
end)


--[[ 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and TestDone == 1 and onTtest == 0 then
		--DrawMissionText2("~r~You are driving without a license", 2000)	
		ESX.ShowNotification("~r~Atención! estas conduciendo sin permiso de circulación!")		
		end
	end
end)
]]--

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		CarSpeed = GetEntitySpeed(GetCar()) * speed
        if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and SpeedControl == 1 and CarSpeed >= speed_limit_resi then
		TriggerEvent("pNotify:SendNotification",{
            text = "Estás acelerando! <b style='color:#B22222'>Ve más despacio!</b><br /><br />Estas conduciendo en una zona de <b style='color:#DAA520'>80 km/h</b>",
            type = "alert",
            timeout = (2000),
            layout = "bottomCenter",
            queue = "global"
        })
			Error = Error + 1	
			Citizen.Wait(10000)
		elseif(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and SpeedControl == 2 and CarSpeed >= speed_limit_town then
		TriggerEvent("pNotify:SendNotification",{
            text = "Estás acelerando! <b style='color:#B22222'>Ve más despacio!</b><br /><br />Estas conduciendo en una zona de <b style='color:#DAA520'>80 km/h</b>",
            type = "alert",
            timeout = (2000),
            layout = "bottomCenter",
            queue = "global"
        })
			Error = Error + 1
			Citizen.Wait(10000)
		elseif(IsPedInAnyVehicle(GetPlayerPed(-1), false)) and SpeedControl == 3 and CarSpeed >= speed_limit_freeway then
		TriggerEvent("pNotify:SendNotification",{
            text = "Estás acelerando! <b style='color:#B22222'>Ve más despacio!</b><br /><br />Estas conduciendo en una zona de <b style='color:#DAA520'>120 km/h</b>",
            type = "alert",
            timeout = (2000),
            layout = "bottomCenter",
            queue = "global"
        })
			Error = Error + 1
			Citizen.Wait(10000)
		end
	end
end)


local speedLimit = 0
--[[
Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 0 )   
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)
        local vehicleModel = GetEntityModel(vehicle)
        local speed = GetEntitySpeed(vehicle)
        local inVehicle = IsPedSittingInAnyVehicle(ped)
        local float Max = GetVehicleMaxSpeed(vehicleModel)
        if ( ped and inVehicle and DamageControl == 1 ) then
            if IsControlJustPressed(1, 73) then
                if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                    if CruiseControl == 0 then
                        speedLimit = speed
                        SetEntityMaxSpeed(vehicle, speedLimit)
						drawNotification("~y~Cruise Control: ~g~enabled\n~s~MAX speed ".. math.floor(speedLimit*3.6).."kmh")
						Citizen.Wait(1000)
				        DisplayHelpText("Adjust your max speed with ~INPUT_CELLPHONE_UP~ ~INPUT_CELLPHONE_DOWN~ controls")
						PlaySound(-1, "COLLECTED", "HUD_AWARDS", 0, 0, 1)
                        CruiseControl = 1
                    else
                        SetEntityMaxSpeed(vehicle, Max)
						drawNotification("~y~Cruise Control: ~r~disabled")						
                        CruiseControl = 0
                    end
                else
				    drawNotification("You need to be driving to preform this action")						
                end
            elseif IsControlJustPressed(1, 27) then
                if CruiseControl == 1 then
                    speedLimit = speedLimit + 0.45
                    SetEntityMaxSpeed(vehicle, speedLimit)
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					DisplayHelpText("Max speed adjusted to ".. math.floor(speedLimit*3.6).. "kmh")
                end
            elseif IsControlJustPressed(1, 173) then
                if CruiseControl == 1 then
                    speedLimit = speedLimit - 0.45
                    SetEntityMaxSpeed(vehicle, speedLimit)
					PlaySound(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)	
					DisplayHelpText("Max speed adjusted to ".. math.floor(speedLimit*3.6).. "kmh")
                end
            end
        end
    end
end)
]]--

----Theory Test NUI Operator

-- ***************** Open Gui and Focus NUI
function openGui()
  onTtest = 1
  SetNuiFocus(true)
  SendNUIMessage({openQuestion = true})
end

-- ***************** Close Gui and disable NUI
function closeGui()
  SetNuiFocus(false)
  SendNUIMessage({openQuestion = false})
end

-- ***************** Disable controls while GUI open
Citizen.CreateThread(function()
  while true do
    if onTtest == 1 then
      local ply = GetPlayerPed(-1)
      local active = true
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
      if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
        SendNUIMessage({type = "click"})
      end
    end
    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
  while true do
    if DTutOpen then
      local ply = GetPlayerPed(-1)
      local active = true
	  SetEntityVisible(ply, false)
	  FreezeEntityPosition(ply, true)
      DisableControlAction(0, 1, active) -- LookLeftRight
      DisableControlAction(0, 2, active) -- LookUpDown
      DisablePlayerFiring(ply, true) -- Disable weapon firing
      DisableControlAction(0, 142, active) -- MeleeAttackAlternate
      DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
    end
    Citizen.Wait(0)
  end
end)

-- ***************** NUI Callback Methods
-- Callbacks pages opening
--[[
RegisterNUICallback('question', function(data, cb)
  SendNUIMessage({openSection = "question"})
  cb('ok')
end)
]]--

-- Callback actions triggering server events

--[[ 
RegisterNUICallback('close', function(data, cb)
  -- if question success
  closeGui()
  cb('ok')
  TriggerServerEvent('dmv:success')
  DrawMissionText2("~b~Test passed, you can now proceed to the driving test", 2000)	
  TestDone = 0
  theorylock = 0
  onTtest = 3
end)
]]--


--[[ 
RegisterNUICallback('kick', function(data, cb)
    closeGui()
    cb('ok')
    DrawMissionText2("~r~You failed the test, you might try again another day", 2000)	
    onTtest = 0
	theorylock = 3
end)
]]--
---------------------------------- DMV PED ----------------------------------

Citizen.CreateThread(function()

  RequestModel(GetHashKey("a_f_y_business_02"))
  while not HasModelLoaded(GetHashKey("a_f_y_business_02")) do
    Wait(1)
  end

  RequestAnimDict("mini@strip_club@idles@bouncer@base")
  while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
    Wait(1)
  end

-- Spawn the DMV Ped
for _, item in pairs(dmvped) do
    dmvmainped =  CreatePed(item.type, item.hash, item.x, item.y, item.z, item.a, false, true)
    -- SetEntityHeading(dmvmainped, 137.71)
    FreezeEntityPosition(dmvmainped, true)
	SetEntityInvincible(dmvmainped, true)
	SetBlockingOfNonTemporaryEvents(dmvmainped, true)
    TaskPlayAnim(dmvmainped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
    end
end)

local talktodmvped = true
--DMV Ped interaction
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(dmvpedpos) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 1.0)then
				DisplayHelpText("Presiona ~INPUT_CONTEXT~ para interactuar con el ~y~instructor")
				if(IsControlJustReleased(1, 38))then
						if talktodmvped then
						    Notify("~b~Bienvenido a la autoescuela ~h~Manos RP")
						    Citizen.Wait(500)
							DMVMenu()
							Menu.hidden = false
							talktodmvped = false
						else
							talktodmvped = true
						end
				end
				Menu.renderGUI(options)
			end
		end
	end
end)

------------
------------ DRAW MENUS
------------
function DMVMenu()
	ClearMenu()
    options.menu_title = "Autoescula Mancos RP"
	Menu.addButton("Obtener el permiso de circulación","VehLicenseMenu",nil)
    Menu.addButton("Cerrar","CloseMenu",nil) 
end

function VehLicenseMenu()
    ClearMenu()
    options.menu_title = "Permiso de circulación"
	Menu.addButton("Introducción    Gratis","startintro", nil)
	Menu.addButton("Examen teórico    100$","startttest", nil)
	Menu.addButton("Examen práctico   200$","startptest",nil)
    Menu.addButton("Menu anterior","DMVMenu", nil) 
end

function CloseMenu()
	Menu.hidden = true
end

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, true)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

----------------
----------------blip
----------------



Citizen.CreateThread(function()
	pos = dmvschool_location
	local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
	SetBlipSprite(blip,408)
	SetBlipColour(blip,11)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Autoesculea Mancos RP')
	EndTextCommandSetBlipName(blip)
	SetBlipAsShortRange(blip,true)
	SetBlipAsMissionCreatorBlip(blip,true)
end)