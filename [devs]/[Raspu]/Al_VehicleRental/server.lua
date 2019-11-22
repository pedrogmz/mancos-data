-- Script Made By Aljunier | Made For ESX Framework --

ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

--Billing
RegisterServerEvent('Al_RentVehicle')
AddEventHandler('Al_RentVehicle', function (x, y, z, heading, price, vehicle)

	--Establish General Info
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	--ESX Gets players' money and removed it if they got the money to rent
	if xPlayer.get('money') >= price then
		xPlayer.removeMoney(price)

		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You Paid For Your Rental. Enjoy!', length = 6000 })
		TriggerClientEvent('Al_SpawnRentalVehicle', source, x, y, z, heading, vehicle)

	else	--If player doesn't have enough money

		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = "You Don't have Enough Money" })

	end
end)