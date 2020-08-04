local getServerType = GetConvar("server_number", "Mancos01")
if getServerType == "MancosWL" then
	local secure = false
else
	local secure = true
end

local newUser = false

RegisterNetEvent('mancos_seguro:newUserLock')
AddEventHandler('mancos_seguro:newUserLock', function(lockUser)
	if lockUser then
		secure = true
		newUser = true
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        -- Arnedo5 | Seguro
        if IsControlPressed(0, 243) and IsControlPressed(0, 21) then -- Shift + |
            secure = not secure
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if secure or newUser then
            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 45, true) -- Melee Attack 1
			DisableControlAction(0, 80, true) -- Melee Attack 1
			DisableControlAction(0, 140, true) -- Melee Attack 1
			DisableControlAction(0, 263, true) -- Melee Attack 1
        end
    end
end)


-- circle under people when talking
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		-- Arnedo5 | Seguro
		if secure or newUser then
			drawTxt(0.245, 0.960, 1.0,1.0,0.4, "~w~Seguro: ~g~ON", 255, 255, 255, 255)
		else
			drawTxt(0.245, 0.960, 1.0,1.0,0.4, "~w~Seguro: ~r~OFF", 255, 255, 255, 255)
		end
	end
end)

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)    
end
