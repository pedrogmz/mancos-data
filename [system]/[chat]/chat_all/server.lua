ESX = nil
local server = GetConvar("server_number", "1")
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--[[
############################################################################
############################################################################
                                EVENTOS
############################################################################
############################################################################
]]
RegisterServerEvent('hidi:chatFaccion')
AddEventHandler('hidi:chatFaccion', function(mensaje,id)
	--local xJugadores = ESX.GetPlayers()
	local checkJob = ESX.GetPlayerFromId(source)
	local _source = source
	local job = checkJob.job.name
	local _identifier = checkJob.getIdentifier()
	local nombre = GetCharacterName(_identifier)

	if job == 'ambulance' then
		sendChat('ambulance', "#F52785", nombre, mensaje,'Ambulancia')
	elseif job == 'mechanic' then
		sendChat('mechanic', "#C5C5C4", nombre, mensaje,'Mecanico')
	elseif job == 'tender' then
		sendChat('tender', "#FF9639", nombre, mensaje,'24/7')
	elseif job == 'bar' then
		sendChat('bar', "#9775FA", nombre, mensaje,'Casino')		
	elseif job == 'cardealer' then
		sendChat('cardealer', "#C5CE51", nombre, mensaje,'Concesionario')		
	elseif job == 'taxi' then
		sendChat('taxi', "#FDCE0D", nombre, mensaje,'Taxista')
	elseif job == 'police' then
		sendChat('police', "#179CE3", nombre, mensaje,'Policia')
	else
		TriggerClientEvent('chat:addMessage',_source, {args = {"^1SYSTEM: ", "^5No perteneces a ninguna facción."}})
	end
	--sendToDiscord(source, "Chat Faccion",mensaje)
end)

RegisterServerEvent('hidi:PoliEms')
AddEventHandler('hidi:PoliEms', function(mensaje,id)
	local _player = ESX.GetPlayerFromId(source)
	local _source = source
	local _job = _player.job.name
	local _identifier = _player.getIdentifier()
	local _name = GetCharacterName(_identifier)
	if _job == 'ambulance' or _job == 'police' then
		if _job == 'ambulance' then
			EmsPol('ambulance', "#A86DEB", _name, mensaje,'EMPL: EMS')
		else
			EmsPol('police', "#A86DEB", _name, mensaje,'EMPL: LSPD')
		end
		--sendToDiscord(source, "Chat entre EMS y LSPD",mensaje)
	else
		TriggerClientEvent('chat:addMessage',_source, {args = {"^1SYSTEM: ", "^5No tienes permisos para usar esto."}})
	end

end)

AddEventHandler('chatMessage', function(source, args, message )
	CancelEvent()
	local _player = GetPlayerName(source)
	local _source = source
	if string.sub(message,1,string.len('/')) ~= '/' then
		TriggerClientEvent("hidi:chatProximidadOoc", -1, source, _player, message)
	end
	--sendToDiscord(source, "ooc",mensaje)
	
end)

--[[
############################################################################
############################################################################
                                COMANDOS
############################################################################
############################################################################
]]

RegisterCommand('a', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(3)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.1vw; margin: 0.1vw; border-radius: 3px;"><i class="fas fa-globe"></i>^1 [AYUDA]^0 '..playerRank(source)..' {0}: {1}</div>',
        args = { playerName, msg }
    })
	--sendToDiscord(source, "Ayuda",mensaje)
end, false)

RegisterCommand('ad', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
	local _player = ESX.GetPlayerFromId(source)
	local _identifier = _player.getIdentifier()
	local _name = GetCharacterName(_identifier)
	local _source = source
	if playerRank(source) ~= '^9[JEFE] ^7' then
    	TriggerClientEvent('chat:addMessage', -1, {
    	    template = '<div style="padding: 0.1vw; margin: 0.1vw; border-radius: 3px;"><i class="fas fa-ad"></i>^3 [Noticia]^0 {1}</div>',
	        args = { _name, msg }
		})
		--sendToDiscord(source, "Anuncio",mensaje)
	else
		TriggerClientEvent('chat:addMessage',_source, {args = {"^1SYSTEM: ", "^5No tienes permisos para usar esto."}})
	end
end, false)

