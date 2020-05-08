local holdingup = false
local hackholdingup = false
local bombholdingup = false
local bank = ""
local savedbank = {}
local secondsRemaining = 0
local dooropen = false
local platingbomb = false
local platingbombtime = 20
local blipRobbery = nil
globalcoords = nil
globalrotation = nil
globalDoortype = nil
globalbombcoords = nil
globalbombrotation = nil
globalbombDoortype = nil


ESX = nil

-- Auxiliar functions
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterCommand("help", function ()

    msg("e")

end, false)

function msg (text)

    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())

    TriggerEvent("chatMessage", "[Server]", {255, 0, 0}, ped)

end

function chat(str, color)
    TriggerEvent(
        'chat:addMessage',
        {
            color = color,
            multiline = true,
            args = {str}
        }
    )
end

-- Arnedo5 comando de test
RegisterCommand("informacion",  function(source, args)

    local name = GetPlayerName(PlayerId())
    
    TriggerServerEvent('informacion', name)
end, false)


RegisterNetEvent("output")
AddEventHandler("output", function(argument)
    TriggerEvent("chatMessage", "[Success]", {0,255,0}, argument)
end) 

-- -------------------------------------------------------------------------------------------------------------
RegisterNetEvent('infoOut')
AddEventHandler('infoOut', function(player)

    local playerOut = json.decode(player);

    TriggerEvent("chatMessage", "[Info Out]", {0, 255, 0}, playerOut.identgetBankifier)
end)

Citizen.CreateThread(function()
	while true do
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        
		for k,v in pairs(Pointers)do
            local pos2 = v.position
            
			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then
                    DrawMarker(25, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 0.9, v.color.r, v.color.g, v.color.b,255, 0, 0, 0,0)
                    
					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							--DisplayHelpText(v.nameofmessage)
							DisplayHelpText(_U('press_to_billing') .. v.nameofmessage)
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
							--TriggerServerEvent('esx_holdupbank:rob', k)
                            --SetDisplay(not display)
                            TriggerServerEvent('marker_billing:checkJob', k)
						end
					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end

		Citizen.Wait(0)
	end
end)


-- Mostrar info en pantalla
RegisterNetEvent("showData")
AddEventHandler("showData", function(data)
    SendNUIMessage({
        data = data
    })
end) 


-- Arnedo5 display INFO
local display = false

RegisterNetEvent('marker_billing:showPc')
AddEventHandler('marker_billing:showPc', function(job)
    
    SetDisplay(not display)

    SendNUIMessage({
        type = "job",
        job = job
    })
end)

--very important cb 
RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNetEvent("marker_billing:exit")
AddEventHandler("marker_billing:exit", function(data)
	SetDisplay(false, null)
	SendNUIMessage({
		type = "restart",
    })
end) 

-- Buscar el total de dinero
RegisterNUICallback("searchUser", function(data)
    TriggerServerEvent('marker_billing:checkTotal', data.strId, data.strJob )
end)

-- Tramitar facturacion / multa (Police)
RegisterNUICallback("billing", function(data)
    TriggerServerEvent('marker_billing:billing', data.strId, data.date)
end)

-- Tramitar facturacion / multa (Mechanic)
RegisterNUICallback("billingMechanic", function(data)
    TriggerServerEvent('marker_billing:billingMechanic', data.strId, data.strDescription, data.strNote, data.strTotal, data.date)
end)

RegisterNetEvent("billingSocietyAdd")
AddEventHandler("billingSocietyAdd", function(society, total)
	TriggerServerEvent('esx_society:depositMoney', society, total)
end) 


RegisterNUICallback("error", function(data)
    SetDisplay(false)
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
	while display do
        Citizen.Wait(0)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)
