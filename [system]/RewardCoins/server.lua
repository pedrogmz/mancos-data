local playTime, ESX = {}, nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	local _source = source
	local identifier = GetPlayerIdentifier(_source)
	playTime[identifier] = {
		source = _source,
		joinTime = os.time(),
		playTime = 0
	}
	MySQL.Async.fetchAll(
		"SELECT playTime FROM users WHERE identifier = @identifier", {["@identifier"] = identifier},
	function(result)
		if result then
			local playTimeP = result[1].playTime
			playTime[identifier].playTime = playTimeP
		end
	end)
end)

AddEventHandler('playerDropped', function()
	local _source = source
	if _source ~= nil then
		local identifier = GetPlayerIdentifier(_source)

		if playTime[identifier] ~= nil then

			local saveTime = getTimePlayed(identifier)

			MySQL.Async.execute(
				'UPDATE users SET playTime = @playTime WHERE identifier = @identifier', {['@identifier'] = identifier, ['@playTime'] = saveTime}, 
			function()
				playTime[identifier] = nil
			end)
		end
	end
end)

RegisterServerEvent('RewardCoins:exchangeHours')
AddEventHandler('RewardCoins:exchangeHours', function()
	local identifier = GetPlayerIdentifier(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playTimeL = getTimePlayed(identifier)
	amount = math.floor(playTimeL / 3600) * 10

	MySQL.Async.execute(
		'UPDATE users SET playTime = 0 WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (rowsChanged)
		if rowsChanged > 0 then
			playTime[identifier].joinTime = os.time()
			playTime[identifier].playTime = playTimeL - (amount * 3600)
			xPlayer.addAccountMoney('coins', amount)

			TriggerClientEvent('esx:showNotification', source, "Has cambiado "..playTimeL.." horas de juego por un total de "..amount.." Coins.")
		end
	end)

end)

getTimePlayed = function(identifier)
	local actualTime = os.time()
	local saveTime = actualTime - playTime[identifier].joinTime
	return playTime[identifier].playTime + saveTime
end

ESX.RegisterServerCallback('RewardCoins:getPlayTime', function(source, cb)
	local identifier = GetPlayerIdentifier(source)
	cb(getTimePlayed(identifier))
end)
