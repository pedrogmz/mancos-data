ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- jail command
TriggerEvent('es:addGroupCommand', 'jail', 'admin', function(source, args, user)
	
	local jailPlayer = args[1]
	local jailTimeMinutes = tonumber(args[2])
	local jailReason = args
	table.remove(jailReason, 1)
	table.remove(jailReason, 1)
	
	local Identifier = ESX.GetPlayerFromId(jailPlayer).identifier
	local localIdentifier = ESX.GetPlayerFromId(source).identifier
	
	if jailPlayer and jailTimeMinutes then
		JailPlayer(jailPlayer, jailTimeMinutes)
		
		-- Para logging en la base de datos y luego poder crear un panel para visualizar los jails
		
		TriggerClientEvent("esx:showNotification", source, GetPlayerName(jailPlayer) .. " encarcelado por " .. jailTimeMinutes .. " minutos!")
		if jailReason ~= nil then
			GetRPName(jailPlayer, function(Firstname, Lastname)
				TriggerClientEvent('chat:addMessage', -1, { args = { "JUEZ",  Firstname .. " " .. Lastname .. " está en la cárcel por este motivo: " .. table.concat(jailReason, " ") }, color = { 249, 166, 0 } })
			end)
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player ID or jail time!' } } )
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Put a player in jail", params = {{name = "id", help = "target id"}, {name = "time", help = "jail time in minutes"}, {name = "reason", help = "Razón para ser enviado a la carcel"}}})

-- unjail
TriggerEvent('es:addGroupCommand', 'unjail', 'mod', function(source, args, user)
	local jailPlayer = args[1]
	if GetPlayerName(jailPlayer) ~= nil then
		UnJail(jailPlayer)
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player ID!' } } )
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Unjail people from jail", params = {{name = "id", help = "target id"}}})

RegisterServerEvent("mancos_jail:jailPlayer")
AddEventHandler("mancos_jail:jailPlayer", function(targetSrc, jailTime, jailReason, mancos)
	-- Si agregamos un parametro más y revisamos su valor(true o false), podemos bloquear los mod menu que hagan trigger a este evento. Nota: desde nuestros scripts debemos mandar este parametro como true
	if not mancos then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Baneado por manco' } } )
		return
	end
	
	local src = source
	local targetSrc = tonumber(targetSrc)
	local jailTimeMinutes = tonumber(jailTime)*60

	JailPlayer(targetSrc, jailTimeMinutes)

	GetRPName(targetSrc, function(Firstname, Lastname)
		TriggerClientEvent('chat:addMessage', -1, { args = { "JUEZ",  Firstname .. " " .. Lastname .. " ha sido condenado a prisión por: " .. jailReason }, color = { 249, 166, 0 } })
	end)

	TriggerClientEvent("esx:showNotification", src, GetPlayerName(targetSrc) .. " encarcelado por " .. jailTime .. " minutos!")
end)

RegisterServerEvent("mancos_jail:unJailPlayer")
AddEventHandler("mancos_jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if xPlayer ~= nil then
		UnJail(xPlayer.source)
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	end

	TriggerClientEvent("esx:showNotification", src, xPlayer.name .. " Unjailed!")
end)

RegisterServerEvent("mancos_jail:updateJailTime")
AddEventHandler("mancos_jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("mancos_jail:prisonWorkReward")
AddEventHandler("mancos_jail:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	xPlayer.addMoney(math.random(67, 320))

	TriggerClientEvent("esx:showNotification", src, "Thanks, here you have som cash for food!")
end)

function JailPlayer(jailPlayer, jailTime)
	TriggerClientEvent("mancos_jail:jailPlayer", jailPlayer, jailTime)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("mancos_jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("mancos_jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("mancos_jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)