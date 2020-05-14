local playerNamesDist = 9
local displayIDHeight = 1.2 --Height of ID above players head (Starts at center body mass)

prefixes = {}
hidePrefix = {}
hideAll = false
prefixStr = ""

function DrawText3D(x, y, z, red, green, blue, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x, y, z, 0)
        DrawText(_x, _y)
    end
end

RegisterNetEvent("ID:Tags-Toggle")
AddEventHandler("ID:Tags-Toggle", function(val, error)
	if val then
		hideAll = true
	else
		hideAll = false
	end
end)

RegisterNetEvent("ID:Tag-Toggle")
AddEventHandler("ID:Tag-Toggle", function(arr, error)
	hidePrefix = arr
end)

RegisterNetEvent("GetStaffID:StaffStr:Return")
AddEventHandler("GetStaffID:StaffStr:Return", function(arr, error)
	prefixes = arr
end)

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

Citizen.CreateThread(function()
    while true do
        for i=0,99 do
            N_0x31698aa80e0223f8(i)
        end
		if not (hideAll) then
			for _, player in ipairs(GetActivePlayers()) do
				local ped = GetPlayerPed(player)
				blip = GetBlipFromEntity( ped )
 
				x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
				x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( player ), true ) )
				distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
				
				local playName = GetPlayerName(GetPlayerFromServerId(GetPlayerServerId(player)))
				if ((distance < playerNamesDist)) then
					for i = 1, #prefixes do
						if prefixes[i][1] == playName then
							prefixStr = prefixes[i][2]
						end
					end
					if not (has_value(hidePrefix, playName)) then
						-- Show their ID tag with prefix then
						if NetworkIsPlayerTalking(player) then
							DrawText3D(x2, y2, z2 + displayIDHeight, 0, 0, 255, prefixStr .. "~b~" .. GetPlayerServerId(player) .. "")
						else
							DrawText3D(x2, y2, z2 + displayIDHeight, 255, 255, 255, prefixStr .. "~w~" .. GetPlayerServerId(player) .. "")
						end
					else
						-- Don't show their ID tag with prefix then
						if NetworkIsPlayerTalking(player) then
							DrawText3D(x2, y2, z2 + displayIDHeight, 0, 0, 255, "~b~" .. GetPlayerServerId(player) .. "")
						else
							DrawText3D(x2, y2, z2 + displayIDHeight, 255, 255, 255, "~w~" .. GetPlayerServerId(player) .. "")
						end
					end
					prefixStr = ""
				end
			end
		end
        Citizen.Wait(0)
    end
end)