RegisterCommand('msg', function(source, args)
	if args[1] == nil then
		TriggerClientEvent('chat:addMessage',source, {args = {"^1SYSTEM: ", "^5La mente destinada no esta operativa."}})
	end
	
	local receptor = tonumber(args[1])
	local _receptor = GetPlayerName(receptor)
	local emisor = GetPlayerName(source)
	local _source = source
	table.remove(args,1)
	local mensaje = table.concat(args," ")
	
	if _receptor then
		TriggerClientEvent('chat:addMessage',receptor, {
			template = '<font color="#FF008F"><b>PRIVADO DE</b></font> <font color="#FFFFFF"><b>[{2}] {0}</b></font><font color="#FFD022"><b>{1}</b></font>',
			args = {emisor, " " .. mensaje,_source}
		})
		TriggerClientEvent('chat:addMessage', _source, {
			template = '<font color="#FF008F"><b>PRIVADO A</b></font> <font color="#FFFFFF"><b>[{2}] {0}</b></font><font color="#FFD022"><b>{1}</b></font>',
			args = {_receptor," " .. mensaje,receptor}
		})
		--sendToDiscord(source, "privado a " .. receptor,mensaje)
	else
		TriggerClientEvent('chat:addMessage',_source, {args = {"^1SYSTEM: ", "^5La mente destinada no esta operativa."}})
	end

end,false)


TriggerEvent('es:addCommand', 'me', function(source, args, user)
	local _player = ESX.GetPlayerFromId(source)
	local _identifier = _player.getIdentifier()
    local nombre = GetCharacterName(_identifier)
    TriggerClientEvent("hidi:chatProximidadMe", -1, source, nombre, table.concat(args, " "))
	--sendToDiscord(source, "me",mensaje)
end)

TriggerEvent('es:addCommand', 'do', function(source, args, user)
	local _player = ESX.GetPlayerFromId(source)
	local _identifier = _player.getIdentifier()
    local nombre = GetCharacterName(_identifier)
    TriggerClientEvent("hidi:chatProximidadDo", -1, source, nombre, table.concat(args, " "))
	--sendToDiscord(source, "do",mensaje)
end)


--[[
############################################################################
############################################################################
                                FUNCIONES
############################################################################
############################################################################
]]
--Recupera el RolName del personaje
function GetCharacterName(identifier)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	})

	if result[1] and result[1].firstname and result[1].lastname then
		return ('%s %s'):format(result[1].firstname, result[1].lastname)
	else
		return GetPlayerName(source)
	end
end
--Envia el mensaje a la faccion pertinente
function sendChat(job, color, nombre, mensaje,faccion)
	local xJugadores = ESX.GetPlayers()
	TriggerEvent('es:getPlayers', function(players)
		for i=1, #xJugadores, 1 do
			local xJugador = ESX.GetPlayerFromId(xJugadores[i])
			if xJugador.job.name == job then
				TriggerClientEvent('chat:addMessage',xJugadores[i], {
					template = '<font color="' .. color .. '"><b>*{0}*</b></font> <font color="#FFFFFF"><b>{1}</b></font><font color="' .. color .. '"><b>{2}</b></font>',
					args = {string.upper(faccion), nombre, ": " .. mensaje}
				})
			end
		end
	end)
end

function EmsPol(job,color,name,mensaje,faccion)
	local xPlayers = ESX.GetPlayers()
	TriggerEvent('es:getPlayers', function(players)
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'police' then
				TriggerClientEvent('chat:addMessage',xPlayers[i], {
					template = '<font color="' .. color .. '"><b>*{0}*</b></font> <font color="#FFFFFF"><b>{1}</b></font><font color="' .. color .. '"><b>{2}</b></font>',
					args = {string.upper(faccion), name, ": " .. mensaje}
				})
			end
		end
	end)
end

--Comprueva el rango del personaje
function playerRank(source) 
	if IsPlayerAceAllowed(source, "tag.jefe") then
		return '^9[JEFE] ^7'
	elseif IsPlayerAceAllowed(source, "tag.superadmin") then
		return '^3[SUPERADMIN] ^7'
	elseif IsPlayerAceAllowed(source, "tag.admin") then
		return '^1[ADMIN] ^7'
	elseif IsPlayerAceAllowed(source, "tag.mod") then
		return '^4[MOD] ^7'
	elseif IsPlayerAceAllowed(source, "tag.support") then
		return '^5[SOPORTE] ^7'
	else 
		return ''
	end
end

function sendToDiscord(source, tipo, msg)
	local playerName = GetPlayerName(source)
    TriggerEvent('DiscordBot:ToDiscord', 'chat', playerName .. ' [ID: ' .. source .. '] Server: '.. server, '** ' .. tipo .. ' **' .. msg, 'steam', true, source)
end