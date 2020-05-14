local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local secure = true

-- colors
local r,g,b,a = 166,166,255,255 -- rgba color

-- ranges
local voice = {default = 6.0, shout = 21.0, whisper = 1.0, current = 0}

AddEventHandler('onClientMapStart', function()
	if voice.current == 0 then
		NetworkSetTalkerProximity(voice.default)
	elseif voice.current == 1 then
		NetworkSetTalkerProximity(voice.shout)
	elseif voice.current == 2 then
		NetworkSetTalkerProximity(voice.whisper)
	end
end)



AddEventHandler('playerSpawned', function()
	NetworkSetTalkerProximity(voice.default)		
end)

-- main part.
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
        if IsControlJustPressed(0, Keys['H']) and IsControlPressed(0, Keys['LEFTSHIFT']) then
            voice.current = (voice.current + 1) % 3
            if voice.current == 0 then
                NetworkSetTalkerProximity(voice.default)
            elseif voice.current == 1 then
                NetworkSetTalkerProximity(voice.shout)
            elseif voice.current == 2 then
                NetworkSetTalkerProximity(voice.whisper)
            end
        end
        if IsControlPressed(0, Keys['H']) and IsControlPressed(0, Keys['LEFTSHIFT']) then
            if voice.current == 0 then
                voiceS = voice.default
            elseif voice.current == 1 then
                voiceS = voice.shout
            elseif voice.current == 2 then
                voiceS = voice.whisper
            end
            Marker(1, coords.x, coords.y, coords.z, voiceS * 2.0)
        end

        -- Arnedo5 | Seguro [Bloquear el click izquierdo y derecho]
        if IsControlPressed(0, Keys['~']) and IsControlPressed(0, Keys['LEFTSHIFT']) then

            secure = not secure
            Citizen.Wait(1000)
          
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if secure then
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

-- distance to see the circle under people when talking
local playerNamesDist = 10

-- circle under people when talking
Citizen.CreateThread(function()
    if Config.EnableMarkerWhenTalking then
        while true do
            for id = 0, 255 do
                if  ((NetworkIsPlayerActive( id )) and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) then
                    ped = GetPlayerPed( id )
                    local coords = GetEntityCoords(PlayerPedId())
                    x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                    x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                    distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
            local takeaway = 0.95

                    if ((distance < playerNamesDist) and IsEntityVisible(GetPlayerPed(id))) ~= GetPlayerPed( -1 ) then
                if NetworkIsPlayerTalking(id) then
                    DrawMarker(-1,x2,y2,z2 - takeaway, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 10.3, 0, 132, 8, 48, 0, 0, 2, 0, 0, 0, 0)
                end
                if NetworkIsPlayerTalking(PlayerId()) then
                    DrawMarker(-1,coords.x,coords.y,coords.z - takeaway, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 10.3, 10, 10, 10, 6, 0, 0, 2, 0, 0, 0, 0)
                end
                    end  
                end
            end
            Citizen.Wait(0)

                -- Raspu Print id
                drawTxt(0.164, 0.840, 1.0,1.0,0.4, "ID: ~b~" .. tostring(GetPlayerServerId(PlayerId())), 255, 255, 255, 255)

				if NetworkIsPlayerTalking(PlayerId()) then
					if voice.current == 0 then
						drawTxt(0.164, 0.870, 1.0,1.0,0.4, "Voz:~b~ Normal", 255, 255, 255, 255)
					elseif voice.current == 1 then
						drawTxt(0.164, 0.870, 1.0,1.0,0.4, "Voz:~r~ Gritando", 255, 255, 255, 255)
					elseif voice.current == 2 then
						drawTxt(0.164, 0.870, 1.5,1.0,0.4, "Voz:~g~ Susurrando", 255, 255, 255, 255)
					end
				else
					if voice.current == 0 then
						drawTxt(0.164, 0.870, 1.0,1.0,0.4, "~w~Voz: Normal", 255, 255, 255, 255)
					elseif voice.current == 1 then
						drawTxt(0.164, 0.870, 1.0,1.0,0.4, "~w~Voz: Gritando", 255, 255, 255, 255)
					elseif voice.current == 2 then
						drawTxt(0.164, 0.870, 1.0,1.0,0.4, "~w~Voz: Susurrando", 255, 255, 255, 255)
					end
                end
                
                -- Arnedo5 | Stress
                TriggerEvent('esx_status:getStatus', 'stress', function(status)

                    if status.val == 0 then
                        stressPercent =   math.floor((status.val / 1000000) * 100)
                    else
                        stressPercent =   math.floor((status.val / 1000000) * 100  + 0.5)
                    end
                   
                    drawTxt(0.225, 0.870, 1.0,1.0,0.4, "~p~Estrés: ~w~" .. stressPercent..'%', 255, 255, 255, 255)
                end)

                -- Arnedo5 | Seguro [Bloquear el click izquierdo y derecho]
                if secure then
                    drawTxt(0.270, 0.870, 1.0,1.0,0.4, "~w~Seguro: ~g~ON", 255, 255, 255, 255)
                else
                    drawTxt(0.270, 0.870, 1.0,1.0,0.4, "~w~Seguro: ~r~OFF", 255, 255, 255, 255)
                end
                
  
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

-- Marker function, don't touch. 
function Marker(type, x, y, z, voiceS)
	DrawMarker(type, x, y, z - 1.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, voiceS, voiceS, 1.0, r, g, b, a, false, true, 2, false, false, false, false)
end

local talking  = {}

Citizen.CreateThread(function()
    RequestAnimDict("facials@gen_male@variations@normal")
    while not HasAnimDictLoaded("facials@gen_male@variations@normal") do
        Wait(10)
    end

    RequestAnimDict("mp_facial")
    while not HasAnimDictLoaded("mp_facial") do
        Wait(10)
    end

    while true do
        for _, player in pairs(GetActivePlayers()) do
            if NetworkIsPlayerTalking(player) then
                talking[player] = true
                PlayFacialAnim(GetPlayerPed(player), "mic_chatter", "mp_facial")
            elseif (not NetworkIsPlayerTalking(player) and talking[player]) then
                talking[player] = false
                PlayFacialAnim(GetPlayerPed(player), "mood_normal_1", "facials@gen_male@variations@normal")
            end
        end
        Wait(500)
    end
end)

-- Arnedo5 | Esc Menu
Citizen.CreateThread(function()
    AddTextEntry('FE_THDR_GTAO', '~f~Bienvenidos a Mancos ~r~RP')
    AddTextEntry('PM_PANE_LEAVE', '~o~Volver a la lista de servidores')
    AddTextEntry('PM_PANE_QUIT', '~r~Salir de Mancos RP')
    AddTextEntry('PM_SCR_MAP', '~b~GPS 🗺️')
    AddTextEntry('PM_SCR_GAM', '~r~Coger el avión ✈️')
    AddTextEntry('PM_SCR_INF', '~b~Registros 📝')
    AddTextEntry('PM_SCR_SET', '~b~Configuración ⚙️')
    AddTextEntry('PM_SCR_STA', '~r~Estadísticas 📊')
    AddTextEntry('PM_SCR_RPL', '~y~Editor Rockstar ∑')
end)
  