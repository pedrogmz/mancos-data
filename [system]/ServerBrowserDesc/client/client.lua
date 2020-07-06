local WaitTime = 2500 -- How often do you want to update the status (In MS)

local DiscordAppId = tonumber(GetConvar("RichAppId", "654145660584591383"))
local DiscordAppAsset = GetConvar("RichAssetId", "mancos_logo2")
local UseKMH = GetConvar("RichUseKMH", true)
	
Citizen.CreateThread(function()
	SetDiscordAppId(DiscordAppId)
	SetDiscordRichPresenceAsset(DiscordAppAsset)
	SetDiscordRichPresenceAssetText('MANCOS RP🌍') --Big picture hover text
	while true do
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		Citizen.Wait(WaitTime)
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence("Trotando en "..StreetName)
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence("Corriendo por "..StreetName)
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence("Caminando por "..StreetName)
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence("Parado en "..StreetName)
				end
			elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				local VehSpeed = GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId()))
				local CurSpeed = UseKMH and math.ceil(VehSpeed * 3.6) or math.ceil(VehSpeed * 2.236936)
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if CurSpeed > 50 then
					SetRichPresence("A toda velocidad en "..StreetName.." en un "..VehName)
				elseif CurSpeed <= 50 and CurSpeed > 0 then
					SetRichPresence("Rodando por "..StreetName.." en un "..VehName)
				elseif CurSpeed == 0 then
					SetRichPresence("Estacionado por "..StreetName.." en un "..VehName)
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
					SetRichPresence("Flying over "..StreetName.." in a "..VehName)
				else
					SetRichPresence("Landed at "..StreetName.." in a "..VehName)
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence("Nadando por ahí")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				SetRichPresence("Navegando en alta mar en un "..VehName)
			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence("In a yellow submarine")
			end
		end
	end
end)