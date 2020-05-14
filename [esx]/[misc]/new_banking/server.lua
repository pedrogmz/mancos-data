--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('bank:deposit')
AddEventHandler('bank:deposit', function(amount)
	local _source = source
	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('chatMessage', _source, "Cantidad no válida")
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', tonumber(amount))
	end
end)


RegisterServerEvent('bank:withdraw')
AddEventHandler('bank:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('bank').money
	if amount == nil or amount <= 0 or amount > base then
		TriggerClientEvent('chatMessage', _source, "Cantidad no válida")
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
	end
end)

RegisterServerEvent('bank:balance')
AddEventHandler('bank:balance', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getAccount('bank').money
	TriggerClientEvent('currentbalance1', _source, balance)
	
end)

RegisterServerEvent('bank:transfer')
AddEventHandler('bank:transfer', function(to, amountt)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local zPlayer = ESX.GetPlayerFromId(to)
	local balance = 0
	amountt = tonumber(amountt)
	balance = xPlayer.getAccount('bank').money
	zbalance = zPlayer.getAccount('bank').money
	
	if tonumber(_source) == tonumber(to) then
		TriggerClientEvent('chatMessage', _source, "No puedes trasnferirte dinero a ti mismo")
	else
		if balance <= 0 or balance < tonumber(amountt) or tonumber(amountt) <= 0 then
			TriggerClientEvent('chatMessage', _source, "No tienes suficiente dinero en el banco.")
		else
		
			MySQL.Async.execute('INSERT INTO transfer (Sender, Type, Amount, Receiver) VALUES (@Sender, @Type, @Amount, @Receiver) ', {
				['@Sender']   = xPlayer.name,
				['@Type']   = 'Cash',
				['@Amount']    = amountt,
				['@Receiver']    = zPlayer.name
			})
			
			xPlayer.removeAccountMoney('bank', amountt)
			zPlayer.addAccountMoney('bank', amountt)
		end
		
	end
end)

RegisterServerEvent('bank:change_drs')
AddEventHandler('bank:change_drs', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount('dragon_coins').money
	if amount == nil or amount < 100 or amount > base then
		TriggerClientEvent('chatMessage', _source, "Cantidad no válida")
	else
	
		MySQL.Async.execute('INSERT INTO transfer (Sender, Type, Amount, Receiver) VALUES (@Sender, @Type, @Amount, @Receiver) ', {
				['@Sender']   = xPlayer.name,
				['@Type']   = 'exchange_drs',
				['@Amount']    = amount,
				['@Receiver']    = xPlayer.name
			})
			
		xPlayer.removeAccountMoney('dragon_coins', amount)
		local new_amount = amount*100
		xPlayer.addAccountMoney('bank', new_amount)
	end
end)

