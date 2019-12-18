-- Define the variable used to open/close the tab
local tabEnabled = false
local tabLoaded = true --false

function REQUEST_NUI_FOCUS(bool)
    SetNuiFocus(bool, bool) -- focus, cursor
    if bool == true then
        SendNUIMessage({showtab = true})

        TriggerEvent('dmpemotes:emote', 'tablet2') -- Arnedo5 | Animación para la tablet
    else
        SendNUIMessage({hidetab = true})
        TriggerEvent('dmpemotes:cancel')
    end
    return bool
end


RegisterNUICallback(
    "tablet-bus",
    function(data)
        -- Do tablet hide shit
        if data.load then
            --print("Loaded the tablet")
            tabLoaded = true

        elseif data.hide then
            --print("Hiding the tablet")
            SetNuiFocus(false, false) -- Don't REQUEST_NUI_FOCUS here
            tabEnabled = false

            TriggerEvent('dmpemotes:cancel')
        elseif data.click then
        -- if u need click events
        end
    end
)

Citizen.CreateThread(
    function()
        -- Wait for nui to load or just timeout

        local l = 0
        local timeout = false
        while not tabLoaded do
            Citizen.Wait(0)
            l = l + 1
            if l > 500 then
                tabLoaded = true --
                timeout = true
            end
        end

        if timeout == true then
            print("Failed to load tablet nui...")
        -- return ---- Quit
        end

        print("::The client lua for tablet loaded::")

        REQUEST_NUI_FOCUS(false) -- This is just in case the resources restarted whilst the NUI is focused.



        while true do
             -- Control ID 20 is the 'Z' key by default
            -- 244 = M
            -- Use https://wiki.fivem.net/wiki/Controls to find a different key
			-- Edgar: Se pone la tecla 246 (Y) para abrir la tablet
            if (IsControlJustPressed(0, 246)) and GetLastInputMethod( 0 ) then
                tabEnabled = not tabEnabled -- Toggle tablet visible state
                REQUEST_NUI_FOCUS(tabEnabled)
                print("The tablet state is: " .. tostring(tabEnabled))
                Citizen.Wait(0)
            end
            if (tabEnabled) then
                local ped = GetPlayerPed(-1)
                DisableControlAction(0, 1, tabEnabled) -- LookLeftRight
                DisableControlAction(0, 2, tabEnabled) -- LookUpDown
                DisableControlAction(0, 24, tabEnabled) -- Attack
                DisablePlayerFiring(ped, tabEnabled) -- Disable weapon firing
                DisableControlAction(0, 142, tabEnabled) -- MeleeAttackAlternate
                DisableControlAction(0, 106, tabEnabled) -- VehicleMouseControlOverride
                DisableControlAction(0, 38, false) -- Arnedo5 [E] no deshabilitada
            end
            Citizen.Wait(0)
        end
    end
)

RegisterNUICallback("redirect", function()
    SendNUIMessage({
        status = 'registered',
        data = "",
        style = ""
    })
end)

-- Arnedo5 NUEVAS FUNCIONES
RegisterNUICallback("newUser", function(data)

    if (data.strEmail == "" or data.strEmail == undefined) then
        SendNUIMessage({
            status = 'error',
            data = "Indique un correo electrónico valido.",
            style = 'danger'
        })

        return
    end

    if (data.strPassword == "" or data.strPassword == undefined) then
        SendNUIMessage({
            status = 'error',
            data = "Las contraseñas no coinciden o no son válidas.",
            style = 'danger'
        })

        return
    end


    -- Si no existe error de formulario enviamos la petición al servidor
    TriggerServerEvent('searchUser', data, true)

end)

RegisterNUICallback("checEmail", function(data)

    if (data.strEmail == "" or data.strEmail == undefined) then
        SendNUIMessage({
            status = 'error',
            data = "Indique un correo electrónico valido.",
            style = 'danger'
        })

        return
    end

    TriggerServerEvent('searchUser', data, false)

end) 




RegisterNetEvent("showData")
AddEventHandler("showData", function(status, msg, style)

   --print ("STATUS: - ", msg)
    SendNUIMessage({
        status = status,
        data = msg,
        style = style
    })

end) 

RegisterNetEvent("redirect")
AddEventHandler("redirect", function(status, identifier)

    SendNUIMessage({
        status = status,
        identifier = identifier,
    })

end) 


RegisterNUICallback("getIdentifiers", function()
    -- Obtenemos el steam id / id de bbdd
    TriggerServerEvent('getIdentifiers')
end)

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(500)
	end
end